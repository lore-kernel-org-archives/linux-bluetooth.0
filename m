Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
Date: Fri, 19 Dec 2008 23:25:46 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200812172243.27442.siarhei.siamashka@nokia.com> <1229641160.17082.0.camel@violet>
In-Reply-To: <1229641160.17082.0.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812192325.46796.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 19 December 2008 00:59:20 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > This simple patch resolves one more SBC encoding quality issue. Now SBC
> > audio encoding quality should be fine in almost all cases after applying
> > it together with a new 8 subband filter.
> >
> > The patch conflicts with the bitstream packing optimization, but I hope
> > that after all the encoding quality problems are fixed, we can get back
> > to it.
>
> both of your patches have been applied and pushed upstream. Please keep
> developing against the upstream tree.

Thanks.

-- 
Best regards,
Siarhei Siamashka
