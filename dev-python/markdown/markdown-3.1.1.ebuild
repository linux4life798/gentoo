# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy3 )

inherit distutils-r1

DESCRIPTION="Python implementation of the markdown markup language"
HOMEPAGE="
	https://python-markdown.github.io/
	https://pypi.org/project/Markdown/
	https://github.com/Python-Markdown/markdown"
SRC_URI="mirror://pypi/M/${PN^}/${P^}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc pygments test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pytidylib[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)"
# source cites pytidylib however from testruns it appears optional
RDEPEND="pygments? ( dev-python/pygments[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${P^}"

python_compile_all() {
	if use doc; then
		esetup.py build_docs
		HTML_DOCS=( "${BUILD_DIR}"/docs/. )
	fi
}

python_test() {
	esetup.py test
}
