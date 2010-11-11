Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1289501521-21825-3-git-send-email-vinicius.gomes@openbossa.org>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
	<1289501521-21825-3-git-send-email-vinicius.gomes@openbossa.org>
Date: Thu, 11 Nov 2010 22:49:35 +0200
Message-ID: <AANLkTimvBy+8ECNEHfwrcCVmtVUxBXU2BV_AXMJGt11n@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] Refactoring adapter_update_found_devices() function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 11, 2010 at 8:51 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> From: Bruna Moreira <bruna.moreira@openbossa.org>
>
> The common code from adapter_update_found_devices() was moved to
> update_found_devices().
> ---
>  src/adapter.c |   50 +++++++++++++++++++++++++++++++-------------------
>  1 files changed, 31 insertions(+), 19 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 363ee94..6f4f2a3 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3108,10 +3108,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
>        g_strfreev(uuids);
>  }
>
> -void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> -                               int8_t rssi, uint32_t class, const char *name,
> -                               const char *alias, gboolean legacy,
> -                               name_status_t name_status, uint8_t *eir_data)
> +static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
> +                               const bdaddr_t *bdaddr, gboolean *new_dev)
>  {
>        struct remote_dev_info *dev, match;
>
> @@ -3121,30 +3119,44 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>
>        dev = adapter_search_found_devices(adapter, &match);
>        if (dev) {
> +               *new_dev = FALSE;
>                /* Out of range list update */
>                adapter->oor_devices = g_slist_remove(adapter->oor_devices,
>                                                        dev);
> +       } else {
> +               *new_dev = TRUE;
> +               dev = g_new0(struct remote_dev_info, 1);
> +               bacpy(&dev->bdaddr, bdaddr);
> +               adapter->found_devices = g_slist_prepend(adapter->found_devices,
> +                                                                       dev);
> +       }
>
> -               if (rssi == dev->rssi)
> -                       return;
> +       return dev;
> +}
>
> -               goto done;
> -       }
> +void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> +                               int8_t rssi, uint32_t class, const char *name,
> +                               const char *alias, gboolean legacy,
> +                               name_status_t name_status, uint8_t *eir_data)
> +{
> +       struct remote_dev_info *dev;
> +       gboolean new_dev;
>
> -       dev = g_new0(struct remote_dev_info, 1);
> +       dev = get_found_dev(adapter, bdaddr, &new_dev);
>
> -       bacpy(&dev->bdaddr, bdaddr);
> -       dev->class = class;
> -       if (name)
> -               dev->name = g_strdup(name);
> -       if (alias)
> -               dev->alias = g_strdup(alias);
> -       dev->legacy = legacy;
> -       dev->name_status = name_status;
> +       if (new_dev) {
> +               if (name)
> +                       dev->name = g_strdup(name);
>
> -       adapter->found_devices = g_slist_prepend(adapter->found_devices, dev);
> +               if (alias)
> +                       dev->alias = g_strdup(alias);
> +
> +               dev->class = class;
> +               dev->legacy = legacy;
> +               dev->name_status = name_status;
> +       } else if (dev->rssi == rssi)
> +               return;
>
> -done:
>        dev->rssi = rssi;
>
>        adapter->found_devices = g_slist_sort(adapter->found_devices,
> --
> 1.7.3.2

Im not so sure this is doing any good to the code, apparently this add
more code without a clear reason. IMO the only thing that could be
really be beneficial is to have some helper functions such as
dev_info_new/dev_info_free, splitting the memory allocation and the
members initialization doesn't sound a good idea too.

-- 
Luiz Augusto von Dentz
Computer Engineer
