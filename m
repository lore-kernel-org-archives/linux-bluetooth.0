Return-Path: <postfix@gmx.com>
Date: Fri, 13 Feb 2004 23:50:30 +0100
From: Radu Maurer <a400@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple keyboard
Message-ID: <20040213225030.GA10502@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de> <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de> <1076515215.2696.36.camel@pegasus> <20040213105035.GA10464@mail.gmx.de> <1076669640.2671.27.camel@pegasus> <20040213113749.GA13481@mail.gmx.de> <1076673365.2671.30.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076673365.2671.30.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

> then you must make sure that the hcid PIN helper works perfect. To be
> sure replace it with a simple executable shell script.
> 
> 	#!/bin/sh
> 	echo "PIN:0000"
> 
> Try again and enter the PIN "0000" on your keyboard.

ok, it worked, thanks very much Marcel!!
 
Feb 13 23:20:49 localhost bthid[8705]: Connected: Apple Computer, Inc. Apple Wireless Keyboard (05ac:0209)

hcidump prints this every time a press a key:
> ACL data: handle 0x0029 flags 0x02 dlen 15
    L2CAP(d): cid 0x41 len 11 [psm 19]

now I wonder: how do I use the keyboard with X11 (and possibly at the
console), i.e. which device do I have to enter in the "InputDevice"
section of XFree86Config?

thanks
Radu
