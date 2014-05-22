Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Don't process read_by_type request with invalied range
Date: Thu, 22 May 2014 14:04:28 +0200
Message-ID: <50030536.bG1W7Pr17I@uw000953>
In-Reply-To: <1400754835-3325-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400754835-3325-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 22 of May 2014 12:33:55 Marcin Kraglak wrote:
> Return ATT_ECODE_INVALID_HANDLE if range is incorrect. It repairs
> TC_GAR_SR_BI_08_C test case.
> ---
>  android/gatt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 89da60d..dae0df3 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4404,6 +4404,9 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>  	if (!len)
>  		return ATT_ECODE_INVALID_PDU;
>  
> +	if (start > end)
> +		return ATT_ECODE_INVALID_HANDLE;
> +
>  	q = queue_new();
>  	if (!q)
>  		return ATT_ECODE_INSUFF_RESOURCES;
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
