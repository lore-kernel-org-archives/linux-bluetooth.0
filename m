Return-Path: <cyrus@holtmann.org>
Message-ID: <1395481944.1364.2.camel@belkin5>
Subject: Cannot send files to PC from phone
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sat, 22 Mar 2014 10:52:24 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We get this errors:
obexd[1944]: OBEX daemon 5.16
obexd[1944]: CONNECT(0x0), (null)(0xffffffff)
obexd[1944]: CONNECT(0x0), (null)(0x0)
obexd[1944]: PUT(0x2), (null)(0xffffffff)
obexd[1944]: PUT(0x2), FORBIDDEN(0x43)
obexd[1944]: DISCONNECT(0x1), (null)(0xffffffff)
obexd[1944]: DISCONNECT(0x1), SUCCESS(0x20)
obexd[1944]: disconnected: Transport got disconnected

Looks similar to:
https://bugzilla.novell.com/show_bug.cgi?id=842688

But we are applying Fedora patches to not need to use systemd --user and
still get the problems :/

http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/net-wireless/bluez/bluez-5.16.ebuild?view=markup
http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/net-wireless/bluez/files/0001-Allow-using-obexd-without-systemd-in-the-user-sessio.patch?revision=1.1&view=markup

Thanks

