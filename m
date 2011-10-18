Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318883671-10932-4-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318883671-10932-4-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 18 Oct 2011 10:23:22 +0300
Message-ID: <CABBYNZ+3idRm2UoXLeheg+zKjeZqpSiXep_m4dLWJoNLs+stHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] AVRCP: respond with UINT32_MAX if duration is not available
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Oct 17, 2011 at 11:34 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Section 5.4.1 of AVRCP 1.3 spec says:
>
>        If TG does not support SongLength And SongPosition on TG, then TG shall
>        return 0xFFFFFFFF.
>
> SongPosition is always available, but song length depends on user to
> provied it.
> ---
>  audio/avrcp.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index b1c3d54..5f8277c 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -796,6 +796,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>        uint16_t len = ntohs(pdu->params_len);
>        uint32_t position;
>        uint32_t duration;
> +       void *pduration;
>
>        if (len != 0) {
>                pdu->params_len = htons(1);
> @@ -804,11 +805,13 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>        }
>
>        position = player->cb->get_position(player->user_data);
> -       duration = GPOINTER_TO_UINT(player->cb->get_metadata(
> -                                               AVRCP_MEDIA_ATTRIBUTE_DURATION,
> -                                               player->user_data));
> +       pduration = player->cb->get_metadata(AVRCP_MEDIA_ATTRIBUTE_DURATION,
> +                                                       player->user_data);
> +       if (pduration != NULL)
> +               duration = htonl(GPOINTER_TO_UINT(pduration));
> +       else
> +               duration = htonl(UINT32_MAX);
>
> -       duration = htonl(duration);
>        position = htonl(position);
>
>        memcpy(&pdu->params[0], &duration, 4);
> --
> 1.7.7
>
> --

Ack.

-- 
Luiz Augusto von Dentz
