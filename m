Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 27 Feb 2015 16:27:45 +0200
Message-ID: <CABBYNZL0WT4izdNB7Wx0Ys32cyq4_G9g+TSS9HDvmjUd8dh41g@mail.gmail.com>
Subject: Re: [PATCH 1/4] audio/avdtp: Remove start timer on stream_free()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 26, 2015 at 5:20 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Makes code identical to android/avdtp
> ---
>  profiles/audio/avdtp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 896f101..15b611f 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -717,6 +717,9 @@ static void stream_free(void *data)
>         if (stream->timer)
>                 g_source_remove(stream->timer);
>
> +       if (stream->start_timer > 0)
> +               g_source_remove(stream->start_timer);
> +
>         if (stream->io)
>                 close_stream(stream);
>
> --
> 2.1.0

I will take a at this over the weekend, I hope I can make the move
without having to redo the patches otherwise the git history will be
lost e.g:

    android/AVDTP: Fix not removing start_timer source

    It is possible that stream->start_timer can be set on stream_free which
    should then should take care of remove it properly otherwise it can
    trigger which would very likely cause a crash.

    Thanks to Hannu Mallat <hannu.mallat@jolla.com> for reporting it.


-- 
Luiz Augusto von Dentz
