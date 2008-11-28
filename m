Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
	encoding
From: Marcel Holtmann <marcel@holtmann.org>
To: Jaska Uimonen <jaska.uimonen@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
Content-Type: text/plain
Date: Fri, 28 Nov 2008 15:18:52 +0100
Message-Id: <1227881932.31311.2.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaska,

> I did some testing on the current 8 band fixed point 
> encoding and it seems to attenuate frequencies below 800Hz 
> and above 18kHz. There might be some other stuff happening 
> also, because at least to me the bass seemed to lack some 
> "definition".
> 
> I didn't quite understand how the current tables are calculated
> and how the filtering works so I wrote a new filtering function
> and calculated new filter tables for it. It is written
> using 16 bit fixed point without any platform specific optimizations.
> I only unrolled some loops etc. I tried to follow the
> flow chart in MPEG-1 annex c.
> 
> With this new filtering the low and high frequencies are there, but
> I haven't done any more thorough testing. At least it sounds
> a little bit better to my ears :)

thanks for looking at it. I am seriously lost when it comes to audio
codecs and my ears normally don't count for much.

So do you think we should throw all away any you start over providing a
correct implementation with fixed point integer and then we start
optimizing step by step (while testing against SBC conformance) or how
should we continue. For sure we have to fix our codec.

Regards

Marcel


