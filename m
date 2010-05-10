Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE8859E.3090305@gmail.com>
Date: Mon, 10 May 2010 15:15:58 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>
CC: linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: magicmouse: claimed by neither input, hiddev nor hidraw
References: <j2idd18b0c31005101341o43b652c1zf8729f5f9a60e0d3@mail.gmail.com>  <alpine.LRH.2.00.1005102334140.14809@twin.jikos.cz> <s2odd18b0c31005101439v22d03bfdw4e65d7c4b8315b6a@mail.gmail.com> <alpine.LNX.2.00.1005102351220.28092@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1005102351220.28092@pobox.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/10/2010 02:52 PM, Jiri Kosina wrote:
> On Mon, 10 May 2010, Justin Mattock wrote:
>
>>>> with the magicmouse connecting i.g. I've had my system setup to use
>>>> the magicmouse with 2.6.33* with no issues now coming back after
>>>> sometime seems everything is connecting,but then no movement: (and
>>>> some thing in dmesg):
>>>> [  116.267993] magicmouse 0005:05AC:030D.0007: claimed by neither
>>>> input, hiddev nor hidraw
>>>> [  116.268053] magicmouse 0005:05AC:030D.0007: magicmouse hw start failed
>>>> using osx  magicmouse connects fine.
>>>> Using standard mightymouse everything connects.
>>>>   are there any reports of such things?
>>>
>>> Adding Michael Poole to CC.
>>>
>>> No, I haven't seen any such reports. First -- could you please provide
>>> complete dmesg?
>>
>> everything seems to be working o.k. now, just had to enable HIDRAW=y
>> maybe something changed to where I needed this(I remember never really
>> using hidraw, just HIDDEV(but could be wrong)).
>
> This sounds a bit strange.
>
> hidraw shouldn't be making too much difference in the case you describe.
> hidraw is basically just a mean of relaying HID events to userspace so
> that any driver/application in userspace can access them. But magicmouse
> driver is written completely in kernelspace.
>
> Does anything on your system have /dev/hidraw* nodes open? (you could
> check by lsof).
>


right now I see
/dev/hidraw0,1,2,3

./lsof | grep /dev
(showing bluetooth)

bluetooth 2020   root    0u      CHR                1,3       0t0 2551 
/dev/null
bluetooth 2020   root    1u      CHR                1,3       0t0 2551 
/dev/null
bluetooth 2020   root    2u      CHR                1,3       0t0 2551 
/dev/null
bluetooth 2020   root   14u      CHR              10,62       0t0 3895 
/dev/rfkill

I can try a bisect on this and see.


Justin P. Mattock
