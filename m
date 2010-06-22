Return-Path: <cyrus@holtmann.org>
Message-ID: <4C206507.40402@gmail.com>
Date: Tue, 22 Jun 2010 09:23:51 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: obexd: obex_handle_input: poll event HUP ERR
Content-Type: text/plain; charset=ISO-8859-2
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a problem with receiving files with obexd. After it receives
header (file name etc.) it hangs up the connection with
obex_handle_input: poll event HUP ERR

With obex-data-server, everything works as expected.

$ rpm -q obexd libopenobex1 bluez kernel-desktop|sort
bluez-4.64-2.6.x86_64                   == should I try 4.66? ==
kernel-desktop-2.6.34-9.3.x86_64
libopenobex1-1.5-1.8.x86_64
obexd-0.27-6.2.x86_64

$ uname -a
Linux anemoi 2.6.34-9-desktop #1 SMP PREEMPT 2010-06-03 18:33:51 +0200
x86_64 x86_64 x86_64 GNU/Linux

$ strace -fo strace-obexd /usr/lib64/obex/obexd --nodaemon --opp --ftp
--root=Public --root-setup=/usr/lib64/obex/obexd-setup.sh -d
obexd[15862]: Enabling debug information
obexd[15862]: manager_init:
obexd[15862]: Loading builtin plugins
obexd[15862]: driver 0x61d800 transport bluetooth registered
obexd[15862]: Plugin bluetooth loaded
obexd[15862]: driver 0x61d840 mimetype x-obex/folder-listing registered
obexd[15862]: driver 0x61d8a0 mimetype x-obex/capability registered
obexd[15862]: driver 0x61d960 mimetype x-obex/folder-listing registered
obexd[15862]: driver 0x61d900 mimetype (null) registered
obexd[15862]: Plugin filesystem loaded
obexd[15862]: driver 0x61d9e0 service Object Push server registered
obexd[15862]: Plugin opp loaded
obexd[15862]: driver 0x61da80 service File Transfer server registered
obexd[15862]: driver 0x61db00 service Nokia OBEX PC Suite Services
registered
obexd[15862]: Plugin ftp loaded
obexd[15862]: driver 0x61dc20 mimetype x-bt/phonebook registered
obexd[15862]: driver 0x61dc80 mimetype x-bt/vcard-listing registered
obexd[15862]: driver 0x61dce0 mimetype x-bt/vcard registered
obexd[15862]: driver 0x61dba0 service Phonebook Access server registered
obexd[15862]: Plugin pbap loaded
obexd[15862]: driver 0x61dde0 mimetype (null) registered
obexd[15862]: driver 0x61dd60 service OBEX server for SyncML, using
SyncEvolution registered
obexd[15862]: Plugin syncevolution loaded
obexd[15862]: Loading plugins /usr/lib64/obex/plugins
obexd[15862]: bluetooth: listening on channel 9
obexd[15862]: bluetooth: listening on channel 10
obexd[15862]: bluetooth: FindAdapter(any)
obexd[15862]: bluetooth: Registered: Object Push server, handle: 0x10008
obexd[15862]: bluetooth: Registered: File Transfer server, handle: 0x10009
obexd[15862]: bluetooth: New connection from: 00:24:7D:65:55:C5, channel 9
obexd[15862]: REQHINT(0x1), CONNECT(0x0), (null)(0x0)
obexd[15862]: REQ(0x2), CONNECT(0x0), (null)(0x0)
obexd[15862]: Version: 0x10. Flags: 0x00  OBEX packet length: 65535
obexd[15862]: Resizing stream chunks to 65335
obexd[15862]: Selected driver: Object Push server
obexd[15862]: REQDONE(0x3), CONNECT(0x0), (null)(0x0)
obexd[15862]: REQHINT(0x1), PUT(0x2), (null)(0x0)
obexd[15862]: REQCHECK(0xb), PUT(0x2), (null)(0x0)
obexd[15862]: OBEX_HDR_NAME: 323mm=20 10kg.txt
obexd[15862]: OBEX_HDR_LENGTH: 28
obexd[15862]: OBEX_HDR_TYPE: text/plain
obexd[15862]: REQDONE(0x3), PUT(0x2), (null)(0x0)
obexd[15862]: obex_handle_input: poll event HUP ERR
^Cobexd[15862]: Terminating due to signal 2
obexd[15862]: Cleanup plugins
obexd[15862]: driver 0x61d800 transport bluetooth unregistered
obexd[15862]: driver 0x61d840 mimetype x-obex/folder-listing unregistered
obexd[15862]: driver 0x61d8a0 mimetype x-obex/capability unregistered
obexd[15862]: driver 0x61d900 mimetype (null) unregistered
obexd[15862]: driver 0x61d9e0 service Object Push server unregistered
obexd[15862]: driver 0x61da80 service File Transfer server unregistered
obexd[15862]: driver 0x61db00 service Nokia OBEX PC Suite Services
unregistered
obexd[15862]: driver 0x61dba0 service Phonebook Access server unregistered
obexd[15862]: driver 0x61dc20 mimetype x-bt/phonebook unregistered
obexd[15862]: driver 0x61dc80 mimetype x-bt/vcard-listing unregistered
obexd[15862]: driver 0x61dce0 mimetype x-bt/vcard unregistered
obexd[15862]: driver 0x61dd60 service OBEX server for SyncML, using
SyncEvolution unregistered
obexd[15862]: driver 0x61dde0 mimetype (null) unregistered
obexd[15862]: manager_cleanup:

strace of the process:
http://www.fi.muni.cz/~xslaby/sklad/obexd-strace
