Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415619477-2358-3-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1415619477-2358-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1415619477-2358-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Mon, 10 Nov 2014 15:23:06 +0200
Message-ID: <CABBYNZK4rdKC9Q3hrr1mBNy=UcZ-UuicUSwGMW-SXpNYvYe04A@mail.gmail.com>
Subject: Re: [PATCH 2/4] android/hal-msg: Add support for new AVRCP CTRL interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Nov 10, 2014 at 1:37 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> AVRCP controller interface added in Android Lollipop. Update it's
> commands and notifications. Update service ids also.
> ---
>  android/hal-msg.h | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index eef226e..cb6f23b 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -34,9 +34,10 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
>  #define HAL_SERVICE_ID_A2DP            6
>  #define HAL_SERVICE_ID_HEALTH          7
>  #define HAL_SERVICE_ID_AVRCP           8
> -#define HAL_SERVICE_ID_GATT            9
> -#define HAL_SERVICE_ID_HANDSFREE_CLIENT        10
> -#define HAL_SERVICE_ID_MAP_CLIENT      11
> +#define HAL_SERVICE_ID_AVRCP_CTRL      9
> +#define HAL_SERVICE_ID_GATT            10
> +#define HAL_SERVICE_ID_HANDSFREE_CLIENT        11
> +#define HAL_SERVICE_ID_MAP_CLIENT      12

Since for the others interface added in 5.0 we did append to the end
this one should also go there, otherwise we will have to reorganize
all the ids.

>  #define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_MAP_CLIENT
>
> @@ -607,7 +608,7 @@ struct hal_cmd_handsfree_phone_state_change {
>         uint8_t number[0];
>  } __attribute__((packed));
>
> -/* AVRCP HAL API */
> +/* AVRCP TARGET HAL API */
>
>  #define HAL_AVRCP_PLAY_STATUS_STOPPED  0x00
>  #define HAL_AVRCP_PLAY_STATUS_PLAYING  0x01
> @@ -711,6 +712,15 @@ struct hal_cmd_avrcp_set_volume {
>         uint8_t value;
>  } __attribute__((packed));
>
> +/* AVRCP CTRL HAL API */
> +
> +#define HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH     0x01
> +struct hal_cmd_avrcp_ctrl_send_passthrough {
> +       uint8_t bdaddr[6];
> +       uint8_t key_code;
> +       uint8_t key_state;
> +} __attribute__((packed));
> +
>  /* GATT HAL API */
>
>  #define HAL_OP_GATT_CLIENT_REGISTER            0x01
> @@ -1499,6 +1509,18 @@ struct hal_ev_avrcp_passthrough_cmd {
>         uint8_t state;
>  } __attribute__((packed));
>
> +#define HAL_EV_AVRCP_CTRL_CONN_STATE           0x80
> +struct hal_ev_avrcp_ctrl_conn_state {
> +       uint8_t state;
> +       uint8_t bdaddr[6];
> +} __attribute__((packed));
> +
> +#define HAL_EV_AVRCP_CTRL_PASSTHROUGH_RSP      0x81
> +struct hal_ev_avrcp_ctrl_passthrough_rsp {
> +       uint8_t id;
> +       uint8_t key_state;
> +} __attribute__((packed));
> +
>  #define HAL_EV_GATT_CLIENT_REGISTER_CLIENT     0x81
>  struct hal_ev_gatt_client_register_client {
>         int32_t status;
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
