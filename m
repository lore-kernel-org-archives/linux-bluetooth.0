Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Bluez-users] Config for Socket CF card
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: digger vermont <dv_mlist@verizon.net>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074698544.7088.102.camel@pegasus>
References: <1074566227.3670.24.camel@myrna>
	 <1074597777.7088.2.camel@pegasus>  <1074697933.3020.19.camel@myrna>
	 <1074698544.7088.102.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074720573.974.29.camel@gaston>
Mime-Version: 1.0
Date: Thu, 22 Jan 2004 08:29:33 +1100
List-ID: <bluez-users.lists.sourceforge.net>


> > I didn't understand it was because the internal serial ports were using
> > ttyS0 and ttyS1. With the ports disabled the card is now starting. 
> > 
> > Should cardmgr, serial_cs.ko, or 8250.ko been able to see that the ports
> > were already used?  (The powerbook uses pmaczilog.ko) If not where can
> > that be configured.  Also, a config definition for the card doesn't seem
> > to be needed.  Should I put one in config.opts?
>
> I don't have any experiences with Apple machines. Ask Benjamin
> Herrenschmidt about this specific problem.

This is a problem with the serial driver since day 1. There is no
proper "dynamic" allocations of port numbers. In 2.4, we used to
have an horrible hack via a macro to "offset" the port numbers
used by the 8250 driver by an amount equal to the number of
on-board 8530 chips (the one that are driven by pmaczilog, or
previously by macserial).

The new 8250 driver doesn't have this ability.

Ben.
