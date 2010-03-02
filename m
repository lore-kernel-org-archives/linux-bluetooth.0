Return-Path: <cyrus@holtmann.org>
Sender: Bastien Nocera <hadessuk@googlemail.com>
Subject: Re: [PATCH] Add sysfs battery & speed attributes for wacom
 bluetooth tablet
From: Bastien Nocera <hadess@hadess.net>
To: Przemo Firszt <przemo@firszt.eu>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel
 <marcel@holtmann.org>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer
 <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>
In-Reply-To: <1267531337.23521.14275.camel@localhost.localdomain>
References: <1267389553.24791.22.camel@pldmachine>
	 <1267531337.23521.14275.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 02 Mar 2010 12:11:29 +0000
Message-ID: <1267531889.23521.14301.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2010-03-02 at 12:02 +0000, Bastien Nocera wrote:
> Hey Przemo,
> 
> On Sun, 2010-02-28 at 20:39 +0000, Przemo Firszt wrote:
> > Hi,
> > I need your opinion if reporting battery condition/changing reporting
> > speed of a bluetooth device through sysfs is an acceptable practice.
> > 
> > [PATCH] Add sysfs battery & speed attributes for wacom bluetooth tablet
> > 
> > The patch creates 2 sysfs attributes:
> > The battery attribute is read-only and it appears in:
> > /sys/bus/hid/devices/{btaddr}/battery
> > /sys/class/bluetooth/hci*:*/{btaddr}/battery
> > /sys/class/hidraw/hidraw*/device/battery
> > Capacity values are in %, zero value means AC plug is connected.
> 
> A couple of comments:
<snip>
> - isn't there a more kernel-y way to export that data, so that it's
> automatically picked up by things like upower (né DeviceKit-power)?

I've been told it should use the power_supply class, so it would work
pretty much out-of-the-box with things like upower and
gnome-power-manager.

Cheers
