Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d942deb8e0bd715b4ce207a874b0bda4.squirrel@mungewell.org>
References: <AM3PR01MB211848A73CABF9631293C19F9030@AM3PR01MB211.eurprd01.prod.exchangelabs.com>
	<d942deb8e0bd715b4ce207a874b0bda4.squirrel@mungewell.org>
Date: Mon, 30 Nov 2015 11:39:40 +0200
Message-ID: <CABBYNZJshjM4VE1CxoYZvHDs8K8J681gxjjGPWqrkpzaftv57w@mail.gmail.com>
Subject: Re: Exploring Bluez alternatives
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Simon Wood <simon@mungewell.org>
Cc: Ad Zeevaarders <ad.zeevaarders@veynex.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 27, 2015 at 5:51 PM, Simon Wood <simon@mungewell.org> wrote:
> On Fri, November 27, 2015 1:32 am, Ad Zeevaarders wrote:
>> Hello,
>>
>>
>> I am an intern at a company. After having developed a few Low Energy
>> applications using BlueZ, the DBus-way and the mgmt way, I was ready for
>> my new assignment. The applications I developed were targeted at an
>> embedded ARM platform running Linux without DBus. The new application I
>> need to develop needs to connect to a device, receive some values using
>> indications, then disconnect.

Well you can in fact use most of the protocols without D-Bus, in fact
that what we did in BlueZ for Android.

>> To my amazement my employer told me that they wanted me to explore
>> alternatives to BlueZ, as they were unsure of the reliability and
>> especially the performance. They sent me a Wikipedia page listing several
>> embedded Bluetooth stacks, like BlueCode+, and asked me to prove, for
>> every single stack, why Bluez was 'better'. My initial response was
>> "Because it is the official supported Bluetooth stack for Linux, our
>> target development OS." Exploring the other solutions, I could not find
>> any rationale as to why I would choose a different protocol stack.

Most of the userspace stack will probably perform worst than BlueZ and
cannot offer the same level of integration with Linux kernel both at
the driver level, USB, UART, etc and other protocols like 6LowPAN
which will probably make them less reliable as well. I actually never
seem any other stack that has emulation support and doing end to end
tests like BlueZ can do.

>
> Hi,
> This maybe of no interest, but I wanted to point out another alternate
> 'community written' stack....
>
> http://bluekitchen-gmbh.com/btstack/
>
> Started as a completely Free project, but was then relicensed to be 'free
> for non-commercial'. Depending on what you need it might be usable for
> your projects.

If I would have started a new stack for Linux Id probably use the
kernel parts otherwise it is pretty much bluedroid all over again.

> BTW you have a hard task if employers just don't like Bluez :-( To me (as
> just a user) the code size would be the major detractor, but it does work
> pretty well.

There are actually a lot of tools involved in BlueZ, just the emulator
and the monitor already account for quite a big part of the userspace.
Anyway Im pretty sure the authors of this btstack do use BlueZ tools
to develop since they have things like HCI_DUMP_BLUEZ.

> Good luck,
> Simon
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
