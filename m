Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180207135616.6090-1-luiz.dentz@gmail.com>
References: <20180207135616.6090-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Feb 2018 06:59:07 -0200
Message-ID: <CABBYNZKc=AVyfLQto7j5bxBETaO_+Cn+Assr=McU7h6WAqzcQg@mail.gmail.com>
Subject: Re: [PATCH v2] core: Fixes order InterfaceAdded
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Feb 7, 2018 at 11:56 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Registering on the callback of MGMT_OP_READ_ADV_FEATURES causes
> InterfacesAdded to be reschedule after the device objects which causes
> tools such as PulseAudio to consider it invalid.
>
> Fixes https://bugzilla.redhat.com/show_bug.cgi?id=1534857
> ---
>  src/advertising.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 94a8c4050..970c3d87b 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1032,14 +1032,6 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
>         if (manager->max_ads == 0)
>                 return;
>
> -       if (!g_dbus_register_interface(btd_get_dbus_connection(),
> -                                       adapter_get_path(manager->adapter),
> -                                       LE_ADVERTISING_MGR_IFACE, methods,
> -                                       NULL, properties, manager, NULL)) {
> -               error("Failed to register " LE_ADVERTISING_MGR_IFACE);
> -               return;
> -       }
> -
>         /* Reset existing instances */
>         if (feat->num_instances)
>                 remove_advertising(manager, 0);
> @@ -1061,19 +1053,29 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter)
>         }
>
>         manager->mgmt_index = btd_adapter_get_index(adapter);
> +       manager->clients = queue_new();
> +       manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
> +
> +       if (!g_dbus_register_interface(btd_get_dbus_connection(),
> +                                       adapter_get_path(manager->adapter),
> +                                       LE_ADVERTISING_MGR_IFACE, methods,
> +                                       NULL, properties, manager, NULL)) {
> +               error("Failed to register " LE_ADVERTISING_MGR_IFACE);
> +               goto fail;
> +       }
>
>         if (!mgmt_send(manager->mgmt, MGMT_OP_READ_ADV_FEATURES,
>                                 manager->mgmt_index, 0, NULL,
>                                 read_adv_features_callback, manager, NULL)) {
>                 error("Failed to read advertising features");
> -               manager_destroy(manager);
> -               return NULL;
> +               goto fail;
>         }
>
> -       manager->clients = queue_new();
> -       manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
> -
>         return manager;
> +
> +fail:
> +       manager_destroy(manager);
> +       return NULL;
>  }
>
>  struct btd_adv_manager *btd_adv_manager_new(struct btd_adapter *adapter)
> --
> 2.14.3

Applied.


-- 
Luiz Augusto von Dentz
