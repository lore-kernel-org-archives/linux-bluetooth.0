Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1385569154-11579-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385569154-11579-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1385569154-11579-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 27 Nov 2013 22:25:37 +0200
Message-ID: <CAMXE1-qwE-hv96x1e3VB+R+4x+G6PhVMpMgH+KB-Wvmt9fYYiQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] android/main: Remove signal source on exit
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Bluetooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 27, 2013 at 6:19 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Remove signal source on exit and move check capability function in order
> to avoid extra check.
> ---
>  android/main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/android/main.c b/android/main.c
> index dd5c622..e408c21 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -536,6 +536,9 @@ int main(int argc, char *argv[])
>         GError *err = NULL;
>         guint signal;
>
> +       if (!set_capabilities())
> +               return EXIT_FAILURE;
> +

Please disregard this patch, debug needs to be initialized first.

>         /* Core Service (ID=0) should always be considered registered */
>         services[0] = true;
>
> @@ -565,18 +568,17 @@ int main(int argc, char *argv[])
>
>         __btd_log_init("*", 0);
>
> -       if (!set_capabilities())
> -               return EXIT_FAILURE;
> -
>         bluetooth_start_timeout = g_timeout_add_seconds(STARTUP_GRACE_SECONDS,
>                                                         quit_eventloop, NULL);
>         if (bluetooth_start_timeout == 0) {
>                 error("Failed to init startup timeout");
> +               g_source_remove(signal);
>                 return EXIT_FAILURE;
>         }
>
>         if (!bt_bluetooth_start(option_index, adapter_ready)) {
>                 g_source_remove(bluetooth_start_timeout);
> +               g_source_remove(signal);
>                 return EXIT_FAILURE;
>         }
>
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
