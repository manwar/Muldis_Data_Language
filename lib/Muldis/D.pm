use 5.006;
use strict;
use warnings;
package Muldis::D;
our $VERSION = '0.200000';
$VERSION = eval $VERSION;
# Note that Perl code only exists at all in this file in order to help
# the CPAN indexer handle the distribution properly.
1;
__END__

=pod

=encoding utf8

=head1 NAME

Muldis::D -
Formal spec of Muldis D relational DBMS lang

=head1 VERSION

This document is Muldis::D version 0.200.

=head1 PREFACE

This is the root document of the Muldis D language specification; the
documents that comprise the remaining parts of the specification, in their
suggested reading order (but that all follow the root), are:
L<Muldis::D::Plain_Text>.

See also L<Muldis::D::Outdated> (which has its own tree of parts to follow)
for a prior and outdated version of this document, since the current
specification has yet to cover all of the same subject areas.

=head1 DESCRIPTION

This distribution / multi-part document is the human readable authoritative
formal specification of the B<Muldis D> language, and of the virtual
environment in which it executes.  If there's a conflict between any other
document and this one, then either the other document is in error, or the
developers were negligent in updating it before this one.

The fully-qualified name of this multi-part document and the language
specification it contains (as a single composition) is
C<Muldis_D:Plain_Text:"http://muldis.com":"0.200"> (B<MDPT>).  It is the
official/original (not embraced and extended) Muldis D Plain Text language
specification by the authority Muldis Data Systems (C<http://muldis.com>),
version number C<0.200> (this number matches the VERSION pod in this file).

This multi-part document is named and organized with the expectation that,
in the Muldis D language family, many versions (core languages, grammars,
vocabularies, etc) for it will exist over time, some of those under the
original author's control, and some under the control of other parties.
The L</VERSIONING> pod section in this file presents a formal method for
specifying the fully-qualified name of a complete language derived from
Muldis D, including any common base plus any dialects and extensions.  All
code written in any dialect or derivation of Muldis D should begin by
specifying the fully-qualified name of the language that it is written in,
the format of the name as defined by said method, to make the code
unambiguous to both human and machine (eg, implementing) readers of the
code.  The method should be very future-proof.

This multi-part document is in the process of being mostly rewritten, with
large layout and language design changes that were conceived since the
middle of 2011 but that weren't formally published, and which are now
largely being implementation-driven.  The last release of the language
specification prior to the rewrite by authority C<http://muldis.com> had
the version number C<0.148.2>, and the first release after the rewrite
began had version number C<0.200>; there were no releases by
C<http://muldis.com> with version numbers between those two.

During the transition period, the Muldis-D distribution contains parts of
two distinct Muldis D specifications, the newer
C<Muldis_D:Plain_Text:"http://muldis.com":"0.200"> which is being regularly
fleshed out, and the older C<Muldis_D:"http://muldis.com":0.148.2:PTMD_STD>
which is a static archive.  The parts of the older are all indexed by
L<Muldis::D::Outdated> and live under its namespace, while the parts of the
newer all live outside the C<Outdated> namespace.  You should always read
the newer parts first, and just refer to the older parts for subject areas
not yet rewritten.  Older parts are subject to be removed piecemeal when
their content has been rewritten, and should all eventually go away.

Muldis D is a computationally / Turing complete (and industrial strength)
high-level programming language with fully integrated database
functionality; you can use it to define, query, and update relational
databases.  The language's paradigm is a mixture of declarative,
homoiconic, functional, imperative, and object-oriented.  It is primarily
focused on providing reliability, consistency, portability, and ease of use
and extension.  (Logically, speed of execution can not be declared as a
Muldis D quality because such a quality belongs to an implementation alone;
however, the language should lend itself to making fast implementations.)

Muldis D is intended to qualify as a "B<D>" language as defined by
"I<Databases, Types, and The Relational Model: The Third Manifesto>"
(I<TTM>), a formal proposal for a solid foundation for data and database
management systems, written by Chris Date (C.J. Date) and Hugh Darwen.  See
L<http://thethirdmanifesto.com> and its "Documents and Books" section for
that book, and the website also has other resources explaining what I<TTM>
is, and has copies of some documents that were used in writing Muldis D.

It should be noted that Muldis D, being quite new, may omit some features
that are mandatory for a "B<D>" language initially, to speed the way to a
useable partial solution, but any omissions will be corrected later.  Also,
it contains some features that go beyond the scope of a "B<D>" language, so
Muldis D is technically a "B<D> plus extra"; examples of this are
constructs for creating the databases themselves and managing connections
to them.

Muldis D also incorporates design aspects and constructs that are taken
from or influenced by Perl 6, other general-purpose languages (particularly
functional ones like Haskell), B<Tutorial D>, various B<D> implementations,
and various SQL implementations (see the L<Muldis::D::SeeAlso>
file).  It also appears in retrospect that Muldis D has some designs in
common with FoxPro or xBase, and with the Ada and Lua languages.  The
newer L<C'Dent|http://cdent.org/> language has some similarities as well.
Most recently Lisp became a larger influence, as well as Python.  At some
point a section will be added that lists the various influences as well as
similarities with other languages, whether by influence or by coincidence.

In any event, the Muldis D documentation will be focusing mainly on how
Muldis D itself works, and will spend little time in providing rationale;
you can read the aforementioned external documentation for much of that.

Continue reading the language spec in L<Muldis::D::Plain_Text>, and then in
L<Muldis::D::Outdated::Basics>.

Also look at the separately distributed L<Muldis::D::RefEng>, which is the
first main implementation of Muldis D.

Muldis D is an L<Acmeist|http://www.acmeism.org/> programming language for
writing portable database modules, that work with any DBMS and with any
other programming language, for superior database interoperability.

=head1 VERSIONING

Strictly speaking, Muldis D is not just a single language but rather is a
family of similar languages.  Each language in the family can be referred
to informally as just B<Muldis D> but formally each one should have a
distinct fully-qualified name.  In this documentation, terms like
I<variant> or I<version> or I<dialect> may be used to mean any particular
specific language rather than the whole family.

All code written in any variant of Muldis D should begin with metadata
that explicitly states that it is written in Muldis D, and that fully
identifies what variant of Muldis D it is, so that the code is completely
unambiguous to both human and machine (eg, implementing) readers of the
code.  This pod section explains how this metadata should be formatted,
and it is intended to be as future-proofed as possible in the face of a
wide variety of both anticipated and unforeseen language variants, both by
the original author and by other parties.

At the highest level, a fully-qualified Muldis D language name is a
(ordered) sequence of values having a minimum of 2 elements, and typically
about 4-6 elements.  The elements are read one at a time, starting with the
first; the value of each element, combined with those before it, determine
what number and kind of elements are valid to follow it in the sequence.
So all Muldis D variants are organized into a single hierarchy where each
child node represents a language derived from or extending the language
represented by its parent node.

In documentation, it is typical to use a Muldis D language name involving
just a sub-sequence of the allowed elements that is missing child-most
allowed elements; in that case, this language name implicitly refers to the
entire language sub-tree having the specified elements in common; an
example of this is the 4-element name mentioned in this file's DESCRIPTION
section.  Even in code, sometimes certain child-most elements are optional.

For the official B<Muldis D Plain Text> language, a fully-qualified
language name, as would be declared by code, has exactly 5 parts: B<Family
Name>, B<Syntax Name>, B<Script Name>, B<Authority>, B<Version Number>.

While not mandatory for Muldis D variants in general, it is strongly
recommended that all elements of a Muldis D language name would, when
expressed in terms of character strings, be expressly limited to comprising
just non-control characters in the ASCII repertoire, and not include any
other characters such as Unicode has.  The primary reason for this is to
make it as simple as possible to interpret a language name on all
architectures, especially so that any explicit hints in the name on how to
interpret the rest of the Muldis D code, including hints as to what
character repertoire it is written in, can be understood without ambiguity.
For all official Muldis D variants, ASCII-only names is actually mandatory.

=head2 Foundation

The actual formatting of a "sequence" used as this language name is
dependent on the language variant itself, but it should be kept as simple
to write and use as is possible for the medium of that variant.

Generally speaking, every Muldis D variant belongs to one of just 2
groups, which are I<non-hosted plain-text> and I<hosted data>.

With all non-hosted plain-text variants, the Muldis D code is represented
by an (ordered) string/sequence of characters like with most normal
programming languages, and so the actual format (of the language name
defining sequence and its elements) is defined in terms of an ordered
series of character sub-strings, each sub-string being a name sequence
element; the sub-strings are often bounded by delimiting characters, and
separated by separating characters.  The string of characters comprising
this name string would be the first characters in the file, and only
following them would be the characters for the actual Muldis D code that
the name is metadata for.

For examples:

    Muldis_D:Plain_Text:ASCII:"http://muldis.com":"0.200"

    Muldis_D:Plain_Text:"Unicode(6.2.0,UTF-8,canon)":"http://muldis.com":"0.200"

    Muldis_D:Plain_Text:ASCII:"http://example.com":"42"

With all hosted data variants, the Muldis D code is represented by
collection-typed values that are of some native type of some other
programming language (eg, Perl) which is the host of Muldis D, so the
actual format (of the language name defining sequence and its elements) is
simply a sequence-typed value of the host programming language.  The Muldis
D code is written here by way of writing code in the host language.

=head2 Family Name

The first element of a Muldis D language name is simply the character
string C<Muldis_D>.  Any language which wants to claim to be a variant of
Muldis D should have this exact first element; only have some other value
if you don't want to claim a connection to Muldis D at all, and in that
case feel free to just ignore everything else in this multi-document.

=head2 Syntax Name

The second element of a Muldis D language name indicates the primary syntax
of the Muldis D code, meaning its implicit vocabulary and its grammar.  For
the canonical Muldis D by C<http://muldis.com>, it is simply the character
string C<Plain_Text>.  Any other Muldis D grammars not intended to be the
canonical one would likely be some other character string, such as
C<Perlish> or C<SQL> or C<Tutorial_D>.

=head2 Script Name

The third element of a Muldis D language name, at least for
C<Muldis_D:Plain_Text>, indicates the primary script of the Muldis D code,
meaning is character repertoire and/or character encoding and/or character
normalization.  Under the assumption that a C<Muldis_D:Plain_Text> parser
might be reading the source code as binary data or otherwise as
unnormalized character data, declaring the Script Name makes it completely
unambiguous as to what characters it is to be treating the input as.

For a simple example, a Script Name of C<ASCII> says every literal source
code character is a 7-bit ASCII character (and representing any non-ASCII
characters is being done with escape sequences), and this is recommended
for any C<Muldis_D:Plain_Text> file that doesn't need to be something else.
For various legacy 8-bit formats the Script Name can tell us if we're using
C<Latin1> or C<CP1252> or C<EBCDIC> etc.  For Unicode the Script Name would
have multiple parts, such as C<Unicode(6.2.0,UTF-8,canon)>, indicating
expected repertoire, and encoding (useful more with ones lacking BOMs); but
at the very least it is useful with normalization; if C<compat> is declared
then the source code is folded before it is parsed so possibly distinct
literal characters in the original code are seen as identical character
strings by the main parser, while C<canon> would not do this folding.

A Muldis D parser would possibly scan through the same source code multiple
times filtering by a variety of text encodings until it can read a Muldis D
language name declaring the same encoding that the name is itself written
in, and then from that point it would expect the whole file to be that
declared encoding or it would consider the code invalid.

=head2 Authority

The fourth element of the Muldis D language name is some character string
whose value uniquely identifies the authority or author of the variant's
language specification.  Generally speaking, the community at large
should self-regulate authority identifier strings so they are reasonable
formats and so each prospective authority/author has one of their own that
everyone recognizes as theirs.  Note that an authority/author doesn't have
to be an individual person; it could be some corporate entity instead.

While technically this string could be any distinct value at all, it is
strongly recommended for Muldis D variant names that authority strings
follow the formats that are valid as authority strings for the long names
of Perl 6 packages, such as a CPAN identifier or an http url.

For the official/original Muldis D language spec by Muldis Data Systems,
Inc., that string is always C<http://muldis.com> during the foreseeable
future.

If someone else wants to I<embrace and extend> Muldis D, then they must use
their own (not C<http://muldis.com>) base authority identifier, to prevent
ambiguity, assist quality control, and give due credit.

In this context, I<embrace and extend> means for someone to do any of the
following:

=over

=item *

Releasing a modified version of this current multi-document where the
original of the modified version was released by someone else (the original
typically being the official release), as opposed to just releasing a delta
document that references the current multi-document as a foundation.  This
applies both for unofficial modifications and for official modifications
following a change of who is the official maintainer.

=item *

Releasing a delta document for a version of this current multi-document
where the referenced original is released by someone else, and where the
delta either makes incompatible syntax changes or makes changes to the
C<Muldis_D> or C<Muldis_D::Low_Level> packages.

=back

=head2 Version Number

The fifth element of the Muldis D language name, at the very least when the
authority is C<http://muldis.com>, is a multi-part version
number, which identifies the language spec version between all those
by the same authority, typically indicating the relative ages of the
versions, the relative sizes of their deltas, and perhaps which development
branches the versions are on.  The version number is a sequence of
non-negative integers that consists of at least 1 element, and 2-4 elements
is recommended (the official version number typically has 2-3
elements); elements are ordered from most significant to least (eg, [major,
minor, bug-fix]).  At the present time, the official spec version number to
use is shown in the VERSION and DESCRIPTION pod of the current file, when
corresponding to the spec containing that file.

=head1 SEE ALSO

Go to the L<Muldis::D::SeeAlso> file for the majority of external
references.

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2015, Muldis Data Systems, Inc.

L<http://www.muldis.com/>

Muldis D is free documentation for software; you can redistribute it and/or
modify it under the terms of the GNU General Public License (GPL) as
published by the Free Software Foundation (L<http://www.fsf.org/>); either
version 3 of the License, or (at your option) any later version.  You
should have received copies of the GPL as part of the Muldis::D
distribution, in the file named "LICENSE/GPL"; if not, see
L<http://www.gnu.org/licenses/>.

Any versions of Muldis D that you modify and distribute must carry
prominent notices stating that you changed the files and the date of any
changes, in addition to preserving this original copyright notice and other
credits.

While it is by no means required, the copyright holder of Muldis D would
appreciate being informed any time you create a modified version of Muldis
D that you are willing to distribute, because that is a practical way of
suggesting improvements to the standard version.

=head1 TRADEMARK POLICY

MULDIS and MULDIS MULTIVERSE OF DISCOURSE are trademarks of Muldis Data
Systems, Inc. (L<http://www.muldis.com/>).  The trademarks apply to
computer database software and related services.  See
L<http://www.muldis.com/trademark_policy.html> for the full written details
of Muldis Data Systems' trademark policy.

The word MULDIS is intended to be used as the distinguishing brand name for
all the products and services of Muldis Data Systems.  So we would greatly
appreciate it if in general you do not incorporate the word MULDIS into the
name or logo of your website, business, product or service, but rather use
your own distinct name (exceptions appear below).  It is, however, always
okay to use the word MULDIS only in descriptions of your website, business,
product or service to provide accurate information to the public about
yourself.

If you do incorporate the word MULDIS into your names anyway, either
because you have permission from us or you have some other good reason,
then:  You must make clear that you are not Muldis Data Systems and that
you do not represent Muldis Data Systems.  A simple or conspicuous
disclaimer on your home page and product or service documentation is an
excellent way of doing that.

Please respect the conventions of the Perl community by not using the
namespace C<Muldis::> at all for your own works, unless you have explicit
permission to do so from Muldis Data Systems; that namespace is mainly just
for our official works.  You can always use either the C<MuldisX::>
namespace for related unofficial works, or some other namespace that is
completely different.  Also as per conventions, its fine to use C<Muldis>
within a Perl package name where that word is nested under some other
project-specific namespace (for example, C<Foo::Storage::Muldis_D_RefEng> or
C<Bar::Interface::Muldis_D_RefEng>), and the package serves to interact with
a Muldis Data Systems work or service.

If you have made a language variant or extension based on the B<Muldis D>
language, then please follow the naming conventions described in the
VERSIONING (L<Muldis::D/VERSIONING>) documentation of the official
B<Muldis D> language spec.

If you would like to use (or have already used) the word MULDIS for any use
that ought to require permission, please contact Muldis Data Systems and
we'll discuss a way to make that happen.

=head1 ACKNOWLEDGEMENTS

None yet.

=head1 FORUMS

Several public email-based forums exist whose main topic is
the L<Muldis D|Muldis::D> language and its implementations, especially
the L<Muldis::D::RefEng> reference implementation, but also
the L<Set::Relation> module.  They exist so that users of Muldis D or
Muldis::D::RefEng can help each other, or so that help coming from the
projects' developers can be said once to many people, rather than
necessarily to each individually.  All of these you can reach via
L<http://mm.darrenduncan.net/mailman/listinfo>; go there to manage your
subscriptions to, or view the archives of, the following:

=over

=item C<muldis-db-announce@mm.darrenduncan.net>

This low-volume list is mainly for official announcements from Muldis D
language or implementation developers, though developers of related projects
can also post their announcements here.  This is not a discussion list.

=item C<muldis-db-users@mm.darrenduncan.net>

This list is for general discussion among people who are using Muldis D or
any of its implementations, especially the Muldis::D::RefEng reference
implementation.  This is the best place to ask for basic help in getting
Muldis::D::RefEng installed on your machine or to make it do what you want.
If you are in doubt on which list to use, then use this one by default.
You could also submit feature requests for Muldis D projects or report
perceived bugs here, if you don't want to use CPAN's RT system.

=item C<muldis-d-language@mm.darrenduncan.net>

This list is mainly for discussion among people who are designing the
Muldis D language specification, or who are implementing or adapting Muldis
D in some form, or who are writing Muldis D documentation, tests, or
examples.  It is not the main forum for any Muldis D implementations, nor
is it the place for non-implementers to get help in using said.

=item C<muldis-db-devel@mm.darrenduncan.net>

This list is for discussion among people who are designing or implementing
Muldis::D::RefEng, or other Muldis D implementations,
or who are writing Muldis::D::RefEng core documentation,
tests, or examples.  It is not the main forum for the Muldis D language
itself, nor is it the place for non-implementers to get help in using said.

=back

An official IRC channel for Muldis D and its implementations is also
intended, but not yet started.

Alternately, you can purchase more advanced commercial support for various
Muldis D implementations, particularly Muldis::D::RefEng, from its author by
way of Muldis Data Systems; see L<http://www.muldis.com/> for details.

=cut
