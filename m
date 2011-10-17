Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318627712-9725-4-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318627712-9725-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318627712-9725-4-git-send-email-lucas.demarchi@profusion.mobi>
Date: Mon, 17 Oct 2011 10:57:26 +0300
Message-ID: <CABBYNZJvjGxp4M8ZQrmFwDc4FMqsjm7w8mh7Sb9BwFTQuQ7jJQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] AVRCP: respond with UINT32_MAX if duration is not available
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Sat, Oct 15, 2011 at 12:28 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Section 5.4.1 of AVRCP 1.3 spec says:
>
>        If TG does not support SongLength And SongPosition on TG, then TG shall
>        return 0xFFFFFFFF.
>
> SongPosition is always available, but song length depends on user to
> provied it.
> ---
>  audio/avrcp.c     |    2 +-
>  doc/media-api.txt |    4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 8b48e83..1b55e33 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -808,7 +808,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>                                                AVRCP_MEDIA_ATTRIBUTE_DURATION,
>                                                player->user_data));
>
> -       duration = htonl(duration);
> +       duration = duration ? htonl(duration) : UINT32_MAX;
>        position = htonl(position);

I would prefer doing this on RegisterPlayer/parse_player_metadata as
we do with title, so if is not present then we set UINT32_MAX.

>        memcpy(&pdu->params[0], &duration, 4);
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index b8dcdbd..204f33e 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -114,7 +114,9 @@ Methods             void RegisterEndpoint(object endpoint, dict properties)
>
>                                uint32 Duration:
>
> -                                       Track duration in milliseconds
> +                                       Track duration in milliseconds. If it's
> +                                       set to 0 or left blank, it will be
> +                                       treated as not available.

0 might be a valid duration so I would just treat as not available if
Duration is not part of the metadata or if the value is actually
UINT32_MAX which can happen if the duration exceeds 32 bits.


-- 
Luiz Augusto von Dentz
