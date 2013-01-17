Return-Path: <cyrus@holtmann.org>
Message-ID: <1358460154.2089.14.camel@aeonflux>
Subject: Thoughts about LE scanning
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Jan 2013 14:02:34 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

so I have been looking into how we handle LE scanning in central role a
little bit. And I am not really happy with what we do right now. Instead
of just adding new profiles, we need to take one step back and get the
basics right.

The one thing that I stumbled about is that we are trying to use the
Start Discovery management command to scan for connectable device that
we are paired with. And it is all triggered by bluetoothd. It tries to
get this done right, but fails badly at it. Trying to do this ends up in
a convoluted solution that will just break down eventually.

So Start Discovery and Stop Discovery management commands are for
finding new devices. They are for finding devices that we want to pair
with. They are not for checking if a paired device is in range or
signals connection requests to us. It is called discovery for a reason.

It might have looked like a good idea to just re-use these two commands,
but what I am seeing when working with multiple paired LE devices is
just a big mess. The amount of code that is needed to keep track of
states between running D-Bus commands for discovery, discovery triggered
management commands, scanning triggered management commands etc. is not
a good idea.

I am failing to understand why we tried to solve this inside bluetoothd
and not just let the kernel take full control here. We are loading the
list of paired LE devices at controller power on anyway. So the kernel
does know about our paired devices. It can control sensible scan
intervals and also sync a device discovery with scanning for connection
triggers from know remote devices. It also can sensible disconnect on
idle and scan for other devices that requests connections.

What I think we should have is a management command that allows us to
load device specific scan parameter configuration into the kernel. And
then the kernel will execute this on our behalf. We need to decouple the
commands for device discovery from the commands that scan for known
devices.

Seems also we should actually implement the scan parameters service as a
core feature of bluetoothd and not just a plugin. For me it looks like
it essential that we allow different behavior for different devices.

Regards

Marcel


