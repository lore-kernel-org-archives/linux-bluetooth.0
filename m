Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: hoene@uni-tuebingen.de
Subject: Re: SBC encoder conformance test for version 4.25 passed!
Date: Mon, 5 Jan 2009 10:27:57 +0200
Cc: "'Marcel Holtmann'" <marcel@holtmann.org>,
        "'Bont, Frans de'" <frans.de.bont@philips.com>,
        linux-bluetooth@vger.kernel.org
References: <200812301246.25781.siarhei.siamashka@nokia.com> <000a01c96c1c$a4c86390$ee592ab0$@hoene@gmx.net>
In-Reply-To: <000a01c96c1c$a4c86390$ee592ab0$@hoene@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901051027.57446.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 01 January 2009 16:24:21 ext Christian Hoene wrote:
> Hello Siarhei,
>
> sorry for the delay - these days my family comes first ;-)
>
> Good news! All tests passed!
> http://net.cs.uni-tuebingen.de/html/nexgenvoip/

Thank you very much. Sorry for the delay with reply too.

I wonder if we need to do something about test 08?

Also could you try running a special test of version 4.25 with
SBC_HIGH_PRECISION enabled? The point is that it uses the best
possible precision for the analysis filter and minimizes effects of
rounding errors (I would estimate that the precision should be even
better than single precision floating point). Having the test run with this
precision settings can expose some of the other minor bugs in the code
(if they exist), which can now be hidden under the slight precision loss
because of using 16-bit fixed point calculations.


Best regards,
Siarhei Siamashka
