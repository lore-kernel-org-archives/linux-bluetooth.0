Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sysfs battery & speed attributes for wacom
 bluetooth tablet
From: Przemo Firszt <przemo@firszt.eu>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>
In-Reply-To: <alpine.LNX.2.00.1003081206210.17799@pobox.suse.cz>
References: <1267389553.24791.22.camel@pldmachine>
	 <alpine.LNX.2.00.1003081206210.17799@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 20:04:12 +0000
Message-ID: <1268078652.3632.3.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Dnia 2010-03-08, pon o godzinie 12:07 +0100, Jiri Kosina pisze:
> On Sun, 28 Feb 2010, Przemo Firszt wrote:
> 
> > Hi,
> > I need your opinion if reporting battery condition/changing reporting
> > speed of a bluetooth device through sysfs is an acceptable practice.
> 
> > [PATCH] Add sysfs battery & speed attributes for wacom bluetooth tablet
> > 
> > The patch creates 2 sysfs attributes:
> > The battery attribute is read-only and it appears in:
> > /sys/bus/hid/devices/{btaddr}/battery
> > /sys/class/bluetooth/hci*:*/{btaddr}/battery
> > /sys/class/hidraw/hidraw*/device/battery
> > Capacity values are in %, zero value means AC plug is connected.
> > 
> > The speed attribute allows to poke reporting speed of wacom tablet.
> > This attribute is RW, valid values are: 5 for low speed, 6 is high
> > speed. High speed is the default value. Using low speed is
> > a workaround if you experience big delay between move of stylus on
> > the tablet and move of cursor on screen.
> 
> Hi Przemo,
> 
> do you see any obstacle to using CONFIG_POWER_SUPPLY (see drivers/power) 
> infrastructure for this?
No, I don't. I'm very sorry for the delay, but I've been rather busy in
last few days. I've got patch implementing usage of power_supply ready -
I just wanted to send it together with switching of reporting speed.
I'll clean it and send it ASAP (but not today :-( ). 
--
Cheers,
Przemo
