Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] sbc: bitstream packing optimization for encoder.
From: Marcel Holtmann <marcel@holtmann.org>
To: Christian Hoene <hoene@uni-tuebingen.de>
Cc: 'Siarhei Siamashka' <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <00cc01c95c71$2b663c30$8232b490$@de>
References: <200812112227.07170.siarhei.siamashka@nokia.com>
	 <1229045974.22285.18.camel@violet.holtmann.net>
	 <200812121137.18041.siarhei.siamashka@nokia.com>
	 <1229079849.22285.43.camel@violet.holtmann.net>
	 <00c801c95c6d$9953dad0$cbfb9070$@de>
	 <1229095847.22285.93.camel@violet.holtmann.net>
	 <00cc01c95c71$2b663c30$8232b490$@de>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 16:56:56 +0100
Message-Id: <1229097416.22285.101.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> > > The sound quality of the fix point implementation still remains below
> > of the
> > > quality of the floating point version.
> > >
> > > Maybe, we shall support both depending on the performance
> > requirements?
> > 
> > I think we should focus a fixed point version. There should be no need
> > for floating point at all. If fixed point isn't good enough, then we
> > screwed it up.
> > 
> > And in case of embedded devices we are seriously limited with floating
> > point and doing that in software just doesn't work out. And this is
> > mostly not directly a performance problem. It is more a power
> > consumption problem. We don't wanna have A2DP drain the battery.
> >
> 
> It would help if we use 64 bit integers if a good sound is required but this
> is again a problem for embedded devices.

depends on. Looking at the libmad library, they do a pretty good job in
just using integers.

Regards

Marcel


