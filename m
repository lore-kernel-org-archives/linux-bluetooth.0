Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1401971470-29048-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401971470-29048-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 9 Jun 2014 16:31:13 +0300
Message-ID: <CABBYNZK7tU6TL+M2beds0VPDU6T5AEv-5L8b=_q+r2Y1T_vAWw@mail.gmail.com>
Subject: Re: [RFC] android/hal-audio: Fix leaving open socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jun 5, 2014 at 3:31 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> When getting out of the poll loop we shall close socket always.
> ---
>  android/hal-audio.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index bfc102f..439b583 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -1346,14 +1346,12 @@ static void *ipc_handler(void *data)
>                 /* Check if socket is still alive. Empty while loop.*/
>                 while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
>
> -               if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
> -                       info("Audio HAL: Socket closed");
> +               info("Audio HAL: Socket closed");
>
> -                       pthread_mutex_lock(&sk_mutex);
> -                       close(audio_sk);
> -                       audio_sk = -1;
> -                       pthread_mutex_unlock(&sk_mutex);
> -               }
> +               pthread_mutex_lock(&sk_mutex);
> +               close(audio_sk);
> +               audio_sk = -1;
> +               pthread_mutex_unlock(&sk_mutex);
>         }
>
>         /* audio_sk is closed at this point, just cleanup endpoints states */
> --
> 1.8.3.2

Im not quite sure what this does fix, I mean I do understand that the
if statement might not be required after all we have since we have
pfd.events = POLLHUP | POLLERR | POLLNVAL but removing it is not a fix
more a cleanup.


-- 
Luiz Augusto von Dentz
