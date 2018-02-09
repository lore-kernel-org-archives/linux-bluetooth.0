Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BlueZ] unit/test-ecc: Fix uninitialised values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180209131028.16874-1-luiz.dentz@gmail.com>
Date: Fri, 9 Feb 2018 15:41:07 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2425F01E-DE0C-4A43-B68D-900BABFE24B6@holtmann.org>
References: <20180209131028.16874-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Conditional jump or move depends on uninitialised value(s)
>  at 0x40208C: test_sample (test-ecc.c:106)
>  by 0x4022AB: test_invalid_pub (test-ecc.c:272)
>  by 0x406DA2: run_callback (tester.c:415)
>  by 0x4E83576: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x4E86B76: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x4E86F1F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x4E87231: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x408245: tester_run (tester.c:830)
>  by 0x401CC3: main (test-ecc.c:291)
> 
> Conditional jump or move depends on uninitialised value(s)
>  at 0x4020D6: test_sample (test-ecc.c:113)
>  by 0x4022AB: test_invalid_pub (test-ecc.c:272)
>  by 0x406DA2: run_callback (tester.c:415)
>  by 0x4E83576: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x4E86B76: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x4E86F1F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x4E87231: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.3)
>  by 0x408245: tester_run (tester.c:830)
>  by 0x401CC3: main (test-ecc.c:291)
> ---
> unit/test-ecc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/unit/test-ecc.c b/unit/test-ecc.c
> index 98400a253..e0f9723fc 100644
> --- a/unit/test-ecc.c
> +++ b/unit/test-ecc.c
> @@ -91,7 +91,7 @@ static int test_sample(uint8_t priv_a[32], uint8_t priv_b[32],
> 				uint8_t pub_a[64], uint8_t pub_b[64],
> 				uint8_t dhkey[32])
> {
> -	uint8_t dhkey_a[32], dhkey_b[32];
> +	uint8_t dhkey_a[32] = {}, dhkey_b[32] = {};
> 	int fails = 0;

does an explicit memset also fixes this?

Regards

Marcel

