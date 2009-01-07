Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Wed, 7 Jan 2009 11:31:25 +0200
Cc: hoene@uni-tuebingen.de, linux-bluetooth@vger.kernel.org
References: <200812311803.45279.siarhei.siamashka@nokia.com> <006c01c96fbf$7f9a38e0$7eceaaa0$@hoene@gmx.net> <1231220701.13304.25.camel@californication>
In-Reply-To: <1231220701.13304.25.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901071131.25867.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 06 January 2009 07:45:01 ext Marcel Holtmann wrote:
> Hi Christian,
>
> > > Do we still need the high precession stuff. I wanna cut down the number
> > > of ifdefs in the code as much as possible.
> >
> > Yes, because provides better audio quality.
>
> okay, but we have to make a choice in what we want. We can't just have a
> lots of ifdefs around. They will be killing us eventually. It is a
> nightmare from a release engineering perspective.

That's a single ifdef, which was added for testing purposes. The analysis
filter code itself is flexible enough to work in both configurations as the
shift constants depend on the use of 'sizeof' operator. The original floating
point constants are also wrapped into macros, which expand to the needed
fixed point data type automagically. 

And as it was discussed before, It is possible to have both fast and high
precision implementations compiled in at the same time. Something like having:

sbc_analysis_filter_template.h - with the tables and implementation of
analysis function as a static inline function, with a custom preprocessor
managed suffix for its name

And 'sbc_analysis_filter.c' having code like this:

#define SBC_HIGH_PRECISION
#define SB_ANALYSIS_FUNCTION_SUFFIX _hq
#include "sbc_analysis_filter_template.h"

#undef SBC_HIGH_PRECISION
#undef SB_ANALYSIS_FUNCTION_SUFFIX
#define SB_ANALYSIS_FUNCTION_SUFFIX _fast
#include "sbc_analysis_filter_template.h"

This double include will instantiate both implementations from the same
template. Or something like this. It does not increase source code size
much.

> What is the downside for doing high precession only?

Performance is a lot better for 16-bit fixed point version because it can
benefit from DSP/multimedia instruction set extensions of modern processors.
A performance difference can be seen when benchmarking MMX enabled vs.
high precision build. The relative difference will get even bigger after
optimizing other parts of SBC encoder.

-- 
Best regards,
Siarhei Siamashka
