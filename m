Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 23:34:20 +0300
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] mSBC tests
Message-ID: <20120927233420.3441f14e@i7>
In-Reply-To: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 27 Sep 2012 16:44:23 +0200
Frédéric Dalleau  <frederic.dalleau@linux.intel.com> wrote:

> Hi folks,
> 
> I wanted to know more about mSBC and I look into the spec and saw it
> was just a set of settings for SBC. So I tried to exercise them using
> sbcenc and sbcdec and found it wasn't possible, I ended modifying SBC
> library and now it should be possible to use mSBC settings.
> Using 15 block doesn't work using SIMD processing because of data
> reordering so I recalled some legacy C code from an older release
> (sbc_analyse_eight) and put in a separate primitives file.

Hi,

I wonder why they decided to go with the odd sided blocks? Anyway,
I guess there is no other way but to adapt to this extended spec.
Thanks for taking a look at this stuff.

Have you tried to tweak the SIMD code to make it process one
block at a time instead of batches of 4?

I suspect that we might only need to track the state and flip between
"even" and "odd" constant tables for every other processed block in
"sbc_analyze_4b_4s_simd" and "sbc_analyze_4b_8s_simd" replacement
functions. The functions "sbc_encoder_process_input_s4_internal"
and "sbc_encoder_process_input_s8_internal" also need to be
updated to handle arbitrary number of blocks and not just
multiples of 4. Though I haven't been working with sbc code lately
and may be mistaken.

Using the old tables "_sbc_proto_fixed8" and "_sbc_proto_fixed4" has
a disadvantage of not having the tweaks from:
    http://git.kernel.org/?p=bluetooth/sbc.git;a=commit;h=bec3d3989ba2
They haven't been in use for ages and just remained in the sources by.

If we just could make SIMD code work, that would be the best option in
my opinion.

> Work done from the spec, not tested with any reference encoder.

Does a reference mSBC encoder exist somewhere? Or any ideas how to test
the new code with something other than bluez just to be sure that it's
correct?

> How to use:
> sample.au should be an .au audio file 16000hz 16bits 1 channel pcm.
> $ src/sbcenc  -m -b26 -B16 -s8   sample.au > sample.au.msbc
> $ src/sbcinfo sample.au.msbc
> $ src/sbcdec  -m -f sample.au.msbc.au sample.au.msbc
> $ mplayer sample.au.msbc.au
> 
> Note sure there is any application yet but I thought I should share.

Thanks for sharing this information and patches. I would love to try
experimenting with mSBC code myself (mostly curious to check whether
SIMD has any chance to remain useful), but don't have much time right
now and will be away from my primary computer for the whole next week.

-- 
Best regards,
Siarhei Siamashka
