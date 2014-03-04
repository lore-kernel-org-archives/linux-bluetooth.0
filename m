Return-Path: <cyrus@holtmann.org>
Message-ID: <53164362.4060102@gmail.com>
Date: Tue, 04 Mar 2014 21:19:30 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Controlling LEDs and rumble on sixaxis
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I would like to be able to control from a client app the LEDs and rumble of the sixaxis PS3 controller.

As far as I understand the kernel 3.15 will allow LEDs to be set by bluez when the controller is
connected.
If I wanted to change the LEDs in my app, would this something that needs to be done by bluez? Can I
write to some device and bypass bluez?
Would this be a job for dbus?

I use the sixaxis to control an app on the Pi, and given the lack of feedbacks from the Pi, the LEDs
and rumble could help me on that front.

Does it make sense to do it?

Andrea
