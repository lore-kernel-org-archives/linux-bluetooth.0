Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: bitstream packing optimization for encoder.
Date: Fri, 12 Dec 2008 18:07:28 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812112227.07170.siarhei.siamashka@nokia.com> <200812121137.18041.siarhei.siamashka@nokia.com> <1229079849.22285.43.camel@violet.holtmann.net>
In-Reply-To: <1229079849.22285.43.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812121807.28650.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 12 December 2008 13:04:09 ext Marcel Holtmann wrote:
[...]
> > But for little endian-systems and also to ensure endian neutrality, data
> > writes are done one byte at a time.
>
> Lets keep doing it byte by byte for now. However keep in mind that the
> input stream can also be in big endian even it is runs on a little
> machine. And vice-versa.

Yes I know, thanks for reminding :) This patch does not touch endian
conversion for the input data, so everything should be OK. Anyway, it's
better to do some real tests on big-endian systems just to be sure.

The endian conversion and channels deinterleaving part for the input data
is actually another performance bottleneck in SBC and can be also optimized.

-- 
Best regards,
Siarhei Siamashka
