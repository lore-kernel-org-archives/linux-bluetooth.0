Return-Path: <cyrus@holtmann.org>
Message-ID: <1410689236.29532.12.camel@gentoo.org>
Subject: Regarding why some tools are not installed
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sun, 14 Sep 2014 12:07:16 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

Recently a user told me that he needed to use hex2hcd to get his
Broadcom firmware loaded by his bluetooth adaptor. We wonder about why
it's not installed by default when we build with "experimental"
configure option:
if EXPERIMENTAL
noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
                        tools/scotest tools/amptest tools/hwdb \
                        tools/hcieventmask tools/hcisecfilter \
                        tools/btmgmt tools/btinfo tools/btattach \
                        tools/btsnoop tools/btproxy tools/btiotest \
                        tools/cltest tools/seq2bseq tools/hex2hcd \
                        tools/ibeacon tools/btgatt-client
(in Makefile.tools)

Thanks a lot for the info

