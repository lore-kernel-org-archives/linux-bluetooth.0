Return-Path: <cyrus@holtmann.org>
Subject: Problems compiling obexd
From: Pacho Ramos <pachoramos@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 12 Jun 2011 12:35:27 +0200
Message-ID: <1307874927.6198.2.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

Looks like some people are having problems compiling obexd downstream
(also with 0.40 version),
http://bugs.gentoo.org/show_bug.cgi?id=368135

 I cannot reproduce myself but, googling a bit, looks like some other
people have this problem (but I still didn't find a solution).

The error is the following:

make -j4 -l3 
make --no-print-directory all-am
  CC     client/pbap.o
  CC     client/sync.o
  CC     client/transfer.o
  GEN    client/obex-client.service
  CC     gdbus/mainloop.o
  CC     gdbus/watch.o
  CC     gdbus/object.o
  CC     gdbus/polkit.o
  CC     gwobex/gw-obex.o
  CC     gwobex/obex-priv.o
  CC     gwobex/obex-xfer.o
  CC     gwobex/utils.o
  CC     btio/btio.o
btio/btio.c: In function 'set_sec_level':
btio/btio.c:369: error: storage size of 'sec' isn't known
btio/btio.c:372: error: 'BT_SECURITY_LOW' undeclared (first use in this
function)
btio/btio.c:372: error: (Each undeclared identifier is reported only
once
btio/btio.c:372: error: for each function it appears in.)
btio/btio.c:372: error: 'BT_SECURITY_HIGH' undeclared (first use in this
function)
btio/btio.c:382: error: 'SOL_BLUETOOTH' undeclared (first use in this
function)
btio/btio.c:382: error: 'BT_SECURITY' undeclared (first use in this
function)
btio/btio.c: In function 'l2cap_get_lm':
btio/btio.c:416: error: 'BT_SECURITY_LOW' undeclared (first use in this
function)
btio/btio.c:418: error: 'BT_SECURITY_MEDIUM' undeclared (first use in
this function)
btio/btio.c:420: error: 'BT_SECURITY_HIGH' undeclared (first use in this
function)
btio/btio.c: In function 'rfcomm_get_lm':
btio/btio.c:437: error: 'BT_SECURITY_LOW' undeclared (first use in this
function)
btio/btio.c:439: error: 'BT_SECURITY_MEDIUM' undeclared (first use in
this function)
btio/btio.c:441: error: 'BT_SECURITY_HIGH' undeclared (first use in this
function)
btio/btio.c: In function 'get_sec_level':
btio/btio.c:449: error: storage size of 'sec' isn't known
btio/btio.c:455: error: 'SOL_BLUETOOTH' undeclared (first use in this
function)
btio/btio.c:455: error: 'BT_SECURITY' undeclared (first use in this
function)
btio/btio.c: In function 'parse_set_opts':
btio/btio.c:635: error: 'L2CAP_MODE_BASIC' undeclared (first use in this
function)
btio/btio.c: In function 'l2cap_get':
btio/btio.c:778: error: 'SOL_BLUETOOTH' undeclared (first use in this
function)
btio/btio.c:778: error: 'BT_DEFER_SETUP' undeclared (first use in this
function)
btio/btio.c: In function 'rfcomm_get':
btio/btio.c:885: error: 'SOL_BLUETOOTH' undeclared (first use in this
function)
btio/btio.c:885: error: 'BT_DEFER_SETUP' undeclared (first use in this
function)
btio/btio.c: In function 'bt_io_listen':
btio/btio.c:1282: error: 'SOL_BLUETOOTH' undeclared (first use in this
function)
btio/btio.c:1282: error: 'BT_DEFER_SETUP' undeclared (first use in this
function)
distcc[23546] ERROR: compile btio/btio.c on localhost failed
make[1]: *** [btio/btio.o] Error 1
make: *** [all] Error 2
make: INTERNAL: Exiting with 5 jobserver tokens available; should be 4!

Do you have any idea about where could the problem be?

Thanks a lot

