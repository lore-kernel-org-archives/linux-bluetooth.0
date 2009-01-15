Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901152134.02777.siarhei.siamashka@nokia.com>
References: <200812311803.45279.siarhei.siamashka@nokia.com>
	 <1231210146.13304.15.camel@californication>
	 <200901091850.55032.siarhei.siamashka@nokia.com>
	 <200901152134.02777.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Fri, 16 Jan 2009 00:29:12 +0100
Message-Id: <1232062152.15331.2.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > > > The attached patch contains what I would consider to be a final
> > > > variant. MMX support is now complete. It works for both x86 and amd64,
> > > > has runtime autodetection of MMX availability, supports 4 and 8
> > > > subbands cases. I also ensured that only original MMX instructions are
> > > > used (and no SSE or other later additions), so the code should work
> > > > fine even on the old Pentium1 MMX. New MMX optimized functions produce
> > > > bit identical results when compared with bluez-4.25 release.
> > > >
> > > > With this patch applied, new filtering functions are noticeably faster
> > > > than than the old ones on x86 (so now they are both faster and have
> > > > better quality). Assembly optimizations for the other platforms can be
> > > > easily added too.
> > >
> > > can you re-base your patch against the latest tree and re-send the
> > > patch.
> >
> > Yes, I will submit an updated SIMD optimizations patchset in a few days.
> 
> Updated patches are attached.
> 
> Performance improvement when testing with big buck bunny soundtrack varies
> somewhere between 1.4x (4 subbands, MMX analysis filter, Intel Core2 CPU) and
> 2x factor (8 subbands, NEON analysis filter, ARM Cortex-A8 CPU). But these
> numbers are for default bitpool settings (32) and no joint stereo, this
> configuration is quite sensitive to analysis filter performance.
> 
> SIMD optimized code provides exactly the same output as C version.
> 
> But even with this optimization done, there are still a lot more things
> to improve. I'm going to improve input data permutation/endian
> conversion/channels deinterleaving next. Also scalefactors processing
> can be vectorized. Audio quality can be still improved by tweaking
> constant tables.

patch has been applied. Thanks.

Regards

Marcel


