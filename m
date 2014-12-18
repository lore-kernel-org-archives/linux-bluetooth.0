Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Veseli Veseljko <veseljko75@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: ShanWan Sixaxis PS3 controller
Date: Thu, 18 Dec 2014 12:24:59 +0100
Message-ID: <1432274.34ricBdst7@uw000953>
In-Reply-To: <20141217133613.GA18280@ubuntu.localnet>
References: <20141216172421.GA12748@ubuntu.localnet> <20141217133613.GA18280@ubuntu.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Veseli,

On Wednesday 17 of December 2014 14:36:13 Veseli Veseljko wrote:
> On Tuesday, 2014-12-16, at 18:24:21 +0100, Veseli Veseljko wrote:
> > I have a Sony PS3 Sixaxis compatible controller made by ShanWan. Is it
> > possible to make it work with bluez sixaxis plugin? I tried it on
> > Ubuntu 14.10 running Linux kernel 3.16 and bluez 5.20, compiled with
> > sixaxis option.
> 
> I added some DBGs into "/profiles/input/server.c" code and I found
> out that when dev_is_sixaxis is run, both vendor ID and product ID for
> this controller are 0x0000.
> 
> Any ideas?

Typically DS3 should be handled like this:

1. make sure you don't have sixad/qtsixa installed as it was reported that it
   conflicted with sixpair plugin (udev rules)
2. make sure you have sixaxis plugin installed - this plugin depends on udev
   so it is not builin into bluetoothd but loaded on start from
   /usr/lib/bluetooth/plugins 
3. plug it into USB (don't press PS button yet)
   you should see something like "sixaxis: compatible device connected: ...."
   in bluetoothd logs
4. unplug it
5. press PS button

Device should now connect and you should be asked (in bluetoothctl or UI) to
authorize connection. After that you should be able to reconnect without need
of pluging it with USB first.

This was mostly tested with genuine controllers. There were reports that some
of clone devices doesn't behave exactly the same ie. use different pid/vid or
don't report correct BT address over USB. Making them work would probably
require some extra work, but I don't have any of those clone devices.


-- 
Best regards, 
Szymon Janc
