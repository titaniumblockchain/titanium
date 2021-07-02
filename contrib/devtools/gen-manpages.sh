#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

ETITANIUMD=${ETITANIUMD:-$BINDIR/etitaniumd}
ETITANIUMCLI=${ETITANIUMCLI:-$BINDIR/etitanium-cli}
ETITANIUMTX=${ETITANIUMTX:-$BINDIR/etitanium-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/etitanium-wallet}
ETITANIUMQT=${ETITANIUMQT:-$BINDIR/qt/etitanium-qt}

[ ! -x $ETITANIUMD ] && echo "$ETITANIUMD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a ETITVER <<< "$($ETITANIUMCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for etitaniumd if --version-string is not set,
# but has different outcomes for etitanium-qt and etitanium-cli.
echo "[COPYRIGHT]" > footer.h2m
$ETITANIUMD --version | sed -n '1!p' >> footer.h2m

for cmd in $ETITANIUMD $ETITANIUMCLI $ETITANIUMTX $WALLET_TOOL $ETITANIUMQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${ETITVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${ETITVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
