Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Keith Conger <keith.conger@gmail.com>
Cc: Szymon Janc <szymon.janc@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: android-bluez with usb adapter
Date: Wed, 18 Feb 2015 21:37:57 +0100
Message-ID: <2375594.LoByC1Hkos@leonov>
In-Reply-To: <CALUN+EcsmogUt4PU-sSM4peusX4gdnmAF=ou1ouj5y-QPSpq3Q@mail.gmail.com>
References: <CALUN+EfYdOffOSejMQh3vnLGX1PZmBqMXL8UhvL-UHK_2kZqFA@mail.gmail.com> <2179587.DtNQVsuMNH@leonov> <CALUN+EcsmogUt4PU-sSM4peusX4gdnmAF=ou1ouj5y-QPSpq3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

On Wednesday 18 of February 2015 13:05:16 Keith Conger wrote:
> Actually I had tried through the UI first and got the above logcat
> messages.  I then tried HAL test.
> 
> Just for some additional background I'm running kernel 3.8.13 and
> bluetooth modules from backports-3.18.1-1

If haltest is working that means kernel is configured properly.
 
> I have them at the bottom of "on boot" in the init.rc.  I have
> attached my kernel config and init.rc.

Could you attach full logcat starting from boot?

It looks like you are also missing audio.a2dp.default.so (it shouldn't affect 
BT enable but is needed for music streaming over BT).

> 
> I noticed in the mako example the following additional modules are
> loaded, I'm guessing I should add them also?
> insmod /system/lib/modules/rfcomm.ko
> insmod /system/lib/modules/bnep.ko

Yes, rfcomm is needed for OBEX (PBAP, OPP, MAP etc). Bnep is needed for PAN 
(BT tethering).

> 
> Thanks again for the help.
> Keith
> 

-- 
BR
Szymon Janc
