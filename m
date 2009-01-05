Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Mon, 5 Jan 2009 10:57:03 +0200
References: <200812311803.45279.siarhei.siamashka@nokia.com> <1230800283.4530.3.camel@californication> <200901021807.17443.siarhei.siamashka@nokia.com>
In-Reply-To: <200901021807.17443.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901051057.03705.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 02 January 2009 18:07:17 ext Siarhei Siamashka wrote:
> On Thursday 01 January 2009 10:58:03 ext Marcel Holtmann wrote:
[...]
> > > But right now I would like to hear some opinions about the following
> > > things regarding the attached patch:
> > >
> > > The first question is about the use of extra source file for SIMD
> > > optimizations and introduction of
> > > 'sbc_encoder_init_simd_optimized_analyze' function to the global
> > > namespace. The rationale for that is the intention to stop adding
> > > changes to 'sbc.c' (otherwise it will become bloated pretty soon with
> > > the addition of multiple optimizations for various platforms). If
> > > anyone has a better idea, I'm very much interested to hear it.
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
> The only problem with SIMD-friendly code is that it uses two tables instead
> of one (that's a sacrifice for the nice and symmetric code layout which
> fits SIMD instructions of modern processors quite well). It may be somewhat
> less optimal for the legacy processors without SIMD capabilities.
>
> I wonder what CPU architectures are the most important for bluez?
>
> > Also two separate files are fine for me. Personally I prefer a runtime
> > selection since compile time options are always painful
> > to test before making the release.
>
> The attached patch contains what I would consider to be a final variant.
> MMX support is now complete. It works for both x86 and amd64, has runtime
> autodetection of MMX availability, supports 4 and 8 subbands cases. I also
> ensured that only original MMX instructions are used (and no SSE or other
> later additions), so the code should work fine even on the old Pentium1
> MMX. New MMX optimized functions produce bit identical results when
> compared with bluez-4.25 release.
>
> With this patch applied, new filtering functions are noticeably faster than
> than the old ones on x86 (so now they are both faster and have better
> quality). Assembly optimizations for the other platforms can be easily
> added too.
>
> > For the copyright header it is pretty simple. We copy the current header
> > and then later on I will add the appropriate Nokia copyright to it. So
> > don't worry about that part, I take care of that.
>
> OK, thanks

I understand that it is too early to ping you regarding the status of the
patch :)

But it would be nice if all the SBC encoder optimizations that are relatively
easy to implement got done and integrated fast (keeping the encoder output
bit identical to that of version 4.25 for now)

After the second thought, I propose the following source files layout:
sbc_dsplib.c, sbc_dsplib.h - contains reference C code for the supplementary
helper functions which can be used in SBC encoder/decoder and can be
efficiently SIMD/assembly optimized
sbc_dsplib_mmx.c - x86 MMX optimizations
sbc_dsplib_sse2.c - x86 SSE2 optimizations
sbc_dsplib_neon.c - ARM NEON optimizations
sbc_dsplib_armv6.c - ARMv6 optimizations
...

sbc_dsplib.c would also contain an initialization function, which sets up the
function pointers in 'sbc_encoder state' structure to the best available
implementations for the current platform.

The content of sbc_dsplib* files can be then considered for the future
submission into liboil if this is desired.

Would you prefer an updated patchset, which implements all of this stuff one
step at a time?

-- 
Best regards,
Siarhei Siamashka
