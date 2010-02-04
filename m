Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100202143519.087e6a42@strolchi>
References: <f97b2b971001292013i3edd6bdajde0d9e39ed021fbd@mail.gmail.com>
	 <f97b2b971001292024u7ddf84b6gd063280efa6c1a4e@mail.gmail.com>
	 <f97b2b971001292040hf7537d2yeef91fecf4189c50@mail.gmail.com>
	 <20100202143519.087e6a42@strolchi>
Date: Thu, 4 Feb 2010 21:43:23 +0200
Message-ID: <f97b2b971002041143y13c9897cm8d7ba14244d76e0b@mail.gmail.com>
Subject: Re: Kernel panic when dongle is disconnected during sco connection
From: Ahmed Ragab <elmasri.ahmed@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan ,

I switched to kernel 2.6.33, however something strange happened
I couldn't bind more than 1 adapter (i have seven) giving the error
Address already in use , so i couldn't even test whether it works or
Not. any suggestions to solve this address already in use problem

Regards

Ahmed


On 2 February 2010 15:35, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> On Sat, 30 Jan 2010 06:40:58 +0200
> Ahmed Ragab <elmasri.ahmed@gmail.com> wrote:
>
>> I Forgot to mention kernel version 2.6.26 however i have the latest
>> bluez package
>
> Nobody around here will start looking at an ages old kernel voluntarily.
>
>> Please confirm this bug, Linux kernel hangs when usb bluetooth dongle
>> is disconnected
>
> Please confirm that this still is true in 2.6.33.
> If it's still there, then please provide the backtrace.
> --
> Stefan Seyfried
>
> "Any ideas, John?"
> "Well, surrounding them's out."
>
