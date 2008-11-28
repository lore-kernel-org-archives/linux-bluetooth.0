Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
	encoding
From: Jaska Uimonen <jaska.uimonen@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1227881932.31311.2.camel@violet.holtmann.net>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <1227881932.31311.2.camel@violet.holtmann.net>
Content-Type: text/plain
Date: Fri, 28 Nov 2008 17:14:35 +0200
Message-Id: <1227885275.20555.30.camel@esdhcp03999.research.nokia.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

So in general I would just like to hear comments 
about the quality on this one. So does it fix the 
quality issues or is there still some problems. 

If someone just has the measurement system ready and would 
be able to run some sound through... This is all 
16 bit fixed point and we have an option to go to 32 bit 
if necessary.

About the optimizations... I myself use a vectorizing 
compiler, which optimizes this kind of C-code very 
well. So we could keep the "reference" fix point 
in the code base (if it actually works now...) and 
then do optimizations to different platform if 
one wishes. But I'm really open to how you would like 
to do it.

br,
Jaska
  


On Fri, 2008-11-28 at 15:18 +0100, ext Marcel Holtmann wrote:
> Hi Jaska,
> 
> > I did some testing on the current 8 band fixed point 
> > encoding and it seems to attenuate frequencies below 800Hz 
> > and above 18kHz. There might be some other stuff happening 
> > also, because at least to me the bass seemed to lack some 
> > "definition".
> > 
> > I didn't quite understand how the current tables are calculated
> > and how the filtering works so I wrote a new filtering function
> > and calculated new filter tables for it. It is written
> > using 16 bit fixed point without any platform specific optimizations.
> > I only unrolled some loops etc. I tried to follow the
> > flow chart in MPEG-1 annex c.
> > 
> > With this new filtering the low and high frequencies are there, but
> > I haven't done any more thorough testing. At least it sounds
> > a little bit better to my ears :)
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
> 
> 
