Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Mar 2014 23:11:18 +0100
From: Antonio Ospite <ao2@ao2.it>
To: Andrea <mariofutire@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Controlling LEDs and rumble on sixaxis
Message-Id: <20140304231118.3500abb703a7c1a7679d01f1@ao2.it>
In-Reply-To: <53164362.4060102@gmail.com>
References: <53164362.4060102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrea,

On Tue, 04 Mar 2014 21:19:30 +0000
Andrea <mariofutire@gmail.com> wrote:

> Hi,
> 
> I would like to be able to control from a client app the LEDs and
> rumble of the sixaxis PS3 controller.
> 
> As far as I understand the kernel 3.15 will allow LEDs to be set by
> bluez when the controller is connected.  If I wanted to change the
> LEDs in my app, would this something that needs to be done by bluez?
> Can I write to some device and bypass bluez?

With older kernels you can already set LEDs and rumble by sending the
HID output report 01 via hidraw (actually there is a regression
preventing that via BT in some versions). See the code in the BlueZ
sixaxis plugin or in the newer linux kernel for the report format.

With recent/newer kernels you can use the sysfs leds class under
/sys/class/leds/ to control the LEDs and the force feedback api[1] to
control the rumble.

No need to "bypass" BlueZ, the BlueZ sixaxis plugin sets the LEDs when
it detects the controller in order to tell the user the controller
number, but after that you are free to change the LEDs as you want.

[1] https://www.kernel.org/doc/Documentation/input/ff.txt

> Would this be a job for dbus?
>

dbus is not necessary, but depending on your application you may want to
use libudev to add the hotplug detection of the controller.

> I use the sixaxis to control an app on the Pi, and given the lack of
> feedbacks from the Pi, the LEDs and rumble could help me on that
> front.
> 
> Does it make sense to do it?
> 

Why not?

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
