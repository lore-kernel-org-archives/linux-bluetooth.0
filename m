Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354274703-15604-7-git-send-email-szymon.janc@tieto.com>
References: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
	<1354274703-15604-7-git-send-email-szymon.janc@tieto.com>
Date: Fri, 30 Nov 2012 07:58:20 -0400
Message-ID: <CAJdJm_MKChWHOiJK9F6LYQo36CsfivOtyD3H0K1eqwHigSqwRQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] adaptername: Refactor adaptername_init/exit to fix
 exit path
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ho Szymon,

On Fri, Nov 30, 2012 at 7:25 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> @@ -266,20 +265,33 @@ static struct btd_adapter_driver adaptername_driver = {
>         .probe  = adaptername_probe,
>  };
>
> -static int adaptername_init(void)
> +struct inotify_data
>  {

The opening "{" should be on the same line as "struct inotify_data".

> -       int err;
>         int inot_fd;
> -       guint32 mask;
> +       int watch_d;
> +};
>
> -       err = btd_register_adapter_driver(&adaptername_driver);
> -       if (err < 0)
> -               return err;
> +static void destroy_cb(gpointer user_data)
> +{
> +       struct inotify_data *data = user_data;
> +
> +       inotify_rm_watch(data->inot_fd, data->watch_d);
> +       g_free(data);
> +}
> +
> +static int adaptername_init(void)
> +{
> +       guint32 mask;
> +       GIOChannel *inotify;
> +       int inot_fd;
> +       int watch_d;
> +       struct inotify_data *data;
>
>         inot_fd = inotify_init();
>         if (inot_fd < 0) {
> -               error("Failed to setup inotify");
> -               return 0;
> +               int err = -errno;
> +               error("Failed to setup inotify (%d)", err);

We usually print errors this way:

error("Failed to setup inotify: %s (%d)", strerror(-err), -err);

> +               return err;
>         }
>
>         mask = IN_CLOSE_WRITE;
> @@ -290,30 +302,38 @@ static int adaptername_init(void)
>
>         watch_d = inotify_add_watch(inot_fd, MACHINE_INFO_DIR, mask);
>         if (watch_d < 0) {
> -               error("Failed to setup watch for '%s'", MACHINE_INFO_DIR);
> +               int err = -errno;
> +               error("Failed to setup watch for '%s' (%d)", MACHINE_INFO_DIR,
> +                                                                       err);

same here:

error("Failed to setup watch for '%s': %s (%d)", MACHINE_INFO_DIR,
strerror(-err), -err);

>                 close(inot_fd);
> -               return 0;
> +               return err;
>         }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
