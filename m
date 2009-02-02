Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with
 __builtin_clz
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200902021248.14496.siarhei.siamashka@nokia.com>
References: <200901290310.03440.siarhei.siamashka@nokia.com>
	 <200901301905.51624.siarhei.siamashka@nokia.com>
	 <1233507223.4809.4.camel@californication>
	 <200902021248.14496.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Mon, 02 Feb 2009 16:20:56 +0100
Message-Id: <1233588056.4668.16.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > > > > > cases.
> > > > >
> > > > > patch has been applied. Thanks.
> > > >
> > > > The tests have passed all.
> > > > http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/
> > >
> > > Thanks a lot for keeping an eye on bluez sbc implementation quality.
> >
> > are all patches applied now or am I missing one?
> 
> Yes, thanks, all the patches have been applied except for this one:
> http://marc.info/?l=linux-bluetooth&m=123319235104928&w=2
> 
> It should work fine, but I'm still considering how to better optimize
> processing of joint stereo, which might also require changing this code
> a bit. For now it's more like a demonstration that scale factors processing 
> can be SIMD optimized quite fine.
> 
> I will provide a more complete patch with optimizations for both scale factors
> and joint stereo a bit later.

please re-sent this one with a proper commit message and I apply it.
Then you can start from there is you like. Or send me a complete new
one.

Regards

Marcel


