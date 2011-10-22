Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319219908-2819-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1319219908-2819-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Sat, 22 Oct 2011 13:09:52 +0300
Message-ID: <CABBYNZ+1Jh_hpHhKF9rjK=kR_PjeZ6LUmrz0RA9EG3afBM27GQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] Add missing TRACK-REACHED-START event
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Oct 21, 2011 at 8:58 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> When track is changed, we automatically start to play it, therefore we
> need to notify CT regarding this event.
> ---
>  audio/media.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index a7647ea..ade2a4b 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1488,6 +1488,8 @@ static gboolean parse_player_metadata(struct media_player *mp,
>        uid = get_uid(mp);
>
>        avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &uid);
> +       avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_START,
> +                                                               NULL);
>
>        return TRUE;
>
> --
> 1.7.7

Ack.

-- 
Luiz Augusto von Dentz
