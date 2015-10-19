Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1444132398-3176-2-git-send-email-bharat.panda@samsung.com>
References: <1444132398-3176-1-git-send-email-bharat.panda@samsung.com>
	<1444132398-3176-2-git-send-email-bharat.panda@samsung.com>
Date: Mon, 19 Oct 2015 13:42:49 +0300
Message-ID: <CABBYNZLebjoeVY0+97BoDcZcEWfviyATkRxyRwh+wMeB=A9khw@mail.gmail.com>
Subject: Re: [PATCH 2/3] audio/avrcp: Handle PlaylistChanged signal
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Oct 6, 2015 at 2:53 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Added signal handler for "PlaylistChanged" on MediaPlayer2.Playlists
> interface.
> ---
>  profiles/audio/media.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index edeb66f..2df0cb2 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -104,6 +104,7 @@ struct media_player {
>         guint                   watch;
>         guint                   properties_watch;
>         guint                   seek_watch;
> +       guint                   playlist_watch;
>         char                    *status;
>         uint32_t                position;
>         uint32_t                duration;
> @@ -965,6 +966,7 @@ static void media_player_free(gpointer data)
>         g_dbus_remove_watch(conn, mp->watch);
>         g_dbus_remove_watch(conn, mp->properties_watch);
>         g_dbus_remove_watch(conn, mp->seek_watch);
> +       g_dbus_remove_watch(conn, mp->playlist_watch);
>
>         if (mp->track)
>                 g_hash_table_unref(mp->track);
> @@ -1871,6 +1873,51 @@ static gboolean position_changed(DBusConnection *connection, DBusMessage *msg,
>         return TRUE;
>  }
>
> +static gboolean playlist_changed(DBusConnection *connection,
> +                                               DBusMessage *msg,
> +                                               void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +       DBusMessageIter iter;
> +       DBusMessageIter entry;
> +       char *playlist_id;
> +       GSList *l;
> +
> +       dbus_message_iter_init(msg, &iter);
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRUCT)
> +               return FALSE;
> +
> +       dbus_message_iter_recurse(&iter, &entry);
> +
> +       if (dbus_message_iter_get_arg_type(&entry) !=
> +                       DBUS_TYPE_OBJECT_PATH)
> +               return FALSE;
> +
> +       dbus_message_iter_get_basic(&entry, &playlist_id);
> +
> +       for (l = mp->playlists; l; l = l->next) {
> +               struct media_playlist *playlist = l->data;
> +
> +               if (g_strcmp0(playlist->id, playlist_id) == 0) {
> +                       dbus_message_iter_next(&entry);
> +                       if (dbus_message_iter_get_arg_type(&entry) !=
> +                                       DBUS_TYPE_STRING)
> +                               return FALSE;
> +
> +                       dbus_message_iter_get_basic(&entry, &playlist->name);
> +
> +                       dbus_message_iter_next(&entry);
> +                       if (dbus_message_iter_get_arg_type(&entry) !=
> +                                       DBUS_TYPE_STRING)
> +                               return FALSE;
> +
> +                       dbus_message_iter_get_basic(&entry, &playlist->icon);
> +               }
> +       }

Id split this into find_playlist since we might need to reuse it in a
few places, also in case the playlist_id don't match it is probably a
new playlist so you might need to create a entry if that happens.

> +
> +       return TRUE;
> +}
> +
>  static struct media_player *media_player_create(struct media_adapter *adapter,
>                                                 const char *sender,
>                                                 const char *path,
> @@ -1950,6 +1997,13 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
>                 return btd_error_invalid_args(msg);
>         }
>
> +       mp->playlist_watch = g_dbus_add_signal_watch(conn,
> +                                       sender, path,
> +                                       MEDIA_PLAYER_PLAYLIST_INTERFACE,
> +                                       "PlaylistChanged",
> +                                       playlist_changed,
> +                                       mp, NULL);
> +

It seems you have in fact tracking this, so please disregard the
comments related to changed signal in the first patch.


-- 
Luiz Augusto von Dentz
