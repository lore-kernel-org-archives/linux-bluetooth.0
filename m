Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: SBC encoder conformance test for version 4.25 passed!
Date: Mon, 5 Jan 2009 17:32:59 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812301246.25781.siarhei.siamashka@nokia.com> <200901051027.57446.siarhei.siamashka@nokia.com> <002901c96f45$a7bbf770$f733e650$@de>
In-Reply-To: <002901c96f45$a7bbf770$f733e650$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901051732.59929.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 16:55:27 ext Christian Hoene wrote:
> > > Good news! All tests passed!
> > > http://net.cs.uni-tuebingen.de/html/nexgenvoip/
> >
> > Thank you very much. Sorry for the delay with reply too.
> >
> > I wonder if we need to do something about test 08?
>
> Done.
>
> > Also could you try running a special test of version 4.25 with
> > SBC_HIGH_PRECISION enabled? The point is that it uses the best
> > possible precision for the analysis filter and minimizes effects of
> > rounding errors (I would estimate that the precision should be even
> > better than single precision floating point). Having the test run with
>
> this
>
> > precision settings can expose some of the other minor bugs in the code
> > (if they exist), which can now be hidden under the slight precision loss
> > because of using 16-bit fixed point calculations.
>
> I have uploaded the results to
> http://net.cs.uni-tuebingen.de/html/nexgenvoip/4.25_high_precision
>
> The encoding results did not change.

Great, it means that sbc encoder is mostly bug free (at least none of them
shows up on this test set with all the available bugfixes applied). 

Now a good improvement would be to tweak the default 16-bit version of
analysis filter to improve its precision. It is a lot faster than the high
precision variant and already provides sufficient quality :)

-- 
Best regards,
Siarhei Siamashka
