Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 25 May 2012 13:17:44 -0300
Message-ID: <CAMOw1v4vOkUM_2U22w3qd1uYT_7x8gCWPCZj5xAE3_Mvt5ONnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] AVRCP: Fix initializing volume before checking
 PDU type
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 25, 2012 at 12:02 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Response may be rejected or not implemented so the operand used to
> initialize the variable may not even exist.
> ---
>  audio/avrcp.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 87a785b..2f96f27 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1145,12 +1145,14 @@ static gboolean avrcp_handle_volume_changed(struct avctp *session,
>  {
>        struct avrcp_player *player = user_data;
>        struct avrcp_header *pdu = (void *) operands;
> -       uint8_t abs_volume = pdu->params[1] & 0x7F;
> +       uint8_t volume;
>
>        if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
>                return FALSE;
>
> -       player->cb->set_volume(abs_volume, player->dev, player->user_data);
> +       volume = pdu->params[1] & 0x7F;
> +
> +       player->cb->set_volume(volume, player->dev, player->user_data);

Ack.

Lucas De Marchi
