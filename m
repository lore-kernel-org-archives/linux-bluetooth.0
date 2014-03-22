Return-Path: <cyrus@holtmann.org>
Message-ID: <1395487433.1597.60.camel@nuvo>
Subject: Re: Cannot send files to PC from phone
From: Bastien Nocera <hadess@hadess.net>
To: Pacho Ramos <pacho@gentoo.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sat, 22 Mar 2014 12:23:53 +0100
In-Reply-To: <1395481944.1364.2.camel@belkin5>
References: <1395481944.1364.2.camel@belkin5>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2014-03-22 at 10:52 +0100, Pacho Ramos wrote:
> We get this errors:
> obexd[1944]: OBEX daemon 5.16
> obexd[1944]: CONNECT(0x0), (null)(0xffffffff)
> obexd[1944]: CONNECT(0x0), (null)(0x0)
> obexd[1944]: PUT(0x2), (null)(0xffffffff)
> obexd[1944]: PUT(0x2), FORBIDDEN(0x43)
> obexd[1944]: DISCONNECT(0x1), (null)(0xffffffff)
> obexd[1944]: DISCONNECT(0x1), SUCCESS(0x20)
> obexd[1944]: disconnected: Transport got disconnected
> 
> Looks similar to:
> https://bugzilla.novell.com/show_bug.cgi?id=842688
> 
> But we are applying Fedora patches to not need to use systemd --user and
> still get the problems :/
> 
> http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/net-wireless/bluez/bluez-5.16.ebuild?view=markup
> http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/net-wireless/bluez/files/0001-Allow-using-obexd-without-systemd-in-the-user-sessio.patch?revision=1.1&view=markup

What are you using as the server (computer) side program? Is it
gnome-user-share, or the obex test application in bluez?

Simply having obexd installed isn't enough, you need an application to
control it and handle authorisation, etc.

