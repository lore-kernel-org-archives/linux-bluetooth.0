Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325900406.6454.116.camel@aeonflux>
References: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
	<1325893697.6454.113.camel@aeonflux>
	<CAHZ1yCkPoHMA52dxMPp=5g_zibOjQui=ffiSGXR1GAiOqUGciA@mail.gmail.com>
	<1325900406.6454.116.camel@aeonflux>
Date: Mon, 9 Jan 2012 11:37:32 -0800
Message-ID: <CAHZ1yCkDf9zM3mzvQT-6A+WWY506vtW9Hk8r_RW8+-A-7mcfgA@mail.gmail.com>
Subject: Re: Bluetooth 2.1 keyboard not sending keypress notifications
From: Scott James Remnant <keybuk@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 6, 2012 at 5:40 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:

Thanks for the pointers!

> > >> Have been testing a Bluetooth 2.1 keyboard, but we don't get any
> > >> keypress notifications from it as the pincode is typed and the Agent=
's
> > >> DisplayPasskey D-Bus method is never called (with two or three
> > >> arguments).
> > >>
> > >> Any ideas where to begin debugging this?
> > >
> > > first, start with hcidump to see what commands and events are actuall=
y
> > > send by the keyboard. And capture the bluetoothd debug output.
> > >
> > > And I am pretty sure that a real 2.1 keyboard with Secure Simple Pair=
ing
> > > is not working at all. We never managed to purchase one of these. If =
you
> > > managed to find one, then let us know where you got it from.
> > >
> > I have both of those attached, the keyboard is the Apple Wireless
> > Keyboard - it at least behaves in a manner consistent with 2.1 SSP
> > under OS X, complete with hilighting the passkey as it's typed.
> >
> > One thing I noticed from the log is that neither side exchanges IO
> > capabilities which seems to be a pre-requisite for SSP?
>
> you are correct here and the usage of PIN Code Request makes it clear
> that this is 2.0 only keyboard. Can you create a binary dump in BTSnoop
> format. Since I see a bunch of vendor events, maybe that is how OS X
> does it.
>
Yup, sending by hand a Remote Version command means the keyboard does
admit that it's 2.0 not 2.1, so the only devices we can find that are
2.1 are the host controllers in all of the hosts :-)

> That said, since this is 2.0 without SSP, it should actually work. Have
> you tried to use simple-agent test script from the source?
>
Pairing works, it's just ugly compared to OS X with it's pretty
light-as-you-type stuff, and you know how those UI designers are ...


So it turns out that the Mac isn't doing anything special either; it's
doing ordinary 2.0 authentication. But the twist is an L2CAP
connection and configuration request/response before authentication is
requested, this seems to enable the keyboard sending a Vendor Event
every time a key is pressed during authentication.

Investigating that now

Scott
--
Scott James Remnant=A0|=A0Chrome OS Systems=A0|=A0keybuk@google.com=A0|=A0G=
oogle
