Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170216180315.30531-3-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com> <20170216180315.30531-3-eu@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Feb 2017 11:26:31 +0200
Message-ID: <CABBYNZLs7YjJp+apMKF9-Qpg6GnvUWEfSUNEa+AkrffCqyg-Eg@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 2/7] src/adapter: Added connection parameter
 load/store functions
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Thu, Feb 16, 2017 at 8:03 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
> It is interesting to let other parts of bluetoothd to access these
> functions since there are few different use-cases where this updating
> and loading connection parameters can happen.
> ---
>  src/adapter.c | 24 ++++++++++++++++++++++--
>  src/adapter.h |  9 +++++++++
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 3dac7d6490d6..b63883e3cae5 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3609,6 +3609,26 @@ static void load_conn_params(struct btd_adapter *adapter, GSList *params)
>                 btd_error(adapter->dev_id, "Load connection parameters failed");
>  }
>
> +void adapter_load_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
> +                               uint8_t bdaddr_type, uint16_t min_interval,
> +                               uint16_t max_interval, uint16_t latency,
> +                               uint16_t timeout)
> +{
> +       GSList *params = NULL;
> +       struct conn_param param;
> +
> +       bacpy(&param.bdaddr, peer);
> +       param.bdaddr_type = bdaddr_type;
> +       param.max_interval = max_interval;
> +       param.min_interval = min_interval;
> +       param.latency = latency;
> +       param.timeout = timeout;
> +
> +       params = g_slist_append(params, &param);
> +       load_conn_params(adapter, params);

Actually calling load_conn_params with just 1 setting does not work,
the kernel does call hci_conn_params_clear_disabled before parsing the
list of the connections which means it may endup cleaning up all the
settings previously loaded. So we have to decide if the kernel should
continue doing this thus the userspace has to reload everything or we
change the handling in the kernel to update the existing settings
which perhaps it is just a matter of removing
hci_conn_params_clear_disabled call from load_conn_param since the
following code code seems to be handling the updates:

hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
addr_type);
if (!hci_param) {
BT_ERR("Failed to add connection parameters");
continue;
}

hci_param->conn_min_interval = min;
hci_param->conn_max_interval = max;
hci_param->conn_latency = latency;
hci_param->supervision_timeout = timeout;


> +       g_slist_free(params);
> +}
> +
>  static uint8_t get_le_addr_type(GKeyFile *keyfile)
>  {
>         uint8_t addr_type;
> @@ -7251,7 +7271,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
>         btd_device_set_temporary(device, false);
>  }
>
> -static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
> +void adapter_store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
>                                 uint8_t bdaddr_type, uint16_t min_interval,
>                                 uint16_t max_interval, uint16_t latency,
>                                 uint16_t timeout)
> @@ -7325,7 +7345,7 @@ static void new_conn_param(uint16_t index, uint16_t length,
>         if (!ev->store_hint)
>                 return;
>
> -       store_conn_param(adapter, &ev->addr.bdaddr, ev->addr.type,
> +       adapter_store_conn_param(adapter, &ev->addr.bdaddr, ev->addr.type,
>                                         ev->min_interval, ev->max_interval,
>                                         ev->latency, ev->timeout);
>  }
> diff --git a/src/adapter.h b/src/adapter.h
> index f9178d59e74a..ca2f6678cfca 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -227,3 +227,12 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
>
>  bool btd_le_connect_before_pairing(void);
>
> +void adapter_load_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
> +                               uint8_t bdaddr_type, uint16_t min_interval,
> +                               uint16_t max_interval, uint16_t latency,
> +                               uint16_t timeout);
> +
> +void adapter_store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
> +                       uint8_t bdaddr_type, uint16_t min_interval,
> +                       uint16_t max_interval, uint16_t latency,
> +                       uint16_t timeout);
> --
> 2.11.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
