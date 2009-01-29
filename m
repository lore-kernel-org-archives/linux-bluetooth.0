Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with
 __builtin_clz
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Christian Hoene <hoene@uni-tuebingen.de>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200901291831.49427.siarhei.siamashka@nokia.com>
References: <200901290310.03440.siarhei.siamashka@nokia.com>
	 <021801c98222$4a1726e0$de4574a0$@de>
	 <200901291730.31869.siarhei.siamashka@nokia.com>
	 <200901291831.49427.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Thu, 29 Jan 2009 18:01:35 +0100
Message-Id: <1233248495.2139.19.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > > The testing results are not positive. It is better to revoke the patch.
> > > http://net.cs.uni-tuebingen.de/html/nexgenvoip/
> > > http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/encoder.bluez.03.wav
> >
> > Thanks for finding the bug. A common things about these failed testcases
> > is that block size is not 16.
> >
> > Looks like this was not covered by my own regression tests, I'll try to do
> > something about this problem now.
> 
> A fix is attached. I also extended my regression test script to cover such
> cases.

patch has been applied. Thanks.

Regards

Marcel


