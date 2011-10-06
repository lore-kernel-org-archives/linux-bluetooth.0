Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317901785-1757-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317901785-1757-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 6 Oct 2011 15:19:40 +0300
Message-ID: <CABBYNZ+fBHNUARSxHnbNBt_y-WVk5KMoBhO=9EKKfdK-7EX+Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] AVRCP: fix loop over number of application settings
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 6, 2011 at 2:49 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avrcp.c |   13 +++++--------
>  1 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 96a0d36..c36af5d 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -715,12 +715,11 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        unsigned int i;
> +       uint8_t *param;
>
> -       if (len < 3)
> +       if (len < 3 || len > 2 * pdu->params[0] + 1U)
>                goto err;
>
> -       len = 0;
> -
>        /*
>         * From sec. 5.7 of AVRCP 1.3 spec, we should igore non-existent IDs
>         * and set the existent ones. Sec. 5.2.4 is not clear however how to
> @@ -728,11 +727,9 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>         * attribute is valid, we respond with no parameters. Otherwise an
>         * E_INVALID_PARAM is sent.
>         */
> -       for (i = 1; i <= pdu->params[0]; i += 2) {
> -               uint8_t attr = pdu->params[i];
> -               uint8_t val = pdu->params[i + 1];
> -
> -               if (player_set_attribute(player, attr, val) < 0)
> +       for (len = 0, i = 0, param = &pdu->params[1]; i < pdu->params[0];
> +                                                       i++, param += 2) {
> +               if (player_set_attribute(player, param[0], param[1]) < 0)
>                        continue;
>
>                len++;
> --
> 1.7.7

Ack.

-- 
Luiz Augusto von Dentz
