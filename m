Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Fri, 30 Jan 2009 19:05:51 +0200
Cc: "'Marcel Holtmann'" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
References: <200901290310.03440.siarhei.siamashka@nokia.com> <1233248495.2139.19.camel@violet> <002e01c982cb$f798fba0$e6caf2e0$@de>
In-Reply-To: <002e01c982cb$f798fba0$e6caf2e0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901301905.51624.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 30 January 2009 13:14:47 ext Christian Hoene wrote:
> > > > Thanks for finding the bug. A common things about these failed
>
> testcases
>
> > > > is that block size is not 16.
> > > >
> > > > Looks like this was not covered by my own regression tests, I'll try
>
> to do
>
> > > > something about this problem now.
> > >
> > > A fix is attached. I also extended my regression test script to cover
>
> such
>
> > > cases.
> >
> > patch has been applied. Thanks.
>
> The tests have passed all.
> http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/
>
> Regards,
>
>  Christian

Thanks a lot for keeping an eye on bluez sbc implementation quality.

-- 
Best regards,
Siarhei Siamashka
