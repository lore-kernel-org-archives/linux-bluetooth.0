Return-Path: <justin-qt-dated-1065622735.c1c440@affinix.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
Date: Tue, 23 Sep 2003 23:06:30 -0700
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309231648.12696.justin-qt@affinix.com> <1064367347.1620.67.camel@pegasus>
In-Reply-To: <1064367347.1620.67.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309232306.30064.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tuesday 23 September 2003 06:35 pm, Marcel Holtmann wrote:
> I only looked at the first Affix release and never looked again. But
> from what I know is that the core of the UART driver is based on
> serial_cs and they put more hacks into to get them working with the
> their own and other Bluetooth cards with serial interface. And the
> serial_cs driver itself is one of the "bad drivers" out their.
>
> The UART on the DTL-1 card is not a normal UART and it uses the ring
> indicator for some unusual flow control. So I decided to drive the UART
> by myself.

So Affix goes through some sort of serial library, while Bluez writes to the 
UART directly?  I noticed calls like outb() in bluez, but no such calls in 
Affix, which probably explains some things..

> > Has anyone here used Affix, and can they claim that suspend/resume works
> > for the DTL1 card?  I noticed the driver does have some handling
> > functions, like affix_uart_suspend() and affix_uart_resume(), which
> > appear to simply detach / reattach the driver from the HCI subsystem. 
> > Under Bluez, such an action would do just about nothing (in my experience
> > anyway), but I think under Affix, the act of attaching to the hci
> > subsystem causes the hardware to be affected also.  My guess is that
> > init_uart gets called somwhere down the line.
>
> The register/unregister should also work with BlueZ, but you must make
> sure that the UART is in the correct state, as I said previous.

Right.  I tried Affix tonight, and it does not properly function after a 
'cardctl reset' either.  However, it can be solved by typing 'btctl down ; 
btctl up'.  This looks more like a bug in their hci side of things.  In any 
case, the UART gets reset to the correct state somehow and the driver works.

Now how to figure out what they are doing so we can have this in Bluez (minus 
the hci bug of course :)).

-Justin
