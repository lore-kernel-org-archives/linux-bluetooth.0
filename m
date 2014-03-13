Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394717549-32065-1-git-send-email-luiz.dentz@gmail.com>
References: <1394717549-32065-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 13 Mar 2014 18:06:33 +0200
Message-ID: <CABBYNZLtD9CzNff+4QDHh0PgXaRMo0-dnsXmW3ZvkrpnAqY9Rw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] audio/player: Use proper errors instead of
 using .Failed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 13, 2014 at 3:32 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  profiles/audio/player.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index 2bd2d6e..c76352e 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -778,19 +778,16 @@ static DBusMessage *media_folder_search(DBusConnection *conn, DBusMessage *msg,
>         dbus_message_iter_init(msg, &iter);
>
>         if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> -               return btd_error_failed(msg, strerror(EINVAL));
> +               return btd_error_invalid_args(msg);
>
>         dbus_message_iter_get_basic(&iter, &string);
>
> -       if (!mp->searchable || folder != mp->folder)
> -               return btd_error_failed(msg, strerror(ENOTSUP));
> +       if (!mp->searchable || folder != mp->folder || !cb->cbs->search)
> +               return btd_error_not_supported(msg);
>
>         if (folder->msg != NULL)
>                 return btd_error_failed(msg, strerror(EINVAL));
>
> -       if (cb->cbs->search == NULL)
> -               return btd_error_failed(msg, strerror(ENOTSUP));
> -
>         err = cb->cbs->search(mp, string, cb->user_data);
>         if (err < 0)
>                 return btd_error_failed(msg, strerror(-err));
> @@ -998,14 +995,14 @@ static DBusMessage *media_folder_change_folder(DBusConnection *conn,
>         if (!dbus_message_get_args(msg, NULL,
>                                         DBUS_TYPE_OBJECT_PATH, &path,
>                                         DBUS_TYPE_INVALID))
> -               return btd_error_failed(msg, strerror(EINVAL));
> +               return btd_error_invalid_args(msg);
>
>         if (folder->msg != NULL)
>                 return btd_error_failed(msg, strerror(EBUSY));
>
>         folder = media_player_find_folder(mp, path);
>         if (folder == NULL)
> -               return btd_error_failed(msg, strerror(EINVAL));
> +               return btd_error_invalid_args(msg);
>
>         if (mp->scope == folder)
>                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> @@ -1017,7 +1014,7 @@ static DBusMessage *media_folder_change_folder(DBusConnection *conn,
>         }
>
>         if (cb->cbs->change_folder == NULL)
> -               return btd_error_failed(msg, strerror(ENOTSUP));
> +               return btd_error_not_supported(msg);
>
>         err = cb->cbs->change_folder(mp, folder->item->name, folder->item->uid,
>                                                                 cb->user_data);
> @@ -1473,11 +1470,8 @@ static DBusMessage *media_item_play(DBusConnection *conn, DBusMessage *msg,
>         struct player_callback *cb = mp->cb;
>         int err;
>
> -       if (!item->playable)
> -               return btd_error_failed(msg, strerror(ENOTSUP));
> -
> -       if (cb->cbs->play_item == NULL)
> -               return btd_error_failed(msg, strerror(ENOTSUP));
> +       if (!item->playable || !cb->cbs->play_item)
> +               return btd_error_not_supported(msg);
>
>         err = cb->cbs->play_item(mp, item->path, item->uid, cb->user_data);
>         if (err < 0)
> @@ -1494,11 +1488,8 @@ static DBusMessage *media_item_add_to_nowplaying(DBusConnection *conn,
>         struct player_callback *cb = mp->cb;
>         int err;
>
> -       if (!item->playable)
> -               return btd_error_failed(msg, strerror(ENOTSUP));
> -
> -       if (cb->cbs->play_item == NULL)
> -               return btd_error_failed(msg, strerror(ENOTSUP));
> +       if (!item->playable || !cb->cbs->play_item)
> +               return btd_error_not_supported(msg);
>
>         err = cb->cbs->add_to_nowplaying(mp, item->path, item->uid,
>                                                         cb->user_data);
> --
> 1.8.5.3

Pushed.


-- 
Luiz Augusto von Dentz
