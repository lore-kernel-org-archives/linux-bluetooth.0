Return-Path: <cyrus@holtmann.org>
Reply-To: <wyrles@ytram.com>
From: "Tom Allebrandi" <wyrles@ytram.com>
To: "'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>,
	<wyrles@ytram.com>
Cc: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
References: <AcxH8lGl8ak3xCaSSCmiX6HP8t/C5Q==>	<04f101cc47f2$652cbbf0$2f8633d0$@ytram.com> <CABBYNZ+ZS77M7-iPUx-TTO_b8MWokPgO3ATahd6Hb_otAo2TKg@mail.gmail.com>
In-Reply-To: <CABBYNZ+ZS77M7-iPUx-TTO_b8MWokPgO3ATahd6Hb_otAo2TKg@mail.gmail.com>
Subject: RE: DBus APIs for HCI/L2CAP?
Date: Tue, 26 Jul 2011 09:40:04 -0700
Message-ID: <00b801cc4bb2$b9f2f0f0$2dd8d2d0$@ytram.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz  -

Tuesday, July 26, 2011 12:27 AM, Luiz Augusto von Dentz said:
> Hi Tom,
> 
> On Fri, Jul 22, 2011 at 1:05 AM, Tom Allebrandi <wyrles@ytram.com> wrote:
> > Hi -
> >
> > Is there a DBus API for issuing HCI commands? I want to be able to
> > issue vendor specific commands.
> >
> > Also, I want to be able set the Limited Inquiry Access Code for both
> > discovery and discoverability. I see the Discoverable property in
> > org.bluez.Adapter but I don't see any way to set the IAC.
> >
> > Similarly, is there a DBus API for L2CAP? I need to be able to
> > manually setup channels and control the packets that I send over those
> channels.
> >
> > I'm working with profiles that are not yet implemented in BlueZ. Also,
> > I need to be able to generate malformed packets for test purposes.
> >
> > I'm pretty sure that I can do all of the above with BTIO or the socket
> > interface. I'm just trying to be a good boy and use DBus :-).
> 
> D-Bus is not really meant for data, it is a high level/convenient API for
> applications, so if you are trying to implement a profile you should
probably
> stick with sockets or use BTIO as bluetoothd and obexd does.
> 

Ok. As I said, I'm trying to be a good boy. I've heard Marcel say words like
"use DBus not sockets" enough times that I was starting in from that end
:-). BTIO looks like a reasonable compromise.

Do you (or anyone) know if there is a Perl<->.so interface? (Perl for
Windows has an interface package that allows arbitrary functions to be
called from any old DLL. (I've never figured out XS.))

I'm not afraid of C/C++ programming, I just do a lot of my scripted type
stuff in Perl.

-----

In my case, I'm not actually implementing whole profiles. I'm more
interested in creating feature/function centric parts of profiles similar to
the way test cases work in PTS.

That, and some downstack support API thingies since {system("hcitool");} is
just clumsy.

Thanks for the info.

Cheers!

--- tom


