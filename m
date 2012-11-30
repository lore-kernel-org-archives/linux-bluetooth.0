Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354274703-15604-4-git-send-email-szymon.janc@tieto.com>
References: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
	<1354274703-15604-4-git-send-email-szymon.janc@tieto.com>
Date: Fri, 30 Nov 2012 07:49:45 -0400
Message-ID: <CAJdJm_OwR=tpUcZiRuyKQSSZTje1iqALJhERoApUYmqtR80Vuw@mail.gmail.com>
Subject: Re: [PATCH 4/8] hog: Fix memory leak in suspend-dummy
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Nov 30, 2012 at 7:24 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> @@ -137,9 +133,9 @@ int suspend_init(suspend_event suspend, resume_event resume)
>
>  void suspend_exit(void)
>  {
> -       if (fifoio) {
> -               g_io_channel_shutdown(fifoio, FALSE, NULL);
> -               g_io_channel_unref(fifoio);
> +       if (watch) {

By convention, we try to use "if (watch > 0)" or "if (watch == 0)"
when checking whether watches are valid. In this case, "if (watch >
0)" is more appropriate.

> +               g_source_remove(watch);
> +               watch = 0;
>         }
>
>         remove(HOG_SUSPEND_FIFO);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
