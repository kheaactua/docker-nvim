#!/bin/bash

function install_neovim_deps()
{
	which pip2 2>/dev/null
	if [[ 0 == "$?" ]]; then
		pip2 install neovim
	fi
	pip3 install neovim
}

function install_neovim_alternatives()
{
	local -r bin=$1
	local -r pri=2

	update-alternatives    --install /usr/bin/vi     vi     ${bin} ${pri} \
	&& update-alternatives --install /usr/bin/vim    vim    ${bin} ${pri} \
	&& update-alternatives --install /usr/bin/editor editor ${bin} ${pri}
}

function install_neovim_latest()
{
	local -r prefix="$1"
	local -r tag="$2"

	set -x

	# Get the source:
	if [[ ! -d "${prefix}/src/neovim" ]]; then
		mkdir -p "${prefix}/src"
		cd "${prefix}/src"
		git clone https://github.com/neovim/neovim.git
	fi

	cd "${prefix}/src/neovim"
	git reset --hard
	git fetch origin
	git checkout "${tag}"
	git pull

	make                                \
		CMAKE_BUILD_TYPE=Release         \
		CMAKE_INSTALL_PREFIX="${prefix}" \
	&& make install                     \
	&& install_neovim_deps              \
	&& install_neovim_alternatives "${prefix}/bin/nvim"
}

# install_neovim_latest 6f073cc
install_neovim_latest "${INSTALL_PREFIX}" "${NVIM_TAG}"

# vim: ts=3 sw=3 sts=0 noet :
