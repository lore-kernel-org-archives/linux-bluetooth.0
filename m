Return-Path: <cyrus@holtmann.org>
Message-ID: <1395488717.1364.4.camel@belkin5>
Subject: Re: Cannot send files to PC from phone
From: Pacho Ramos <pacho@gentoo.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sat, 22 Mar 2014 12:45:17 +0100
In-Reply-To: <1395487433.1597.60.camel@nuvo>
References: <1395481944.1364.2.camel@belkin5>
	 <1395487433.1597.60.camel@nuvo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El sáb, 22-03-2014 a las 12:23 +0100, Bastien Nocera escribió:
> On Sat, 2014-03-22 at 10:52 +0100, Pacho Ramos wrote:
> > We get this errors:
> > obexd[1944]: OBEX daemon 5.16
> > obexd[1944]: CONNECT(0x0), (null)(0xffffffff)
> > obexd[1944]: CONNECT(0x0), (null)(0x0)
> > obexd[1944]: PUT(0x2), (null)(0xffffffff)
> > obexd[1944]: PUT(0x2), FORBIDDEN(0x43)
> > obexd[1944]: DISCONNECT(0x1), (null)(0xffffffff)
> > obexd[1944]: DISCONNECT(0x1), SUCCESS(0x20)
> > obexd[1944]: disconnected: Transport got disconnected
> > 
> > Looks similar to:
> > https://bugzilla.novell.com/show_bug.cgi?id=842688
> > 
> > But we are applying Fedora patches to not need to use systemd --user and
> > still get the problems :/
> > 
> > http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/net-wireless/bluez/bluez-5.16.ebuild?view=markup
> > http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/net-wireless/bluez/files/0001-Allow-using-obexd-without-systemd-in-the-user-sessio.patch?revision=1.1&view=markup
> 
> What are you using as the server (computer) side program? Is it
> gnome-user-share, or the obex test application in bluez?
> 
> Simply having obexd installed isn't enough, you need an application to
> control it and handle authorisation, etc.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I have gnome-user-share installed and I configured sharing options for
allowing bluetooth sharing (from gnome-control-center) but, as I was
only getting this error in journalctl output:
mar 22 12:43:24 belkin5 bluetoothd[233]: D-Bus failed to
register /org/bluez/hci0/dev_F8_E0_79_0C_CD_A3/player0 path
mar 22 12:43:24 belkin5 kernel: input: F8:E0:79:0C:CD:A3
as /devices/virtual/input/input9

I tried to manually run obexd in that way to try to get more info. My
kernel is 3.13.6, I have systemd-208 and I run Gnome 3.10 

