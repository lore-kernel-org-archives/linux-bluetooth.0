Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <001c01d12905$cd41ec80$67c5c580$@samsung.com>
References: <1445346988-12782-1-git-send-email-bharat.panda@samsung.com>
	<1445346988-12782-2-git-send-email-bharat.panda@samsung.com>
	<001c01d12905$cd41ec80$67c5c580$@samsung.com>
Date: Wed, 2 Dec 2015 15:31:51 +0200
Message-ID: <CABBYNZLHJo+eQ1SCughLL1QUmsJRDSmanKb_08bSg4fbYE7m9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] audio/avrcp: Handle PlaylistChanged signal
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Nov 27, 2015 at 1:21 PM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> ping
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Bharat Panda
>> Sent: Tuesday, October 20, 2015 6:46 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: cpgs@samsung.com; Bharat Panda
>> Subject: [PATCH 2/3] audio/avrcp: Handle PlaylistChanged signal
>>
>> Added signal handler for "PlaylistChanged" on MediaPlayer2.Playlists
>> interface.
>> ---
>>  profiles/audio/media.c | 79
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>
>> diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
>> 1b5246d..94fce79 100644
>> --- a/profiles/audio/media.c
>> +++ b/profiles/audio/media.c
>> @@ -113,6 +113,7 @@ struct media_player {
>>       guint                   watch;
>>       guint                   properties_watch;
>>       guint                   seek_watch;
>> +     guint                   playlist_watch;
>>       char                    *status;
>>       uint32_t                position;
>>       uint32_t                duration;
>> @@ -973,6 +974,7 @@ static void media_player_free(gpointer data)
>>       g_dbus_remove_watch(conn, mp->watch);
>>       g_dbus_remove_watch(conn, mp->properties_watch);
>>       g_dbus_remove_watch(conn, mp->seek_watch);
>> +     g_dbus_remove_watch(conn, mp->playlist_watch);
>>
>>       if (mp->track)
>>               g_hash_table_unref(mp->track);
>> @@ -1913,6 +1915,76 @@ static gboolean
>> position_changed(DBusConnection *connection, DBusMessage *msg,
>>       return TRUE;
>>  }
>>
>> +static struct media_playlist *find_playlist_by_id(struct media_player
> *mp,
>> +                                             char *playlist_id)
>> +{
>> +     GSList *l;
>> +
>> +     for (l = mp->playlists; l; l = l->next) {
>> +             struct media_playlist *playlist = l->data;
>> +
>> +             if (g_strcmp0(playlist->id, playlist_id) == 0) {
>> +                     return playlist;
>> +             }
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static gboolean playlist_changed(DBusConnection *connection,
>> +                                             DBusMessage *msg,
>> +                                             void *user_data)
>> +{
>> +     struct media_player *mp = user_data;
>> +     struct media_playlist *playlist;
>> +     DBusMessageIter iter;
>> +     DBusMessageIter entry;
>> +     char *playlist_id;
>> +     char *name;
>> +     char *icon;
>> +
>> +     dbus_message_iter_init(msg, &iter);
>> +     if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRUCT)
>> +             return FALSE;
>> +
>> +     dbus_message_iter_recurse(&iter, &entry);
>> +
>> +     if (dbus_message_iter_get_arg_type(&entry) !=
>> +                     DBUS_TYPE_OBJECT_PATH)
>> +             return FALSE;
>> +
>> +     dbus_message_iter_get_basic(&entry, &playlist_id);
>> +
>> +     dbus_message_iter_next(&entry);
>> +     if (dbus_message_iter_get_arg_type(&entry) !=
>> +                     DBUS_TYPE_STRING)
>> +             return FALSE;
>> +
>> +     dbus_message_iter_get_basic(&entry, &name);
>> +
>> +     dbus_message_iter_next(&entry);
>> +     if (dbus_message_iter_get_arg_type(&entry) !=
>> +                     DBUS_TYPE_STRING)
>> +             return FALSE;
>> +
>> +     dbus_message_iter_get_basic(&entry, &icon);
>> +
>> +     playlist = find_playlist_by_id(mp, playlist_id);
>> +
>> +     if (playlist) {
>> +             playlist->name = g_strdup(name);
>> +             playlist->icon = g_strdup(icon);
>> +     } else {
>> +             playlist = g_new0(struct media_playlist, 1);
>> +
>> +             playlist->id = playlist_id;
>> +             playlist->name = g_strdup(name);
>> +             playlist->icon = g_strdup(icon);
>> +     }

Change this to if (!playlist) { new0.. the you can have name and icon
set after that since playlist would be set one way or the other.

>> +     return TRUE;
>> +}
>> +
>>  static struct media_player *media_player_create(struct media_adapter
>> *adapter,
>>                                               const char *sender,
>>                                               const char *path,
>> @@ -1995,6 +2067,13 @@ static DBusMessage
>> *register_player(DBusConnection *conn, DBusMessage *msg,
>>       if (!get_playlists(mp))
>>               DBG("Error fetching playlists");
>>
>> +     mp->playlist_watch = g_dbus_add_signal_watch(conn,
>> +                                     sender, path,
>> +
>>       MEDIA_PLAYER_PLAYLIST_INTERFACE,
>> +                                     "PlaylistChanged",
>> +                                     playlist_changed,
>> +                                     mp, NULL);
>> +
>>       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);  }
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
