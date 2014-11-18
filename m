Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416263288-30530-11-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
	<1416263288-30530-11-git-send-email-szymon.janc@tieto.com>
Date: Tue, 18 Nov 2014 11:58:58 +0100
Message-ID: <CAN_7+YbHD0+4CEWmWOdD-0Z=YLQx48qFYC_=vEW5670S9GGVig@mail.gmail.com>
Subject: Re: [PATCH 11/16] android/hal-gatt: Implement client multi_adv_set_inst_data
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 17, 2014 at 11:28 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This adds required IPC message, HAL implementation and daemon stub
> handler.
> ---
>  android/gatt.c     | 16 ++++++++++++++++
>  android/hal-gatt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  android/hal-msg.h  | 13 +++++++++++++
>  3 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 6d1f2c7..1ba06f7 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5662,6 +5662,19 @@ static void handle_client_update_multi_adv(const void *buf, uint16_t len)
>                                         HAL_STATUS_UNSUPPORTED);
>  }
>
> +static void handle_client_setup_multi_adv_inst(const void *buf, uint16_t len)
> +{
> +       const struct hal_cmd_gatt_client_setup_multi_adv_inst *cmd = buf;
> +
> +       DBG("client_if %d", cmd->client_if);
> +
> +       /* TODO */
> +
> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> +                                       HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST,
> +                                       HAL_STATUS_UNSUPPORTED);
> +}
> +
>  static const struct ipc_handler cmd_handlers[] = {
>         /* HAL_OP_GATT_CLIENT_REGISTER */
>         { handle_client_register, false,
> @@ -5795,6 +5808,9 @@ static const struct ipc_handler cmd_handlers[] = {
>         /* HAL_OP_GATT_CLIENT_UPDATE_MULTI_ADV */
>         { handle_client_update_multi_adv, false,
>                 sizeof(struct hal_cmd_gatt_client_update_multi_adv) },
> +       /* HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST */
> +       { handle_client_setup_multi_adv_inst, false,
> +               sizeof(struct hal_cmd_gatt_client_setup_multi_adv_inst) },
>  };
>
>  static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
> diff --git a/android/hal-gatt.c b/android/hal-gatt.c
> index 0a1d823..bf1e3e7 100644
> --- a/android/hal-gatt.c
> +++ b/android/hal-gatt.c
> @@ -1522,11 +1522,59 @@ static bt_status_t multi_adv_set_inst_data(int client_if, bool set_scan_rsp,
>                                                 int service_uuid_len,
>                                                 char *service_uuid)
>  {
> -       DBG("");
> +       char buf[IPC_MTU];
> +       struct hal_cmd_gatt_client_setup_multi_adv_inst *cmd = (void *) buf;
> +       int off = 0;
>
> -       /* TODO */
> +       if (!interface_ready())
> +               return BT_STATUS_NOT_READY;
>
> -       return BT_STATUS_UNSUPPORTED;
> +       if (manufacturer_len > 0 && !manufacturer_data)
> +                       return BT_STATUS_PARM_INVALID;
> +
> +       if (service_data_len > 0 && !service_data)
> +                       return BT_STATUS_PARM_INVALID;
> +
> +       if (service_uuid_len > 0 && !service_uuid)
> +               return BT_STATUS_PARM_INVALID;
> +
> +       if (sizeof(*cmd) + manufacturer_len + service_data_len
> +                                               + service_uuid_len > IPC_MTU)
> +               return BT_STATUS_FAIL;
> +
> +       if (!interface_ready())
> +               return BT_STATUS_NOT_READY;

This is not needed. It is already checked couple lines above.
> +
> +       cmd->client_if = client_if;
> +       cmd->set_scan_rsp = set_scan_rsp;
> +       cmd->include_name = include_name;
> +       cmd->include_tx_power = incl_txpower;
> +       cmd->appearance = appearance;
> +       cmd->manufacturer_data_len = manufacturer_len;
> +       cmd->service_data_len = service_data_len;
> +       cmd->service_uuid_len = service_uuid_len;
> +
> +       if (manufacturer_len > 0) {
> +               memcpy(cmd->data_service_uuid, manufacturer_data,
> +                                                       manufacturer_len);
> +               off += manufacturer_len;
> +       }
> +
> +       if (service_data_len > 0) {
> +               memcpy(cmd->data_service_uuid + off, service_data,
> +                                                       service_data_len);
> +               off += service_data_len;
> +       }
> +
> +       if (service_uuid_len > 0) {
> +               memcpy(cmd->data_service_uuid + off, service_uuid,
> +                                                       service_uuid_len);
> +               off += service_uuid_len;
> +       }
> +
> +       return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
> +                               HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST,
> +                               sizeof(*cmd) + off, cmd, NULL, NULL, NULL);
>  }
>
>  static bt_status_t multi_adv_disable(int client_if)
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 096d610..7d26140 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -1116,6 +1116,19 @@ struct hal_cmd_gatt_client_update_multi_adv {
>         int32_t timeout;
>  } __attribute__((packed));
>
> +#define HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST                0x2d
> +struct hal_cmd_gatt_client_setup_multi_adv_inst {
> +       int32_t client_if;
> +       uint8_t set_scan_rsp;
> +       uint8_t include_name;
> +       uint8_t include_tx_power;
> +       int32_t appearance;
> +       int32_t manufacturer_data_len;
> +       int32_t service_data_len;
> +       int32_t service_uuid_len;
> +       uint8_t data_service_uuid[0];
> +} __attribute__((packed));
> +
>  /* Handsfree client HAL API */
>
>  #define HAL_OP_HF_CLIENT_CONNECT               0x01
> --
> 1.9.3

\Łukasz

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
