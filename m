Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 17:18:44 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812301246.25781.siarhei.siamashka@nokia.com> <200901051522.25993.siarhei.siamashka@nokia.com> <002701c96f43$dc833c90$9589b5b0$@de>
In-Reply-To: <002701c96f43$dc833c90$9589b5b0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901051718.44559.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 16:42:39 ext Christian Hoene wrote:
> > There are some parts that look a bit redundant/suspicious:
> > > @@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t
> > > count) while (count > 0) {
> > >                 len = read(fd, buf + pos, count);
> > >                 if (len <= 0)
> > > -                       return len;
> > > +                       return pos > len ? pos : len;
> > >
> > >                 count -= len;
> > >                 pos   += len;
> >
> > Is the ternary '?' operator really needed here? In this part of code we
> > know for sure that 'len' is less or equal to zero, also 'pos ' is a
> > positive number or zero. Having just 'return pos' should be enough.
>
> No. If read returns an error, the this error is passed to __read, too.

I mean that 'return pos > len ? pos : len' and 'return pos' expressions are
completely interexchangeable in this context.

Regarding this particular change itself, was there a reproducible problem in
your testing that strictly required this fix? Was it involving sockets or
pipes?

But the bug in 'sbc_get_codesize' is the unquestionable one for sure. Good job
finding and fixing it.

-- 
Best regards,
Siarhei Siamashka
