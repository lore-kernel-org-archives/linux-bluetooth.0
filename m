Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Keith Conger <keith.conger@gmail.com>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Szymon Janc <szymon.janc@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: android-bluez with usb adapter
Date: Fri, 20 Feb 2015 17:30:55 +0100
Message-ID: <1990072.y8qsfZFrAp@uw000953>
In-Reply-To: <CALUN+Ed-mxOBY4YT27VnaXDGEb6Mot47uMQ9jD7fNWn5DNAUEA@mail.gmail.com>
References: <CALUN+EfYdOffOSejMQh3vnLGX1PZmBqMXL8UhvL-UHK_2kZqFA@mail.gmail.com> <1729969.3pX2YMqAzZ@uw000953> <CALUN+Ed-mxOBY4YT27VnaXDGEb6Mot47uMQ9jD7fNWn5DNAUEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

On Friday 20 of February 2015 07:59:10 Keith Conger wrote:
> If I figure it out I'll let you know.  

I've already pushed a patch that should fix installation path on KK.

> I'm also trying to figure out
> why audio.a2dp.default and audio.sco.default aren't being build
> automatically.

Those libs are optional so you need to add them to PRODUCT_PACKAGES for your device.
Check for reference (this is for mako (Nexus 4)):
https://code.google.com/p/aosp-bluez/source/browse/device.mk?repo=device-lge-mako#183


> Thanks again,
> Keith
> 
> On Fri, Feb 20, 2015 at 3:05 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > Hi Keith,
> >
> > On Thursday 19 of February 2015 11:49:43 Keith Conger wrote:
> >> That did the trick! It appears bluetooth is now working!  Thanks again
> >> for all your help and patience!
> >
> > I'm glad that it works for you, feel free to get back if you would have any problems.
> >
> > As for those libs being installed in /system/lib instead of /system/lib/hw it looks
> > like we have some bug (but it appears only on KitKat, on Lollipop libs are correctly
> > installed in hw). I haven't tracked it why this happen yet.
> >
> >>
> >> Keith
> >>
> >> On Thu, Feb 19, 2015 at 10:25 AM, Keith Conger <keith.conger@gmail.com> wrote:
> >> > Sorry, I see the problem. ro.kernel.qemu is set to 1.
> >> >
> >> > I'm commenting out the check. And rebuilding.
> >> >
> >> > On Thu, Feb 19, 2015 at 9:31 AM, Keith Conger <keith.conger@gmail.com> wrote:
> >> >> Interesting, do you happen to know what I need to change in the kernel?
> >> >>
> >> >> Thanks again!
> >> >> Keith
> >> >>
> >> >> On Thu, Feb 19, 2015 at 9:08 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> >> >>> Hi Keith,
> >> >>>
> >> >>> On Thursday 19 of February 2015 09:06:01 Keith Conger wrote:
> >> >>>> Thanks I'll try that, do you know which BoardConfig option triggers
> >> >>>> its build? Eventually I'd like to send my work in getting Bluez in the
> >> >>>> bbbandroid repo to its maintainer.
> >> >>>
> >> >>> I think the problem with bt working from haltest but not from java is that this
> >> >>> board of your is using kernel for emulator.
> >> >>>
> >> >>>
> >> >>> This is from your logcat:
> >> >>> I/SystemServer(  595): No Bluetooh Service (emulator)
> >> >>>
> >> >>> and check this for reference:
> >> >>> http://androidxref.com/5.0.0_r2/xref/frameworks/base/services/java/com/android/server/SystemServer.java#487
> >> >>>
> >> >>>>
> >> >>>> Thanks,
> >> >>>> Keith
> >
> >>
> >
> > --
> > Best regards,
> > Szymon Janc
> 
> 
> 
> 

-- 
Best regards, 
Szymon Janc
