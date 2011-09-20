Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316454126-32614-2-git-send-email-ospite@studenti.unina.it>
References: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
	<1316454126-32614-2-git-send-email-ospite@studenti.unina.it>
Date: Tue, 20 Sep 2011 14:30:42 +0300
Message-ID: <CABBYNZL4wmb=ZvwDZasoZVx939-HZkv=u8xzZZR_jdqnF_+aLw@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 1/3] Add a btd_manager_get_default_adapter_str() call
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Mon, Sep 19, 2011 at 8:42 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> Add a new btd_* call to get the default adapter address as a string,
> this is going to be used by the external playstation-peripheral plugin.
> ---
>  src/manager.h |    1 +
>  src/manager.c |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/src/manager.h b/src/manager.h
> index 4f92d2f..91d9894 100644
> --- a/src/manager.h
> +++ b/src/manager.h
> @@ -36,6 +36,7 @@ const char *manager_get_base_path(void);
>  struct btd_adapter *manager_find_adapter(const bdaddr_t *sba);
>  struct btd_adapter *manager_find_adapter_by_id(int id);
>  struct btd_adapter *manager_get_default_adapter(void);
> +char *btd_manager_get_default_adapter_str(void);
>  void manager_foreach_adapter(adapter_cb func, gpointer user_data);
>  GSList *manager_get_adapters(void);
>  struct btd_adapter *btd_manager_register_adapter(int id);
> diff --git a/src/manager.c b/src/manager.c
> index 464b0ca..8947f85 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -270,6 +270,22 @@ struct btd_adapter *manager_get_default_adapter(void)
>        return manager_find_adapter_by_id(default_adapter_id);
>  }
>
> +char *btd_manager_get_default_adapter_str(void)
> +{
> +       struct btd_adapter *adapter;
> +       bdaddr_t adapter_bdaddr;
> +       char *str = bt_malloc(18);
> +
> +       adapter = manager_get_default_adapter();
> +       if (adapter == NULL) {
> +               return NULL;
> +       }
> +
> +       adapter_get_address(adapter, &adapter_bdaddr);
> +       ba2str(&adapter_bdaddr, str);
> +       return str;
> +}
> +

It doesn't seems that gonna be very useful for the core daemon,
besides you can always get the bdaddr and convert yourself, if the
purpose is just to be a helper function then perhaps we should find
another place. Btw are you sure you need the adapter address and not
the remote device address?

-- 
Luiz Augusto von Dentz
