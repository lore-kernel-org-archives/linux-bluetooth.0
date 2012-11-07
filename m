Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352284442-6855-1-git-send-email-luiz.dentz@gmail.com>
References: <1352284442-6855-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 7 Nov 2012 12:15:53 -0200
Message-ID: <CAMOw1v6dSy9Nrswh3oYDncF7Dy1a9xpsSD4HLPwFQkdYWAnBjg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] AVRCP: Add supported events field to session structure
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 7, 2012 at 8:34 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This simplify detecting which events are available depending on the role
> and version of the session.
> ---
>  audio/avrcp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 3d9ecc7..ab9ffbf 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -197,6 +197,7 @@ struct avrcp {
>
>         unsigned int control_id;
>         unsigned int browsing_id;
> +       uint16_t supported_events;
>         uint16_t registered_events;
>         uint8_t transaction;
>         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
> @@ -858,12 +859,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
>
>                 return AVC_CTYPE_STABLE;
>         case CAP_EVENTS_SUPPORTED:
> -               pdu->params[1] = 5;
> -               pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
> -               pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
> -               pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
> -               pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
> -               pdu->params[6] = AVRCP_EVENT_SETTINGS_CHANGED;
> +               for (i = 0; i <= AVRCP_EVENT_LAST; i++) {
> +                       if (session->supported_events & (1 << i)) {
> +                               pdu->params[1]++;
> +                               pdu->params[pdu->params[1] + 1] = i;
> +                       }
> +               }
>
>                 pdu->params_len = htons(2 + pdu->params[1]);
>                 return AVC_CTYPE_STABLE;
> @@ -2064,6 +2065,11 @@ static void session_tg_init(struct avrcp *session)
>         }
>
>         session->control_handlers = tg_control_handlers;
> +       session->supported_events = (1 << AVRCP_EVENT_STATUS_CHANGED) |
> +                               (1 << AVRCP_EVENT_TRACK_CHANGED) |
> +                               (1 << AVRCP_EVENT_TRACK_REACHED_START) |
> +                               (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> +                               (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
>         if (session->version >= 0x0104) {
>                 avrcp_register_notification(session,
> --
> 1.7.11.7
>

Ack

Lucas De Marchi
