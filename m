Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Mon, 2 Feb 2009 12:48:14 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200901290310.03440.siarhei.siamashka@nokia.com> <200901301905.51624.siarhei.siamashka@nokia.com> <1233507223.4809.4.camel@californication>
In-Reply-To: <1233507223.4809.4.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902021248.14496.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sunday 01 February 2009 18:53:43 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > > > > cases.
> > > >
> > > > patch has been applied. Thanks.
> > >
> > > The tests have passed all.
> > > http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/
> >
> > Thanks a lot for keeping an eye on bluez sbc implementation quality.
>
> are all patches applied now or am I missing one?

Yes, thanks, all the patches have been applied except for this one:
http://marc.info/?l=linux-bluetooth&m=123319235104928&w=2

It should work fine, but I'm still considering how to better optimize
processing of joint stereo, which might also require changing this code
a bit. For now it's more like a demonstration that scale factors processing 
can be SIMD optimized quite fine.

I will provide a more complete patch with optimizations for both scale factors
and joint stereo a bit later.

-- 
Best regards,
Siarhei Siamashka
