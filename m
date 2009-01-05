Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 19:39:23 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812301246.25781.siarhei.siamashka@nokia.com> <200901051718.44559.siarhei.siamashka@nokia.com> <004501c96f4a$ea4f0500$beed0f00$@de>
In-Reply-To: <004501c96f4a$ea4f0500$beed0f00$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901051939.23341.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 17:33:10 ext Christian Hoene wrote:
> > I mean that 'return pos > len ? pos : len' and 'return pos' expressions
> > are completely interexchangeable in this context.
>
> They are slightly different but really, I do not care. Both fixes will work.

Yes, because they provide exactly identical results :-) In this sense, your
fix is a bit broken, because it will never allow to pass through and return a
negative error code.

> At least one must be applied. BTW: Why not use fread instead? ;-) 

Agreed here. What's the point of having double underscored versions (such
identifiers are reserved and not allowed to be used by programs) of read and
write functions? Maybe they can be purged and just normal read/write calls
could be used instead? Or alternatively fread/fwrite indeed?

Also there seems to be a performance issue: memove calls are redundant and
can be avoided in SBC encoder program.

I can confirm that getting rid of the __read and __write functions (or fixing
them with your patch or its modification) is the only change, needed to pass
encoder test 08.

All the other changes are not directly related to this particular testcase,
though a fix for 'codesize' is also nice to have. It would be required for a
faster, memmove-free version of the encoder.

You have found and fixed two definite bugs (as I can see it now), that's very
good. Now it would be nice to apply the fixes to git with the descriptive
commit messages and move forward ;-)

-- 
Best regards,
Siarhei Siamashka
