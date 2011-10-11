Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318250231-14001-5-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318250231-14001-5-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 11 Oct 2011 12:54:47 +0300
Message-ID: <CABBYNZJNng4NZ6r0xkQnom_-MpF+dmOrnAr0Jcrhw=V3GhfD4w@mail.gmail.com>
Subject: Re: [PATCH 5/7] Move debug messages to their correspondent getters
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
>  audio/avrcp.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 058fa83..ea175e3 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -474,9 +474,15 @@ static int player_set_attribute(struct avrcp_player *player,
>
>  static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
>  {
> -       DBG("Get attribute: %u", attr);
> +       int value;
>
> -       return player->cb->get_setting(attr, player->user_data);
> +       DBG("attr %u", attr);
> +
> +       value = player->cb->get_setting(attr, player->user_data);
> +       if (value < 0)
> +               DBG("attr %u not supported by player", attr);
> +
> +       return value;
>  }
>
>  static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
> @@ -535,10 +541,8 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp_player *player,
>                goto done;
>
>        for (i = 1; i <= AVRCP_ATTRIBUTE_SCAN; i++) {
> -               if (player_get_attribute(player, i) < 0) {
> -                       DBG("Ignoring setting %u: not supported by player", i);
> +               if (player_get_attribute(player, i) < 0)
>                        continue;
> -               }
>
>                len++;
>                pdu->params[len] = i;
> @@ -677,11 +681,8 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp_player *player
>                }
>
>                val = player_get_attribute(player, settings[i]);
> -               if (val < 0) {
> -                       DBG("Ignoring %u: not supported by player",
> -                                                               settings[i]);
> +               if (val < 0)
>                        continue;
> -               }
>
>                pdu->params[++len] = settings[i];
>                pdu->params[++len] = val;
> --
> 1.7.7

Ack.

-- 
Luiz Augusto von Dentz
