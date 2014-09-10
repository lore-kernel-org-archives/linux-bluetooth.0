Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD9L4re8KghqVZYjZ3ZC_Jnh9V050kZrk5ySWsY9t3YVO2yt6g@mail.gmail.com>
References: <CAD9L4re8KghqVZYjZ3ZC_Jnh9V050kZrk5ySWsY9t3YVO2yt6g@mail.gmail.com>
Date: Wed, 10 Sep 2014 10:47:01 +0300
Message-ID: <CABBYNZK4Cx3bqxK7vC3WNzM9oWnPZEqYwCt1Qqmti0rOiejgOQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Create FIFO in /run instead of /tmp
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcos Marado <mindboosternoori@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcos,

On Tue, Sep 9, 2014 at 9:46 PM, Marcos Marado
<mindboosternoori@gmail.com> wrote:
> Hi there,
>
> This patch changes BlueZ to create its test FIFO on /run instead of /tmp , to
> make SELinux happy.

Could you please follow the guidelines included on HACKING, things
like 'Hi There' probably don't belong here, regarding the actual
explanation why we need this patch could you please explain why run is
better than tmp?

> ---
>
> diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
> index 542ae25..580213e 100644
> --- a/profiles/input/suspend-dummy.c
> +++ b/profiles/input/suspend-dummy.c
> @@ -40,7 +40,7 @@
>  #include "src/log.h"
>  #include "suspend.h"
>
> -#define HOG_SUSPEND_FIFO       "/tmp/hogsuspend"
> +#define HOG_SUSPEND_FIFO       "/run/hogsuspend"
>
>  static suspend_event suspend_cb = NULL;
>  static resume_event resume_cb = NULL;
>
> ---
>
> Best regards,
> --
> Marcos Marado
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
