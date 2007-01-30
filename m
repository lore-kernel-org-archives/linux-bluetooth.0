Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0701301404o42c00599mf12770f8141027f4@mail.gmail.com>
Date: Tue, 30 Jan 2007 17:04:42 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <2e9fc96f0701290848j39544depaad1def88a36d161@mail.gmail.com>
MIME-Version: 1.0
References: <2e9fc96f0701252321k59b0320cld9eef725a6cc06ac@mail.gmail.com>
	<20070127035832.4aecaae8@localhost.localdomain>
	<2e9fc96f0701270326g37539095s2c533407439ec8bc@mail.gmail.com>
	<ef9938ec0701271824i65a6a58ejf43d3b02cffe6dff@mail.gmail.com>
	<2e9fc96f0701290848j39544depaad1def88a36d161@mail.gmail.com>
Subject: Re: [Bluez-users] Obex File Transfers between Nokia and BlueZ
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

obexftpd is old and outdated.  Additionally, I think it hardcodes the
RFCOMM channel number to 10, so if you're going to use it, you'll
probably need to use sdptool --channel=10 instead of --channel=9.
It's better if you use an obex server that does SDP registration
automatically.  I think collin mulliner's sobexsrv does this, although
I haven't tried it myself.
http://www.mulliner.org/bluetooth/sobexsrv.php

In the past, I've had success with obexserver (
http://packages.debian.org/stable/comm/obexserver ) which is just as
old and outdated as obexftpd, but it works.  To use obexserver, you'll
also need to register a service with sdptool:  sdptool add
--channel=10 OPUSH ; obexserver.

-albert

On 1/29/07, Prabhu nath <gprabhunath@gmail.com> wrote:
> Oops.. I am running an headless Linux (without X). Is there obex-server
> which will work without X.  I browsed over to get obexserver-apps, which is
> no more works for latest openobex lib.
>
> I am using obexftpd, I am not sure why it is not working for Nokia but works
> for MotoQ.
>
>
> Thanks,
> Prabhu
>
>
>
>
> On 1/28/07, Albert Huang <albert@csail.mit.edu> wrote:
> > Are you sure you're actually running an obex server?  If you're using
> > fedora, then you can use the obexserver that comes with
> > gnome-bluetooth.  From the foot menu thing, you should find a menu
> > option that allows you to receive files via bluetooth.  If your
> > machine is advertising OPUSH but you're not actually running a server,
> > then it's not going to work.  If you ever used the sdptool command,
> > then you probably did something wrong.  This is a fairly standard
> > usage of bluez and nokia phones.
> >
> > -albert
> >
> > On 1/27/07, Prabhu nath <gprabhunath@gmail.com> wrote:
> > > I enabled piscan and again no luck.
> > > I am able to push from BlueZ to Nokia, but vice-versa is not possible.
> i.e.
> > > Pushing an object/file from Nokia to BlueZ. I do the following on the
> NOkia
> > > cell phone to push a file.
> > >
> > > Select an image, and options->send->via Bluetooth->Select BT Device.
> > > Once I do, the messsage, sending failed is displayed on the cell phone.
> > >
> > > -Prabhu
> > >
> > >
> > >
> > >
> -------------------------------------------------------------------------
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > > opinions on IT & business topics through brief surveys - and earn cash
> > >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > >
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > >
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> > >
> > >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys - and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
