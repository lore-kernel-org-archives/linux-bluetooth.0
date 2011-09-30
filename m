Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317249357-1362-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317249357-1362-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1317249357-1362-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 30 Sep 2011 17:55:45 +0300
Message-ID: <CABBYNZLz13Ev27PgdJo3uqfM0PSGtNLWDiZE_zXgPUA4oKUCYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] AVRCP: fix case when only one setting is provided
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 29, 2011 at 1:35 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> If CT tries to change an Application Setting providing only one
> setting, the size of the PDU will be 3 bytes. Therefore we should check
> if the PDU is shorter than or equal 3, not only shorter.
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index e7b0d1b..ac9a107 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1021,7 +1021,7 @@ static uint8_t avrcp_handle_set_player_value(struct media_player *mp,
>        uint16_t len = ntohs(pdu->params_len);
>        unsigned int i;
>
> -       if (len < 3)
> +       if (len <= 3)
>                goto err;
>
>        len = 0;
> --
> 1.7.6.4
>
> --

Ack.


-- 
Luiz Augusto von Dentz
