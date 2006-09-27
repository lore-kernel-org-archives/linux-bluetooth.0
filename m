Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7d3798db0609262219g49e2b77aie498f6b1c7f9cbf7@mail.gmail.com>
Date: Wed, 27 Sep 2006 07:19:51 +0200
From: "=?ISO-8859-1?Q?Robert_Dahlstr=F6m?=" <robert.dahlstrom.4007@student.uu.se>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1159301443.800.29.camel@localhost>
MIME-Version: 1.0
References: <7d3798db0609260723y34fe4dcam37b9d9a9264ba282@mail.gmail.com>
	<1159284114.800.6.camel@localhost>
	<7d3798db0609261300ke3cad5dg88e4def7532aa6c2@mail.gmail.com>
	<1159301443.800.29.camel@localhost>
Subject: Re: [Bluez-users] rfcomm device names
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

On 9/26/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Robert,
>
> > > > Hello all, I'm currently trying to make bluez work with a Maxell
> > > > Digital Pen (the DP-201 for interested parties)...
> > > >
> > > > The question to make this happen is if it is possible to have generic
> > > > rfcomm device names? I.e. can rfcomm be configured to use any device
> > > > name that I can choose? (These pens only supply data via bluetooth to
> > > > a specifically named port so for them to work with linux I need to be
> > > > able to set this device/port name somehow)
> > > >
> > > > Specifically the pen works ok out of the box with the obex transfer
> > > > protocol but I'm trying to enable the pens streaming protocol with
> > > > connects using the serial interface and expects to find a commport
> > > > with a specific name. (I'm aware that this is quite bad programming in
> > > > the pens but I cannot change that)
> > > >
> > > > I'd appreciate any hints/ideas that would take me in the right
> > > > direction. Sadly I failed to find any information in the archives for
> > > > this issue.
> > >
> > > I am not sure if I understand you correct, but you simply have to write
> > > your own RFCOMM server that registers a SDP record with the correct
> > > service name in it.
> >
> > I think this is correct, however, for a little bit more feedback:
> > So far I have others that have used this pen in Windows and they got
> > it working by renaming the virtual serial port to the expected name
> > (using the widcom stack). If the serial ports are exported as services
> > then you're definately spot on (I guess I have some reading to do on
> > the SDP for bluetooth).
>
> I am still not sure what renaming means.

The serial ports in windows are mapped to COM1, COM2, COM3 and so on
(like ttyS0, tttyS1 etc). This name (as I have understood it) needs to
be mapped so that it appears as say STREAMING instead. For certain
windows devices you can simply tell it to have a specific name and
this is supposed to be enough.

I realise it is possible that this could be achieved by a virtual
device in linux linked to the correct rfcomm<x> port as well but my
knowledge in this area is rather small at the moment.

Since it seemed that it was Bluez that mapped the names for the rfcomm
ports I figured that maybe it was through Bluez it could be achieved.


>
> > Please forgive me for being confusing, I have had very little
> > information to begin with. As for implementing a RFCOMM server and
> > exporting it do I build it on top of existing bluez source code or can
> > I hook the utility programs rfcomm together with the sdptool somehow?
>
> You can't really hook these to up and I prefer if you write your own
> application to make it work properly.
>
> Regards
>
> Marcel
>

Thanks for all the help so far!

-- 
Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
