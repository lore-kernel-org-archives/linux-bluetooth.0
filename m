Return-Path: <cyrus@holtmann.org>
Message-ID: <d51df2e1e321efc18d74f3cc33bd4106.squirrel@mungewell.org>
In-Reply-To: <55A8AA15.2050802@ti.com>
References: <a48f30f621c508955ba989117690fe73.squirrel@mungewell.org>
    <dcf4c0f809904c54f453fe781e30adfe.squirrel@mungewell.org>
    <8297c42b69d89cb9326b938a9adaa997.squirrel@mungewell.org>
    <913a160c809900ee52e7c83350b4162f.squirrel@mungewell.org>
    <55A8AA15.2050802@ti.com>
Date: Fri, 17 Jul 2015 11:14:37 -0400
Subject: Re: Kernel Oops: btusb: 4.2rc1 System lockup with BT dongle insert -
 log attached
From: simon@mungewell.org
To: "Kim, Milo" <milo.kim@ti.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> So in summary this problem is showing up now as the 'User Helper
>> Fallback'
>> is now forced on, obviously the underlying problem needs to be fixed -
>> but
>> I don't know when it crept in.
>>
>
> The 'CONFIG_FW_LOADER_USER_HELPER_FALLBACK' enables to load firmware
> data manually by accessing /sys/class/firmware/<name>/data. It runs in
> case the firmware file is missing.
> This user helper fallback will be enabled if one of LP55xx driver is
> included in your dot config. Please see my patch below.
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/leds?id=b67893206fc0a0e8af87130e67f3d8ae553fc87c
>
> However, I'm not sure why this affects your system lockup. Can I have
> more details?

Hi Milo,
I'm not suggesting that your patch is the cause, just that it is an
'enabler' and and explains why the problem (system lockup when I plug USB
Bluetooth dongle in) appears now.

A full Oops log is further back in this thread:
http://www.spinics.net/lists/linux-bluetooth/msg63090.html


>> Will try building 4.1 with this option to see if it fails.

A very quick test as I was leaving the house this morning shows that 4.1
with 'CONFIG_FW_LOADER_USER_HELPER_FALLBACK' does not show the problem.

So at least we know the 'real' problem is a recent change to the code.
Simon

