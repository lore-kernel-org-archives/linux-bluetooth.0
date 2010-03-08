Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Mar 2010 12:07:10 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Przemo Firszt <przemo@firszt.eu>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	marcel <marcel@holtmann.org>,
	Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>
Subject: Re: [PATCH] Add sysfs battery & speed attributes for wacom bluetooth
 tablet
In-Reply-To: <1267389553.24791.22.camel@pldmachine>
Message-ID: <alpine.LNX.2.00.1003081206210.17799@pobox.suse.cz>
References: <1267389553.24791.22.camel@pldmachine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 28 Feb 2010, Przemo Firszt wrote:

> Hi,
> I need your opinion if reporting battery condition/changing reporting
> speed of a bluetooth device through sysfs is an acceptable practice.

> [PATCH] Add sysfs battery & speed attributes for wacom bluetooth tablet
> 
> The patch creates 2 sysfs attributes:
> The battery attribute is read-only and it appears in:
> /sys/bus/hid/devices/{btaddr}/battery
> /sys/class/bluetooth/hci*:*/{btaddr}/battery
> /sys/class/hidraw/hidraw*/device/battery
> Capacity values are in %, zero value means AC plug is connected.
> 
> The speed attribute allows to poke reporting speed of wacom tablet.
> This attribute is RW, valid values are: 5 for low speed, 6 is high
> speed. High speed is the default value. Using low speed is
> a workaround if you experience big delay between move of stylus on
> the tablet and move of cursor on screen.

Hi Przemo,

do you see any obstacle to using CONFIG_POWER_SUPPLY (see drivers/power) 
infrastructure for this?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
