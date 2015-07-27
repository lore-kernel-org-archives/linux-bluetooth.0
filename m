Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1437736623-27428-1-git-send-email-bharat.panda@samsung.com>
References: <1437736623-27428-1-git-send-email-bharat.panda@samsung.com>
Date: Mon, 27 Jul 2015 14:05:14 +0300
Message-ID: <CABBYNZ+VBuuuZzEWatgHE0a9nx7cRdy6+i92gsf_Pf9_P=iXGw@mail.gmail.com>
Subject: Re: [PATCH v4] audio/avrcp: Handle Available Players Changed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Jul 24, 2015 at 2:17 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Add support to handle AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED
> notification.
> - Register notification for "Available Players Changed"
> - Send interim and final responses on change in available players.
>
> < ACL data: handle 70 flags 0x00 dlen 18
>     L2CAP(d): cid 0x0041 len 14 [psm 23]
>       AVCTP Control: Response : pt 0x00 transaction 13 pid 0x110e
>         AV/C: Changed: address 0x48 opcode 0x00
>           Subunit: Panel
>           Opcode: Vendor Dependent
>           Company ID: 0x001958
>           AVRCP: RegisterNotification: pt Single len 0x0001
>             EventID: 0x0a (EVENT_AVAILABLE_PLAYERS_CHANGED)
> ---
>  profiles/audio/avrcp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 60f8cbf..5e25cd3 100644
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
> @@ -3440,6 +3446,9 @@ static void target_init(struct avrcp *session)
>         if (target->version < 0x0104)
>                 return;
>
> +       session->supported_events |=
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
> +
>         /* Only check capabilities if controller is not supported */
>         if (session->controller == NULL)
>                 avrcp_get_capabilities(session);
> @@ -3719,6 +3728,9 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
>                 }
>         }
>
> +       avrcp_player_event(player,
> +                               AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
> +
>         return player;
>  }
>
> @@ -3742,6 +3754,8 @@ void avrcp_unregister_player(struct avrcp_player *player)
>         }
>
>         player_destroy(player);
> +       avrcp_player_event(player,
> +                               AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
>  }
>
>  static gboolean avrcp_handle_set_volume(struct avctp *conn,
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
