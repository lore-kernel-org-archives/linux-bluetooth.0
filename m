Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138887.6454.165.camel@aeonflux>
Subject: Re: Bluetooth 2.1 keyboard not sending keypress notifications
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <keybuk@google.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Jan 2012 11:54:47 -0800
In-Reply-To: <CAHZ1yCkDf9zM3mzvQT-6A+WWY506vtW9Hk8r_RW8+-A-7mcfgA@mail.gmail.com>
References: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
	 <1325893697.6454.113.camel@aeonflux>
	 <CAHZ1yCkPoHMA52dxMPp=5g_zibOjQui=ffiSGXR1GAiOqUGciA@mail.gmail.com>
	 <1325900406.6454.116.camel@aeonflux>
	 <CAHZ1yCkDf9zM3mzvQT-6A+WWY506vtW9Hk8r_RW8+-A-7mcfgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> > > >> Have been testing a Bluetooth 2.1 keyboard, but we don't get any
> > > >> keypress notifications from it as the pincode is typed and the Agent's
> > > >> DisplayPasskey D-Bus method is never called (with two or three
> > > >> arguments).
> > > >>
> > > >> Any ideas where to begin debugging this?
> > > >
> > > > first, start with hcidump to see what commands and events are actually
> > > > send by the keyboard. And capture the bluetoothd debug output.
> > > >
> > > > And I am pretty sure that a real 2.1 keyboard with Secure Simple Pairing
> > > > is not working at all. We never managed to purchase one of these. If you
> > > > managed to find one, then let us know where you got it from.
> > > >
> > > I have both of those attached, the keyboard is the Apple Wireless
> > > Keyboard - it at least behaves in a manner consistent with 2.1 SSP
> > > under OS X, complete with hilighting the passkey as it's typed.
> > >
> > > One thing I noticed from the log is that neither side exchanges IO
> > > capabilities which seems to be a pre-requisite for SSP?
> >
> > you are correct here and the usage of PIN Code Request makes it clear
> > that this is 2.0 only keyboard. Can you create a binary dump in BTSnoop
> > format. Since I see a bunch of vendor events, maybe that is how OS X
> > does it.
> >
> Yup, sending by hand a Remote Version command means the keyboard does
> admit that it's 2.0 not 2.1, so the only devices we can find that are
> 2.1 are the host controllers in all of the hosts :-)
> 
> > That said, since this is 2.0 without SSP, it should actually work. Have
> > you tried to use simple-agent test script from the source?
> >
> Pairing works, it's just ugly compared to OS X with it's pretty
> light-as-you-type stuff, and you know how those UI designers are ...
> 
> 
> So it turns out that the Mac isn't doing anything special either; it's
> doing ordinary 2.0 authentication. But the twist is an L2CAP
> connection and configuration request/response before authentication is
> requested, this seems to enable the keyboard sending a Vendor Event
> every time a key is pressed during authentication.

that is what I thought. Get your Packet Logger in OS X running and hope
that it decodes a bit more. However getting this integrated into BlueZ
might be a lot trickier. This is nasty stuff.

Regards

Marcel


