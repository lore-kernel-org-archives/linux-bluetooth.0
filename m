Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALUN+EfrG1o8VsTWjMxW7Y4NGe=-E3M_hz_618ToAG4QHwPZKA@mail.gmail.com>
References: <CALUN+EfYdOffOSejMQh3vnLGX1PZmBqMXL8UhvL-UHK_2kZqFA@mail.gmail.com>
	<2179587.DtNQVsuMNH@leonov>
	<CALUN+EcsmogUt4PU-sSM4peusX4gdnmAF=ou1ouj5y-QPSpq3Q@mail.gmail.com>
	<2375594.LoByC1Hkos@leonov>
	<CALUN+EfrG1o8VsTWjMxW7Y4NGe=-E3M_hz_618ToAG4QHwPZKA@mail.gmail.com>
Date: Thu, 19 Feb 2015 08:39:51 -0700
Message-ID: <CALUN+EfQkYuwfh5tqes0mKmGopshRhoWU823MNVE_EKwHsf_ZQ@mail.gmail.com>
Subject: Re: android-bluez with usb adapter
From: Keith Conger <keith.conger@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Szymon Janc <szymon.janc@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Can't seem to figure out why audio.a2dp.default.so isn't being built.

It seems almost like its not even trying to start bluetoothd.  I
wrapped it with strace, and it didn't create a trace log.

On Wed, Feb 18, 2015 at 3:21 PM, Keith Conger <keith.conger@gmail.com> wrote:
> Ok I added the additional kernel modules.
>
> Here is a logcat from boot to turning on bluetooth in the UI.
>
> For some reason  audio.a2dp.default.so didn't get built, I'm looking into that.
>
> Thanks,
> Keith
>
> On Wed, Feb 18, 2015 at 1:37 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> Hi Keith,
>>
>> On Wednesday 18 of February 2015 13:05:16 Keith Conger wrote:
>>> Actually I had tried through the UI first and got the above logcat
>>> messages.  I then tried HAL test.
>>>
>>> Just for some additional background I'm running kernel 3.8.13 and
>>> bluetooth modules from backports-3.18.1-1
>>
>> If haltest is working that means kernel is configured properly.
>>
>>> I have them at the bottom of "on boot" in the init.rc.  I have
>>> attached my kernel config and init.rc.
>>
>> Could you attach full logcat starting from boot?
>>
>> It looks like you are also missing audio.a2dp.default.so (it shouldn't affect
>> BT enable but is needed for music streaming over BT).
>>
>>>
>>> I noticed in the mako example the following additional modules are
>>> loaded, I'm guessing I should add them also?
>>> insmod /system/lib/modules/rfcomm.ko
>>> insmod /system/lib/modules/bnep.ko
>>
>> Yes, rfcomm is needed for OBEX (PBAP, OPP, MAP etc). Bnep is needed for PAN
>> (BT tethering).
>>
>>>
>>> Thanks again for the help.
>>> Keith
>>>
>>
>> --
>> BR
>> Szymon Janc
>
>
>
> --
> Keith Conger
> keith DOT conger AT gmail DOT com
> http://thecongers.org



-- 
Keith Conger
keith DOT conger AT gmail DOT com
http://thecongers.org
