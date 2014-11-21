Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/client: Check if hex data is present in define
Date: Fri, 21 Nov 2014 14:37:39 +0100
Message-ID: <3082917.KM6LTQJ3Pf@uw000953>
In-Reply-To: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 20 of November 2014 16:34:01 Grzegorz Kolodziejczyk wrote:
> Each hex data argument need to be checked before parsing. It was done in
> before parse argc check. Now it's integrated in GET_VERIFIER_HEX_STRING.
> ---
>  android/client/if-gatt.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index 49ccebf..9d6fafd 100644
> --- a/android/client/if-gatt.c
> +++ b/android/client/if-gatt.c
> @@ -116,9 +116,14 @@ const btgatt_interface_t *if_gatt = NULL;
>  		} \
>  	} while (0)
>  
> -#define GET_VERIFY_HEX_STRING(n, v, l) \
> +#define GET_VERIFY_HEX_STRING(i, v, l) \
>  	do { \
>  		int ll;\
> +		const char *n = argv[i]; \
> +		if (argc <= i) { \
> +			haltest_error("No value specified\n"); \
> +			return; \
> +		} \
>  		if (n[0] != '0' || (n[1] != 'X' && n[1] != 'x')) { \
>  			haltest_error("Value must be hex string\n"); \
>  			return; \
> @@ -1366,13 +1371,7 @@ static void write_characteristic_p(int argc, const char **argv)
>  	}
>  	write_type = atoi(argv[5]);
>  
> -	/* value */
> -	if (argc <= 6) {
> -		haltest_error("No value specified\n");
> -		return;
> -	}
> -
> -	GET_VERIFY_HEX_STRING(argv[6], value, len);
> +	GET_VERIFY_HEX_STRING(6, value, len);
>  
>  	/* auth_req */
>  	if (argc > 7)
> @@ -1984,8 +1983,7 @@ static void gatts_send_indication_p(int argc, const char *argv[])
>  	}
>  	confirm = atoi(argv[5]);
>  
> -	if (argc > 6)
> -		GET_VERIFY_HEX_STRING(argv[6], data, len);
> +	GET_VERIFY_HEX_STRING(6, data, len);
>  
>  	EXEC(if_gatt->server->send_indication, server_if, attr_handle, conn_id,
>  							len, confirm, data);
> @@ -2013,15 +2011,7 @@ static void gatts_send_response_p(int argc, const char *argv[])
>  	data.attr_value.auth_req = 0;
>  	data.attr_value.len = 0;
>  
> -	if (argc > 7) {
> -		GET_VERIFY_HEX_STRING(argv[7], data.attr_value.value,
> -							data.attr_value.len);
> -
> -		if (data.attr_value.len == 0) {
> -			haltest_error("Failed to parse response value");
> -			return;
> -		}
> -	}
> +	GET_VERIFY_HEX_STRING(7, data.attr_value.value, data.attr_value.len);
>  
>  	haltest_info("conn_id %d, trans_id %d, status %d", conn_id, trans_id,
>  									status);
> 

All six patches applied, thanks.

-- 
Best regards, 
Szymon Janc
