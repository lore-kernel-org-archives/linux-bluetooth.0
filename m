Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.00.1005102334140.14809@twin.jikos.cz>
References: <j2idd18b0c31005101341o43b652c1zf8729f5f9a60e0d3@mail.gmail.com>
	 <alpine.LRH.2.00.1005102334140.14809@twin.jikos.cz>
Date: Mon, 10 May 2010 14:39:51 -0700
Message-ID: <s2odd18b0c31005101439v22d03bfdw4e65d7c4b8315b6a@mail.gmail.com>
Subject: Re: magicmouse: claimed by neither input, hiddev nor hidraw
From: Justin Mattock <justinmattock@gmail.com>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, May 10, 2010 at 2:34 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 10 May 2010, Justin Mattock wrote:
>
>> is it me, or is there something wrong
>> with the magicmouse connecting
>> i.g. I've had my system setup to use the
>> magicmouse with 2.6.33* with no issues
>> now coming back after sometime
>> seems everything is connecting,but then no movement:
>> (and some thing in dmesg):
>> [  116.267993] magicmouse 0005:05AC:030D.0007: claimed by neither
>> input, hiddev nor hidraw
>> [  116.268053] magicmouse 0005:05AC:030D.0007: magicmouse hw start failed
>>
>> using osx  magicmouse connects fine.
>> Using standard mightymouse everything connects.
>>  are there any reports of such things?
>
> Adding Michael Poole to CC.
>
> No, I haven't seen any such reports. First -- could you please provide
> complete dmesg?
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>
>

everything seems to be working o.k. now,
just had to enable HIDRAW=y
maybe something changed to where
I needed this(I remember never really
using hidraw, just HIDDEV(but could be wrong)).

-- 
Justin P. Mattock
