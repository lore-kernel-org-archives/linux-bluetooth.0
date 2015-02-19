Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALUN+Edm_YPzNd9Lwm+zBJnqO3_0=r+CrQr1TdOUAvd7qZUQDA@mail.gmail.com>
References: <CALUN+EfYdOffOSejMQh3vnLGX1PZmBqMXL8UhvL-UHK_2kZqFA@mail.gmail.com>
	<20150219160213.GB32397@aemeltch-MOBL1>
	<CALUN+EdMNvfnjRE3ks2EVUxGcHWYoVey+SSx9qPec9r+QCqbOg@mail.gmail.com>
	<2660784.otTN7klW3S@uw000953>
	<CALUN+Edm_YPzNd9Lwm+zBJnqO3_0=r+CrQr1TdOUAvd7qZUQDA@mail.gmail.com>
Date: Thu, 19 Feb 2015 10:25:57 -0700
Message-ID: <CALUN+Ecm_0381JuAQYoM37zj+EZHoVoLgayECSRrzmd2BOvwAg@mail.gmail.com>
Subject: Re: android-bluez with usb adapter
From: Keith Conger <keith.conger@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Szymon Janc <szymon.janc@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, I see the problem. ro.kernel.qemu is set to 1.

I'm commenting out the check. And rebuilding.

On Thu, Feb 19, 2015 at 9:31 AM, Keith Conger <keith.conger@gmail.com> wrote:
> Interesting, do you happen to know what I need to change in the kernel?
>
> Thanks again!
> Keith
>
> On Thu, Feb 19, 2015 at 9:08 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> Hi Keith,
>>
>> On Thursday 19 of February 2015 09:06:01 Keith Conger wrote:
>>> Thanks I'll try that, do you know which BoardConfig option triggers
>>> its build? Eventually I'd like to send my work in getting Bluez in the
>>> bbbandroid repo to its maintainer.
>>
>> I think the problem with bt working from haltest but not from java is that this
>> board of your is using kernel for emulator.
>>
>>
>> This is from your logcat:
>> I/SystemServer(  595): No Bluetooh Service (emulator)
>>
>> and check this for reference:
>> http://androidxref.com/5.0.0_r2/xref/frameworks/base/services/java/com/android/server/SystemServer.java#487
>>
>>>
>>> Thanks,
>>> Keith
>>>
>>> On Thu, Feb 19, 2015 at 9:02 AM, Andrei Emeltchenko
>>> <andrei.emeltchenko.news@gmail.com> wrote:
>>> > Hi Keith,
>>> >
>>> > On Thu, Feb 19, 2015 at 08:39:51AM -0700, Keith Conger wrote:
>>> >> Can't seem to figure out why audio.a2dp.default.so isn't being built.
>>> >>
>>> >
>>> > This depends on your Android board configuration.
>>> >
>>> > afaik you can still build it locally with "mm" and copy to target
>>> >
>>> > adb sync should be enough
>>> >
>>> > Best regards
>>> > Andrei Emeltchenko
>>> >
>>> >
>>> >> It seems almost like its not even trying to start bluetoothd.  I
>>> >> wrapped it with strace, and it didn't create a trace log.
>>> >>
>>> >> On Wed, Feb 18, 2015 at 3:21 PM, Keith Conger <keith.conger@gmail.com> wrote:
>>> >> > Ok I added the additional kernel modules.
>>> >> >
>>> >> > Here is a logcat from boot to turning on bluetooth in the UI.
>>> >> >
>>> >> > For some reason  audio.a2dp.default.so didn't get built, I'm looking into that.
>>> >> >
>>> >> > Thanks,
>>> >> > Keith
>>> >> >
>>> >> > On Wed, Feb 18, 2015 at 1:37 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>>> >> >> Hi Keith,
>>> >> >>
>>> >> >> On Wednesday 18 of February 2015 13:05:16 Keith Conger wrote:
>>> >> >>> Actually I had tried through the UI first and got the above logcat
>>> >> >>> messages.  I then tried HAL test.
>>> >> >>>
>>> >> >>> Just for some additional background I'm running kernel 3.8.13 and
>>> >> >>> bluetooth modules from backports-3.18.1-1
>>> >> >>
>>> >> >> If haltest is working that means kernel is configured properly.
>>> >> >>
>>> >> >>> I have them at the bottom of "on boot" in the init.rc.  I have
>>> >> >>> attached my kernel config and init.rc.
>>> >> >>
>>> >> >> Could you attach full logcat starting from boot?
>>> >> >>
>>> >> >> It looks like you are also missing audio.a2dp.default.so (it shouldn't affect
>>> >> >> BT enable but is needed for music streaming over BT).
>>> >> >>
>>> >> >>>
>>> >> >>> I noticed in the mako example the following additional modules are
>>> >> >>> loaded, I'm guessing I should add them also?
>>> >> >>> insmod /system/lib/modules/rfcomm.ko
>>> >> >>> insmod /system/lib/modules/bnep.ko
>>> >> >>
>>> >> >> Yes, rfcomm is needed for OBEX (PBAP, OPP, MAP etc). Bnep is needed for PAN
>>> >> >> (BT tethering).
>>> >> >>
>>> >> >>>
>>> >> >>> Thanks again for the help.
>>> >> >>> Keith
>>> >> >>>
>>> >> >>
>>> >> >> --
>>> >> >> BR
>>> >> >> Szymon Janc
>>> >> >
>>> >> >
>>> >> >
>>> >> > --
>>> >> > Keith Conger
>>> >> > keith DOT conger AT gmail DOT com
>>> >> > http://thecongers.org
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> Keith Conger
>>> >> keith DOT conger AT gmail DOT com
>>> >> http://thecongers.org
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>>
>> --
>> Best regards,
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
