Return-Path: <cyrus@holtmann.org>
Message-ID: <1357758529.1806.46.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/3] unit: Reuse define_test() macro for
 /TP/SERVER/BRW/* tests
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 11:08:49 -0800
In-Reply-To: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> This is made possible by adding the mtu parameter, given
> /TP/SERVER/BRW/* tests use MTU of 672.
> ---
>  unit/test-sdp.c |   24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/unit/test-sdp.c b/unit/test-sdp.c
> index 315a5cd..e9cbcdf 100644
> --- a/unit/test-sdp.c
> +++ b/unit/test-sdp.c
> @@ -68,34 +68,22 @@ struct test_data {
>  		.cont_len = cont,				\
>  	}
>  
> -#define define_test(name, args...) \
> +#define define_test(name, _mtu, args...) \
>  	do {								\
>  		const struct sdp_pdu pdus[] = {				\
>  			args, { }, { }					\
>  		};							\
>  		static struct test_data data;				\
> -		data.mtu = 48;						\
> +		data.mtu = _mtu;					\

so using _mtu instead of mtu was the trick here. For the heck of it I
could not figure that one out. So in the end I gave up on it and
hardcoded it :(

Patch has been applied.

Regards

Marcel


