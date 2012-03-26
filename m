Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR3pqj6xoJ-G-pt5QTY6BjuyUNXTZRzsQmmutcSNBzY3qQ@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
	<CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
	<CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
	<CABax29WFvAXH9g8CnOtEDAqfmKmURnt4eYY58fi+P9zBa5Ji1A@mail.gmail.com>
	<CACY+gR3pqj6xoJ-G-pt5QTY6BjuyUNXTZRzsQmmutcSNBzY3qQ@mail.gmail.com>
Date: Mon, 26 Mar 2012 23:11:58 +0200
Message-ID: <CABax29Unh0AOhExp_FJwUr=edmPSDXy=_YJAXN81M5tp5+yUxw@mail.gmail.com>
Subject: Re: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: qduaty <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/3/26 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> On Sun, Mar 25, 2012 at 5:51 AM, qduaty <qduaty@gmail.com> wrote:
> Out of curiosity, how do you measure noise reduction?

It seems to reduce noise making it less audible. I didn't perform
objective measurements because it's not relevant as long as the
(decoded) stream is not used for encoding.

> Floating point code does not need any rounding coefficient.

You have right, I missed the comment. t1 should be initialized to 0.

> I find it hard to believe that this accumError would make any
> noticeable difference on the output (neither good nor bad).

I don't believe it either, but it is a trick. Perhaps my results are
biased, but it always seems that adding 0.5 before rounding adds some
noise, while adding accumError calculated this way, does the opposite
(removes some noise). Objective measurements could give the right
answer. Anyway, if you're interested in the patch, I'd be careful with
removing the part of code involving accumError - it's computationally
cheap and at least one listener claims it improves quality. Three
"blind" listeners could give you meaningful statistical data.

> With your change, you are only messing around the lowest bit in the extra
> fractional part.

Now I'm surprised that it actually works.

> If you have any questions about the current code, just ask.

How to call sbc_encode(), sbc_decode() and again sbc_encode() in a
single function? It seems they cannot use the same instance of sbc_t
struct. I tried to estimate the amount of attenuation for adaptive
clipping prevention (obviously this solution is suboptimal but can be
a good starting point).


Regards

--
Sebastian Olter
