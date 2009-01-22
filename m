Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] Audio quality improvement for 16-bit fixed point SBC encoder
Date: Thu, 22 Jan 2009 17:52:22 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901220111.29248.siarhei.siamashka@nokia.com> <004001c97c88$ce69da90$6b3d8fb0$@de>
In-Reply-To: <004001c97c88$ce69da90$6b3d8fb0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901221752.22081.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 22 January 2009 13:58:57 ext Christian Hoene wrote:
> Hello Siarhei,
>
> > Hello all,
> >
> > The attached patch quite noticeably minimizes rounding errors and
> > improves audio quality.
> >
> >
> > It is very interesting to see what a more advanced PEAQ test will show.
>
> The PEAQ results for latest version and the latest plus your latest patch
> can be found
> http://net.cs.uni-tuebingen.de/html/nexgenvoip/ in latest and latest+patch.
>
> Congratulations, the encoder is perfect now. Sometimes even better than the
> reference!

Thanks. The results have really exceeded my expectations. Looks like the
precision loss on rounding is now really insignificant so that the rounding
errors are now smaller than the sensitivity of PEAQ method. My guess is that
very minor differences in results in both directions are just some kind of
random deviation and can't be clearly interpreted as an advantage of either
implementation.

So appears that the perceived quality should be really good now (PSNR rating
is a bit worse than reference, but it is not an objective way to measure
audio quality). Looks like there is even no need to introduce a high precision
configuration option for enabling 32-bit fixed point implementation in
practice. It makes everything a bit easier :)

-- 
Best regards,
Siarhei Siamashka
