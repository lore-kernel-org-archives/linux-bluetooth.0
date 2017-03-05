Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Barry Byford <31baz66@gmail.com>
Date: Sun, 5 Mar 2017 10:23:55 +0000
Message-ID: <CAAu3APaWx59uH18QRtuLJgqAZD9Aws3LzQvWhtaA388bm+0HFg@mail.gmail.com>
Subject: Connecting to Dual Shock 4 controller
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a single board computer (SBC) running Linux that will be
embedded inside of a project and run headless. I'm looking to have a
Bluetooth remote control with some buttons on so that I can interact
with the SBC.

Looking around the house I have a few Sony DS4 controllers that could
fit the bill of my remote control.

On the SBC I've upgraded to BlueZ 5.44 and using bluetoothctl can pair
the DS4 and trust it so that it connects on start-up.
The piece I'm stuck on is how to access when buttons have been pressed
from within a Python script.

On the command line I can get the power level with this:
$ cat /sys/class/power_supply/sony_controller_battery_40\:1b\:5f\:8e\:bf\:2a/capacity
70

The only control on the DS4 I am able to see is the touch pad with:
$ cat /dev/input/js0

I've taken a look at Python3 Sockets which seem to have something
about getting input from Bluetooth. Although not enough instructions
for me to get it working with the DS4.

I've had a good 'google' around and there seems to be lots of out of
date information or pieces missing so that I can't get something
working.
Does anyone have any suggestions of what I can try?
Or pointers to a tutorial would be ideal.

Thanks in advance,
Barry
