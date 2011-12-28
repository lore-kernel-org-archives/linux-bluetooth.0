Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325054785-15073-1-git-send-email-chethan.tn@samsung.com>
References: <1325054785-15073-1-git-send-email-chethan.tn@samsung.com>
Date: Wed, 28 Dec 2011 11:22:10 +0200
Message-ID: <CABBYNZLnkW6BkeqmQbgbdV5SARqPYhvKL2SM1Yd19740icT2og@mail.gmail.com>
Subject: Re: [PATCH] audio: Fix headset crash
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chethan T N <chethan.tn@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chethan,

On Wed, Dec 28, 2011 at 8:46 AM, Chethan T N <chethan.tn@samsung.com> wrote:
> Original patch by Chan-yeol Park <chanyeol.park@samsung.com>
>
> Once the headset struct is freed, rfcomm_io_cb would be called and
> it might lead to a crash. So when g_io_shutdown rfcomm channel,
> additionally we remove g_io_add_watch() source id handle to avoid
> unwanted call. And even though rfcomm_io_cb is called and in case
> that struct headset is NULL, rfcomm_io_cb would return with FALSE.

I don't think this is true, iirc this will lead to G_IO_NVAL which is
handled in rfcomm_io_cb, so there might be a bug somewhere else if the
callback is still called after headset_close_rfcomm and the condition
is not G_IO_NVAL. Btw it is a good practice to add the backtrace of
the crash you are fixing.

Now holding the source id is probably a good idea since it reduces the
extra call to the callback while disconnecting.

>  audio/headset.c |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/audio/headset.c b/audio/headset.c
> index 6aef6a8..77883d2 100644
> --- a/audio/headset.c
> +++ b/audio/headset.c
> @@ -165,6 +165,7 @@ struct headset {
>        gboolean auto_dc;
>
>        guint dc_timer;
> +       guint rfcomm_io_id;
>
>        gboolean hfp_active;
>        gboolean search_hfp;
> @@ -1280,6 +1281,9 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
>                return FALSE;
>
>        hs = device->headset;
> +       if (!hs)
> +               return FALSE;
> +

That is another evidence that there is something else broken, the
callback should not be called after its gsource is removed, so this
prevent the crash but masquerade the real issue.


-- 
Luiz Augusto von Dentz
