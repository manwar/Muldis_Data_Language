use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

my $EMPTY_STR = q{};

my $FALSE = (1 == 0);
my $TRUE  = (1 == 1);

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType; # module
    our $VERSION = 0.000000;
    # Note: This given version applies to all of this file's packages.

    use base 'Exporter';
    our @EXPORT_OK = qw(
        Bool Text Blob Int TextKeyedMap Heading Tuple Relation
        Cat_DeclEntityName Cat_InvokEntityName
    );

###########################################################################

sub Bool {
    my ($scalar) = @_;
    return QDRDBMS::Engine::Example::PhysType::Bool->new( $scalar );
}

sub Text {
    my ($scalar) = @_;
    return QDRDBMS::Engine::Example::PhysType::Text->new( $scalar );
}

sub Blob {
    my ($scalar) = @_;
    return QDRDBMS::Engine::Example::PhysType::Blob->new( $scalar );
}

sub Int {
    my ($scalar) = @_;
    return QDRDBMS::Engine::Example::PhysType::Int->new( $scalar );
}

sub TextKeyedMap {
    my ($map) = @_;
    return QDRDBMS::Engine::Example::PhysType::TextKeyedMap->new( $map );
}

sub Heading {
    my ($attr_defs_aoa) = @_;
    return QDRDBMS::Engine::Example::PhysType::Heading->new(
        $attr_defs_aoa );
}

sub Tuple {
    my ($heading, $body) = @_;
    return QDRDBMS::Engine::Example::PhysType::Tuple->new(
        $heading, $body );
}

sub Relation {
    my ($heading, $body, $key_defs_aoh, $index_defs_aoh) = @_;
    return QDRDBMS::Engine::Example::PhysType::Relation->new(
        $heading, $body, $key_defs_aoh, $index_defs_aoh );
}

sub Cat_DeclEntityName {
    return QDRDBMS::Engine::Example::PhysType::Cat_DeclEntityName->new();
}

sub Cat_InvokEntityName {
    return QDRDBMS::Engine::Example::PhysType::Cat_InvokEntityName->new();
}

###########################################################################

} # module QDRDBMS::Engine::Example::PhysType

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Value; # role
    my $ATTR_ROOT_TYPE = 'Value::root_type';
        # QDRDBMS::Engine::Example::PhysType::TypeRef.
        # This is the fundamental QDRDBMS D data type that this ::Value
        # object's implementation sees it as a generic member of, and which
        # generally determines what operators can be used with it.
        # It is a supertype of the declared type.
    my $ATTR_DECL_TYPE = 'Value::decl_type';
        # QDRDBMS::Engine::Example::PhysType::TypeRef.
        # This is the QDRDBMS D data type that the ::Value was declared to
        # be a member of when the ::Value object was created.
    my $ATTR_LAST_KNOWN_MST = 'Value::last_known_mst';
        # QDRDBMS::Engine::Example::PhysType::TypeRef.
        # This is the QDRDBMS data type that is the most specific type of
        # this ::Value, as it was last determined.
        # It is a subtype of the declared type.
        # Since calculating a value's mst may be expensive, this object
        # attribute may either be unset or be out of date with respect to
        # the current type system, that is, not be automatically updated at
        # the same time that a new subtype of its old mst is declared.
    my $ATTR_WHICH = 'Value::which';
        # Str.
        # This is a unique identifier for the value that this object
        # represents that should compare correctly with the corresponding
        # identifiers of all ::Value-doing objects.
        # It is a text string of format "<tnl>_<tn>_<vll>_<vl>" where:
        #   1. <tn> is the value's root type name (fully qualified)
        #   2. <tnl> is the character-length of <tn>
        #   3. <vl> is the (class-determined) stringified value itself
        #   4. <vll> is the character-length of <vl>
        # This identifier is mainly used when a ::Value needs to be used as
        # a key to index the ::Value with, not necessarily when comparing
        # 2 values for equality.
        # This identifier can be expensive to calculate, so it will be done
        # only when actually required; eg, by the which() method.

###########################################################################

sub new {
    my ($class, @args) = @_;
    my $self = bless {}, $class;
    return $self->_build( @args );
}

###########################################################################

sub which {
    my ($self) = @_;
    if (!exists $self->{$ATTR_WHICH}) {
        my ($cls_nm_unq_part, $scalarified_value)
            = $self->_calc_parts_of_self_which();
        my $len_cnup = length $cls_nm_unq_part;
        my $len_sv = length $scalarified_value;
        $self->{$ATTR_WHICH} = '8 PhysType'
            . " $len_cnup $cls_nm_unq_part $len_sv $scalarified_value";
    }
    return $self->{$ATTR_WHICH};
}

###########################################################################

} # role QDRDBMS::Engine::Example::PhysType::Value

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Bool; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    my $ATTR_SCALAR = 'scalar';
        # A p5 Scalar that equals $FALSE|$TRUE.

###########################################################################

sub _build {
    my ($self, $scalar) = @_;
    $self->{$ATTR_SCALAR} = $scalar;
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    return ('Bool', $self->{$ATTR_SCALAR});
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::Bool

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Text; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    my $ATTR_SCALAR = 'scalar';
        # A p5 Scalar that is a text-mode string;
        # it either has true utf8 flag or is only 7-bit bytes.

###########################################################################

sub _build {
    my ($self, $scalar) = @_;
    $self->{$ATTR_SCALAR} = $scalar;
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    return ('Text', $self->{$ATTR_SCALAR});
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::Text

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Blob; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    my $ATTR_SCALAR = 'scalar';
        # A p5 Scalar that is a byte-mode string; it has false utf8 flag.

###########################################################################

sub _build {
    my ($self, $scalar) = @_;
    $self->{$ATTR_SCALAR} = $scalar;
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    return ('Blob', $self->{$ATTR_SCALAR});
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::Blob

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Int; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    use bigint; # this is experimental

    my $ATTR_SCALAR = 'scalar';
        # A p5 Scalar that is a Perl integer or BigInt or canonical string.

###########################################################################

sub _build {
    my ($self, $scalar) = @_;
    $self->{$ATTR_SCALAR} = $scalar;
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    return ('Int', $self->{$ATTR_SCALAR});
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::Int

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::TextKeyedMap; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    my $ATTR_MAP = 'map';
        # A p5 Hash with 0..N elements:
            # Each Hash key is a p5 text-mode string.
            # Each Hash value is a ::Example::* value of some kind.

###########################################################################

sub _build {
    my ($self, $map) = @_;
    $self->{$ATTR_MAP} = $map;
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    my $map = $self->{$ATTR_MAP};
    return ('TextKeyedMap', join ' ', map {
            my $mk = (length $_) . ' ' . $_;
            my $mv = $map->{$_}->which();
            "K $mk V $mv";
        } sort keys %{$map});
}

###########################################################################

sub ref_to_attr_map {
    my ($self) = @_;
    return $self->{$ATTR_MAP};
}

###########################################################################

sub pairs {
    my ($self) = @_;
    my $map = $self->{$ATTR_MAP};
    return [map { [$_, $map->{$_} ] } keys %{$map}];
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::TextKeyedMap

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Heading; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    my $ATTR_ATTR_DEFS_BY_NAME = 'attr_defs_by_name';
        # A p5 Hash with 0..N elements:
            # Each Hash key is a p5 text-mode string; an attr name.
            # Each Hash value would describe a single tuple|relation
            # attribute; it is a p5 Array with 3 elements:
                # 1. attr name: a p5 text-mode string; same as Hash key.
                # 2. major type: a p5 text-mode string, one of: 'S','T','R'
                # 3. minor type: a disjunction depending on maj-tp value:
                    # 'S': a p5 text-mode string.
                    # 'T'|'R': a Heading.
    my $ATTR_ATTR_DEFS_ORDERED = 'attr_defs_ordered';
        # A p5 Array with 0..N elements; its elements are all of the Hash
        # values of $!attr_defs_by_name, sorted by the attr-name/Hash key.

###########################################################################

sub _build {
    my ($self, $attr_defs_aoa) = @_;
    my $attr_defs_by_name
        = $self->{$ATTR_ATTR_DEFS_BY_NAME}
        = {map { $_->[0] => $_ } @{$attr_defs_aoa}};
    $self->{$ATTR_ATTR_DEFS_ORDERED}
        = [map { $attr_defs_by_name->{$_} }
            sort keys %{$attr_defs_by_name}];
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    my $defs = $self->{$ATTR_ATTR_DEFS_ORDERED};
    return ('Heading', join ' ', map {
            my ($atnm, $mjtp, $mntp) = @{$_};
            'ATNM ' . (length $atnm) . ' ' . $atnm
                . ' MJTP ' . (length $mjtp) . ' ' . $mjtp
                . ' MNTP ' . $mntp->which();
        } @{$defs});
}

###########################################################################

sub get_attr_attr_defs_ordered {
    my ($self) = @_;
    return $self->{$ATTR_ATTR_DEFS_ORDERED};
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::Heading

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Tuple; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    my $ATTR_HEADING = 'heading';
        # A Heading.
    my $ATTR_BODY    = 'body';
        # A TextKeyedMap whose keys match the attribute names in $!heading,
        # and whose values are of the types specified in $!heading.

###########################################################################

sub _build {
    my ($self, $heading, $body) = @_;
    $self->{$ATTR_HEADING} = $heading;
    $self->{$ATTR_BODY}    = $body;
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    return ('Tuple H ', $self->{$ATTR_HEADING}->which()
        . ' B ' . $self->{$ATTR_BODY}->which());
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::Tuple

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::PhysType::Relation; # class
    use base 'QDRDBMS::Engine::Example::PhysType::Value';

    my $ATTR_HEADING    = 'heading';
        # A Heading.
    my $ATTR_BODY       = 'body';
        # A p5 Array with 0..N elements, each element being a
        # TextKeyedMap whose keys match the attribute names in $!heading,
        # and whose values are of the types specified in $!heading.
    my $ATTR_KEY_DEFS   = 'key_defs';
        # A p5 Hash with 1..N elements
    my $ATTR_KEY_DATA   = 'key_data';
    my $ATTR_INDEX_DEFS = 'index_defs';
        # A p5 Hash with 0..N elements
    my $ATTR_INDEX_DATA = 'index_data';

###########################################################################

sub _build {
    my ($self, $heading, $body, $key_defs_aoh, $index_defs_aoh) = @_;
    # Assume input $body may contain duplicate elements (okay; silently
    # remove), and/or duplicate attributes where the attributes are keys
    # (not okay; throw an exception).
    # Otherwise assume all input is okay, and no key|index redundancy.
    my $attr_defs_ordered = $heading->get_attr_attr_defs_ordered();
    if (scalar keys %{$key_defs_aoh} == 0) {
        # There is no explicit key, so make an implicit one over all attrs.
        push @{$key_defs_aoh}, map { $_ => undef } @{$attr_defs_ordered};
    }
    my $key_defs = {};
    my $index_defs = {};




    $self->{$ATTR_HEADING}    = $heading;
    $self->{$ATTR_BODY}       = $body;
    $self->{$ATTR_KEY_DEFS}   = $key_defs;
    $self->{$ATTR_INDEX_DEFS} = $index_defs;
}

###########################################################################

sub _calc_parts_of_self_which {
    my ($self) = @_;
    return ('Relation H ', $self->{$ATTR_HEADING}->which()
        . ' B ' . (join ' ',
            sort map { $_->which() } @{$self->{$ATTR_BODY}}));
}

###########################################################################

} # class QDRDBMS::Engine::Example::PhysType::Relation

###########################################################################
###########################################################################

1; # Magic true value required at end of a reuseable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

QDRDBMS::Engine::Example::PhysType -
Physical representations of all core data types

=head1 VERSION

This document describes QDRDBMS::Engine::Example::PhysType version 0.0.0
for Perl 5.

It also describes the same-number versions for Perl 5 of ::Bool, ::Text,
::Blob, ::Int, ::Tuple, and ::Relation.

=head1 DESCRIPTION

This file is used internally by L<QDRDBMS::Engine::Example>; it is not
intended to be used directly in user code.

It provides physical representations of data types that this Example Engine
uses to implement QDRDBMS D.  The API of these is expressly not intended to
match the API that the language itself specifies as possible
representations for system-defined data types.

Specifically, this file represents the core system-defined data types that
all QDRDBMS D implementations must have, namely: Bool, Text, Blob, Int,
Tuple, Relation, and the Cat.* types.

By contast, the optional data types are given physical representations by
other files: L<QDRDBMS::Engine::Example::PhysType::Num>,
L<QDRDBMS::Engine::Example::PhysType::Temporal>,
L<QDRDBMS::Engine::Example::PhysType::Spatial>.

=head1 BUGS AND LIMITATIONS

This file assumes that it will only be invoked by other components of
Example, and that they will only be feeding it arguments that are exactly
what it requires.  For reasons of performance, it does not do any of its
own basic argument validation, as doing so should be fully redundant.  Any
invoker should be validating any arguments that it in turn got from user
code.  Moreover, this file will often take or return values by reference,
also for performance, and the caller is expected to know that they should
not be modifying said then-shared values afterwards.

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENCE AND COPYRIGHT

This file is part of the QDRDBMS framework.

QDRDBMS is Copyright © 2002-2007, Darren Duncan.

See the LICENCE AND COPYRIGHT of L<QDRDBMS> for details.

=cut
