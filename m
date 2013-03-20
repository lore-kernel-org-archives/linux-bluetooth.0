Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Mar 2013 13:58:13 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Graham Burnside <graham@somethingshocking.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: ralink rt3290/3298 pcie
Message-ID: <20130320165813.GA7522@joana>
References: <5148EB5B.6030104@somethingshocking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5148EB5B.6030104@somethingshocking.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Graham,

* Graham Burnside <graham@somethingshocking.com> [2013-03-19 22:48:59 +0000]:

> Hi,
> 
> I was wondering if anyone had had a look into or discussed this wifi /
> bluetooth combo card with ralink? It came present in my new HP laptop,
> so I'm guessing its quite common.
> 
> I have the wifi working perfectly from the rt2x00 backports, but can't
> find any mention of the bluetooth device. I have also emailed ralink, so
> will post anything useful back here.
> 
> Details as follows:
> 
>            +-1c.0-[01]--+-00.0  Ralink corp. Device 3290
>            |                        \-00.1  Ralink corp. Device 3298

You are saying that you don't even see the device with 'hciconfig', right?

So please post the output of /sys/kernel/debug/usb/devices for the bluetooth
device here so we can more information about this device.

	Gustavo
