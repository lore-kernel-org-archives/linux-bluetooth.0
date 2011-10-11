Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318250231-14001-4-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318250231-14001-4-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 11 Oct 2011 12:54:01 +0300
Message-ID: <CABBYNZKMzxCoMezscDQy4WjYnsUxmHE3mR8QFaguOVGaeOUy_g@mail.gmail.com>
Subject: Re: [PATCH 4/7] Don't overwrite metadata when changing track
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Oct 10, 2011 at 3:37 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> If we use the same hash table to set the new metadata, we have 2
> undesired behaviors:
>
> 1) New track may contain fields from previous track if it didn't set all
> the fields
> 2) If we fail on parsing the signal, we will still change some of the
> fields
> ---
>  audio/media.c |   43 ++++++++++++++++++++++++++-----------------
>  1 files changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index 32dab86..13a0c78 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1351,8 +1351,8 @@ static gboolean parse_player_metadata(struct media_player *mp,
>  {
>        DBusMessageIter dict;
>        DBusMessageIter var;
> +       GHashTable *track;
>        int ctype;
> -       gboolean title = FALSE;
>
>        ctype = dbus_message_iter_get_arg_type(iter);
>        if (ctype != DBUS_TYPE_ARRAY)
> @@ -1360,6 +1360,9 @@ static gboolean parse_player_metadata(struct media_player *mp,
>
>        dbus_message_iter_recurse(iter, &dict);
>
> +       track = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
> +                                                       metadata_value_free);
> +
>        while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
>                                                        DBUS_TYPE_INVALID) {
>                DBusMessageIter entry;
> @@ -1368,21 +1371,21 @@ static gboolean parse_player_metadata(struct media_player *mp,
>                int id;
>
>                if (ctype != DBUS_TYPE_DICT_ENTRY)
> -                       return FALSE;
> +                       goto parse_error;
>
>                dbus_message_iter_recurse(&dict, &entry);
>                if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
> -                       return FALSE;
> +                       goto parse_error;
>
>                dbus_message_iter_get_basic(&entry, &key);
>                dbus_message_iter_next(&entry);
>
>                id = metadata_to_val(key);
>                if (id < 0)
> -                       return FALSE;
> +                       goto parse_error;
>
>                if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
> -                       return FALSE;
> +                       goto parse_error;
>
>                dbus_message_iter_recurse(&entry, &var);
>
> @@ -1391,13 +1394,12 @@ static gboolean parse_player_metadata(struct media_player *mp,
>
>                switch (id) {
>                case AVRCP_MEDIA_ATTRIBUTE_TITLE:
> -                       title = TRUE;
>                case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
>                case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
>                case AVRCP_MEDIA_ATTRIBUTE_GENRE:
>                        if (value->type != DBUS_TYPE_STRING) {
>                                g_free(value);
> -                               return FALSE;
> +                               goto parse_error;
>                        }
>
>                        dbus_message_iter_get_basic(&var, &value->value.str);
> @@ -1407,13 +1409,13 @@ static gboolean parse_player_metadata(struct media_player *mp,
>                case AVRCP_MEDIA_ATTRIBUTE_DURATION:
>                        if (value->type != DBUS_TYPE_UINT32) {
>                                g_free(value);
> -                               return FALSE;
> +                               goto parse_error;
>                        }
>
>                        dbus_message_iter_get_basic(&var, &value->value.num);
>                        break;
>                default:
> -                       return FALSE;
> +                       goto parse_error;
>                }
>
>                switch (value->type) {
> @@ -1425,24 +1427,31 @@ static gboolean parse_player_metadata(struct media_player *mp,
>                        DBG("%s=%u", key, value->value.num);
>                }
>
> -               if (!mp->track)
> -                       mp->track = g_hash_table_new_full(g_direct_hash,
> -                                                       g_direct_equal, NULL,
> -                                                       metadata_value_free);
> -
> -               g_hash_table_replace(mp->track, GUINT_TO_POINTER(id), value);
> +               g_hash_table_replace(track, GUINT_TO_POINTER(id), value);
>                dbus_message_iter_next(&dict);
>        }
>
> -       if (title == FALSE)
> -               return TRUE;
> +       if (g_hash_table_size(track) == 0) {
> +               g_hash_table_unref(track);
> +               track = NULL;
> +       }
>
> +       if (mp->track != NULL)
> +               g_hash_table_unref(mp->track);
> +
> +       mp->track = track;
>        mp->position = 0;
>        g_timer_start(mp->timer);
>
>        avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, NULL);
>
>        return TRUE;
> +
> +parse_error:
> +       if (track)
> +               g_hash_table_unref(track);
> +
> +       return FALSE;
>  }
>
>  static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
> --
> 1.7.7
>

It might be useful to add to the documentation that the metadata need
to be set all at once so it cannot be updated in parts.

-- 
Luiz Augusto von Dentz
