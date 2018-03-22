Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] gatt: Add confirmation callback
Date: Thu, 22 Mar 2018 15:55:50 +0100
Message-ID: <1572389.x88qM0ZYMA@ix>
In-Reply-To: <20180319124427.26418-1-luiz.dentz@gmail.com>
References: <20180319124427.26418-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Monday, 19 March 2018 13:44:26 CET Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This replaces indicate flag with confirmation callback to enable
> setting custom callback if necessary.
> ---
>  src/gatt-database.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 9a33ae7f9..82f376568 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -956,8 +956,8 @@ struct notify {
>  	uint16_t handle, ccc_handle;
>  	const uint8_t *value;
>  	uint16_t len;
> -	bool indicate;
> -	GDBusProxy *proxy;
> +	bt_gatt_server_conf_func_t conf;
> +	void *user_data;
>  };
> 
>  static void conf_cb(void *user_data)
> @@ -983,7 +983,7 @@ static void send_notification_to_device(void *data, void
> *user_data) if (!ccc)
>  		return;
> 
> -	if (!ccc->value[0] || (notify->indicate && !(ccc->value[0] & 0x02)))
> +	if (!ccc->value[0] || (notify->conf && !(ccc->value[0] & 0x02)))
>  		return;
> 
>  	device = btd_adapter_get_device(notify->database->adapter,
> @@ -1003,7 +1003,7 @@ static void send_notification_to_device(void *data,
> void *user_data) * TODO: If the device is not connected but bonded, send
> the
>  	 * notification/indication when it becomes connected.
>  	 */
> -	if (!notify->indicate) {
> +	if (!notify->conf) {
>  		DBG("GATT server sending notification");
>  		bt_gatt_server_send_notification(server,
>  					notify->handle, notify->value,
> @@ -1013,8 +1013,8 @@ static void send_notification_to_device(void *data,
> void *user_data)
> 
>  	DBG("GATT server sending indication");
>  	bt_gatt_server_send_indication(server, notify->handle, notify->value,
> -							notify->len, conf_cb,
> -							notify->proxy, NULL);
> +						notify->len, notify->conf,
> +						notify->user_data, NULL);
> 
>  	return;
> 
> @@ -1027,10 +1027,16 @@ remove:
>  	}
>  }
> 
> +static void service_changed_conf(void *user_data)
> +{
> +	DBG("");
> +}
> +
>  static void send_notification_to_devices(struct btd_gatt_database
> *database, uint16_t handle, const uint8_t *value,
>  					uint16_t len, uint16_t ccc_handle,
> -					bool indicate, GDBusProxy *proxy)
> +					bt_gatt_server_conf_func_t conf,
> +					void *user_data)
>  {
>  	struct notify notify;
> 
> @@ -1041,8 +1047,8 @@ static void send_notification_to_devices(struct
> btd_gatt_database *database, notify.ccc_handle = ccc_handle;
>  	notify.value = value;
>  	notify.len = len;
> -	notify.indicate = indicate;
> -	notify.proxy = proxy;
> +	notify.conf = conf;
> +	notify.user_data = user_data;
> 
>  	queue_foreach(database->device_states, send_notification_to_device,
>  								&notify);
> @@ -1073,7 +1079,7 @@ static void send_service_changed(struct
> btd_gatt_database *database, put_le16(end, value + 2);
> 
>  	send_notification_to_devices(database, handle, value, sizeof(value),
> -							ccc_handle, true, NULL);
> +					ccc_handle, service_changed_conf, NULL);
>  }
> 
>  static void gatt_db_service_added(struct gatt_db_attribute *attrib,
> @@ -1948,8 +1954,8 @@ static bool pipe_io_read(struct io *io, void
> *user_data) gatt_db_attribute_get_handle(chrc->attrib),
>  				buf, bytes_read,
>  				gatt_db_attribute_get_handle(chrc->ccc),
> -				chrc->props & BT_GATT_CHRC_PROP_INDICATE,
> -				chrc->proxy);
> +				chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
> +				conf_cb : NULL, chrc->proxy);
> 
>  	return true;
>  }
> @@ -2225,7 +2231,8 @@ static void property_changed_cb(GDBusProxy *proxy,
> const char *name, gatt_db_attribute_get_handle(chrc->attrib),
>  				value, len,
>  				gatt_db_attribute_get_handle(chrc->ccc),
> -				chrc->props & BT_GATT_CHRC_PROP_INDICATE, proxy);
> +				chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
> +				conf_cb : NULL, proxy);
>  }
> 
>  static bool database_add_ccc(struct external_service *service,

Both patches applied, thanks.

-- 
pozdrawiam
Szymon Janc


