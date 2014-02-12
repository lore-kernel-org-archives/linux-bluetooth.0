Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/9] android/hal-ipc-api: Add Get Play Status Response
Date: Wed, 12 Feb 2014 19:29:05 +0100
Message-ID: <7446843.dRdmMMYOsq@leonov>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday 12 of February 2014 16:48:06 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  android/hal-ipc-api.txt | 30 +++++++++++++++++++++++++++++-
>  android/hal-msg.h       | 16 ++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index ad5d192..01c2e81 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -1174,7 +1174,35 @@ Bluetooth Remote Control HAL (ID 8)
>  Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
> 
>  	Opcode 0x00 - Error response
> -	Opcode 0x01 - Get Play Status command/response
> +
> +		Response parameters: Status (1 octet)
> +
> +		Valid status values: 0x01 = Fail
> +		                     0x02 = Not ready
> +		                     0x03 = No memory
> +		                     0x04 = Busy
> +		                     0x05 = Done (already completed)
> +		                     0x06 = Unsupported
> +		                     0x07 = Parameter invalid
> +		                     0x08 = Unhandled
> +		                     0x09 = Authentication failure
> +		                     0x0a = Remote device down
> +
> +	Opcode 0x01 - Get Play Status Response command/response
> +
> +		Command parameters: Status (1 octet)
> +		                    Duration (4 octets)
> +		                    Position (4 octets)
> +
> +		In case of an error, the error response will be returned.
> +
> +		Valid status values: 0x00 = Stopped
> +		                     0x01 = Playing
> +		                     0x02 = Paused
> +		                     0x03 = Fwd seek
> +		                     0x04 = Rev seek
> +		                     0xff = Error
> +
>  	Opcode 0x02 - List Player Application Attributes command/response
>  	Opcode 0x03 - List Player Application Values command/response
>  	Opcode 0x04 - Get Player Application Values command/response
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 6ef00f9..82cd3f5 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -783,3 +783,19 @@ struct hal_ev_handsfree_unknown_at {
>  } __attribute__((packed));
> 
>  #define HAL_EV_HANDSFREE_HSP_KEY_PRESS	0x90
> +
> +/* AVRCP HAL API */
> +
> +#define HAL_AVRCP_PLAY_STATUS_STOPPED	0x00
> +#define HAL_AVRCP_PLAY_STATUS_PLAYING	0x01
> +#define HAL_AVRCP_PLAY_STATUS_PAUSED	0x02
> +#define HAL_AVRCP_PLAY_STATUS_FWD_SEEK	0x03
> +#define HAL_AVRCP_PLAY_STATUS_REV_SEEK	0x04
> +#define HAL_AVRCP_PLAY_STATUS_ERROR	0xff
> +
> +#define HAL_OP_AVRCP_GET_PLAY_STATUS	0x01
> +struct hal_cmd_avrcp_get_play_status {
> +	uint8_t status;
> +	uint32_t duration;
> +	uint32_t position;
> +} __attribute__((packed));

All patches in this set have been applied, thanks.

-- 
BR
Szymon Janc
