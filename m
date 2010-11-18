Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Keith Mok <ek9852@gmail.com>
Subject: Re: [PATCH v3] Add iwmmxt optimization for sbc for pxa series cpu
Date: Thu, 18 Nov 2010 15:05:29 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com> <AANLkTimQR5wMTTEO6KGuv3YvPBaftO-i+96WKYQEOzFU@mail.gmail.com> <201011151308.31972.siarhei.siamashka@gmail.com>
In-Reply-To: <201011151308.31972.siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011181505.29428.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 15 November 2010 13:08:19 Siarhei Siamashka wrote:
> On Monday 15 November 2010 04:46:25 Keith Mok wrote:
> > > I sometimes use different indentation levels in such cases in order to
> > > improve readability after instructions reordering, so that each
> > > logically independent block of code has its own indentation level and
> > > it is still easily visible
> > 
> > > after instructions reordering. For example, with the original code:
> > Thanks for the hints. I rearranged the code.
> 
> Thanks, now the assembly code looks ok to me. I also discovered that qemu
> supports iwmmxt1 emulation just fine and also tried to test your
> optimizations for correctness myself (with a script which tries different
> encoding paramaters for different audio samples and checks md5 checksums),
> no problems detected.
> 
> So if somebody else could check whether the other things are right
> (copyright notices for example), then we are done with it.

As nobody else has stepped in, I guess it's still my responsibility to provide
some further guidance even though I'm a very infrequent contributor myself.
Hopefully somebody will correct me if I'm wrong.

So please

1. Make a final patch in such a form that can be pushed to git repository 
without any modifications, it means that you need a clean commit message and 
not just some text intermixed with the parts and quotations of discussion from
this mailing list.
2. "Signed-off-by" header is not needed for the userspace parts of bluez.
3. All files must have copyright notices, even a small one like 
'sbc_primitives_iwmmxt.h'. And probably you should just replicate all the
copyright notices from the source files with sbc mmx optimizations and add your
own copyright on top.

Hopefully that should be enough to get your optimizations applied. Thanks.

-- 
Best regards,
Siarhei Siamashka
