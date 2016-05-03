Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160428105457.GA17511@t440s>
References: <CAArnnE5VYZT7eG591qkBtOd8tL_NAr2H3vYCGNDFiCpVRA6ghg@mail.gmail.com>
	<20160428105457.GA17511@t440s>
Date: Tue, 3 May 2016 15:37:01 +0900
Message-ID: <CAArnnE5ouyVAF8HTQwts=HU8532JCepuyv9HYHciKmPDYjK3BA@mail.gmail.com>
Subject: Re: How to use BLE with kernel 3.4?
From: Hyuntak Lee <pphdev12@gmail.com>
To: Hyuntak Lee <pphdev12@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2016-04-28 19:54 GMT+09:00 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Tak,
>
> On Thu, Apr 28, 2016, Hyuntak Lee wrote:
>> I’m working on an embedded board of allwinner.
>> I try to use BLE to communicate with mobile or other BLE peripheral devices.
>> But kernel version of provided allwinner is ‘3.4’.
>> I already know BlueZ5 BLE supports at least kernel 3.5 version, and
>> ‘LEAdvertisingManager1’ is 4.1 and later versions support only.
>> I would much prefer to use bluez, but the embedded system kernel
>> version is too low.
>>
>> Do you have any plan for supporting the embedded system?
>> Almost embedded systems are low kernel version.
>>
>> At this point, I can consider two options
>>
>> 1. Try to backports for updating Linux BT subsystem of kernel 4.1 and
>> later. And try to BLE with the most recent bluez.
>> 2. Find and try another BLE stack implementations
>>
>> Please give me some advice or an opinion.
>> Thank you for your consideration.
>
> It'd probably make sense for you to look into the kernel backports
> project. We've used that to e.g. backport the latest Bluetooth subsystem
> to some old kernel versions used by Android:
>
>         https://backports.wiki.kernel.org/index.php/Main_Page
>
Thank you for reply

My purpose is that execute 'bluez-5.39/test/example-advertisement'
script on 3.4 kernel version.
But LEAdvertisingManager1 require 4.1 and
later.(http://permalink.gmane.org/gmane.linux.bluez.kernel/63228)

So, According to your advice I try to backport the bluetooth subsystem
of 4.1 kernel to 3.4 kernel.
(http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/)

Thank you for your consideration.
Tak

> Johan
