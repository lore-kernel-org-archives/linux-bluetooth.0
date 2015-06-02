Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: 3dsp sample app and Bluez v5
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <556D3082.5060403@mort.net>
Date: Tue, 2 Jun 2015 07:00:13 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <37075208-AE18-4114-8029-40930FE22DA7@holtmann.org>
References: <556CC928.60503@mort.net> <C1D5C485-4FA0-4221-9F1A-A1A0941FE5F8@holtmann.org> <556CF450.2030107@mort.net> <4CBFCC0A-794F-4F78-A499-DFD083F29378@holtmann.org> <556D3082.5060403@mort.net>
To: Gary Mort <gary@mort.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gary,

>>>> Also I would really urge to read the 3DSP specification and understand that the only thing 3DSP is doing is synchronising shutter timings.
>>> That's all you need to make a pair of "Joo Janta 200 Super-Chromatic Peril Sensitive Sunglasses"...well that and some form of 'agitation' sensor[ie blood pressure, pulse, heart rate, etc].
>>> 
>>> Instead of running them as alternating 3D, I plan on running them as 'two player mode' and then I just need to control the time period they are "open" for based on agitation such that the more 'peril' you are in, the better they will shield you from actually observing the danger - a real life saver when faced with the Ravenous Bugblatter Beast of Traal and much cooler looking then a silly towel.
>>> 
>> If you want to control the glasses from a different machine, then you also need to get the Bluetooth clock information. Getting the proper clock in relation to the frame sync signal is hard. Normally it means you need some sort of extra wired trigger signal.
> 
> 
> I'm going to take a guess that you have never read Douglas Adams Hitchhikers Guide to the Galaxy?
> 
> The sunglasses I'm referring to are a comic device designed "keep the user calm" when they are in danger.  To do this, they darken, eventually to the point of pitch black, so as to keep the wearer from seeing the danger[and thus the wearer is not frightened].
> 
> I don't need to get a clock in relation to the frame sync signal - instead I am creating a fake timing signal.  To use large, unreasonable numbers:  The base signal would be designed for a perfect 50/50 split on open and closed.
> 
> Using a pulse monitor, as the users pulse increases, the ratio is modified.  Ideally, it would scale from 50/50...40/60...30/70...20/80...10/90...0/100
> 
> In this case, the open/close ratio is not being used to create a 3D effect - instead it is used to create a set of computer controlled variable sunglasses[over incredibly short periods of time, there is not much difference between glasses which absorb/reflect 80% of all incoming light or glasses which block 100% of incoming light 80% of the time]
> 
> Note: based on my reading of the 3DS spec, 0/100 is likely not possible - if the frequency for shut/open exceeds certain limits, then the glasses are supposed to open both shutters and ignore the timing information.   However, just because they are supposed to do that doesn't mean they do, so I can start with a a "reasonable" fake timing schedule and play from there.
> 
> While all of this is for learning and my own personal amusement, there actually is a real world use case - some people promote using glasses which obscure part of your vision in one eye in order to "exercise" the eye....mind you the people promoting this seem to be peddling very expensive custom designed glasses..  If I can get a reasonable range of shutter timing for cheap 3d glasses, it would be relatively simple to then port that over to a smartphone application so instead of spending lots of money on these glasses, people can use a cheap pair of 3DS bluetooth glasses.

then you need a controller with connectionless slave broadcast support in master mode. The only ones I know of are some Marvell PCIe/USB or SDIO based cards and one Broadcom dongle with the firmware update applied.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d049f4e513e861167361b06c7ca85f9e872c8cde

I wrote an extra long commit message for reference on how this dongle works and that its slave mode is actually broken. And I have run this against a 3D enabled TV and I can pretend to be 3D glasses.

However for the display side, I have never gotten any good timing values that would allow me to get the glasses do something useful. And hooking it up to a proper frame sync was then just too much work. Then again, the code is there and you can start toying with it.

Regards

Marcel

