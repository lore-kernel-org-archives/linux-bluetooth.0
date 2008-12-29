Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
 encoding
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Brad Midgley <bmidgley@gmail.com>,
	Jaska Uimonen <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200812291246.22288.siarhei.siamashka@nokia.com>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <1229994015.8047.27.camel@californication>
	 <200812231245.14493.siarhei.siamashka@nokia.com>
	 <200812291246.22288.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 12:56:11 +0100
Message-Id: <1230551771.15666.3.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > Right now I'm also doublechecking correctness of the code to ensure that
> > there are no overflows of other problems related to audio quality.
> 
> Here is (hopefully) the final revision of patch. I tested it with all the possible files
> that I could find or generate myself and it seems to work fine in all cases.
> 
> The code was reverted to use fabs macro. After all, looks like it is the right
> way to handle scale factors and adheres to the specification. The weird
> effects on sound quality related to the use of fabs and the modified macro
> which was tried as a replacement have been apparently the side effects of
> other bugs.
> 
> Also I have to admit that the change from
> http://marc.info/?l=linux-bluetooth&m=122946440507726&w=2
> is not needed and the original patch was in fact correct. The output of
> quantizer is strictly a positive number (unless there are bugs or overflows).
> This was also changed back.
> 
> Rounding for the values in the final analysis function output was removed
> (we already keep a lot of extra bits in output, so it does not matter for
> precision). Also the change of SCALE_OUT_BITS to 15 has a nice feature
> that the shifting of output values is not needed at all for 16-bit version
> (and naturally rounding is not needed here too), this should be good for
> performance.

I applied your patch to the upstream tree. Thanks for your work. I know
like to get feedback from other people if this helps us with the SBC
conformance testing and the audio quality.

Regards

Marcel


