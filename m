Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318250231-14001-6-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318250231-14001-6-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 11 Oct 2011 12:55:09 +0300
Message-ID: <CABBYNZJOmC2LgabvzT+Qz_xL5BKsUrcz2TTALjpypQWJSBmRpA@mail.gmail.com>
Subject: Re: [PATCH 6/7] AVRCP: Do not list values for unsupported attributes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Oct 10, 2011 at 3:37 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avrcp.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index ea175e3..0d9b6d0 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -565,11 +565,10 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp_player *player,
>        if (len != 1 || !player)
>                goto err;
>
> -       len = attr_get_max_val(pdu->params[0]);
> -       if (!len) {
> -               error("Attribute is invalid: %u", pdu->params[0]);
> +       if (player_get_attribute(player, pdu->params[0]) < 0)
>                goto err;
> -       }
> +
> +       len = attr_get_max_val(pdu->params[0]);
>
>        for (i = 1; i <= len; i++)
>                pdu->params[i] = i;
> --
> 1.7.7

Ack.

-- 
Luiz Augusto von Dentz
