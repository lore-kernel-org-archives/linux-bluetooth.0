Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200812301246.25781.siarhei.siamashka@nokia.com> <000a01c96c1c$a4c86390$ee592ab0$@hoene@gmx.net> <200901051027.57446.siarhei.siamashka@nokia.com>
In-Reply-To: <200901051027.57446.siarhei.siamashka@nokia.com>
Subject: RE: SBC encoder conformance test for version 4.25 passed!
Date: Mon, 5 Jan 2009 15:55:27 +0100
Message-ID: <002901c96f45$a7bbf770$f733e650$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > Good news! All tests passed!
> > http://net.cs.uni-tuebingen.de/html/nexgenvoip/
> 
> Thank you very much. Sorry for the delay with reply too.
> 
> I wonder if we need to do something about test 08?

Done.

> Also could you try running a special test of version 4.25 with
> SBC_HIGH_PRECISION enabled? The point is that it uses the best
> possible precision for the analysis filter and minimizes effects of
> rounding errors (I would estimate that the precision should be even
> better than single precision floating point). Having the test run with
this
> precision settings can expose some of the other minor bugs in the code
> (if they exist), which can now be hidden under the slight precision loss
> because of using 16-bit fixed point calculations.

I have uploaded the results to
http://net.cs.uni-tuebingen.de/html/nexgenvoip/4.25_high_precision

The encoding results did not change. 

Best regards,

 Christian 

