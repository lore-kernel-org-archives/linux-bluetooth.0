Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317696960-1937-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317696960-1937-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Wed, 5 Oct 2011 18:30:04 +0300
Message-ID: <CABBYNZL4BHPPFUBc6rcnZT9UoO13zg2-9d-V=09BNavaKuQuog@mail.gmail.com>
Subject: Re: [PATCH] AVRCP: fix loop over number of application settings
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Oct 4, 2011 at 5:56 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>
> Hi, Luiz,
>
> I applied this patch on top of yours. If you are able to test the "set_player_value"
> at UPF, please apply this patch first.
>
>
> Regards,
>
>  audio/avrcp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index cfdb313..6969fac 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -719,6 +719,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>        if (len <= 3)
>                goto err;
>
> +       DBG("len %u", len);
>        len = 0;
>
>        /*
> @@ -728,13 +729,14 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>         * attribute is valid, we respond with no parameters. Otherwise an
>         * E_INVALID_PARAM is sent.
>         */
> -       for (i = 1; i < pdu->params[0]; i += 2) {
> +       for (i = 1; i < (2 * pdu->params[0] + 1U); i += 2) {
>                uint8_t attr = pdu->params[i];
>                uint8_t val = pdu->params[i + 1];
>
>                if (player_set_attribute(player, attr, val) < 0)
>                        continue;
>
> +               DBG("set attr %u val %u", attr, val);
>                len++;
>        }

Maybe we can have an auxiliary pointer to the current params, e.g.
uint8_t *param = &pdu->params[1] and then we increment the actual
pointer without messing around with i which is the number of
attributes.

-- 
Luiz Augusto von Dentz
