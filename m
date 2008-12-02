Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Dec 2008 12:15:20 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: Jaska Uimonen <jaska.uimonen@nokia.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
 encoding
In-Reply-To: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
Message-ID: <Pine.LNX.4.64.0812021203290.6346@xena.cft.ca.us>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 28 Nov 2008, Jaska Uimonen wrote:

> I did some testing on the current 8 band fixed point 
> encoding and it seems to attenuate frequencies below 800Hz 
> and above 18kHz. There might be some other stuff happening 
> also, because at least to me the bass seemed to lack some 
> "definition".

I have the same subjective impression: on (inexpensive) Motorola HT-820 
phones, A2DP is noticeably anemic compared to the same phones with the 
provided wire.

> I didn't quite understand how the current tables are calculated
> and how the filtering works so I wrote a new filtering function
> and calculated new filter tables for it. It is written
> using 16 bit fixed point without any platform specific optimizations.
> I only unrolled some loops etc. I tried to follow the
> flow chart in MPEG-1 annex c.

This is very exciting!  But it's been about 1.5 years since I read the A2DP 
spec so I can't remember: does the headphone require standard band 
breakpoints?  Or are the breakpoints implicit in the encoding, so if you 
adjust them to make better use of the Bluetooth bandwidth, the headphone 
will automatically go along?


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
