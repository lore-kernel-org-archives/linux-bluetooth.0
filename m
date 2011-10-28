Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319634146-1643-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319634146-1643-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 28 Oct 2011 10:34:46 +0300
Message-ID: <CABBYNZ+bFZwgNuvoNF_J+K9EQH9bDb=mXjtwjVbM-a=SwxRsKQ@mail.gmail.com>
Subject: Re: [PATCH] Fix check for PDU size
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 26, 2011 at 4:02 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Company ID became part of the avrcp header so its size is already
> accounted in the AVRCP_HEADER_LENGTH define.
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index f06afbf..879e959 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1053,7 +1053,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>        pdu->packet_type = 0;
>        pdu->rsvd = 0;
>
> -       if (operand_count + 3 < AVRCP_HEADER_LENGTH) {
> +       if (operand_count < AVRCP_HEADER_LENGTH) {
>                pdu->params[0] = E_INVALID_COMMAND;
>                goto err_metadata;
>        }
> --
> 1.7.7.1
>
> --

Ack.


-- 
Luiz Augusto von Dentz
