Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [BlueZ PATCH 1/3] android: Do not fail if empty keyset cannot be loaded
Date: Wed, 11 Oct 2017 09:32:43 +0200
Message-ID: <3195897.6uX0vmqWOl@ix>
In-Reply-To: <20171010092751.30705.10296.stgit@localhost>
References: <20171010092748.30705.23283.stgit@localhost> <20171010092751.30705.10296.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Tuesday, 10 October 2017 11:27:51 CEST Martin Fuzzey wrote:
> On startup the keys are loaded, even if the keyset is empty.
> As mentionned in a  comment says this is to erase any keys in the kernel.
> 
> However BLE only devices do not support loading keys (the operation always
> returns unsupported error code).
> 
> So, if we get an unsupported operation error, and if the keyset is empty,
> ignore and continue.
> 

Yes, when BlueZ for Android was developed there were not so many single mode 
devices around that could be used:)

Would it make sense to check if BR/EDR supported and only try to load it in 
that case?

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

We don't use s-o-b for userspace patches.

> ---
>  android/bluetooth.c |   23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 51a31fe..8ea521e 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -2531,13 +2531,18 @@ static void register_mgmt_handlers(void)
>  								NULL, NULL);
>  }
> 
> +struct load_link_keys_userdata {
> +	bt_bluetooth_ready cb;
> +	size_t key_count;
> +};
> +
>  static void load_link_keys_complete(uint8_t status, uint16_t length,
>  					const void *param, void *user_data)
>  {
> -	bt_bluetooth_ready cb = user_data;
> +	struct load_link_keys_userdata *ud = user_data;
>  	int err;
> 
> -	if (status) {
> +	if (status && !((status == MGMT_STATUS_NOT_SUPPORTED &&  ud->key_count ==
> 0))) { error("Failed to load link keys for index %u: %s (0x%02x)",
>  				adapter.index, mgmt_errstr(status), status);
>  		err = -EIO;
> @@ -2546,17 +2551,20 @@ static void load_link_keys_complete(uint8_t status,
> uint16_t length,
> 
>  	DBG("status %u", status);
> 
> -	cb(0, &adapter.bdaddr);
> +	ud->cb(0, &adapter.bdaddr);
> +	g_free(ud);
>  	return;
> 
>  failed:
> -	cb(err, NULL);
> +	ud->cb(err, NULL);
> +	g_free(ud);
>  }
> 
>  static void load_link_keys(GSList *keys, bt_bluetooth_ready cb)
>  {
>  	struct mgmt_cp_load_link_keys *cp;
>  	struct mgmt_link_key_info *key;
> +	struct load_link_keys_userdata *req_ud;
>  	size_t key_count, cp_size;
>  	unsigned int id;
> 
> @@ -2578,13 +2586,18 @@ static void load_link_keys(GSList *keys,
> bt_bluetooth_ready cb) for (key = cp->keys; keys != NULL; keys =
> g_slist_next(keys), key++) memcpy(key, keys->data, sizeof(*key));
> 
> +	req_ud = g_malloc0(sizeof(*req_ud));
> +	req_ud->cb = cb;
> +	req_ud->key_count = key_count;
> +
>  	id = mgmt_send(mgmt_if, MGMT_OP_LOAD_LINK_KEYS, adapter.index,
> -			cp_size, cp, load_link_keys_complete, cb, NULL);
> +			cp_size, cp, load_link_keys_complete, req_ud, NULL);
> 
>  	g_free(cp);
> 
>  	if (id == 0) {
>  		error("Failed to load link keys");
> +		g_free(req_ud);
>  		cb(-EIO, NULL);
>  	}
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
pozdrawiam
Szymon Janc
