Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1381492404-25765-1-git-send-email-luiz.dentz@gmail.com>
References: <1381492404-25765-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 15 Oct 2013 13:11:54 +0300
Message-ID: <CABBYNZKf=2nC2gHZOdXqW3XPS9rvHpFJe=Y3P9+o+E_yXCahCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio/media: Add support for tracking Seeked signal
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 11, 2013 at 2:53 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This tracks Seeked signal and update the position in case it happens.
> ---
>  profiles/audio/media.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 9c72b8d..646c76a 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -96,6 +96,7 @@ struct media_player {
>         guint                   watch;
>         guint                   properties_watch;
>         guint                   track_watch;
> +       guint                   seek_watch;
>         char                    *status;
>         uint32_t                position;
>         uint32_t                duration;
> @@ -949,6 +950,7 @@ static void media_player_free(gpointer data)
>         g_dbus_remove_watch(conn, mp->watch);
>         g_dbus_remove_watch(conn, mp->properties_watch);
>         g_dbus_remove_watch(conn, mp->track_watch);
> +       g_dbus_remove_watch(conn, mp->seek_watch);
>
>         if (mp->track)
>                 g_hash_table_unref(mp->track);
> @@ -1681,6 +1683,21 @@ static gboolean properties_changed(DBusConnection *connection, DBusMessage *msg,
>         return TRUE;
>  }
>
> +static gboolean position_changed(DBusConnection *connection, DBusMessage *msg,
> +                                                       void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +       DBusMessageIter iter;
> +
> +       DBG("sender=%s path=%s", mp->sender, mp->path);
> +
> +       dbus_message_iter_init(msg, &iter);
> +
> +       set_position(mp, &iter);
> +
> +       return TRUE;
> +}
> +
>  static struct media_player *media_player_create(struct media_adapter *adapter,
>                                                 const char *sender,
>                                                 const char *path,
> @@ -1702,6 +1719,10 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
>                                                 path, MEDIA_PLAYER_INTERFACE,
>                                                 properties_changed,
>                                                 mp, NULL);
> +       mp->seek_watch = g_dbus_add_signal_watch(conn, sender,
> +                                               path, MEDIA_PLAYER_INTERFACE,
> +                                               "Seeked", position_changed,
> +                                               mp, NULL);
>         mp->player = avrcp_register_player(adapter->btd_adapter, &player_cb,
>                                                         mp, media_player_free);
>         if (!mp->player) {
> --
> 1.8.3.1

Pushed.


-- 
Luiz Augusto von Dentz
