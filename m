Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com
References: <1444639277-5998-1-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1444639277-5998-1-git-send-email-bharat.panda@samsung.com>
Subject: RE: [PATCH ] audio/player: Fix player name value for MPRIS
Date: Tue, 20 Oct 2015 18:35:19 +0530
Message-id: <02ec01d10b38$052f11e0$0f8d35a0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Bharat Panda
> Sent: Monday, October 12, 2015 2:11 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: cpgs@samsung.com; Bharat Panda
> Subject: [PATCH ] audio/player: Fix player name value for MPRIS
> 
> Added fix for setting media player name when the player Identity value is
> invalid.
> ---
>  profiles/audio/media.c | 15 +++++++++++++--
>  tools/mpris-proxy.c    |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
> 69070bf..68111e6 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1805,7 +1805,7 @@ static DBusMessage
> *register_player(DBusConnection *conn, DBusMessage *msg,
>  	struct media_adapter *adapter = data;
>  	struct media_player *mp;
>  	DBusMessageIter args;
> -	const char *sender, *path;
> +	const char *sender, *path, *name;
>  	int err;
> 
>  	sender = dbus_message_get_sender(msg); @@ -1814,6 +1814,8 @@
> static DBusMessage *register_player(DBusConnection *conn, DBusMessage
> *msg,
> 
>  	dbus_message_iter_get_basic(&args, &path);
>  	dbus_message_iter_next(&args);
> +	dbus_message_iter_get_basic(&args, &name);
> +	dbus_message_iter_next(&args);
> 
>  	if (media_adapter_find_player(adapter, sender, path) != NULL)
>  		return btd_error_already_exists(msg); @@ -1831,6 +1833,14
> @@ static DBusMessage *register_player(DBusConnection *conn,
> DBusMessage *msg,
>  		return btd_error_invalid_args(msg);
>  	}
> 
> +	/*
> +	 * The Player Identity value is NULL in MPRIS case, so create
> +	 * mpris name on the basis of player bus name and assign
> +	 * the value.
> +	 */
> +	if (mp->name == NULL)
> +		mp->name = g_strdup(name);
> +
>  	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);  }
> 
> @@ -1864,7 +1874,8 @@ static const GDBusMethodTable media_methods[]
> = {
>  	{ GDBUS_METHOD("UnregisterEndpoint",
>  		GDBUS_ARGS({ "endpoint", "o" }), NULL,
> unregister_endpoint) },
>  	{ GDBUS_METHOD("RegisterPlayer",
> -		GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" }),
> +		GDBUS_ARGS({ "player", "o" }, { "name", "s" },
> +						{ "properties", "a{sv}" }),
>  		NULL, register_player) },
>  	{ GDBUS_METHOD("UnregisterPlayer",
>  		GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
> diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c index
bf8148f..cb94f2b
> 100644
> --- a/tools/mpris-proxy.c
> +++ b/tools/mpris-proxy.c
> @@ -466,6 +466,7 @@ static void add_player(DBusConnection *conn, const
> char *name,
>  	dbus_message_iter_init_append(msg, &iter);
> 
>  	dbus_message_iter_append_basic(&iter,
> DBUS_TYPE_OBJECT_PATH, &path);
> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
> &name);
> 
>  	if (player != NULL) {
>  		if (!g_dbus_get_properties(player->conn,
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

