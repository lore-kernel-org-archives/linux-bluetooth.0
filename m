Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix memory leak
Date: Wed, 24 Dec 2014 12:16:33 +0100
Message-ID: <1962912.3sVAV770nz@leonov>
In-Reply-To: <1418997020-7293-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1418997020-7293-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 19 of December 2014 15:50:20 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/gatt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 2534836..6248f07 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6129,6 +6129,7 @@ static uint8_t find_info_handle(const uint8_t *cmd,
> uint16_t cmd_len, int iterator = 0;
>  	uint16_t start, end;
>  	uint16_t len, queue_len;
> +	uint8_t ret = 0;
> 
>  	DBG("");
> 
> @@ -6206,13 +6207,13 @@ static uint8_t find_info_handle(const uint8_t *cmd,
> uint16_t cmd_len, ATT_FIND_INFO_RESP_FMT_128BIT, adl, rsp,
>  								rsp_size);
>  	if (!len)
> -		return ATT_ECODE_UNLIKELY;
> +		ret = ATT_ECODE_UNLIKELY;
> 
>  	*length = len;
>  	att_data_list_free(adl);
>  	queue_destroy(temp, NULL);
> 
> -	return 0;
> +	return ret;
>  }
> 
>  static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,

Applied, thanks.

-- 
BR
Szymon Janc
