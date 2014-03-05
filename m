Return-Path: <cyrus@holtmann.org>
Message-ID: <53172F72.1050804@gmail.com>
Date: Wed, 05 Mar 2014 14:06:42 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: Antonio Ospite <ao2@ao2.it>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Controlling LEDs and rumble on sixaxis
References: <53164362.4060102@gmail.com> <20140304231118.3500abb703a7c1a7679d01f1@ao2.it>
In-Reply-To: <20140304231118.3500abb703a7c1a7679d01f1@ao2.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/03/14 22:11, Antonio Ospite wrote:
> 
> With older kernels you can already set LEDs and rumble by sending the
> HID output report 01 via hidraw (actually there is a regression
> preventing that via BT in some versions). See the code in the BlueZ

I think the kernels I use have this regressions as the plugin does not set anything.
(Szymon mentioned something like that)
could you please give me a link to the fix so I can track if and when they are fixed for me.

> sixaxis plugin or in the newer linux kernel for the report format.
> 
> With recent/newer kernels you can use the sysfs leds class under
> /sys/class/leds/ to control the LEDs and the force feedback api[1] to
> control the rumble.

sounds simple. is this functionality affected by the above regression?

> dbus is not necessary, but depending on your application you may want to
> use libudev to add the hotplug detection of the controller.
> 

I only mentioned dbus as I found I can use it to disconnect the controller (Bluetooth).
Happy to skip it altogether. If there is a better way?

Andrea

