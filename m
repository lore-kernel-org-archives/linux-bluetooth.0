Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412610595-16393-1-git-send-email-bharat.panda@samsung.com>
References: <1412610595-16393-1-git-send-email-bharat.panda@samsung.com>
Date: Mon, 20 Oct 2014 14:17:16 +0300
Message-ID: <CABBYNZLTMaJQ2hO_LoCgZQz-EwCQ9LuD9mDgK-w54XDc3wNCvw@mail.gmail.com>
Subject: Re: [PATCH ] audio/avrcp: Add Support for PLAYBACK_POS_CHANGED_EVENT
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 6, 2014 at 6:49 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> As per AVRCP 1.5 spec, 6.7.2, page 57.
>
> EVENT_PLAYBACK_POS_CHANGED shall be notified in the following conditions:
>
>         1. TG has reached the registered playback Interval time.
>         2. Changed PLAY STATUS.
>         3. Changed Current Track.
>         4. Reached end or beginning of track.
> ---
>  profiles/audio/avrcp.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/avrcp.h |  1 +
>  profiles/audio/media.c | 23 ++++++++++++++---------
>  3 files changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 5c3c4f9..77f1dcb 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -198,6 +198,7 @@ struct pending_list_items {
>  struct avrcp_player {
>         struct avrcp_server *server;
>         GSList *sessions;
> +       uint16_t pos_timer;
>         uint16_t id;
>         uint8_t scope;
>         uint64_t uid;
> @@ -627,6 +628,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>         uint8_t buf[AVRCP_HEADER_LENGTH + 9];
>         struct avrcp_header *pdu = (void *) buf;
>         uint16_t size;
> +       uint32_t *pos = NULL;
>         GSList *l;
>         int attr;
>         int val;
> @@ -673,6 +675,18 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>                 pdu->params[size++] = attr;
>                 pdu->params[size++] = val;
>                 break;
> +       case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
> +               size = 5;
> +               pos = (uint32_t *) data;
> +
> +               be32toh(*pos);
> +               memcpy(&pdu->params[1], pos, sizeof(uint32_t));
> +
> +               if (player->pos_timer > 0) {
> +                       g_source_remove(player->pos_timer);
> +                       player->pos_timer = 0;
> +               }
> +               break;

Note that it is meant to be playback interval, so if it is not playing
we should not send anything.

>         default:
>                 error("Unknown event %u", id);
>                 return;
> @@ -1429,6 +1443,19 @@ static bool handle_passthrough(struct avctp *conn, uint8_t op, bool pressed,
>         return handler->func(session);
>  }
>
> +static gboolean interval_timeout(gpointer user_data)
> +{
> +       uint32_t pos;
> +       struct avrcp_player *mp = user_data;
> +
> +       pos = player_get_position(mp);
> +       mp->pos_timer = 0;
> +       avrcp_player_event(mp, AVRCP_EVENT_PLAYBACK_POS_CHANGED,
> +                                               &pos);
> +
> +       return FALSE;
> +}
> +
>  static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>                                                 struct avrcp_header *pdu,
>                                                 uint8_t transaction)
> @@ -1436,6 +1463,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>         struct avrcp_player *player = target_get_player(session);
>         struct btd_device *dev = session->dev;
>         uint16_t len = ntohs(pdu->params_len);
> +       uint32_t interval;
> +       uint32_t pos;
>         uint64_t uid;
>         GList *settings;
>
> @@ -1467,6 +1496,20 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>         case AVRCP_EVENT_TRACK_REACHED_START:
>                 len = 1;
>                 break;
> +       case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
> +               len = 5;
> +
> +               interval = htole32(pdu->params[1]);
> +               player->pos_timer = g_timeout_add_seconds(interval,
> +                                                               interval_timeout, player);
> +
> +               pos = player_get_position(player);
> +               be32toh(pos);
> +               /* Fill the value for sending INTERIM response */
> +               memcpy(&pdu->params[1], &pos, sizeof(uint32_t));
> +
> +               break;
> +
>         case AVRCP_EVENT_SETTINGS_CHANGED:
>                 len = 1;
>                 settings = player_list_settings(player);
> @@ -2949,6 +2992,11 @@ static void player_destroy(gpointer data)
>         if (player->destroy)
>                 player->destroy(player->user_data);
>
> +       if (player->pos_timer != 0) {
> +               g_source_remove(player->pos_timer);
> +               player->pos_timer = 0;
> +       }
> +
>         g_slist_free(player->sessions);
>         g_free(player->path);
>         g_free(player->change_path);
> @@ -3407,6 +3455,7 @@ static void target_init(struct avrcp *session)
>                                 (1 << AVRCP_EVENT_TRACK_CHANGED) |
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_START) |
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> +                               (1 << AVRCP_EVENT_PLAYBACK_POS_CHANGED) |
>                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
>         if (target->version < 0x0104)
> diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> index 6ac5294..4816e4b 100644
> --- a/profiles/audio/avrcp.h
> +++ b/profiles/audio/avrcp.h
> @@ -74,6 +74,7 @@
>  #define AVRCP_EVENT_TRACK_CHANGED              0x02
>  #define AVRCP_EVENT_TRACK_REACHED_END          0x03
>  #define AVRCP_EVENT_TRACK_REACHED_START                0x04
> +#define        AVRCP_EVENT_PLAYBACK_POS_CHANGED        0x05
>  #define AVRCP_EVENT_SETTINGS_CHANGED           0x08
>  #define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED  0x0a
>  #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED   0x0b
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index ef7b910..cc19c61 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1305,6 +1305,9 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
>         mp->status = g_strdup(value);
>
>         avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, mp->status);
> +       avrcp_player_event(mp->player,
> +                                       AVRCP_EVENT_PLAYBACK_POS_CHANGED,
> +                                       &mp->position);
>
>         return TRUE;
>  }
> @@ -1312,7 +1315,6 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
>  static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
>  {
>         uint64_t value;
> -       const char *status;
>
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
>                         return FALSE;
> @@ -1321,11 +1323,6 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
>
>         value /= 1000;
>
> -       if (value > get_position(mp))
> -               status = "forward-seek";
> -       else
> -               status = "reverse-seek";
> -

Not sure what is reasoning of removing these, the remote side may not
register for position change and in that case it would not get any
seek event to synchronize the position.

>         mp->position = value;
>         g_timer_start(mp->timer);
>
> @@ -1334,6 +1331,9 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
>         if (!mp->position) {
>                 avrcp_player_event(mp->player,
>                                         AVRCP_EVENT_TRACK_REACHED_START, NULL);
> +               avrcp_player_event(mp->player,
> +                                       AVRCP_EVENT_PLAYBACK_POS_CHANGED,
> +                                       &mp->position);
>                 return TRUE;
>         }
>
> @@ -1344,11 +1344,13 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
>         if (mp->position == UINT32_MAX || mp->position >= mp->duration) {
>                 avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
>                                                                         NULL);
> +               avrcp_player_event(mp->player,
> +                                       AVRCP_EVENT_PLAYBACK_POS_CHANGED,
> +                                       &mp->position);
>                 return TRUE;
>         }
> -
> -       /* Send a status change to force resync the position */
> -       avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, status);
> +       avrcp_player_event(mp->player, AVRCP_EVENT_PLAYBACK_POS_CHANGED,
> +                                                               &mp->position);
>
>         return TRUE;
>  }
> @@ -1456,6 +1458,7 @@ static gboolean parse_player_metadata(struct media_player *mp,
>         int ctype;
>         gboolean title = FALSE;
>         uint64_t uid;
> +       uint32_t pos;
>
>         ctype = dbus_message_iter_get_arg_type(iter);
>         if (ctype != DBUS_TYPE_ARRAY)
> @@ -1521,9 +1524,11 @@ static gboolean parse_player_metadata(struct media_player *mp,
>         mp->position = 0;
>         g_timer_start(mp->timer);
>         uid = get_uid(mp);
> +       pos = get_position(mp);
>
>         avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &uid);
>         avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_START, NULL);
> +       avrcp_player_event(mp->player, AVRCP_EVENT_PLAYBACK_POS_CHANGED, &pos);
>
>         return TRUE;
>  }
> --
> 1.9.1

Overall EVENT_PLAYBACK_POS_CHANGED cause more problems than it solves,
because position is already part of the play status and that normally
has to be queried anyway, also self synchronizing is way more
efficient since we can't estimate the speed when the playback is
fast-foward or rewind, and even if we could that would generate a lot
of traffic depending on what interval the remote side wants to be
updated.


-- 
Luiz Augusto von Dentz
