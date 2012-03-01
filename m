Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330613135-16552-3-git-send-email-michal.labedzki@tieto.com>
References: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
	<1330613135-16552-3-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 1 Mar 2012 17:43:47 +0200
Message-ID: <CABBYNZJJJ69YNrS6VU7ak_qBZJ6THgBm3VpkFNAC3KS-tyoBHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] avrcp: Treat position as unknown when duration is unavailable
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	vani.patel@stericsson.com, joohi.rastogi@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Mar 1, 2012 at 4:45 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> According to the specification when duration and position are not
> supported then 0xFFFFFFFF should be returned. This patch avoid random
> position on stream where duration is not available.

Again you should quote the spec. Btw is really random or 0?

> ---
>  audio/avrcp.c |   10 ++++++----
>  audio/media.c |    3 ++-
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 2d29d56..e141030 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -859,16 +859,18 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>                return AVC_CTYPE_REJECTED;
>        }
>
> -       position = player->cb->get_position(player->user_data);
>        pduration = player->cb->get_metadata(AVRCP_MEDIA_ATTRIBUTE_DURATION,
>                                                        player->user_data);
>
> -       if (pduration != NULL)
> +       if (pduration != NULL) {
>                duration = htonl(GPOINTER_TO_UINT(pduration));
> -       else
> +               position = htonl(player->cb->get_position(player->user_data));
> +       } else {
>                duration = htonl(UINT32_MAX);
> +               position = htonl(UINT32_MAX);
> +       }

So the position cannot be known without the duration? What about live streams?

-- 
Luiz Augusto von Dentz
