Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318250231-14001-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318250231-14001-3-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 11 Oct 2011 12:47:26 +0300
Message-ID: <CABBYNZKxk9F4hS8w1WgaO1vt9C2Be8DVjvLwQkW8Mrn2eX05ug@mail.gmail.com>
Subject: Re: [PATCH 3/7] Remove left over comment
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Oct 10, 2011 at 3:37 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Since "138f831 AVRCP: return empty string instead of rejecting" we
> return empty strings for all the attributes when there isn't any value
> set.
> ---
>  audio/avrcp.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index c36af5d..058fa83 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -600,10 +600,6 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
>        nattr = pdu->params[8];
>
>        if (!nattr) {
> -               /*
> -                * Return all available information, at least
> -                * title must be returned.
> -                */
>                for (i = 1; i < AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
>                        size = player_get_media_attribute(player, i,
>                                                        &pdu->params[pos],
> --
> 1.7.7

Ack.


-- 
Luiz Augusto von Dentz
