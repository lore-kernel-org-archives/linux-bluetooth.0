Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 18:53:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Keith Mok <ek9852@gmail.com>
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add iwmmxt optimization for sbc for pxa series cpu
Message-ID: <20101118165333.GA2935@jh-x301>
References: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com>
 <AANLkTimQR5wMTTEO6KGuv3YvPBaftO-i+96WKYQEOzFU@mail.gmail.com>
 <201011151308.31972.siarhei.siamashka@gmail.com>
 <201011181505.29428.siarhei.siamashka@gmail.com>
 <AANLkTi=rSK1zmW4kcPh7qopdZKN7mefX2RYWiBQZSacF@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=rSK1zmW4kcPh7qopdZKN7mefX2RYWiBQZSacF@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

On Thu, Nov 18, 2010, Keith Mok wrote:
> Add iwmmxt optimization for sbc for pxa series cpu.
> 
> Benchmarked on ARM PXA platform:
> ===  Before (4 bands) ====
> $ time  ./sbcenc_orig  -s 4     long.au  > /dev/null
> real    0m 2.44s
> user    0m 2.39s
> sys     0m 0.05s
> ===  After (4 bands) ====
> $ time  ./sbcenc  -s 4     long.au  > /dev/null
> real    0m 1.59s
> user    0m 1.49s
> sys     0m 0.10s
> 
> ===  Before (8 bands) ====
> $ time  ./sbcenc_orig   -s 8     long.au  > /dev/null
> real    0m 4.05s
> user    0m 3.98s
> sys     0m 0.07s
> ===  After (8 bands) ====
> $ time  ./sbcenc  -s 8     long.au  > /dev/null
> real    0m 1.48s
> user    0m 1.41s
> sys     0m 0.06s
> 
> ===  Before (a2dp usage) ====
> $ time  ./sbcenc_orig   -b53 -s8 -j    long.au  > /dev/null
> real    0m 4.51s
> user    0m 4.41s
> sys     0m 0.10s
> ===  After (a2dp usage) ====
> $ time  ./sbcenc   -b53 -s8 -j    long.au  > /dev/null
> real    0m 2.05s
> user    0m 1.99s
> sys     0m 0.06s
> 
> ---
>  Makefile.am                 |    1 +
>  sbc/sbc_primitives.c        |    4 +
>  sbc/sbc_primitives_iwmmxt.c |  304 +++++++++++++++++++++++++++++++++++++++++++
>  sbc/sbc_primitives_iwmmxt.h |   42 ++++++
>  4 files changed, 351 insertions(+), 0 deletions(-)
>  create mode 100644 sbc/sbc_primitives_iwmmxt.c
>  create mode 100644 sbc/sbc_primitives_iwmmxt.h

Pushed upstream. Thanks.

Johan
