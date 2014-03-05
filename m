Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] monitor: Allow to modify epoll even events are the same
Date: Wed, 05 Mar 2014 14:24:25 +0100
Message-ID: <8771068.vOHNjRSlbZ@uw000953>
In-Reply-To: <1394011361-9469-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394011361-9469-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 05 of March 2014 10:22:37 Lukasz Rymanowski wrote:
> This is epsecially needed when we want to modify timer.
> ---
>  monitor/mainloop.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/monitor/mainloop.c b/monitor/mainloop.c
> index 8c94bfe..7f97e65 100644
> --- a/monitor/mainloop.c
> +++ b/monitor/mainloop.c
> @@ -222,9 +222,6 @@ int mainloop_modify_fd(int fd, uint32_t events)
>  	if (!data)
>  		return -ENXIO;
>  
> -	if (data->events == events)
> -		return 0;
> -
>  	memset(&ev, 0, sizeof(ev));
>  	ev.events = events;
>  	ev.data.ptr = data;
> 

All patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
