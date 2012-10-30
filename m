Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Oct 2012 03:46:33 +0200
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: "Dalleau, Frederic" <frederic.dalleau@intel.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 06/10] sbc: Add mmx primitive for 1b 8s analyse
Message-ID: <20121030034633.2242d317@i7>
In-Reply-To: <CA+QXtDvsWoQd+JVxKC0HVRGZxUKg-JeN7_V+MfHXotg_N6EBKQ@mail.gmail.com>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351272036-4875-7-git-send-email-frederic.dalleau@linux.intel.com>
	<20121028020621.3653ac8e@i7>
	<20121028022942.3bcd1bd7@i7>
	<CA+QXtDvsWoQd+JVxKC0HVRGZxUKg-JeN7_V+MfHXotg_N6EBKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 29 Oct 2012 08:42:08 +0100
"Dalleau, Frederic" <frederic.dalleau@intel.com> wrote:

> Hi Siarhei,
> 
> Since only neon is concerned by this, I'd rather add a one liner like this :
> 
> #ifdef SBC_BUILD_WITH_NEON_SUPPORT
>        sbc_init_primitives_neon(state);
> +
> +     if (state->increment == 1)
> +             state->sbc_analyze_4b_8s = sbc_analyze_1b_8s_simd;
> #endif
> 
> It is more explicit, doesn't change priority and doesn't add needless code
> to other implementations.

It's not just neon, but armv6 and iwmmxt are affected too. Additionally,
neon code also provides optimized "sbc_enc_process_input_*" functions,
which are not going to work correctly for mSBC:

	state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le_neon;
	state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be_neon;

So I still think that it is safer and cleaner to have
"sbc_init_primitives" function performing the following in order:
1. Initialize function pointers with C implementations.
2. Allow to override them with various platform specific
implementations (which would work fine for old SBC formats).
3. At the end of the function have a check if we are actually dealing
with mSBC format and restore all the function pointers back to C
implementations in this case.

So SBC is accelerated, and mSBC at least works correctly.

Then for the follow up patches just review/fix all the assembly
optimized implementations one at a time, make sure that they do work
with mSBC and move their initialization to the end of the
"sbc_init_primitives" function.

This allows to first take care of C implementation without MMX
getting in the way. Then fix and enable mSBC support for MMX in the
last patch from your series. Later somebody could take care of the
ARM implementations in a similar way.

> And what about sbc_analyze_8s?

Renaming "sbc_analyze_4b_8s" -> "sbc_analyze_8s" in a separate patch
prior to other changes is IMHO better than keeping the old misleading
name.

> Regarding point 2, this is the reason why patch 4 was a bit bigger, the simd
> implementation is complete.

Well, I just don't quite like that after the patches
    [PATCH 04/10] sbc: Add msbc flag and generic C primitive
    [PATCH 05/10] sbc: Add support for mSBC frame header
we already have a complete mSBC support in C code, which is still
unusable (as in buggy) if run on mmx, iwmmxt, armv6 or arm neon capable
systems.

And having another look at it, we actually may have one more problem.
The sbc-1.0 library is already starting to get packaged in some linux
distributions. If somebody tries to run some application to do mSBC
encoding/decoding, but happens to have an old sbc-1.0 library in his
system, then it would not be able to handle the new SBC flag
gracefully. The comment about returning error code "-3 Unsupported
number of blocks" is not quite true after
    http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=ce342bf2524b

Having a proper standalone sbc library, we might want to be nicer to the
users and minimize any possible ABI related issues on the upgrade path.
>From this point of view, even introducing new msbc_encode/msbc_decode
functions might be safer. We may not go so far for the first library
update (after all, what would be the purpose of the flags argument in
this case?). But eventually making error checking code more sane
certainly looks like a good idea to me.

Regarding ABI stability in general, there is an interesting project,
which is tracking many open source libraries including bluez:
    http://upstream-tracker.org/versions/bluez.html

-- 
Best regards,
Siarhei Siamashka
