Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354280264-19036-7-git-send-email-szymon.janc@tieto.com>
References: <1354280264-19036-1-git-send-email-szymon.janc@tieto.com>
	<1354280264-19036-7-git-send-email-szymon.janc@tieto.com>
Date: Fri, 30 Nov 2012 09:22:09 -0400
Message-ID: <CAJdJm_Md2jo=nUUD=xj+bDCO0i4f3Wxr1U32DjsGgMq8ATCJ2w@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] adaptername: Refactor adaptername_init/exit to fix
 exit path
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Nov 30, 2012 at 8:57 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>         inot_fd = inotify_init();
>         if (inot_fd < 0) {
> -               error("Failed to setup inotify");
> -               return 0;
> +               int err = errno;
> +               error("Failed to setup inotify: %s (%d)", strerror(-err), -err);
> +               return -err;

Now it is broken :) By convention, "err" should be always negative, so use:

int err = -errno;

when printing the error, you need to make it positive, like above:

error("Failed to setup inotify: %s (%d)", strerror(-err), -err);

then when returning, use:

return err;

See other examples on the bluez code if you have doubts.

> @@ -290,30 +301,38 @@ static int adaptername_init(void)
>
>         watch_d = inotify_add_watch(inot_fd, MACHINE_INFO_DIR, mask);
>         if (watch_d < 0) {
> -               error("Failed to setup watch for '%s'", MACHINE_INFO_DIR);
> +               int err = errno;
> +               error("Failed to setup watch for '%s': %s (%d)",
> +                               MACHINE_INFO_DIR, strerror(-err), -err);
>                 close(inot_fd);
> -               return 0;
> +               return -err;
>         }

Same problem here, please fix. (you can send just a v3 of this patch,
it should not conflict with others).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
