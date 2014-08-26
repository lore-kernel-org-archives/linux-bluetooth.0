Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] android/client: Fix incorrect data parsing
Date: Tue, 26 Aug 2014 11:27:42 +0200
Message-ID: <1439770.xPBATBfFEp@uw000953>
In-Reply-To: <1408974654-22836-1-git-send-email-marcin.kraglak@tieto.com>
References: <1408974654-22836-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 25 of August 2014 15:50:53 Marcin Kraglak wrote:
> Use fill_buffer function in processing write_characteristic
> and send_indication functions.
> ---
>  android/client/if-gatt.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index 8154bfd..a4c6bc9 100644
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
> +	if (strncmp(argv[6], "0X", 2) && strncmp(argv[6], "0x", 2)) {
> +		haltest_error("Value must be hex string");
> +		return;
> +	}

Why not just compare argv[6] == '0' and argv[7] == 'x' ?
(Also there is strncasecmp() if you really insist on comparing strings).

> +
> +	len = fill_buffer(argv[6] + 2, value, sizeof(value));
>  
>  	/* auth_req */
>  	if (argc > 7)
> @@ -1775,7 +1776,7 @@ static void gatts_send_indication_p(int argc, const char *argv[])
>  	int attr_handle;
>  	int conn_id;
>  	int confirm;
> -	char data[200];
> +	uint8_t data[200];

Why this change? It looks like it makes no difference except of extra cast
few lines later.

>  	int len = 0;
>  
>  	RETURN_IF_NULL(if_gatt);
> @@ -1791,12 +1792,16 @@ static void gatts_send_indication_p(int argc, const char *argv[])
>  	confirm = atoi(argv[5]);
>  
>  	if (argc > 6) {
> -		len = strlen(argv[6]);
> -		scan_field(argv[6], len, (uint8_t *) data, sizeof(data));
> +		if (strncmp(argv[6], "0X", 2) && strncmp(argv[6], "0x", 2)) {
> +			haltest_error("Value must be hex string");
> +			return;
> +		}
> +
> +		len = fill_buffer(argv[6] + 2, data, sizeof(data));
>  	}
>  
>  	EXEC(if_gatt->server->send_indication, server_if, attr_handle, conn_id,
> -							len, confirm, data);
> +						len, confirm, (char *) data);
>  }
>  
>  /* send_response */
> 

-- 
Best regards, 
Szymon Janc
