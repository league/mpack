
## Customized version of `munpack`

[![Build Status](https://travis-ci.org/league/mpack.svg?branch=master)](https://travis-ci.org/league/mpack)

When the attachment's suggested filename has spaces or other
undesirable characters, munpack replaces them with `'X'`.
`ThisXisXugly`, and I'd prefer to let the user specify a replacement
character. Here is a patch that adds an option `[-r character]` so
that `munpack -r-` would produce `This-is-better`. The default is
still `'X'`, so as not to disrupt any expectations. The manual page
and usage string have been updated accordingly.
