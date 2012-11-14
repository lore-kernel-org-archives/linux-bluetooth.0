Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 21:57:20 +0200
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: frederic.dalleau@linux.intel.com
Subject: Re: [PATCH v4 00/16] mSBC tests
Message-ID: <20121114215720.4ac04e24@i7>
In-Reply-To: <1352904655.20338.11.camel@aeonflux>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
	<50A36BAC.4090604@linux.intel.com>
	<1352904655.20338.11.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 14 Nov 2012 23:50:55 +0900
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Fred,
> 
> > > v4 integrate latest comments from Siarhei:
> > >   - remove state->pending field from sbc_encoder_state
> > >   - add armv6 and iwmmxt primitives
> > >   - use simd primitive instead of neon
> > >   - reorder patches so that the SBC_MSBC flag is exposed to users only when
> > > implementation is complete.
> > 
> > Any feedback ?
> 
> beside a tiny cosmetic comment, I have nothing. However I am not the
> expert here. If Siarhei looks over this and is fine with it, I will be
> as well.

Hi,

My biggest concern is the way how we handle the mSBC API/ABI extension.
Because once the new version of sbc library is out, we can't
(easily/painlessly) change it any more. Everything else is fixable.

Anyway, as far as I can see, there are no regressions in the existing
SBC functionality, which is the most important requirement.

I personally would prefer a bit more verbose commit messages. But let
me know if these demands are unreasonable :)

-- 
Best regards,
Siarhei Siamashka
