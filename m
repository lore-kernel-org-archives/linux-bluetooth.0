Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android/client: Check if hex string is byte format
Date: Fri, 05 Sep 2014 15:28:28 +0200
Message-ID: <2083072.L6pR49dnTk@uw000953>
In-Reply-To: <1409921307-31445-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1409921307-31445-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1409921307-31445-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 05 of September 2014 14:48:27 Grzegorz Kolodziejczyk wrote:
> Data strings should be byte format.
> ---
>  android/client/if-gatt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index c8352b5..5cae7e8 100644
> --- a/android/client/if-gatt.c
> +++ b/android/client/if-gatt.c
> @@ -803,6 +803,10 @@ static int fill_buffer(const char *str, uint8_t *out, int out_size)
>  
>  	str_len = strlen(str);
>  
> +	/* Hex string must be byte format */
> +	if (str_len%2 != 0)

if (str_len % 2)

> +		return -1;
> +
>  	for (i = 0, j = 0; i < out_size && j < str_len; i++, j++) {
>  		c = str[j];
>  
> @@ -1201,6 +1205,10 @@ static void write_characteristic_p(int argc, const char **argv)
>  	}
>  
>  	GET_VERIFY_HEX_STRING(argv[6], value, len);
> +	if (len < 0) {
> +		haltest_error("Value must be byte hex string\n");
> +		return;
> +	}

Move this check to GET_VERIFY_HEX_STRING() macro (after fill_bufer()) so that
all users gets updated.

>  
>  	/* auth_req */
>  	if (argc > 7)
> 

-- 
Best regards, 
Szymon Janc
