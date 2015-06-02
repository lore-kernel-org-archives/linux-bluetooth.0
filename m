Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: 3dsp sample app and Bluez v5
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <556CF450.2030107@mort.net>
Date: Tue, 2 Jun 2015 03:13:15 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4CBFCC0A-794F-4F78-A499-DFD083F29378@holtmann.org>
References: <556CC928.60503@mort.net> <C1D5C485-4FA0-4221-9F1A-A1A0941FE5F8@holtmann.org> <556CF450.2030107@mort.net>
To: Gary Mort <gary@mort.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gary,

> >
> > do you actually have a Bluetooth controller that supports connectionless slave broadcast. If not, then you can not serve content for 3D Glasses.
> 
> Hmm.. I did not realize that might be the case.   I'll have to check it...worst case scenario I have a couple of usb TI CC2541 dongles as well as a couple of CC2541 sensortags, so I can always code it directly on to them.

actually connectionless slave broadcast is a BR/EDR classic feature. It is not Low Energy feature. It is not a popular feature.

> >
> > Also I would really urge to read the 3DSP specification and understand that the only thing 3DSP is doing is synchronising shutter timings.
> 
> That's all you need to make a pair of "Joo Janta 200 Super-Chromatic Peril Sensitive Sunglasses"...well that and some form of 'agitation' sensor[ie blood pressure, pulse, heart rate, etc].
> 
> Instead of running them as alternating 3D, I plan on running them as 'two player mode' and then I just need to control the time period they are "open" for based on agitation such that the more 'peril' you are in, the better they will shield you from actually observing the danger - a real life saver when faced with the Ravenous Bugblatter Beast of Traal and much cooler looking then a silly towel.
> 

If you want to control the glasses from a different machine, then you also need to get the Bluetooth clock information. Getting the proper clock in relation to the frame sync signal is hard. Normally it means you need some sort of extra wired trigger signal.

Regards

Marcel

