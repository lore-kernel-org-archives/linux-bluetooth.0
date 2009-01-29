Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Thu, 29 Jan 2009 17:30:31 +0200
Cc: "'Marcel Holtmann'" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
References: <200901290310.03440.siarhei.siamashka@nokia.com> <1233214058.2139.6.camel@violet> <021801c98222$4a1726e0$de4574a0$@de>
In-Reply-To: <021801c98222$4a1726e0$de4574a0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901291730.31869.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 29 January 2009 17:00:11 ext Christian Hoene wrote:
> > > The attached patch contains optimization for scale factors calculation
>
> which
>
> > > provides additional SBC encoder speedup.
> > >
> > > For non-gcc compilers, CLZ function is implemented with a very simple
>
> and
>
> > > slow straightforward code (but it is still faster than current git code
>
> even
>
> > > if used instead of __builtin_clz). Something better could be done like:
> > > http://groups.google.com/group/comp.sys.arm/msg/5ae56e3a95a2345e?hl=en
> > > But I'm not sure about license/copyright of the code at this link and
> >
> > decided
> >
> > > not to touch it. Anyway, I don't think that gcc implementation of
> > > __builtin_clz for the CPU cores which do not support CLZ instruction is
>
> any
>
> > > worse.
> >
> > personally I don't really care about non-gcc compilers. I think that
> > some of the BlueZ source might not even compile without gcc.
> >
> > Anyway, patch has been applied. Thanks.
>
> The testing results are not positive. It is better to revoke the patch.
> http://net.cs.uni-tuebingen.de/html/nexgenvoip/
> http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/encoder.bluez.03.wav

Thanks for finding the bug. A common things about these failed testcases
is that block size is not 16.

Looks like this was not covered by my own regression tests, I'll try to do 
something about this problem now.


Best regards,
Siarhei Siamashka
