Return-Path: <cyrus@holtmann.org>
From: "Simon Pickering" <S.G.Pickering@bath.ac.uk>
To: "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>,
	"'ext Brad Midgley'" <bmidgley@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200812311803.45279.siarhei.siamashka@nokia.com> <200901021807.17443.siarhei.siamashka@nokia.com> <d89ddf300901020827w20c48a5fgb37d35ff33ea5fd3@mail.gmail.com> <200901021911.20265.siarhei.siamashka@nokia.com>
Subject: RE: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Mon, 5 Jan 2009 11:08:39 -0000
Message-ID: <004501c96f25$f66d96a0$6f41268a@enpcsmm11>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200901021911.20265.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> > The ideal is to have portable devices mitigate this with dsp
hardware,
> > but we can't count on the hardware or the driver to be there in all
> > cases. (see https://garage.maemo.org/projects/dsp-sbc/ for some work
> > using the TI dsp)
> 
> Yes, I know about this project. And its maintainer should be 
> subscribed here
> too :)

He is now :)

> Making code a bit more C55x friendly is not difficult at all 
> and can be surely
> done.

I'm catching up on the flood of patches and will have a look at this
soon,

Cheers,


Simon

