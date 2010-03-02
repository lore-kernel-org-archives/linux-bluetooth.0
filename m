Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sysfs battery & speed attributes for wacom
 bluetooth tablet
From: Bastien Nocera <hadess@hadess.net>
To: Przemo Firszt <przemo@firszt.eu>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        marcel
 <marcel@holtmann.org>, Jiri Kosina <jkosina@suse.cz>,
        Peter Hutterer
 <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>
In-Reply-To: <1267389553.24791.22.camel@pldmachine>
References: <1267389553.24791.22.camel@pldmachine>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 02 Mar 2010 12:02:17 +0000
Message-ID: <1267531337.23521.14275.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Przemo,

On Sun, 2010-02-28 at 20:39 +0000, Przemo Firszt wrote:
> Hi,
> I need your opinion if reporting battery condition/changing reporting
> speed of a bluetooth device through sysfs is an acceptable practice.
> 
> [PATCH] Add sysfs battery & speed attributes for wacom bluetooth tablet
> 
> The patch creates 2 sysfs attributes:
> The battery attribute is read-only and it appears in:
> /sys/bus/hid/devices/{btaddr}/battery
> /sys/class/bluetooth/hci*:*/{btaddr}/battery
> /sys/class/hidraw/hidraw*/device/battery
> Capacity values are in %, zero value means AC plug is connected.

A couple of comments:
- battery status and adapter status should probably be 2 separate
values. I don't know what the hardware actually exports, but I hope to
have access to the specs of the device soon, which should answer that
question.
- isn't there a more kernel-y way to export that data, so that it's
automatically picked up by things like upower (né DeviceKit-power)?

> The speed attribute allows to poke reporting speed of wacom tablet.
> This attribute is RW, valid values are: 5 for low speed, 6 is high
> speed. High speed is the default value. Using low speed is
> a workaround if you experience big delay between move of stylus on
> the tablet and move of cursor on screen.

5 and 6 are magic values. I'd rather have a boolean "high_speed"
attribute which would switch between high-speed and low-speed.

Finally, the patch should be split in at least 2 parts, one to add the
sysfs infrastructure and one of the properties, and another one adding
the property itself (maybe even 3, if we were to split the sysfs
enablement from the properties themselves).

But that's a minor problem, and if the maintainers are happy taking a
single patch for the features, then I'm happy as well :)

Cheers
