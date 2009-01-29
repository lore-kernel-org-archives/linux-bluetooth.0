Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] Performance optimizations for input data processing in SBC encoder
Date: Thu, 29 Jan 2009 03:27:53 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200901272014.13387.siarhei.siamashka@nokia.com> <1233121613.18259.9.camel@violet>
In-Reply-To: <1233121613.18259.9.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901290327.53997.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 28 January 2009 07:46:53 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > Here is a cleaned up version of the previous experimental patch:
> > http://marc.info/?l=linux-bluetooth&m=123245036109697&w=2
> >
> > I changed it to be alignment and byte order neutral (input data is read
> > one byte at a time). It's a bit slower than reading via int16_t *
> > pointer, but avoids headache of worrying about the other problems. Endian
> > conversion is still also kept (when reading one byte at a time, it does
> > not affect performance anyway).
> >
> > The patch should be safe to apply.
>
> your patch has been applied. Thanks.

Thanks.

> > Benchmarks show consistent performance improvement ~30% for both x86
> > and ARM Cortex-A8. It's even more than I measured before just because
> > optimizations are cumulative and the effect of each individual change
> > becomes
> > more visible when the other parts also get faster (the previous
> > benchmark was
> > run before "-funroll-loops" optimization got committed).
>
> Sounds great to me. Keep optimizing it :)

Fortunately not so much is left to be optimized :)

Joint stereo encoding performance still can be improved. Also a few other
tweaks could be tried for 'sbc_pack_frame_internal'. After that, only
implementing SIMD optimizations for various CPU cores (primarily ARM11)
would be left to do.


Best regards,
Siarhei Siamashka
