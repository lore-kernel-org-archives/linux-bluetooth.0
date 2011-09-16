Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316060497-4068-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1316060497-4068-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 16 Sep 2011 10:39:32 +0300
Message-ID: <CABBYNZ+5QGcUZMrLZzu1XYfiJOHGtFPtkirF6T0T2=K10fA6dg@mail.gmail.com>
Subject: Re: [PATCH 1/5] avrcp: fix missing error code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 15, 2011 at 7:21 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avrcp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index c9eae6e..9b1d797 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1228,8 +1228,10 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>        pdu->packet_type = 0;
>        pdu->rsvd = 0;
>
> -       if (operand_count + 3 < AVRCP_HEADER_LENGTH)
> +       if (operand_count + 3 < AVRCP_HEADER_LENGTH) {
> +               pdu->params[0] = E_INVALID_COMMAND;
>                goto err_metadata;
> +       }
>
>        for (handler = handlers; handler; handler++) {
>                if (handler->pdu_id == pdu->pdu_id)
> --
> 1.7.6.1
>
> --

Ack.

-- 
Luiz Augusto von Dentz
