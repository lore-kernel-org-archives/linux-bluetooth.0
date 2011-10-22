Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319219908-2819-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1319219908-2819-3-git-send-email-lucas.demarchi@profusion.mobi>
Date: Sat, 22 Oct 2011 13:10:21 +0300
Message-ID: <CABBYNZLj0BdT5guRXg53ORCM+=kfHeTiGSL-rJ1rQ2GpG5+x7w@mail.gmail.com>
Subject: Re: [PATCH 3/5] Fix leak of GTimer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Oct 21, 2011 at 8:58 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/media.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index ade2a4b..5528ada 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -885,6 +885,7 @@ static void media_player_free(gpointer data)
>        if (mp->settings)
>                g_hash_table_unref(mp->settings);
>
> +       g_timer_destroy(mp->timer);
>        g_free(mp->sender);
>        g_free(mp->path);
>        g_free(mp);
> --
> 1.7.7
>

Ack.

-- 
Luiz Augusto von Dentz
