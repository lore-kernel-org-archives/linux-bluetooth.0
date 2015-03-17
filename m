Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ssagarr Patil <hugarsagar@outlook.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez5 pairing devices
Date: Tue, 17 Mar 2015 19:41:43 +0100
Message-ID: <12627750.IG3ACNRtuD@leonov>
In-Reply-To: <46068BD2-CF33-4617-80DB-5AE5C1FCA364@holtmann.org>
References: <BAY176-W679B1127159C091585D3AD3030@phx.gbl> <46068BD2-CF33-4617-80DB-5AE5C1FCA364@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tuesday 17 of March 2015 09:42:44 Marcel Holtmann wrote:
> Hi Sagar,
> 
> >>>>> I am very new to bluetooth, so sorry for a novice query.
> >>>>> 
> >>>>> 1: I am using 2.6.37 Linux kernel, can bluez5 stack be used on this or
> >>>>> should I use bluez4 ? 2: With bluez5 I am able to scan devices and
> >>>>> also see the device on other device but I am not able to pair them Is
> >>>>> there some sort of deamon required to pair them ?
> >>>> 
> >>>> BlueZ 5 requires a Bluetooth subsystem with management API support. So
> >>>> at least kernel 3.4 or you have to use Linux backports to at least
> >>>> bring the Bluetooth subsystem to your 2.6.37 kernel. And I have heard
> >>>> of success from people doing that, but I have not personally done
> >>>> that.>>> 
> >>> Probably that would take me more time in back porting. In case of 2.6.37
> >>> what version of bluez4 would be best ?>> 
> >> the Linux backports project does that automatically. Give it a try. You
> >> are not the person with this problem, but it is not something were BlueZ
> >> upstream will be of much assistance.> 
> > Any quick pointers on doing this ?
> 
> https://backports.wiki.kernel.org/
> 
> >> I think that our android/README has even some instructions on how to get
> >> that started for an Android build. You might be able to adapt that
> >> quickly.> 
> > I am more interested in Linux.
> 
> It is still running the same Linux kernel. That is why I said, you might be
> able to adapt that to your needs.

Just an note that recent backports dropped support for kernels older than 3.0.
So some older release might be needed for 2.6.37.

-- 
BR
Szymon Janc
