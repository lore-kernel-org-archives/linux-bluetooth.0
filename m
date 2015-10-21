Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1445346988-12782-1-git-send-email-bharat.panda@samsung.com>
References: <1445346988-12782-1-git-send-email-bharat.panda@samsung.com>
Date: Wed, 21 Oct 2015 16:04:15 +0300
Message-ID: <CABBYNZL2U+3UAA-+oAA=2HuzQtu5hBO=muA16eitY3H=UqmDGg@mail.gmail.com>
Subject: Re: [PATCH 1/3] audio/avrcp: Get player playlist details
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Oct 20, 2015 at 4:16 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Support added to read and cache player playlist details after
> player registration completes.
> ---
>  profiles/audio/media.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 69070bf..1b5246d 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -58,6 +58,7 @@
>  #define MEDIA_INTERFACE "org.bluez.Media1"
>  #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
>  #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
> +#define MEDIA_PLAYER_PLAYLIST_INTERFACE "org.mpris.MediaPlayer2.Playlists"
>
>  #define REQUEST_TIMEOUT (3 * 1000)             /* 3 seconds */
>
> @@ -92,9 +93,19 @@ struct media_endpoint {
>         GSList                  *transports;
>  };
>
> +struct player_request {
> +       struct media_player     *mp;
> +       DBusMessage             *msg;
> +       DBusPendingCall         *call;
> +       GDestroyNotify          destroy;
> +       void                    *user_data;
> +};
> +
>  struct media_player {
>         struct media_adapter    *adapter;
>         struct avrcp_player     *player;
> +       GSList                  *playlists;
> +       GSList                  *requests;
>         char                    *sender;        /* Player DBus bus id */
>         char                    *path;          /* Player object path */
>         GHashTable              *settings;      /* Player settings */
> @@ -105,6 +116,7 @@ struct media_player {
>         char                    *status;
>         uint32_t                position;
>         uint32_t                duration;
> +       uint32_t                total_items;
>         uint8_t                 volume;
>         GTimer                  *timer;
>         bool                    play;
> @@ -115,6 +127,13 @@ struct media_player {
>         char                    *name;
>  };
>
> +struct media_playlist {
> +       char            *name;
> +       char            *id;
> +       char            *icon;
> +       uint8_t         data[0];
> +} __attribute__ ((packed));
> +

Im lost here, why do you need this to packed? Usually we only use
packed for network frames which may not be aligned depending on the
architecture, also what is this data[0] for?

>  static GSList *adapters = NULL;
>
>  static void endpoint_request_free(struct endpoint_request *request)
> @@ -966,6 +985,7 @@ static void media_player_free(gpointer data)
>         g_free(mp->path);
>         g_free(mp->status);
>         g_free(mp->name);
> +       g_free(mp->playlists);

You need to free the playlists here, and probable the requests as
well, actually are you running this with valgrind/gdb? By now I would
expect you to have been always testing with valgrind or gdb to make
sure your changes don't cause leaks which means I have to be super
cautions with your patches.

>         g_free(mp);
>  }
>
> @@ -1271,6 +1291,147 @@ static bool previous(void *user_data)
>         return media_player_send(mp, "Previous");
>  }
>
> +static void playlist_reply(DBusPendingCall *call, void *user_data)
> +{
> +       struct player_request *request = user_data;
> +       struct media_player *mp = request->mp;
> +       DBusMessage *reply;
> +       DBusMessageIter array_iter, entry, struct_iter;
> +       DBusError derr;
> +       int ctype;
> +
> +       reply = dbus_pending_call_steal_reply(call);
> +
> +       dbus_error_init(&derr);
> +
> +       if (dbus_set_error_from_message(&derr, reply)) {
> +               error("Error: GetPlayLists method %s, %s", derr.name,
> +                                       derr.message);
> +               dbus_error_free(&derr);
> +               goto done;
> +       }
> +
> +       dbus_message_iter_init(reply, &array_iter);
> +       ctype = dbus_message_iter_get_arg_type(&array_iter);
> +
> +       if (ctype != DBUS_TYPE_ARRAY)
> +               goto done;
> +
> +       dbus_message_iter_recurse(&array_iter, &struct_iter);
> +
> +       while ((ctype = dbus_message_iter_get_arg_type(&struct_iter)) !=
> +                               DBUS_TYPE_INVALID) {
> +               struct media_playlist *playlist;
> +
> +               if (ctype != DBUS_TYPE_STRUCT) {
> +                       error("Invalid type");
> +                       goto done;
> +               }
> +
> +               playlist = g_new0(struct media_playlist, 1);
> +
> +               dbus_message_iter_recurse(&struct_iter, &entry);
> +
> +               dbus_message_iter_get_basic(&entry, &playlist->id);
> +               DBG("Playlists Id %s", playlist->id);
> +
> +               dbus_message_iter_next(&entry);
> +               dbus_message_iter_get_basic(&entry, &playlist->name);
> +               DBG("Playlist Name %s", playlist->name);
> +
> +               dbus_message_iter_next(&entry);
> +               dbus_message_iter_get_basic(&entry, &playlist->icon);
> +               DBG("Playlist Icon %s", playlist->icon);
> +
> +               /* TODO: Create Media folder with playlist information */
> +
> +               mp->playlists = g_slist_append(mp->playlists, playlist);
> +
> +               g_free(playlist);
> +
> +               mp->total_items++;
> +               dbus_message_iter_next(&struct_iter);
> +       }
> +
> +done:
> +       dbus_message_unref(reply);
> +
> +       mp->requests = g_slist_remove(mp->requests, request);
> +
> +       if (request->call)
> +               dbus_pending_call_unref(request->call);
> +
> +       if (request->destroy)
> +               request->destroy(request->user_data);
> +
> +       dbus_message_unref(request->msg);
> +       g_free(request);

It probably make sense to have a free function for the lines above
e.g. player_request_free so that you can reuse when cleaning up.

> +}
> +
> +static gboolean media_player_async_call(DBusMessage *msg,
> +                                       struct media_player *mp,
> +                                       GDestroyNotify destroy)
> +{
> +       struct player_request *request;
> +       const char *method = NULL;
> +
> +       request = g_new0(struct player_request, 1);
> +
> +       if (!(dbus_connection_send_with_reply(btd_get_dbus_connection(),
> +                                       msg, &request->call, -1))) {
> +               error("D-Bus send failed");
> +               g_free(request);
> +               return FALSE;
> +       }
> +
> +       method = dbus_message_get_member(msg);
> +
> +       if (g_strcmp0(method, "GetPlaylists") == 0)
> +               dbus_pending_call_set_notify(request->call,
> +                                               &playlist_reply, request, NULL);

Pass the reply callback in the function parameter like
media_endpoint_async_call is doing.

> +
> +       request->mp = mp;
> +       request->msg = msg;
> +       request->destroy = destroy;
> +
> +       mp->requests = g_slist_append(mp->requests, request);
> +
> +       DBG("Calling %s: name = %s path = %s", dbus_message_get_member(msg),
> +                       dbus_message_get_destination(msg),
> +                       dbus_message_get_path(msg));
> +
> +       return TRUE;
> +}
> +static gboolean get_playlists(struct media_player *mp)
> +{
> +       DBusMessage *msg;
> +       gboolean reverse_order = FALSE;
> +       uint32_t start_index = 0x0000;
> +       uint32_t end_index = 0xFFFF;
> +       char *ordering = "Alphabetical";
> +       uint32_t max_count = (end_index - start_index);
> +
> +       msg = dbus_message_new_method_call(mp->sender, mp->path,
> +                               MEDIA_PLAYER_PLAYLIST_INTERFACE,
> +                               "GetPlaylists");
> +
> +       if (msg == NULL) {
> +               error("Couldn't allocate D-Bus message");
> +               return -ENOMEM;
> +       }
> +
> +       dbus_message_append_args(msg,
> +                       DBUS_TYPE_UINT32, &start_index,
> +                       DBUS_TYPE_UINT32, &max_count,
> +                       DBUS_TYPE_STRING, &ordering,
> +                       DBUS_TYPE_BOOLEAN, &reverse_order,
> +                       DBUS_TYPE_INVALID);
> +
> +       mp->total_items = 0;
> +
> +       return (media_player_async_call(msg, mp, g_free));

Why the extra parenthesis? Im pretty sure checkpatch would complain about this.

> +}
> +
>  static struct avrcp_player_cb player_cb = {
>         .list_settings = list_settings,
>         .get_setting = get_setting,
> @@ -1831,6 +1992,9 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
>                 return btd_error_invalid_args(msg);
>         }
>
> +       if (!get_playlists(mp))
> +               DBG("Error fetching playlists");
> +
>         return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>  }
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
