Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2 v3] adapter: Add btd_request_authorization_cable_configured()
Date: Fri, 24 Jul 2015 00:32:57 +0200
Message-ID: <1530933.8bMTNVp5s8@athlon>
In-Reply-To: <1436278440.26954.30.camel@hadess.net>
References: <1436278440.26954.30.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tuesday 07 July 2015 16:14:00 Bastien Nocera wrote:
> Add btd_request_authorization_cable_configured() function to allow
> cable configured devices to ask the user straight away about whether the
> device should be allowed to connect to the computer.
> 
> This allows us to ask the user at the time of the USB connection and
> initial setup, rather than when the first Bluetooth connection is made.

I'd also add a note to doc/agent-api.txt that this can be called also for not 
connected devices under some circumstances (and see how it fits).

What bothers me is that now bluetoothd will send AuthorizeService request for 
device that is not connected (and authorizing will not result in connection). 
And this was explicitly checked against before this patch.

> ---
>  src/adapter.c | 42 ++++++++++++++++++++++++++++++++++++------
>  src/adapter.h |  2 ++
>  2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 95b5349..cf09d4b 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -262,6 +262,11 @@ struct btd_adapter {
>  	bool is_default;		/* true if adapter is default one */
>  };
> 
> +typedef enum {
> +	ADAPTER_AUTHORIZE_DISCONNECTED = 0,
> +	ADAPTER_AUTHORIZE_CHECK_CONNECTED
> +} adapter_authorize_type;
> +
>  static struct btd_adapter *btd_adapter_lookup(uint16_t index)
>  {
>  	GList *list;
> @@ -5814,8 +5819,9 @@ static void svc_complete(struct btd_device *dev, int
> err, void *user_data) }
> 
>  static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t
> *dst, -					const char *uuid, service_auth_cb cb,
> -					void *user_data)
> +					const char *uuid,
> +					adapter_authorize_type check_for_connection,
> +					service_auth_cb cb, void *user_data)
>  {
>  	struct service_auth *auth;
>  	struct btd_device *device;
> @@ -5826,7 +5832,7 @@ static int adapter_authorize(struct btd_adapter
> *adapter, const bdaddr_t *dst, return 0;
> 
>  	/* Device connected? */
> -	if (!g_slist_find(adapter->connections, device))
> +	if (check_for_connection && !g_slist_find(adapter->connections, device))
>  		error("Authorization request for non-connected device!?");

Since check_for_connection is enum this should be compared to one of its 
values.

> 
>  	auth = g_try_new0(struct service_auth, 1);
> @@ -5839,7 +5845,12 @@ static int adapter_authorize(struct btd_adapter
> *adapter, const bdaddr_t *dst, auth->device = device;
>  	auth->adapter = adapter;
>  	auth->id = ++id;
> -	auth->svc_id = device_wait_for_svc_complete(device, svc_complete, auth);
> +	if (check_for_connection)
> +		auth->svc_id = device_wait_for_svc_complete(device, svc_complete, 
auth);
> +	else {
> +		if (adapter->auth_idle_id == 0)
> +			adapter->auth_idle_id = g_idle_add(process_auth_queue, adapter);
> +	}
> 
>  	g_queue_push_tail(adapter->auths, auth);
> 
> @@ -5858,7 +5869,8 @@ guint btd_request_authorization(const bdaddr_t *src,
> const bdaddr_t *dst, if (!adapter)
>  			return 0;
> 
> -		return adapter_authorize(adapter, dst, uuid, cb, user_data);
> +		return adapter_authorize(adapter, dst, uuid,
> +				ADAPTER_AUTHORIZE_CHECK_CONNECTED, cb, user_data);
>  	}
> 
>  	for (l = adapters; l != NULL; l = g_slist_next(l)) {
> @@ -5866,7 +5878,8 @@ guint btd_request_authorization(const bdaddr_t *src,
> const bdaddr_t *dst,
> 
>  		adapter = l->data;
> 
> -		id = adapter_authorize(adapter, dst, uuid, cb, user_data);
> +		id = adapter_authorize(adapter, dst, uuid,
> +				ADAPTER_AUTHORIZE_CHECK_CONNECTED, cb, user_data);
>  		if (id != 0)
>  			return id;
>  	}
> @@ -5874,6 +5887,23 @@ guint btd_request_authorization(const bdaddr_t *src,
> const bdaddr_t *dst, return 0;
>  }
> 
> +guint btd_request_authorization_cable_configured(const bdaddr_t *src, const
> bdaddr_t *dst, +						const char *uuid, service_auth_cb cb,
> +						void *user_data)
> +{
> +	struct btd_adapter *adapter;
> +
> +	if (bacmp(src, BDADDR_ANY) == 0)
> +		return 0;
> +
> +	adapter = adapter_find(src);
> +	if (!adapter)
> +		return 0;
> +
> +	return adapter_authorize(adapter, dst, uuid,
> +			ADAPTER_AUTHORIZE_DISCONNECTED, cb, user_data);
> +}
> +
>  static struct service_auth *find_authorization(guint id)
>  {
>  	GSList *l;
> diff --git a/src/adapter.h b/src/adapter.h
> index 0c95f5d..b9da6cf 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -119,6 +119,8 @@ int btd_register_adapter_driver(struct
> btd_adapter_driver *driver); void btd_unregister_adapter_driver(struct
> btd_adapter_driver *driver); guint btd_request_authorization(const bdaddr_t
> *src, const bdaddr_t *dst, const char *uuid, service_auth_cb cb, void
> *user_data);
> +guint btd_request_authorization_cable_configured(const bdaddr_t *src, const
> bdaddr_t *dst, +		const char *uuid, service_auth_cb cb, void 
*user_data);
>  int btd_cancel_authorization(guint id);
> 
>  int btd_adapter_restore_powered(struct btd_adapter *adapter);

Also in general I'd prefer to use sixaxis instead of cable in names. Mainly 
for consistency with other core sixaxis specific code.

-- 
Szymon K. Janc
szymon.janc@gmail.com
