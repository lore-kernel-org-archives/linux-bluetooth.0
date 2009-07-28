Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 27 Jul 2009 21:47:18 -0400
Message-ID: <9e4733910907271847w4a10b658x571148965788b5cf@mail.gmail.com>
Subject: Possible bluez sensor net application
From: Jon Smirl <jonsmirl@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I need to get data from about 200 sensors in to a central Linux system
wirelessly. I'm attracted to using Bluetooth for this since I can buy
the radios so cheaply.

The sensors are quiet most of the time. Occasionally (once an hour)
they will record an event. This event need to be quickly communicated
to the central node. Upon receiving the event the central node may
send out a broadcast message instructing groups of sensors to do
something.

Can I implement this has a direct HCI layer application? The 200
sensors would be in parked state 99% of the time. When they get an
event they ask the central node to unpark. Then they send the event
data (a couple of bytes) to the central node. Central node would then
broadcast a couple of byte activation node depending on the event id.
Can I broadcast to all of the parked nodes?

Power is not a problem in the sensor nodes. The sensors have a basic
microcontroller in them. I can add a HCI Bluetooth chip (BC4-ROM).
Alternatively I can look at something like a BC4+flash module.

Or is Bluetooth totally unsuited to this application?

-- 
Jon Smirl
jonsmirl@gmail.com
