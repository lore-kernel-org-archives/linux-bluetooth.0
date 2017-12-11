Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1512993166.4454.5.camel@ewol.com>
Subject: Re: raspberry bluez ble.Question?
To: liyj1 <liyj1@nationalchip.com>, linux-bluetooth@vger.kernel.org
Date: Mon, 11 Dec 2017 04:52:46 -0700
In-Reply-To: <6ae1dbd2-284e-5bd8-aa69-6b37f3caf286@nationalchip.com>
References: <6ae1dbd2-284e-5bd8-aa69-6b37f3caf286@nationalchip.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-12-11 at 17:00 +0800, liyj1 wrote:
> hello!
> 
>      I am a man who  use BLE. I want to use bluez. but I dont't know
> how 
> to do it.either in raspberry or in openwrt.
> 
> https://stackoverflow.com/questions/47385023/bluez-5-43-raspberry-pi-
> 3b-how-to-creat-gatt-in-pi3b-with-bluez-5-43-bluez-5-43
> 
>    I  asked in stack overflow. any advices will help.
> 
> God bless you. Good man live long.
> 
> 
I've been running it on an rpi3 for a few months. Works fine. Raspbian
has development tools where as openwrt doesn't. I think you would spend
lots of time integrating it into the openwrt build system. With the
rpi3, I cloned the git repository, compiled and installed it.

There's an older version in the Raspbian distribution, but was too out-
of-date for what I wanted to do.

Steve
 
