Return-Path: <cyrus@holtmann.org>
Message-ID: <492FFF3B.7000702@powercraft.nl>
Date: Fri, 28 Nov 2008 15:24:59 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Jaska Uimonen <jaska.uimonen@nokia.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
 encoding
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <1227881932.31311.2.camel@violet.holtmann.net>
In-Reply-To: <1227881932.31311.2.camel@violet.holtmann.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi Jaska,
> 
>> I did some testing on the current 8 band fixed point 
>> encoding and it seems to attenuate frequencies below 800Hz 
>> and above 18kHz. There might be some other stuff happening 
>> also, because at least to me the bass seemed to lack some 
>> "definition".
>>
>> I didn't quite understand how the current tables are calculated
>> and how the filtering works so I wrote a new filtering function
>> and calculated new filter tables for it. It is written
>> using 16 bit fixed point without any platform specific optimizations.
>> I only unrolled some loops etc. I tried to follow the
>> flow chart in MPEG-1 annex c.
>>
>> With this new filtering the low and high frequencies are there, but
>> I haven't done any more thorough testing. At least it sounds
>> a little bit better to my ears :)
> 
> thanks for looking at it. I am seriously lost when it comes to audio
> codecs and my ears normally don't count for much.
> 
> So do you think we should throw all away any you start over providing a
> correct implementation with fixed point integer and then we start
> optimizing step by step (while testing against SBC conformance) or how
> should we continue. For sure we have to fix our codec.
> 
> Regards
> 
> Marcel

Hi Jaska, Thank you so much for improving the codecs :-D it was on my
long standing wish list. You want to receive a few Dutch stroopwafels
for your efforts :-D

Is the patch you provided working against the latest git? Marcel would
you be willing to review the patch for code style, hidden issues etcetera.

I would love to test this patch this weekend and apply it to the latest git.

I am an heavy stereo bluetooth user and will notice glitches and quality
distortions on my bluetooth speakers and headsets.

Best regards,

Jelle
