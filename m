Return-Path: <cyrus@holtmann.org>
Message-ID: <1325900406.6454.116.camel@aeonflux>
Subject: Re: Bluetooth 2.1 keyboard not sending keypress notifications
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <keybuk@google.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 06 Jan 2012 17:40:06 -0800
In-Reply-To: <CAHZ1yCkPoHMA52dxMPp=5g_zibOjQui=ffiSGXR1GAiOqUGciA@mail.gmail.com>
References: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
	 <1325893697.6454.113.camel@aeonflux>
	 <CAHZ1yCkPoHMA52dxMPp=5g_zibOjQui=ffiSGXR1GAiOqUGciA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> >> Have been testing a Bluetooth 2.1 keyboard, but we don't get any
> >> keypress notifications from it as the pincode is typed and the Agent's
> >> DisplayPasskey D-Bus method is never called (with two or three
> >> arguments).
> >>
> >> Any ideas where to begin debugging this?
> >
> > first, start with hcidump to see what commands and events are actually
> > send by the keyboard. And capture the bluetoothd debug output.
> >
> > And I am pretty sure that a real 2.1 keyboard with Secure Simple Pairing
> > is not working at all. We never managed to purchase one of these. If you
> > managed to find one, then let us know where you got it from.
> >
> I have both of those attached, the keyboard is the Apple Wireless
> Keyboard - it at least behaves in a manner consistent with 2.1 SSP
> under OS X, complete with hilighting the passkey as it's typed.
> 
> One thing I noticed from the log is that neither side exchanges IO
> capabilities which seems to be a pre-requisite for SSP?

you are correct here and the usage of PIN Code Request makes it clear
that this is 2.0 only keyboard. Can you create a binary dump in BTSnoop
format. Since I see a bunch of vendor events, maybe that is how OS X
does it.

In addition OS X comes with a tool called Packet Logger (from the SDK)
which allows you also to create a dump file. hcidump can actually read
these as well. So having that one to compare would be nice.

That said, since this is 2.0 without SSP, it should actually work. Have
you tried to use simple-agent test script from the source?

Regards

Marcel


