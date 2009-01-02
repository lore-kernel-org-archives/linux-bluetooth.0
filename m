Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] Added possibility to analyze 4 blocks at once in SBC encoder
Date: Fri, 2 Jan 2009 18:13:57 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311729.30975.siarhei.siamashka@nokia.com> <1230800042.4530.0.camel@californication>
In-Reply-To: <1230800042.4530.0.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901021813.57181.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 01 January 2009 10:54:02 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > With bluez-4.25 release I hope that the SBC encoder sound quality issues
> > are now solved (though this is yet to be confirmed).
> >
> > Nevertheless, I think it is time to focus on performance :) The attached
> > patch contains code preparations which are needed for SIMD optimizations
> > for the analysis filter. Also theoretically it should be possible to
> > tweak code to have both 32-bit and 16-bit fixed point analysis filter
> > compiled in and switch between them at runtime (at user's request or
> > semi-intelligently depending on audio bitrate).
> >
> > This patch should be stable and ready to be committed.
>
> your patch has been applied. Thanks.

Thank you very much for taking a good care of my patches :)


Best regards,
Siarhei Siamashka
