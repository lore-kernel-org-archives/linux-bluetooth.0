Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318250231-14001-7-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318250231-14001-7-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 11 Oct 2011 13:12:42 +0300
Message-ID: <CABBYNZJpmRwt3N68zNfJo3hxk7bJvVOnub15Owq6_jZUh+4DyA@mail.gmail.com>
Subject: Re: [PATCH 7/7] AVRCP: fix off-by-one in media attribute iteration
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
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 0d9b6d0..3576008 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -603,7 +603,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
>        nattr = pdu->params[8];
>
>        if (!nattr) {
> -               for (i = 1; i < AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
> +               for (i = 1; i <= AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
>                        size = player_get_media_attribute(player, i,
>                                                        &pdu->params[pos],
>                                                        AVRCP_PDU_MTU - pos);
> --
> 1.7.7

What if we have a new callback to list the available metadata in the
media player and then iterate in that list, this way we don't have to
lookup for everything instead we use g_hash_table_get_keys and just
lookup for existing ones.

-- 
Luiz Augusto von Dentz
