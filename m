Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] sbc: fix endian detection on arm-none-eabi
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPWKHJSraT_wG9FDtarTXQuWN=1pymf5dMbmwdgz8EQp_JPaMg@mail.gmail.com>
Date: Tue, 9 Jan 2018 16:28:44 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4BDCCBFF-0E03-4C57-B107-6F7C65B5E7A2@holtmann.org>
References: <CAPWKHJSraT_wG9FDtarTXQuWN=1pymf5dMbmwdgz8EQp_JPaMg@mail.gmail.com>
To: Austin Morton <austinpmorton@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Austin,

> The gcc-arm-none-eabi toolchain defines its byte order constants with a single
> preceding underscore rather than two.
> Additionally, the macros do not get defined unless <sys/param.h> is included.
> 
> Signed-off-by: Austin Morton <austinpmorton@gmail.com>
> ---
> sbc/sbc.c | 13 +++++++++----
> 1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index 606f11c..d3f5948 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -35,6 +35,7 @@
> #include <stdlib.h>
> #include <stdbool.h>
> #include <sys/types.h>
> +#include <sys/param.h>
> #include <limits.h>
> 
> #include "sbc_math.h"
> @@ -70,7 +71,8 @@
> #define A2DP_ALLOCATION_SNR (1 << 1)
> #define A2DP_ALLOCATION_LOUDNESS (1 << 0)
> 
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> +#if (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN) || \
> + (defined(_BYTE_ORDER) && _BYTE_ORDER == _LITTLE_ENDIAN)

while we can surely do this, I wonder why we need it. BlueZ is pretty old and has used the same ifdef for a long time. If this breaks in your toolchain, then it breaks in a lot of cases. So is this really the right fix or are we just missing some includes.

Regards

Marcel

