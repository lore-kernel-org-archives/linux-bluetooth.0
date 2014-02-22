Return-Path: <cyrus@holtmann.org>
Message-ID: <53086B93.3080503@gmail.com>
Date: Sat, 22 Feb 2014 09:19:15 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: partial success with PS3 sixaxis
References: <52FBE820.6050701@gmail.com> <2534491.XllyezJg3g@uw000953> <52FFD116.2080902@gmail.com> <1484977.kC8PK9znGI@uw000953>
In-Reply-To: <1484977.kC8PK9znGI@uw000953>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 20/02/14 09:47, Szymon Janc wrote:
> Hi Andrea,
> 
> 
> This is a known regression on kernels >3.9. Should be fixed in 3.15 AFAIR.
> 

you really mean 3.15? not even 3.14?

then, my last issue is the following:

on Fedora 19 x86 things work with a Bluetooth 4.0 dongle

0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

running 3.12.11 (Fedora version)



unfortunately on a Raspberry Pi ARM6, Arch Linux with kernel 3.13.3 I get a strange kernel oops
after a random time of successful usage (could be 1 minute or 2 days)

I struggle to get a meaningful stack trace (the whole system dies, need to attach a serial console),
would you know of any issues on this architecture? it seems to be a NULL pointer exception.
The same crash happens with a different dongle (older bluetooth 2 from broadcom)


thanks

