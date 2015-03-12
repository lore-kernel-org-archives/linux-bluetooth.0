Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/7] profiles/network: Remove unneded bnep_uuid function from bnep code
Date: Thu, 12 Mar 2015 17:38:14 +0100
Message-ID: <2172584.X11lDVV6Va@leonov>
In-Reply-To: <1426176402-21179-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1426176402-21179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1426176402-21179-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 12 of March 2015 17:06:37 Grzegorz Kolodziejczyk wrote:
> This function is no longer needed since connection and server can handle
> this funcionality by itself.
> ---
>  profiles/network/bnep.c       | 10 ----------
>  profiles/network/bnep.h       |  1 -
>  profiles/network/connection.c | 19 ++++++++++++-------
>  profiles/network/server.c     | 36 ++++++++++++++++++++++++++++++------
>  4 files changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 48926b4..966fb8f 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -85,16 +85,6 @@ struct bnep {
>  	void	*disconn_data;
>  };
> 
> -const char *bnep_uuid(uint16_t id)
> -{
> -	int i;
> -
> -	for (i = 0; __svc[i].uuid128; i++)
> -		if (__svc[i].id == id)
> -			return __svc[i].uuid128;
> -	return NULL;
> -}
> -
>  const char *bnep_name(uint16_t id)
>  {
>  	int i;
> diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
> index 31579f9..811ea14 100644
> --- a/profiles/network/bnep.h
> +++ b/profiles/network/bnep.h
> @@ -26,7 +26,6 @@ struct bnep;
>  int bnep_init(void);
>  int bnep_cleanup(void);
> 
> -const char *bnep_uuid(uint16_t id);
>  const char *bnep_name(uint16_t id);
> 
>  struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
> diff --git a/profiles/network/connection.c b/profiles/network/connection.c
> index 4311cc9..da8b86e 100644
> --- a/profiles/network/connection.c
> +++ b/profiles/network/connection.c
> @@ -284,21 +284,23 @@ static DBusMessage *local_connect(DBusConnection
> *conn, struct btd_service *service;
>  	struct network_conn *nc;
>  	const char *svc;
> -	const char *uuid;
>  	uint16_t id;
>  	int err;
> +	char uuid_str[MAX_LEN_UUID_STR];
> +	bt_uuid_t uuid;
> 
>  	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &svc,
>  						DBUS_TYPE_INVALID) == FALSE)
>  		return btd_error_invalid_args(msg);
> 
>  	id = get_pan_srv_id(svc);
> -	uuid = bnep_uuid(id);
> +	bt_uuid16_create(&uuid, id);
> +	bt_uuid_to_uuid128(&uuid, &uuid);

I've missed that in previous review iterations but I think that 
bt_uuid_to_uuid128 doesn't work in place.

> 
> -	if (uuid == NULL)
> +	if (bt_uuid_to_string(&uuid, uuid_str, MAX_LEN_UUID_STR) < 0)
>  		return btd_error_invalid_args(msg);
> 
> -	service = btd_device_get_service(peer->device, uuid);
> +	service = btd_device_get_service(peer->device, uuid_str);
>  	if (service == NULL)
>  		return btd_error_not_supported(msg);
> 
> @@ -439,15 +441,18 @@ static gboolean network_property_get_uuid(const
> GDBusPropertyTable *property, {
>  	struct network_peer *peer = data;
>  	struct network_conn *nc;
> -	const char *uuid;
> +	char uuid_str[MAX_LEN_UUID_STR];
> +	bt_uuid_t uuid;
> 
>  	nc = find_connection_by_state(peer->connections, CONNECTED);
>  	if (nc == NULL)
>  		return FALSE;
> 
> -	uuid = bnep_uuid(nc->id);
> +	bt_uuid16_create(&uuid, nc->id);
> +	bt_uuid_to_uuid128(&uuid, &uuid);
> +	bt_uuid_to_string(&uuid, uuid_str, MAX_LEN_UUID_STR);
> 
> -	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid_str);
> 
>  	return TRUE;
>  }
> diff --git a/profiles/network/server.c b/profiles/network/server.c
> index 9caabb0..32aafc3 100644
> --- a/profiles/network/server.c
> +++ b/profiles/network/server.c
> @@ -114,14 +114,38 @@ static struct network_server *find_server(GSList
> *list, uint16_t id) static struct network_server
> *find_server_by_uuid(GSList *list,
>  							const char *uuid)
>  {
> -	for (; list; list = list->next) {
> -		struct network_server *ns = list->data;
> +	bt_uuid_t srv_uuid, bnep_uuid;
> 
> -		if (strcasecmp(uuid, bnep_uuid(ns->id)) == 0)
> -			return ns;
> +	if (!bt_string_to_uuid(&srv_uuid, uuid)) {
> +		for (; list; list = list->next) {
> +			struct network_server *ns = list->data;
> 
> -		if (strcasecmp(uuid, bnep_name(ns->id)) == 0)
> -			return ns;
> +			bt_uuid16_create(&bnep_uuid, ns->id);
> +
> +			/* UUID value compare */
> +			if (!bt_uuid_cmp(&srv_uuid, &bnep_uuid))
> +				return ns;
> +		}
> +	} else {
> +		for (; list; list = list->next) {
> +			struct network_server *ns = list->data;
> +
> +			/* String value compare */
> +			switch (ns->id) {
> +			case BNEP_SVC_PANU:
> +				if (!strcasecmp(uuid, "panu"))
> +					return ns;
> +				break;
> +			case BNEP_SVC_NAP:
> +				if (!strcasecmp(uuid, "nap"))
> +					return ns;
> +				break;
> +			case BNEP_SVC_GN:
> +				if (!strcasecmp(uuid, "gn"))
> +					return ns;
> +				break;
> +			}
> +		}
>  	}
> 
>  	return NULL;

-- 
BR
Szymon Janc
