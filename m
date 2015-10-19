Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com
References: <1444132398-3176-1-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1444132398-3176-1-git-send-email-bharat.panda@samsung.com>
Subject: RE: [PATCH  1/3] aurdio/avrcp: Get player playlist details
Date: Mon, 19 Oct 2015 14:32:14 +0530
Message-id: <02bc01d10a4c$e2c50510$a84f0f30$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Bharat Panda
> Sent: Tuesday, October 06, 2015 5:23 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: cpgs@samsung.com; Bharat Panda
> Subject: [PATCH 1/3] aurdio/avrcp: Get player playlist details
> 
> Support added to read and cache player playlist details after player
> registration completes.
> ---
>  profiles/audio/media.c | 121
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
> 69070bf..edeb66f 100644
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
> @@ -95,6 +96,7 @@ struct media_endpoint {  struct media_player {
>  	struct media_adapter	*adapter;
>  	struct avrcp_player	*player;
> +	GSList			*playlists;
>  	char			*sender;	/* Player DBus bus id */
>  	char			*path;		/* Player object path */
>  	GHashTable		*settings;	/* Player settings */
> @@ -105,8 +107,10 @@ struct media_player {
>  	char			*status;
>  	uint32_t		position;
>  	uint32_t		duration;
> +	uint32_t		total_items;
>  	uint8_t			volume;
>  	GTimer			*timer;
> +	guint			playlist_id;
>  	bool			play;
>  	bool			pause;
>  	bool			next;
> @@ -115,6 +119,13 @@ struct media_player {
>  	char			*name;
>  };
> 
> +struct media_playlist {
> +	char		*name;
> +	char		*id;
> +	char		*icon;
> +	uint8_t		data[0];
> +} __attribute__ ((packed));
> +
>  static GSList *adapters = NULL;
> 
>  static void endpoint_request_free(struct endpoint_request *request) @@ -
> 961,6 +972,9 @@ static void media_player_free(gpointer data)
>  	if (mp->settings)
>  		g_hash_table_unref(mp->settings);
> 
> +	if (mp->playlist_id > 0)
> +		g_source_remove(mp->playlist_id);
> +
>  	g_timer_destroy(mp->timer);
>  	g_free(mp->sender);
>  	g_free(mp->path);
> @@ -1271,6 +1285,111 @@ static bool previous(void *user_data)
>  	return media_player_send(mp, "Previous");  }
> 
> +
> +static void playlist_reply(DBusPendingCall *call, void *user_data) {
> +	struct media_player *mp = user_data;
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
> +		mp->total_items++;
> +
> +		dbus_message_iter_next(&struct_iter);
> +	}
> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
> +static gboolean get_playlists(gpointer user_data) {
> +	struct media_player *mp = user_data;
> +	DBusMessage *msg;
> +	DBusPendingCall *call;
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
> +	if ((dbus_connection_send_with_reply(btd_get_dbus_connection(),
> +					msg, &call, -1))) {
> +		dbus_pending_call_set_notify(call, &playlist_reply, mp,
> NULL);
> +		dbus_pending_call_unref(call);
> +		dbus_message_unref(msg);
> +	}
> +
> +	mp->playlist_id = 0;
> +
> +	return FALSE;
> +}
> +
>  static struct avrcp_player_cb player_cb = {
>  	.list_settings = list_settings,
>  	.get_setting = get_setting,
> @@ -1831,6 +1950,8 @@ static DBusMessage
> *register_player(DBusConnection *conn, DBusMessage *msg,
>  		return btd_error_invalid_args(msg);
>  	}
> 
> +	mp->playlist_id = g_idle_add(get_playlists, mp);
> +
>  	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);  }
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

