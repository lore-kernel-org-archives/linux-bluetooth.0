Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120927233420.3441f14e@i7>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
	<20120927233420.3441f14e@i7>
Date: Fri, 28 Sep 2012 10:21:18 +0200
Message-ID: <CA+QXtDvf3J33dusXDa6gVbYX=Q5zwOFxy5UqjVZF+=8NAuHSwQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] mSBC tests
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

Thanks for reply,

On Thu, Sep 27, 2012 at 10:34 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> Have you tried to tweak the SIMD code to make it process one
> block at a time instead of batches of 4?

I looked at sbc_analyze_4b_8s_simd but I missed the logic behind
reordering. That's
why I reused generic code in order to make sure that it would work.
If there is some interest I can look into it deeper. And if you have
any pointers
they are welcome.

> If we just could make SIMD code work, that would be the best option in
> my opinion.

Agreed, for sure.

>> Work done from the spec, not tested with any reference encoder.
>
> Does a reference mSBC encoder exist somewhere? Or any ideas how to test
> the new code with something other than bluez just to be sure that it's
> correct?

IIRC there used to be one, it was a windows program sbcencoder.exe but
I couldn't find
it anymore, and I'm not sure that it would support mSBC.

Regards,
Frédéric
