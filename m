Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:27:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v2 2/3] android: Update HAL with device info on incoming
 connection
Message-ID: <20131112132730.GD22931@x220.p-661hnu-f1>
References: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1384260700-16621-3-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384260700-16621-3-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Nov 12, 2013, Lukasz Rymanowski wrote:
> Make sure Android have information about connecting remote device. This
> is needed for example to show device name on incoming bonding request.
> ---
>  android/adapter.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index f92301e..a59ab4e 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -857,9 +857,8 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
>  		return;
>  	}
>  
> -	/* TODO: Update device */
> -
> -	/* TODO: Check Set bonding state */
> +	update_found_device(&ev->addr.bdaddr, ev->addr.type, 0, false,
> +					&ev->eir[0], btohs(ev->eir_len));
>  
>  	hal_ev.status = HAL_STATUS_SUCCESS;
>  	hal_ev.state = HAL_ACL_STATE_CONNECTED;

This patch has been applied. Thanks.

Johan
