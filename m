Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1437560362-31152-1-git-send-email-bharat.panda@samsung.com>
References: <1437560362-31152-1-git-send-email-bharat.panda@samsung.com>
Date: Thu, 23 Jul 2015 13:18:06 +0300
Message-ID: <CABBYNZL07SVr7PGopeEAwdEBRprTe8fF=1gHPJ8MVxLE=QftCg@mail.gmail.com>
Subject: Re: [PATCH v2] audio/avrcp: Handle Available Players Changed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Wed, Jul 22, 2015 at 1:19 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Add support to handle AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED
> notification.
> - Register notification for "Available Players Changed"
> - Send interim and final responses on change in available palyers.

Could you please add the HCI traces of these events, also there a typo
in the line above, it should players.

> ---
>  profiles/audio/avrcp.c | 7 +++++++
>  profiles/audio/media.c | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 60f8cbf..b22f2fe 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -673,6 +673,9 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>                 pdu->params[size++] = attr;
>                 pdu->params[size++] = val;
>                 break;
> +       case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> +               size = 1;
> +               break;
>         default:
>                 error("Unknown event %u", id);
>                 return;
> @@ -1490,6 +1493,9 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>                 }
>
>                 break;
> +       case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> +               len = 1;
> +               break;
>         case AVRCP_EVENT_VOLUME_CHANGED:
>                 pdu->params[1] = media_transport_get_device_volume(dev);
>                 if (pdu->params[1] > 127)
> @@ -3435,6 +3441,7 @@ static void target_init(struct avrcp *session)
>                                 (1 << AVRCP_EVENT_TRACK_CHANGED) |
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_START) |
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
>                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
>         if (target->version < 0x0104)
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index ed441d0..83a9a10 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -988,6 +988,9 @@ static void media_player_remove(struct media_player *mp)
>  {
>         info("Player unregistered: sender=%s path=%s", mp->sender, mp->path);
>
> +       avrcp_player_event(mp->player,
> +                               AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
> +
>         media_player_destroy(mp);
>  }
>
> @@ -1799,6 +1802,9 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
>                 return btd_error_invalid_args(msg);
>         }
>
> +       avrcp_player_event(mp->player,
> +                               AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
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
