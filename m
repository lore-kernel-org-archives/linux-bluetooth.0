Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: AR3011 Device Under Test
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHuuS6FJUF0mO1DRe9mzC2h7Nx_LXL26wHSFzgVgeH8ZcN4jzQ@mail.gmail.com>
Date: Wed, 15 Nov 2017 14:53:41 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3F85D5AE-FCCF-47C7-A520-6D2DFCCBA458@holtmann.org>
References: <CAHuuS6G0JCOHUiohpzzskg7x6kib-Y-ToibjX6vf4vTbwYkLcQ@mail.gmail.com>
 <9DD19A09-6011-49DC-9B03-05D783C3DC61@holtmann.org>
 <CAHuuS6FJUF0mO1DRe9mzC2h7Nx_LXL26wHSFzgVgeH8ZcN4jzQ@mail.gmail.com>
To: Julien Massot <massot.julien@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Julien,

>>> Does anyone already succeed to put an AR3011 (managed by ATH3K driver),
>>> under radio test condition ?
>> 
>> you can use the HCI commands for test mode.
> 
> Thanks a lot, I didn't search the right way, and the solution was in bluetooth
> specification.
> 
> Was stuck on WiFi way of thinking in which any constructor have it's own way.
> 
> So for future people looking at this topic please read
> BLUETOOTH SPECIFICATION Version 2.0 + EDR [vol 3]
> "7.6.3 Enable Device Under Test Mode Command"

I think that I added /sys/kernel/debug/bluetooth/hci0/dut_mode or something like that.

Regards

Marcel

