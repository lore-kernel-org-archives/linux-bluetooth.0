Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1481118263-4518-1-git-send-email-loic.poulain@gmail.com>
References: <1481118263-4518-1-git-send-email-loic.poulain@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Dec 2016 17:11:42 +0200
Message-ID: <CABBYNZJFoURMqFrVd2o4gac=nqWaQMBwOf+pdeHcJR-ZB8bBTw@mail.gmail.com>
Subject: Re: [PATCH] shared/mainloop: Fix timeout data memleak
To: Loic Poulain <loic.poulain@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Wed, Dec 7, 2016 at 3:44 PM, Loic Poulain <loic.poulain@gmail.com> wrote:
> Valgrind reports "timeout_data" as definitely lost.
> Fix this issue in timeout_destroy function.
> ---
>  src/shared/mainloop.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
> index eacb6a4..09c46a7 100644
> --- a/src/shared/mainloop.c
> +++ b/src/shared/mainloop.c
> @@ -283,6 +283,8 @@ static void timeout_destroy(void *user_data)
>
>         if (data->destroy)
>                 data->destroy(data->user_data);
> +
> +       free(data);
>  }

Seems valid but can you add the backtrace, I wonder how we didn't spot
this before so perhaps the backtrace would explain it.

-- 
Luiz Augusto von Dentz
