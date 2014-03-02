Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/18] android/hal-gatt-api: Add Client Register event
Date: Sun, 02 Mar 2014 23:02:25 +0100
Message-ID: <1720368.2O4kFFxrmM@leonov>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 28 of February 2014 11:23:46 Jakub Tyszkowski wrote:
> ---
>  android/hal-ipc-api.txt | 5 +++++
>  android/hal-msg.h       | 7 +++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index 1a19c80..58c05a9 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -1797,6 +1797,11 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
>  		In case of an error, the error response will be returned.
> 
>  	Opcode 0x81 - Register Client notification
> +
> +		Notification parameters: Status (4 octets)
> +		                         Client Interface (4 octets)
> +		                         UUID (16 octets)
> +
>  	Opcode 0x82 - Scan Result notification
>  	Opcode 0x83 - Connect Device notification
>  	Opcode 0x84 - Disconnect Device notification
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index bde9717..9f7f9e9 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -1236,3 +1236,10 @@ struct hal_ev_avrcp_passthrough_cmd {
>  	uint8_t id;
>  	uint8_t state;
>  } __attribute__((packed));
> +
> +#define HAL_EV_GATT_CLIENT_REGISTER_CLIENT	0x81
> +struct hal_ev_gatt_client_register_client {
> +	int32_t status;
> +	int32_t client_if;
> +	uint8_t app_uuid[16];
> +} __attribute__((packed));

All patches in this set are now applied, thanks.

-- 
BR
Szymon Janc
