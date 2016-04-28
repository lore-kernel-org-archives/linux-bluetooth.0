Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 13:54:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hyuntak Lee <pphdev12@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to use BLE with kernel 3.4?
Message-ID: <20160428105457.GA17511@t440s>
References: <CAArnnE5VYZT7eG591qkBtOd8tL_NAr2H3vYCGNDFiCpVRA6ghg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAArnnE5VYZT7eG591qkBtOd8tL_NAr2H3vYCGNDFiCpVRA6ghg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tak,

On Thu, Apr 28, 2016, Hyuntak Lee wrote:
> I’m working on an embedded board of allwinner.
> I try to use BLE to communicate with mobile or other BLE peripheral devices.
> But kernel version of provided allwinner is ‘3.4’.
> I already know BlueZ5 BLE supports at least kernel 3.5 version, and
> ‘LEAdvertisingManager1’ is 4.1 and later versions support only.
> I would much prefer to use bluez, but the embedded system kernel
> version is too low.
> 
> Do you have any plan for supporting the embedded system?
> Almost embedded systems are low kernel version.
> 
> At this point, I can consider two options
> 
> 1. Try to backports for updating Linux BT subsystem of kernel 4.1 and
> later. And try to BLE with the most recent bluez.
> 2. Find and try another BLE stack implementations
> 
> Please give me some advice or an opinion.
> Thank you for your consideration.

It'd probably make sense for you to look into the kernel backports
project. We've used that to e.g. backport the latest Bluetooth subsystem
to some old kernel versions used by Android:

	https://backports.wiki.kernel.org/index.php/Main_Page

Johan
