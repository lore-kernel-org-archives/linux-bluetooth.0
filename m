Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Nov 2009 14:35:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alexander H Deriziotis <deriziotis@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Connecting to Bluetooth Speakers via command line
Message-ID: <20091119123535.GA4305@jh-x301>
References: <5eee8c670911190321gd44f7f4x522dc8af67e19c2f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <5eee8c670911190321gd44f7f4x522dc8af67e19c2f@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Alex,

On Thu, Nov 19, 2009, Alexander H Deriziotis wrote:
> In Ubuntu 9.10 the Bluetooth applet has improved functionality for
> managing connected devices. Once I pair my Bluetooth speakers with my
> computer, I can click on the Bluetooth applet, select my speakers and
> click ‘Connect’ in order to establish a connection.
> 
> This seems to automatically connect to the speakers and create a
> pulseaudio sink for me which I can use, however, every time I reboot,
> I need to manually click on Connect again to get my sink back.
> 
> Is there any way to connect to my Bluetooth speakers from the
> command-line, so that I can set-up my system to automatically use the
> relevant sink whenever I boot-up?

I think the Bluetooth applet is using the org.bluez.Audio.Connect D-Bus
method to create the connection. You can call it from the command line
using e.g. the attached python script (I also realized this was missing
from the bluez source tree so it's now added there too). I also think
that it could be a nice feature if in the Bluetooth applet you could
mark devices to be auto-connected when the applet starts.

Johan

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=test-audio

#!/usr/bin/python

import sys
import dbus

bus = dbus.SystemBus()

manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
adapter = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()),
				"org.bluez.Adapter")

if len(sys.argv) < 3:
	print """Usage: %s <command>

	connect <bdaddr>
	disconnect <bdaddr>
	""" % sys.argv[0]
	sys.exit(1)

device = adapter.FindDevice(sys.argv[2])
audio = dbus.Interface(bus.get_object("org.bluez", device),
				"org.bluez.Audio")

if sys.argv[1] == "connect":
	audio.Connect()
elif sys.argv[1] == "disconnect":
	audio.Disconnect()
else:
	print "Unknown command"
	sys.exit(1)

--yrj/dFKFPuw6o+aM--
