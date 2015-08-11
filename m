Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1439204861-4716-2-git-send-email-bharat.panda@samsung.com>
References: <1439204861-4716-1-git-send-email-bharat.panda@samsung.com>
	<1439204861-4716-2-git-send-email-bharat.panda@samsung.com>
Date: Tue, 11 Aug 2015 11:35:06 +0300
Message-ID: <CABBYNZLs_kN7pu2Y0t0WoNTOGYcwOLNdOCijBLN886p7-oUPtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] audio/avrcp: Handle Addressed Player Changed event
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Mon, Aug 10, 2015 at 2:07 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Added AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED to TG supported events.
> Send response and notify on change in addressed player.
>
>       AVCTP Control: Response: type 0x00 label 12 PID 0x110e
>         AV/C: Interim: address 0x48 opcode 0x00
>           Subunit: Panel
>           Opcode: Vendor Dependent
>           Company ID: 0x001958
>           AVRCP: RegisterNotification pt Single len 0x0005
>             EventID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
>             PlayerID: 0x0000 (0)
>             UIDCounter: 0x0000 (0)
>
>       AVCTP Control: Response: type 0x00 label 3 PID 0x110e
>         AV/C: Interim: address 0x48 opcode 0x00
>           Subunit: Panel
>           Opcode: Vendor Dependent
>           Company ID: 0x001958
>           AVRCP: RegisterNotification pt Single len 0x0005
>             EventID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
>             PlayerID: 0x0002 (2)
>             UIDCounter: 0x0a8a (2698)
> ---
>  profiles/audio/avrcp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 003e978..596a866 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -676,6 +676,11 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>                 pdu->params[size++] = attr;
>                 pdu->params[size++] = val;
>                 break;
> +       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> +               size = 5;
> +               memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
> +               memcpy(&pdu->params[3], &player->uid_counter, sizeof(uint16_t));
> +               break;

As a TG we should complete the player specific events with reject and
error code set to addressed player changed as the spec states.

>         case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
>                 size = 1;
>                 break;
> @@ -1496,6 +1501,11 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>                 }
>
>                 break;
> +    case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> +               len = 5;
> +               memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
> +               memcpy(&pdu->params[3], &player->uid_counter, sizeof(uint16_t));
> +               break;
>         case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
>                 len = 1;
>                 break;
> @@ -3576,6 +3586,7 @@ static void target_init(struct avrcp *session)
>                 return;
>
>         session->supported_events |=
> +                               (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
>                                 (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
>
>         /* Only check capabilities if controller is not supported */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
