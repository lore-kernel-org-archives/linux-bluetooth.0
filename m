Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901021807.17443.siarhei.siamashka@nokia.com>
References: <200812311803.45279.siarhei.siamashka@nokia.com>
	 <1230800283.4530.3.camel@californication>
	 <200901021807.17443.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 03:49:06 +0100
Message-Id: <1231210146.13304.15.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > > This is a preliminary preview of SIMD optimizations for SBC encoder
> > > analysis filter.
> > >
> > > It already contains MMX optimization for 4 subbands case (yes, all this
> > > insane amount of extra lines of code finally starts to pay off) ;)
> > >
> > > Important notice: in order to test MMX optimizations, you need to have
> > > extra '-mmmx' command line option passed to gcc. Runtime MMX
> > > autodetection can be easily added later. Also don't forget to pass -s4
> > > option to sbcenc because 8 subbands case is still not accelerated. By the
> > > way, SSE2 is twice wider than MMX and should be a lot faster. Though MMX
> > > is supported on virtually every x86 cpu that is in use nowadays and can
> > > be considered "lowest common denominator".
> > >
> > > My quick benchmark showed that the performance gets improved about ~10%
> > > overall (and about twice better for the analysis filter function alone)
> > > when compared with bluez-4.23 release which had the old buggy code.
> > > Improvement is much more noticeable over the release 4.25 which contains
> > > a new fixed and mostly nonoptimized filter.
> > >
> > > So now the performance is better than ever. And I guess, all the
> > > platforms should use SIMD optimizations nowadays, so they should gain
> > > performance improvements too. Those 'anamatrix' style optimizations in
> > > older code feel so much like the previous century ;)
> > >
> > > I'm going to primarily focus on NEON and maybe ARMv6 SIMD optimizations,
> > > these will be submitted a bit later. Also, as I have already written
> > > before, the other parts of code are quite inefficient too and can be
> > > optimized. There are still lots of things to improve.
> > >
> > >
> > > But right now I would like to hear some opinions about the following
> > > things regarding the attached patch:
> > >
> > > The first question is about the use of extra source file for SIMD
> > > optimizations and introduction of
> > > 'sbc_encoder_init_simd_optimized_analyze' function to the global
> > > namespace. The rationale for that is the intention to stop adding changes
> > > to 'sbc.c' (otherwise it will become bloated pretty soon with the
> > > addition of multiple optimizations for various platforms). If anyone has
> > > a better idea, I'm very much interested to hear it.
> > >
> > > And if the addition of a new source file gets approved, I wonder about
> > > what text should go to the copyright header?
> > >
> > > Now we have two "reference" C implementations of analysis filter. Is it
> > > OK to keep both? Or only SIMD-friendly one should remain in the end?
> >
> > I am fine with keeping both, but if one is just not useful, we are going
> > to remove it.
> 
> The only problem with SIMD-friendly code is that it uses two tables instead of
> one (that's a sacrifice for the nice and symmetric code layout which fits SIMD
> instructions of modern processors quite well). It may be somewhat less
> optimal for the legacy processors without SIMD capabilities.
> 
> I wonder what CPU architectures are the most important for bluez?
> 
> > Also two separate files are fine for me. Personally I prefer a runtime
> > selection since compile time options are always painful 
> > to test before making the release.
> 
> The attached patch contains what I would consider to be a final variant. MMX
> support is now complete. It works for both x86 and amd64, has runtime
> autodetection of MMX availability, supports 4 and 8 subbands cases. I also
> ensured that only original MMX instructions are used (and no SSE or other
> later additions), so the code should work fine even on the old Pentium1 MMX.
> New MMX optimized functions produce bit identical results when compared
> with bluez-4.25 release.
> 
> With this patch applied, new filtering functions are noticeably faster than
> than the old ones on x86 (so now they are both faster and have better
> quality). Assembly optimizations for the other platforms can be easily
> added too. 

can you re-base your patch against the latest tree and re-send the
patch.

Do we still need the high precession stuff. I wanna cut down the number
of ifdefs in the code as much as possible.

Regards

Marcel


