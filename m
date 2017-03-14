Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170313175412.11365-4-eu@felipetonello.com>
References: <20170313175412.11365-1-eu@felipetonello.com> <20170313175412.11365-4-eu@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Mar 2017 15:36:09 +0200
Message-ID: <CABBYNZKsTz_LGXwGW7jHK3vC4Hc1UFe6oTFv4hfO1sX6FZ0iow@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 BlueZ 3/3] Bluetooth: mgmt: Added new
 MGMT_OP_UPDATE_CONN_PARAM command
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Mon, Mar 13, 2017 at 7:54 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
> This command is similar to MGMT_OP_LOAD_CONN_PARAM with the exception
> that it only updates one connection parameter and it doesn't cleanup
> previous parameters set.
>
> This is useful for applications to update one specific connection
> parameter and not caring about other cached connection parameters.
>
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  include/net/bluetooth/mgmt.h |  10 +++++
>  net/bluetooth/mgmt.c         | 104 ++++++++++++++++++++++++++++---------------
>  2 files changed, 77 insertions(+), 37 deletions(-)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 72a456bbbcd5..f81003fb32f1 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -604,6 +604,16 @@ struct mgmt_cp_set_appearance {
>  } __packed;
>  #define MGMT_SET_APPEARANCE_SIZE       2
>
> +#define MGMT_OP_UPDATE_CONN_PARAM      0x0044
> +struct mgmt_cp_update_conn_param {
> +       struct mgmt_addr_info addr;
> +       __le16 min_interval;
> +       __le16 max_interval;
> +       __le16 latency;
> +       __le16 timeout;
> +} __packed;
> +#define MGMT_UPDATE_CONN_PARAM_SIZE    (MGMT_ADDR_INFO_SIZE + 8)
> +

Id really like it to be named add instead of update since this may be
a new entry. Regarding the AD, the tricky part about it is that in
case of passive scanning + auto reconnect the userspace may not have
enough time to set since the kernel should start connecting to it
immediately, also we don't want to keep adding the same parameters
over and over, perhaps not even if they change, since they only really
matter if the device is going to be connected we can just cache the
last parameters and only propagate to the kernel before connecting.
Again this only matters for devices not marked to auto-connect, which
in most cases is limited to devices that have never been connected
before, for the devices marked to auto-connect the kernel should
probably be parsing the AD.

>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         __le16  opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 0f44af559ae6..b9546bab3b07 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
>         MGMT_OP_START_LIMITED_DISCOVERY,
>         MGMT_OP_READ_EXT_INFO,
>         MGMT_OP_SET_APPEARANCE,
> +       MGMT_OP_UPDATE_CONN_PARAM,
>  };
>
>  static const u16 mgmt_events[] = {
> @@ -5462,6 +5463,69 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
>         return err;
>  }
>
> +/* This function requires the caller holds hdev->lock */
> +static u8 really_update_conn_param(struct hci_dev *hdev,
> +                                  struct mgmt_cp_update_conn_param *param)
> +{
> +       struct hci_conn_params *hci_param;
> +       u16 min, max, latency, timeout;
> +       u8 addr_type;
> +
> +       if (param->addr.type == BDADDR_LE_PUBLIC)
> +               addr_type = ADDR_LE_DEV_PUBLIC;
> +       else if (param->addr.type == BDADDR_LE_RANDOM)
> +               addr_type = ADDR_LE_DEV_RANDOM;
> +       else
> +               return MGMT_STATUS_INVALID_PARAMS;
> +
> +       min = le16_to_cpu(param->min_interval);
> +       max = le16_to_cpu(param->max_interval);
> +       latency = le16_to_cpu(param->latency);
> +       timeout = le16_to_cpu(param->timeout);
> +
> +       BT_DBG("min 0x%04x max 0x%04x latency 0x%04x timeout 0x%04x",
> +              min, max, latency, timeout);
> +
> +       if (hci_check_conn_params(min, max, latency, timeout) < 0) {
> +               BT_ERR("Ignoring invalid connection parameters");
> +               return MGMT_STATUS_INVALID_PARAMS;
> +       }
> +
> +       hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
> +                                       addr_type);
> +       if (!hci_param) {
> +               BT_ERR("Failed to add connection parameters");
> +               return MGMT_STATUS_FAILED;
> +       }
> +
> +       hci_param->conn_min_interval = min;
> +       hci_param->conn_max_interval = max;
> +       hci_param->conn_latency = latency;
> +       hci_param->supervision_timeout = timeout;
> +
> +       return 0;
> +}
> +
> +static int update_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
> +                            u16 len)
> +{
> +       struct mgmt_cp_update_conn_param *cp = data;
> +       u8 cmd_status;
> +
> +       if (!lmp_le_capable(hdev))
> +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_UPDATE_CONN_PARAM,
> +                                      MGMT_STATUS_NOT_SUPPORTED);
> +
> +       hci_dev_lock(hdev);
> +
> +       cmd_status = really_update_conn_param(hdev, cp);
> +
> +       hci_dev_unlock(hdev);
> +
> +       return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UPDATE_CONN_PARAM,
> +                                cmd_status, NULL, 0);
> +}
> +
>  static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
>                            u16 len)
>  {
> @@ -5500,47 +5564,12 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
>
>         for (i = 0; i < param_count; i++) {
>                 struct mgmt_conn_param *param = &cp->params[i];
> -               struct hci_conn_params *hci_param;
> -               u16 min, max, latency, timeout;
> -               u8 addr_type;
>
>                 BT_DBG("Adding %pMR (type %u)", &param->addr.bdaddr,
>                        param->addr.type);
>
> -               if (param->addr.type == BDADDR_LE_PUBLIC) {
> -                       addr_type = ADDR_LE_DEV_PUBLIC;
> -               } else if (param->addr.type == BDADDR_LE_RANDOM) {
> -                       addr_type = ADDR_LE_DEV_RANDOM;
> -               } else {
> -                       BT_ERR("Ignoring invalid connection parameters");
> -                       continue;
> -               }
> -
> -               min = le16_to_cpu(param->min_interval);
> -               max = le16_to_cpu(param->max_interval);
> -               latency = le16_to_cpu(param->latency);
> -               timeout = le16_to_cpu(param->timeout);
> -
> -               BT_DBG("min 0x%04x max 0x%04x latency 0x%04x timeout 0x%04x",
> -                      min, max, latency, timeout);
> -
> -               if (hci_check_conn_params(min, max, latency, timeout) < 0) {
> -                       BT_ERR("Ignoring invalid connection parameters");
> -                       continue;
> -               }
> -
> -               hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
> -                                               addr_type);
> -               if (!hci_param) {
> -                       BT_ERR("Failed to add connection parameters");
> -                       continue;
> -               }
> -
> -               hci_param->conn_min_interval = min;
> -               hci_param->conn_max_interval = max;
> -               hci_param->conn_latency = latency;
> -               hci_param->supervision_timeout = timeout;
> -               hci_param->conn_config = BT_LE_CONN_CONFIG_CUSTOM_LATENCY;
> +               really_update_conn_param(hdev,
> +                       (struct mgmt_cp_update_conn_param *)param);
>         }
>
>         hci_dev_unlock(hdev);
> @@ -6539,6 +6568,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
>         { read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
>                                                 HCI_MGMT_UNTRUSTED },
>         { set_appearance,          MGMT_SET_APPEARANCE_SIZE },
> +       { update_conn_param,       MGMT_UPDATE_CONN_PARAM_SIZE },
>  };
>
>  void mgmt_index_added(struct hci_dev *hdev)
> --
> 2.12.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
