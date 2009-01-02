Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Added possibility to analyze 4 blocks at once in SBC encoder
Date: Fri, 2 Jan 2009 18:51:26 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311729.30975.siarhei.siamashka@nokia.com> <2d5a2c100812311304u562e6363wc16f1bdf28ac9552@mail.gmail.com>
In-Reply-To: <2d5a2c100812311304u562e6363wc16f1bdf28ac9552@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901021851.27048.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 31 December 2008 23:04:20 ext Luiz Augusto von Dentz wrote:
> Hi Siarhei,
>
> > Nevertheless, I think it is time to focus on performance :) The attached
> > patch contains code preparations which are needed for SIMD optimizations
> > for the analysis filter. Also theoretically it should be possible to
> > tweak code to have both 32-bit and 16-bit fixed point analysis filter
> > compiled in and switch between them at runtime (at user's request or
> > semi-intelligently depending on audio bitrate).
>
> Picking a implementation at runtime would be really great,

What I had in mind was that we can have two source files which
include 'sbc_tables.h'. Then compile one of them with
SBC_HIGH_PRECISION macro defined, and the other one
without it. This way we will have two sets of functions, which
can be called via function pointers transparently from the rest
of code, as long as they have the same interface.

Having high precision analysis filter variant may be beneficial for
extremely high bitrates, when we might want to keep as much of
precision as possible. For the normal cases the extra precision is
just excessive.

I also have an idea about improving precision for the case of 16-bit
multiplications only. This would involve only tweaking coefficients in
the tables with no code changes at all. I hope to reduce rounding
errors to the very minimum. Will post about the progress a bit later.

If the precision difference between 16-bit and 32-bit implementations
can be reduced, there will be a bit less reasons to use a slow high
precision version anymore :)

> that is why I suggested using liboil in the other thread.

I don't see much relation with liboil here.

I'm not against liboil in general, but its usefullness for sbc codec just
needs to be proved.

-- 
Best regards,
Siarhei Siamashka
