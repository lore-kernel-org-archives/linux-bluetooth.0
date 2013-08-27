Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 27 Aug 2013 17:04:26 -0400
Message-ID: <CAKON4OziwQbTUymPddfu7i_6g2oMMXJsbf8RE3kZWZPDVbcFqQ@mail.gmail.com>
Subject: Simultaneous BLE connections
From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

How are multiple BLE connections implemented in Bluez? Is it a
function of host memory like IOS with a high limit (1000's)? I see an
old post saying that Bluez only supports one connection at a time.

This has a large impact on host power consumption. With a connection
you know the windows where you have to listen for a peripheral
connection. If instead you use advertising to trigger the connection
the host has to always be scanning since you never know when the
peripheral is going to advertise.

An example system might have twenty BLE sensors that send alerts when
they are tripped. Wouldn't it be better to have 20 long lasting
connections to these sensors? Now the host only has to wake up at the
windows where it is legal for the peripheral to transmit. And the
peripherals can take advantage of their ability to skip transmission
windows.

If instead the peripherals only use advertising the host has to always
be scanning since they don't know when the peripheral might trip.
Doing that consumes a lot of battery power.

-- 
Jon Smirl
jonsmirl@gmail.com
