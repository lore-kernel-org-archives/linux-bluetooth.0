Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com
References: <1446628721-4590-1-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1446628721-4590-1-git-send-email-bharat.panda@samsung.com>
Subject: RE: [PATCH v2] audio/avrcp: Get player playlist details
Date: Fri, 27 Nov 2015 16:50:55 +0530
Message-id: <001b01d12905$bf7387d0$3e5a9770$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Bharat Panda
> Sent: Wednesday, November 04, 2015 2:49 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: cpgs@samsung.com; Bharat Panda
> Subject: [PATCH v2] audio/avrcp: Get player playlist details
> 
> Support added to read and cache player playlist details after player
> registration completes.
> ---
>  profiles/audio/media.c | 171
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/media.h |   2 +
>  2 files changed, 173 insertions(+)
> 
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
> 69070bf..d74fc93 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -58,6 +58,7 @@
>  #define MEDIA_INTERFACE "org.bluez.Media1"
>  #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
>  #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
> +#define MEDIA_PLAYER_PLAYLIST_INTERFACE
> "org.mpris.MediaPlayer2.Playlists"
> 
>  #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
> 
> @@ -92,9 +93,19 @@ struct media_endpoint {
>  	GSList			*transports;
>  };
> 
> +struct player_request {
> +	struct media_player	*mp;
> +	DBusMessage		*msg;
> +	DBusPendingCall		*call;
> +	GDestroyNotify		destroy;
> +	void			*user_data;
> +};
> +
>  struct media_player {
>  	struct media_adapter	*adapter;
>  	struct avrcp_player	*player;
> +	GSList			*playlists;
> +	GSList			*requests;
>  	char			*sender;	/* Player DBus bus id */
>  	char			*path;		/* Player object path */
>  	GHashTable		*settings;	/* Player settings */
> @@ -105,6 +116,7 @@ struct media_player {
>  	char			*status;
>  	uint32_t		position;
>  	uint32_t		duration;
> +	uint32_t		total_items;
>  	uint8_t			volume;
>  	GTimer			*timer;
>  	bool			play;
> @@ -115,6 +127,12 @@ struct media_player {
>  	char			*name;
>  };
> 
> +struct media_playlist {
> +	char		*name;
> +	char		*id;
> +	char		*icon;
> +};
> +
>  static GSList *adapters = NULL;
> 
>  static void endpoint_request_free(struct endpoint_request *request) @@ -
> 940,6 +958,18 @@ static void release_player(struct media_player *mp)
>  	g_dbus_send_message(btd_get_dbus_connection(), msg);  }
> 
> +static void playlist_request_free(struct player_request *request) {
> +	if (request->call)
> +		dbus_pending_call_unref(request->call);
> +
> +	if (request->destroy)
> +		request->destroy(request->user_data);
> +
> +	dbus_message_unref(request->msg);
> +	g_free(request);
> +}
> +
>  static void media_player_free(gpointer data)  {
>  	DBusConnection *conn = btd_get_dbus_connection(); @@ -966,6
> +996,8 @@ static void media_player_free(gpointer data)
>  	g_free(mp->path);
>  	g_free(mp->status);
>  	g_free(mp->name);
> +	g_free(mp->playlists);
> +	g_free(mp->requests);
>  	g_free(mp);
>  }
> 
> @@ -1271,6 +1303,141 @@ static bool previous(void *user_data)
>  	return media_player_send(mp, "Previous");  }
> 
> +static void playlist_reply(DBusPendingCall *call, void *user_data) {
> +	struct player_request *request = user_data;
> +	struct media_player *mp = request->mp;
> +	DBusMessage *reply;
> +	DBusMessageIter array_iter, entry, struct_iter;
> +	DBusError derr;
> +	int ctype;
> +
> +	reply = dbus_pending_call_steal_reply(call);
> +
> +	dbus_error_init(&derr);
> +
> +	if (dbus_set_error_from_message(&derr, reply)) {
> +		error("Error: GetPlayLists method %s, %s", derr.name,
> +					derr.message);
> +		dbus_error_free(&derr);
> +		goto done;
> +	}
> +
> +	dbus_message_iter_init(reply, &array_iter);
> +	ctype = dbus_message_iter_get_arg_type(&array_iter);
> +
> +	if (ctype != DBUS_TYPE_ARRAY)
> +		goto done;
> +
> +	dbus_message_iter_recurse(&array_iter, &struct_iter);
> +
> +	while ((ctype = dbus_message_iter_get_arg_type(&struct_iter)) !=
> +				DBUS_TYPE_INVALID) {
> +		struct media_playlist *playlist;
> +
> +		if (ctype != DBUS_TYPE_STRUCT) {
> +			error("Invalid type");
> +			goto done;
> +		}
> +
> +		playlist = g_new0(struct media_playlist, 1);
> +
> +		dbus_message_iter_recurse(&struct_iter, &entry);
> +
> +		dbus_message_iter_get_basic(&entry, &playlist->id);
> +		DBG("Playlists Id %s", playlist->id);
> +
> +		dbus_message_iter_next(&entry);
> +		dbus_message_iter_get_basic(&entry, &playlist->name);
> +		DBG("Playlist Name %s", playlist->name);
> +
> +		dbus_message_iter_next(&entry);
> +		dbus_message_iter_get_basic(&entry, &playlist->icon);
> +		DBG("Playlist Icon %s", playlist->icon);
> +
> +		/* TODO: Create Media folder with playlist information */
> +
> +		mp->playlists = g_slist_append(mp->playlists, playlist);
> +
> +		g_free(playlist);
> +
> +		mp->total_items++;
> +		dbus_message_iter_next(&struct_iter);
> +	}
> +
> +done:
> +	dbus_message_unref(reply);
> +
> +	mp->requests = g_slist_remove(mp->requests, request);
> +	playlist_request_free(request);
> +}
> +
> +static gboolean media_player_async_call(DBusMessage *msg,
> +					struct media_player *mp,
> +					media_player_cb_t cb,
> +					GDestroyNotify destroy)
> +{
> +	struct player_request *request;
> +	const char *method = NULL;
> +
> +	request = g_new0(struct player_request, 1);
> +
> +	if
> (!(dbus_connection_send_with_reply(btd_get_dbus_connection(),
> +					msg, &request->call, -1))) {
> +		error("D-Bus send failed");
> +		g_free(request);
> +		return FALSE;
> +	}
> +
> +	method = dbus_message_get_member(msg);
> +
> +	if (g_strcmp0(method, "GetPlaylists") == 0)
> +		dbus_pending_call_set_notify(request->call,
> +						cb, request, NULL);
> +
> +	request->mp = mp;
> +	request->msg = msg;
> +	request->destroy = destroy;
> +
> +	mp->requests = g_slist_append(mp->requests, request);
> +
> +	DBG("Calling %s: name = %s path = %s",
> dbus_message_get_member(msg),
> +			dbus_message_get_destination(msg),
> +			dbus_message_get_path(msg));
> +
> +	return TRUE;
> +}
> +
> +static gboolean get_playlists(struct media_player *mp) {
> +	DBusMessage *msg;
> +	gboolean reverse_order = FALSE;
> +	uint32_t start_index = 0x0000;
> +	uint32_t end_index = 0xFFFF;
> +	char *ordering = "Alphabetical";
> +	uint32_t max_count = (end_index - start_index);
> +
> +	msg = dbus_message_new_method_call(mp->sender, mp->path,
> +				MEDIA_PLAYER_PLAYLIST_INTERFACE,
> +				"GetPlaylists");
> +
> +	if (msg == NULL) {
> +		error("Couldn't allocate D-Bus message");
> +		return -ENOMEM;
> +	}
> +
> +	dbus_message_append_args(msg,
> +			DBUS_TYPE_UINT32, &start_index,
> +			DBUS_TYPE_UINT32, &max_count,
> +			DBUS_TYPE_STRING, &ordering,
> +			DBUS_TYPE_BOOLEAN, &reverse_order,
> +			DBUS_TYPE_INVALID);
> +
> +	mp->total_items = 0;
> +
> +	return media_player_async_call(msg, mp, playlist_reply, g_free); }
> +
>  static struct avrcp_player_cb player_cb = {
>  	.list_settings = list_settings,
>  	.get_setting = get_setting,
> @@ -1290,6 +1457,7 @@ static struct avrcp_player_cb player_cb = {
>  	.previous = previous,
>  };
> 
> +
>  static void media_player_exit(DBusConnection *connection, void
> *user_data)  {
>  	struct media_player *mp = user_data;
> @@ -1831,6 +1999,9 @@ static DBusMessage
> *register_player(DBusConnection *conn, DBusMessage *msg,
>  		return btd_error_invalid_args(msg);
>  	}
> 
> +	if (!get_playlists(mp))
> +		DBG("Error fetching playlists");
> +
>  	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);  }
> 
> diff --git a/profiles/audio/media.h b/profiles/audio/media.h index
> dd630d4..6d15882 100644
> --- a/profiles/audio/media.h
> +++ b/profiles/audio/media.h
> @@ -26,6 +26,8 @@ struct media_endpoint;
> 
>  typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
>  					void *ret, int size, void
*user_data);
> +typedef void (*media_player_cb_t) (DBusPendingCall *call,
> +					void *user_data);
> 
>  int media_register(struct btd_adapter *btd_adapter);  void
> media_unregister(struct btd_adapter *btd_adapter);
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

