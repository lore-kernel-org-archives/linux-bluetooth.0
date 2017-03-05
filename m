Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APaWx59uH18QRtuLJgqAZD9Aws3LzQvWhtaA388bm+0HFg@mail.gmail.com>
References: <CAAu3APaWx59uH18QRtuLJgqAZD9Aws3LzQvWhtaA388bm+0HFg@mail.gmail.com>
From: Juha Kuikka <juha.kuikka@gmail.com>
Date: Sun, 5 Mar 2017 11:47:51 -0800
Message-ID: <CAKvrXUpZZMzs0w4G0isE8W0iLQFM+5sAjeX6E=ZKSNJqxhFBTg@mail.gmail.com>
Subject: Re: Connecting to Dual Shock 4 controller
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

An input event device should have been created for the controller,
usually /dev/input/eventX, you can use the python evdev library to
read it, here: https://python-evdev.readthedocs.io/en/latest/

Same method works for any device that is exposed through the linux
input framework.

As a side comment, bluez also has a plugin for pairing the DS4 over
USB, that could be of use to you as well.

 - Juha

On Sun, Mar 5, 2017 at 2:23 AM, Barry Byford <31baz66@gmail.com> wrote:
> Hello,
>
> I have a single board computer (SBC) running Linux that will be
> embedded inside of a project and run headless. I'm looking to have a
> Bluetooth remote control with some buttons on so that I can interact
> with the SBC.
>
> Looking around the house I have a few Sony DS4 controllers that could
> fit the bill of my remote control.
>
> On the SBC I've upgraded to BlueZ 5.44 and using bluetoothctl can pair
> the DS4 and trust it so that it connects on start-up.
> The piece I'm stuck on is how to access when buttons have been pressed
> from within a Python script.
>
> On the command line I can get the power level with this:
> $ cat /sys/class/power_supply/sony_controller_battery_40\:1b\:5f\:8e\:bf\:2a/capacity
> 70
>
> The only control on the DS4 I am able to see is the touch pad with:
> $ cat /dev/input/js0
>
> I've taken a look at Python3 Sockets which seem to have something
> about getting input from Bluetooth. Although not enough instructions
> for me to get it working with the DS4.
>
> I've had a good 'google' around and there seems to be lots of out of
> date information or pieces missing so that I can't get something
> working.
> Does anyone have any suggestions of what I can try?
> Or pointers to a tutorial would be ideal.
>
> Thanks in advance,
> Barry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
