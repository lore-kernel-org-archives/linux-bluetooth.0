Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1480272696-3760-1-git-send-email-loic.poulain@gmail.com>
References: <1480272696-3760-1-git-send-email-loic.poulain@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Nov 2016 14:35:10 +0200
Message-ID: <CABBYNZJ=tYaa-Gd3AvxoM7smFkZXWv=SwrOnLvGSaDsYDw064w@mail.gmail.com>
Subject: Re: [PATCH] shared/mainloop: Fix msec to nsec conversion in timerfd config
To: Loic Poulain <loic.poulain@gmail.com>
Cc: Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Sun, Nov 27, 2016 at 8:51 PM, Loic Poulain <loic.poulain@gmail.com> wrote:
> ---
>  src/shared/mainloop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
> index 9fff615..eacb6a4 100644
> --- a/src/shared/mainloop.c
> +++ b/src/shared/mainloop.c
> @@ -311,7 +311,7 @@ static inline int timeout_set(int fd, unsigned int msec)
>         itimer.it_interval.tv_sec = 0;
>         itimer.it_interval.tv_nsec = 0;
>         itimer.it_value.tv_sec = sec;
> -       itimer.it_value.tv_nsec = (msec - (sec * 1000)) * 1000;
> +       itimer.it_value.tv_nsec = (msec - (sec * 1000)) * 1000 * 1000;
>
>         return timerfd_settime(fd, 0, &itimer, NULL);
>  }
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
