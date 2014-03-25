Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/hal-gatt: Fix sending wrong gatt_id struct
Date: Tue, 25 Mar 2014 14:07:36 +0100
Message-ID: <3336350.Z0yWCzldkc@uw000953>
In-Reply-To: <1395751981-15843-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395751981-15843-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 25 of March 2014 13:53:00 Jakub Tyszkowski wrote:
> ---
>  android/hal-gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hal-gatt.c b/android/hal-gatt.c
> index bd61576..8a8ce9c 100644
> --- a/android/hal-gatt.c
> +++ b/android/hal-gatt.c
> @@ -676,7 +676,7 @@ static bt_status_t get_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
>  	cmd->number = 1;
>  
>  	if (start_descr_id) {
> -		gatt_id_to_hal(&cmd->gatt_id[1], char_id);
> +		gatt_id_to_hal(&cmd->gatt_id[1], start_descr_id);
>  		len += sizeof(cmd->gatt_id[1]);
>  		cmd->number++;
>  	}
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
