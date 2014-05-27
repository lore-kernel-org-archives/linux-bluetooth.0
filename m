Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix not sending write request responses
Date: Tue, 27 May 2014 22:16:04 +0200
Message-ID: <5629184.VfTTLvXmbY@leonov>
In-Reply-To: <1401191567-25019-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401191567-25019-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 27 of May 2014 13:52:47 Jakub Tyszkowski wrote:
> Responses were pushed to pending response queue but send was never
> triggered.
> ---
>  android/gatt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b120834..485a238 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5007,6 +5007,8 @@ static uint8_t write_req_request(const uint8_t *cmd,
> uint16_t cmd_len, return ATT_ECODE_UNLIKELY;
>  	}
> 
> +	process_dev_pending_requests(dev, cmd[0]);
> +
>  	return 0;
>  }

Patch applied, thanks.

-- 
BR
Szymon Janc
