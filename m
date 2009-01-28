Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Performance optimizations for input data processing in
 SBC encoder
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200901272014.13387.siarhei.siamashka@nokia.com>
References: <200901272014.13387.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:46:53 +0100
Message-Id: <1233121613.18259.9.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> Here is a cleaned up version of the previous experimental patch:
> http://marc.info/?l=linux-bluetooth&m=123245036109697&w=2
> 
> I changed it to be alignment and byte order neutral (input data is read one
> byte at a time). It's a bit slower than reading via int16_t * pointer, but
> avoids headache of worrying about the other problems. Endian conversion
> is still also kept (when reading one byte at a time, it does not affect
> performance anyway).
> 
> The patch should be safe to apply.

your patch has been applied. Thanks.

> Benchmarks show consistent performance improvement ~30% for both x86
> and ARM Cortex-A8. It's even more than I measured before just because
> optimizations are cumulative and the effect of each individual change
> becomes
> more visible when the other parts also get faster (the previous
> benchmark was
> run before "-funroll-loops" optimization got committed).

Sounds great to me. Keep optimizing it :)

Regards

Marcel


