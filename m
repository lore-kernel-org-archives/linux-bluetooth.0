Return-Path: <cyrus@holtmann.org>
Message-ID: <1334746924.8818.115.camel@novo.hadess.net>
Subject: Re: [PATCH BlueZ v2 1/3] manager: add a
 btd_manager_get_default_adapter_address_str() call
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Date: Wed, 18 Apr 2012 12:02:04 +0100
In-Reply-To: <1334741891-11869-2-git-send-email-ospite@studenti.unina.it>
References: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
	 <1334741891-11869-2-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2012-04-18 at 11:38 +0200, Antonio Ospite wrote:
> Add a new btd_* call to get the default adapter address as a string,
> meant to be used by _external_ plugins, this is to avoid to make public
> these symbols:
> 
>   manager_get_default_adapter
>   adapter_get_address
>   bt_malloc

It's already public.

>   ba2str

Already public.

> ---
> 
> Alternatively a version without the _str prefix can be used which
> returns a bdaddr_t, but I have to make ba2str a global symbol so I can
> make the conversion to string in the plugin itself.
> 
> Let me know how do you like that.

ba2str() is in libbluetooth.
$ grep ba2str /usr/include/bluetooth/bluetooth.h 
int ba2str(const bdaddr_t *ba, char *str);

So it's already public.

> 
>  src/manager.c |   21 +++++++++++++++++++++
>  src/manager.h |    1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/src/manager.c b/src/manager.c
> index 6244516..fbd5ef8 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -270,6 +270,27 @@ struct btd_adapter *manager_get_default_adapter(void)
>  	return manager_find_adapter_by_id(default_adapter_id);
>  }
>  
> +char *btd_manager_get_default_adapter_address_str(void)
> +{
> +	struct btd_adapter *adapter;
> +	bdaddr_t adapter_bdaddr;
> +	char *str;
> +
> +	adapter = manager_get_default_adapter();
> +	if (adapter == NULL) {
> +		return NULL;
> +	}
> +
> +	adapter_get_address(adapter, &adapter_bdaddr);
> +
> +	str = bt_malloc(18);

You could have used batostr() instead, so you wouldn't have needed to do
the allocation yourself. Use bt_free() to free.

> +	if (str == NULL)
> +		return NULL;
> +
> +	ba2str(&adapter_bdaddr, str);
> +	return str;
> +}
> +
>  static void manager_remove_adapter(struct btd_adapter *adapter)
>  {
>  	uint16_t dev_id = adapter_get_dev_id(adapter);
> diff --git a/src/manager.h b/src/manager.h
> index 264cd25..7df882e 100644
> --- a/src/manager.h
> +++ b/src/manager.h
> @@ -36,6 +36,7 @@ const char *manager_get_base_path(void);
>  struct btd_adapter *manager_find_adapter(const bdaddr_t *sba);
>  struct btd_adapter *manager_find_adapter_by_id(int id);
>  struct btd_adapter *manager_get_default_adapter(void);
> +char *btd_manager_get_default_adapter_address_str(void);
>  void manager_foreach_adapter(adapter_cb func, gpointer user_data);
>  GSList *manager_get_adapters(void);
>  struct btd_adapter *btd_manager_register_adapter(int id, gboolean up);


