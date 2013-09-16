Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC SBC] build: Add configure option --disable-high-precision
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379323375-21540-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 16 Sep 2013 09:19:31 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ACAC771F-74CD-40BF-BFB7-4CC92B588415@holtmann.org>
References: <1379323375-21540-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This enables high precision using 64 bits accumulators by default which
> can be disabled with --disable-high-precision.
> ---
> configure.ac     | 8 ++++++++
> sbc/sbc_tables.h | 2 --
> 2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c052616..5f994d1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -58,4 +58,12 @@ if (test "${enable_tester}" != "no"); then
> fi
> AM_CONDITIONAL(TESTER, test "${enable_tester}" != "no")
> 
> +AC_ARG_ENABLE(high-precision, AC_HELP_STRING([--disable-high-precision],
> +					[disable high precision support]),
> +					[enable_high_precision=${enableval}])
> +if (test "${enable_high_precision}" != "no"); then
> +	AC_DEFINE(SBC_HIGH_PRECISION, 1,
> +		[Define to 1 to enable high precision build of SBC encoder])
> +fi
> +
> AC_OUTPUT(Makefile sbc/sbc.pc)
> diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
> index 25e24e6..3fd80e1 100644
> --- a/sbc/sbc_tables.h
> +++ b/sbc/sbc_tables.h
> @@ -136,8 +136,6 @@ static const int32_t synmatrix8[16][8] = {
> 	  SN8(0xfb8e3130), SN8(0xf8275a10), SN8(0xfe70747c), SN8(0x06a6d988) }
> };
> 
> -/* Uncomment the following line to enable high precision build of SBC encoder */
> -
> /* #define SBC_HIGH_PRECISION */

the comment with the define should also be removed.

Is there any impact on using 64-bit integers compared to 32-bit integers. When would you use one or the other. I think this needs to be documented in README as well.

Regards

Marcel

