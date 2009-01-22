Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200901220111.29248.siarhei.siamashka@nokia.com>
References: <200901220111.29248.siarhei.siamashka@nokia.com>
Date: Thu, 22 Jan 2009 10:36:36 -0300
Message-ID: <2d5a2c100901220536v268134a5m65c7aa4062b39686@mail.gmail.com>
Subject: Re: [PATCH] Audio quality improvement for 16-bit fixed point SBC
	encoder
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> I decided to drop non-SIMD variant because it would require quite a bit of
> work to update for better precision. Most of the CPU cores which are
> relevant nowadays have support for some kind of SIMD extension anyway.
> I will also do ARMv6 SIMD version of the analysis filter after all the high
> level SBC optimizations are in place.

Perhaps we can just disable it, since it is probably useful to
maintain a version in C as a reference code just in case someone want
to do its own optimizations in the future.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
