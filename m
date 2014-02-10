Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 10 Feb 2014 14:16:09 +0200
Message-ID: <CABBYNZJq3wWht-Jk7BP=dkEnsTG2o8fXiF8JycJr_prMvQe0NA@mail.gmail.com>
Subject: Re: [PATCH 1/4] android/haltest: Remove unneeded assignment
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 7, 2014 at 2:11 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  android/client/if-audio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/android/client/if-audio.c b/android/client/if-audio.c
> index 8c640a1..5ab11a6 100644
> --- a/android/client/if-audio.c
> +++ b/android/client/if-audio.c
> @@ -225,10 +225,8 @@ static void *playback_thread(void *data)
>                 pthread_mutex_unlock(&outstream_mutex);
>         } while (len && w_len > 0);
>
> -       if (in) {
> +       if (in)
>                 fclose(in);
> -               in = NULL;
> -       }
>
>         pthread_cleanup_pop(1);
>         return NULL;
> --
> 1.8.3.2

Pushed, note that I did move the changes from audio to android since
the audio code will be dropped as it is not unit tested.


-- 
Luiz Augusto von Dentz
