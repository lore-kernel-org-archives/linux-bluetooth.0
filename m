Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
        "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200901290310.03440.siarhei.siamashka@nokia.com>	 <021801c98222$4a1726e0$de4574a0$@de>	 <200901291730.31869.siarhei.siamashka@nokia.com>	 <200901291831.49427.siarhei.siamashka@nokia.com> <1233248495.2139.19.camel@violet>
In-Reply-To: <1233248495.2139.19.camel@violet>
Subject: RE: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Fri, 30 Jan 2009 12:14:47 +0100
Message-ID: <002e01c982cb$f798fba0$e6caf2e0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

> > > Thanks for finding the bug. A common things about these failed
testcases
> > > is that block size is not 16.
> > >
> > > Looks like this was not covered by my own regression tests, I'll try
to do
> > > something about this problem now.
> >
> > A fix is attached. I also extended my regression test script to cover
such
> > cases.
> 
> patch has been applied. Thanks.
> 

The tests have passed all.
http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/

Regards,

 Christian
