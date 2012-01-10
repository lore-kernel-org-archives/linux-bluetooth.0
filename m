Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326140173.6454.168.camel@aeonflux>
References: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
	<1325893697.6454.113.camel@aeonflux>
	<CAHZ1yCkPoHMA52dxMPp=5g_zibOjQui=ffiSGXR1GAiOqUGciA@mail.gmail.com>
	<1325900406.6454.116.camel@aeonflux>
	<CAHZ1yCkDf9zM3mzvQT-6A+WWY506vtW9Hk8r_RW8+-A-7mcfgA@mail.gmail.com>
	<1326138887.6454.165.camel@aeonflux>
	<CAHZ1yCmLV6RS6EA7+p2+VDG05YNSNUxCbo8gLcq2t04Ahn2Kcw@mail.gmail.com>
	<1326140173.6454.168.camel@aeonflux>
Date: Mon, 9 Jan 2012 17:10:34 -0800
Message-ID: <CAHZ1yCnOegQhL-Vy_vf8ex9rTsXOb98geaYzzT6wpDuqM-sbsg@mail.gmail.com>
Subject: Re: Bluetooth 2.1 keyboard not sending keypress notifications
From: Scott James Remnant <keybuk@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 9, 2012 at 12:16 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:

> > Right now it looks like it's just making a connection to the HID
> > Interrupt PSM (0x13), and while that connection is open, seeing the
> > keypresses.
> >
> > Is there an L2CAP debugger on the Linux side, so I can make sure I'm
> > replicating what it's doing packetwise?
>
> hcidump can record binary logfiles with -w. If you use hcidump 2.x then
> it automatically record into BTSnoop format. Supported by Wireshark as
> well. You can also use -R to see the raw data packets.
>
Ok, so here's what's happening:

When it sees that it's pairing with an Apple keyboard, OS X makes an
L2CAP connection to the HID Interrupt PSM (0x13) between the initial
connection to the keyboard and the authentication request.

This connection receives a notification every time a key is pressed
(any key, OS X doesn't care, it moves along to the next).

Once authentication is complete, OS X drops this L2CAP connection

Scott
--
Scott James Remnant=A0|=A0Chrome OS Systems=A0|=A0keybuk@google.com=A0|=A0G=
oogle
