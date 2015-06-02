Return-Path: <cyrus@holtmann.org>
Subject: Re: 3dsp sample app and Bluez v5
To: Marcel Holtmann <marcel@holtmann.org>
References: <556CC928.60503@mort.net>
 <C1D5C485-4FA0-4221-9F1A-A1A0941FE5F8@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
From: Gary Mort <gary@mort.net>
Message-ID: <556CF450.2030107@mort.net>
Date: Mon, 1 Jun 2015 20:09:52 -0400
MIME-Version: 1.0
In-Reply-To: <C1D5C485-4FA0-4221-9F1A-A1A0941FE5F8@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



On 06/01/2015 05:23 PM, Marcel Holtmann wrote:
 >
 > do you actually have a Bluetooth controller that supports 
connectionless slave broadcast. If not, then you can not serve content 
for 3D Glasses.

Hmm.. I did not realize that might be the case.   I'll have to check 
it...worst case scenario I have a couple of usb TI CC2541 dongles as 
well as a couple of CC2541 sensortags, so I can always code it directly 
on to them.

 >
 > Also I would really urge to read the 3DSP specification and 
understand that the only thing 3DSP is doing is synchronising shutter 
timings.

That's all you need to make a pair of "Joo Janta 200 Super-Chromatic 
Peril Sensitive Sunglasses"...well that and some form of 'agitation' 
sensor[ie blood pressure, pulse, heart rate, etc].

Instead of running them as alternating 3D, I plan on running them as 
'two player mode' and then I just need to control the time period they 
are "open" for based on agitation such that the more 'peril' you are in, 
the better they will shield you from actually observing the danger - a 
real life saver when faced with the Ravenous Bugblatter Beast of Traal 
and much cooler looking then a silly towel.
