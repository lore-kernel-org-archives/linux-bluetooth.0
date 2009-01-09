Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Fri, 9 Jan 2009 18:50:54 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311803.45279.siarhei.siamashka@nokia.com> <200901021807.17443.siarhei.siamashka@nokia.com> <1231210146.13304.15.camel@californication>
In-Reply-To: <1231210146.13304.15.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901091850.55032.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 06 January 2009 04:49:06 ext Marcel Holtmann wrote:
> > The attached patch contains what I would consider to be a final variant.
> > MMX support is now complete. It works for both x86 and amd64, has runtime
> > autodetection of MMX availability, supports 4 and 8 subbands cases. I
> > also ensured that only original MMX instructions are used (and no SSE or
> > other later additions), so the code should work fine even on the old
> > Pentium1 MMX. New MMX optimized functions produce bit identical results
> > when compared with bluez-4.25 release.
> >
> > With this patch applied, new filtering functions are noticeably faster
> > than than the old ones on x86 (so now they are both faster and have
> > better quality). Assembly optimizations for the other platforms can be
> > easily added too.
>
> can you re-base your patch against the latest tree and re-send the
> patch.

Yes, I will submit an updated SIMD optimizations patchset in a few days.


Best regards,
Siarhei Siamashka
