Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 15:31:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: Keith Mok <ek9852@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Add iwmmxt optimization for sbc for pxa series cpu
Message-ID: <20101118133152.GA5526@jh-x301>
References: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com>
 <AANLkTimQR5wMTTEO6KGuv3YvPBaftO-i+96WKYQEOzFU@mail.gmail.com>
 <201011151308.31972.siarhei.siamashka@gmail.com>
 <201011181505.29428.siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201011181505.29428.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Thu, Nov 18, 2010, Siarhei Siamashka wrote:
> 1. Make a final patch in such a form that can be pushed to git repository 
> without any modifications, it means that you need a clean commit message and 
> not just some text intermixed with the parts and quotations of discussion from
> this mailing list.
> 2. "Signed-off-by" header is not needed for the userspace parts of bluez.
> 3. All files must have copyright notices, even a small one like 
> 'sbc_primitives_iwmmxt.h'. And probably you should just replicate all the
> copyright notices from the source files with sbc mmx optimizations and add your
> own copyright on top.
> 
> Hopefully that should be enough to get your optimizations applied. Thanks.

Yep, those things would be needed before pushing upstream. Thanks for
reminding me about this patch. I had actually forgotten about it.

Johan
