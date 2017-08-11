Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Aug 2017 14:06:36 +0300
Message-ID: <CABBYNZKEr+jYOXgS5wA5SAkq74E-aa+XwL1ztAefRCHOT-Xs0Q@mail.gmail.com>
Subject: Re: [PATCH v8 01/14] advertising: Ensure all instances are reset
 during init
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 10, 2017 at 4:32 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If for some reason bluetoothd crashes or is killed it may leave
> instances behind.
> ---
>  src/advertising.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index c2af3acb4..64d5a27bb 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -144,6 +144,22 @@ static void client_destroy(void *data)
>         client_free(data);
>  }
>
> +static void remove_advertising(struct btd_adv_manager *manager,
> +                                               uint8_t instance)
> +{
> +       struct mgmt_cp_remove_advertising cp;
> +
> +       if (instance)
> +               DBG("instance %u", instance);
> +       else
> +               DBG("all instances");
> +
> +       cp.instance = instance;
> +
> +       mgmt_send(manager->mgmt, MGMT_OP_REMOVE_ADVERTISING,
> +                       manager->mgmt_index, sizeof(cp), &cp, NULL, NULL, NULL);
> +}
> +
>  static void client_remove(void *data)
>  {
>         struct btd_adv_client *client = data;
> @@ -791,8 +807,14 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         adapter_get_path(manager->adapter),
>                                         LE_ADVERTISING_MGR_IFACE, methods,
> -                                       NULL, properties, manager, NULL))
> +                                       NULL, properties, manager, NULL)) {
>                 error("Failed to register " LE_ADVERTISING_MGR_IFACE);
> +               return;
> +       }
> +
> +       /* Reset existing instances */
> +       if (feat->num_instances)
> +               remove_advertising(manager, 0);
>  }
>
>  static struct btd_adv_manager *manager_create(struct btd_adapter *adapter)
> --
> 2.13.4

Applied.


-- 
Luiz Augusto von Dentz
