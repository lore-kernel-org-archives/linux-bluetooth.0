Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/2] android/client: Fix incorrect data parsing
Date: Tue, 26 Aug 2014 15:21:09 +0200
Message-ID: <6050899.WYRYWitLqa@uw000953>
In-Reply-To: <1409048454-16116-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409048454-16116-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tuesday 26 of August 2014 12:20:53 Marcin Kraglak wrote:
> Use fill_buffer function in processing write_characteristic
> and send_indication functions.
> ---
>  android/client/if-gatt.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index 8154bfd..1d8def2 100644
> --- a/android/client/if-gatt.c
> +++ b/android/client/if-gatt.c
> @@ -1191,11 +1191,12 @@ static void write_characteristic_p(int argc, const char **argv)
>  		return;
>  	}
>  
> -	/* len in chars */
> -	len = strlen(argv[6]);
> -	scan_field(argv[6], len, value, sizeof(value));
> -	/* len in bytes converted from ascii chars */
> -	len = (len + 1) / 2;
> +	if (argv[6][0] != '0' || (argv[6][1] != 'X' && argv[6][1] != 'x')) {
> +		haltest_error("Value must be hex string");
> +		return;
> +	}
> +
> +	len = fill_buffer(argv[6] + 2, value, sizeof(value));
>  
>  	/* auth_req */
>  	if (argc > 7)
> @@ -1791,8 +1792,13 @@ static void gatts_send_indication_p(int argc, const char *argv[])
>  	confirm = atoi(argv[5]);
>  
>  	if (argc > 6) {
> -		len = strlen(argv[6]);
> -		scan_field(argv[6], len, (uint8_t *) data, sizeof(data));
> +		if (argv[6][0] != '0' ||
> +				(argv[6][1] != 'X' && argv[6][1] != 'x')) {
> +			haltest_error("Value must be hex string");
> +			return;
> +		}
> +
> +		len = fill_buffer(argv[6] + 2, (uint8_t *) data, sizeof(data));
>  	}
>  
>  	EXEC(if_gatt->server->send_indication, server_if, attr_handle, conn_id,
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
