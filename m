Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394011361-9469-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394011361-9469-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1394011361-9469-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 5 Mar 2014 09:39:18 -0400
Message-ID: <CAJdJm_P0r4KgudNz=83PT4YD+EKOLNsFpF7qhhMNsDGVuJZRLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] monitor: Use miliseconds instead of seconds in the timeout
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Mar 5, 2014 at 5:22 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> -static inline int timeout_set(int fd, unsigned int seconds)
> +static inline int timeout_set(int fd, unsigned int msec)
>  {
>         struct itimerspec itimer;
> +       unsigned int sec = msec / 1000;
>
>         memset(&itimer, 0, sizeof(itimer));
>         itimer.it_interval.tv_sec = 0;
>         itimer.it_interval.tv_nsec = 0;
> -       itimer.it_value.tv_sec = seconds;
> -       itimer.it_value.tv_nsec = 0;
> +       itimer.it_value.tv_sec = sec;
> +       itimer.it_value.tv_nsec = (msec - (sec * 1000)) * 1000;

Would you not be multiplying by 1000000 (i.e. 10^6) instead?

Also, why not use:

itimer.it_value.tv_nsec = (msec % 1000) * 1000000;

>
>         return timerfd_settime(fd, 0, &itimer, NULL);
>  }

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
