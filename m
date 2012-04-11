Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334135558-21866-3-git-send-email-michal.labedzki@tieto.com>
References: <1334135558-21866-1-git-send-email-michal.labedzki@tieto.com>
	<1334135558-21866-3-git-send-email-michal.labedzki@tieto.com>
Date: Wed, 11 Apr 2012 14:14:36 +0300
Message-ID: <CABBYNZJPsS5MdJHnwV_5k6MZJaOjTtriYUjkLLDWj3OsfhO5ZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] AVRCP: Remove unused field in player structure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Apr 11, 2012 at 12:12 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Remove unused "audio_device" field in player structure.
> ---
>  audio/avrcp.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index d456023..f0c9665 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -146,7 +146,6 @@ struct pending_pdu {
>  struct avrcp_player {
>        struct avrcp_server *server;
>        struct avctp *session;
> -       struct audio_device *dev;
>
>        unsigned int handler;
>        uint16_t registered_events;
> --
> on behalf of ST-Ericsson
>

Instead of removing it we can make use of it to set which device is
addressing the player which is going to be useful when implementing
1.4.

-- 
Luiz Augusto von Dentz
