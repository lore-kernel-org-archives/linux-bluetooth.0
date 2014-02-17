Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 17 Feb 2014 14:01:38 +0200
Message-ID: <CABBYNZ+4Fiii937Y2Sa+zUaO7wb4bzPnuAdv=d5VoR+mQnJRjw@mail.gmail.com>
Subject: Re: [PATCH] health: Fix HealthDevice dbus registration
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Sat, Feb 8, 2014 at 12:27 AM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> For some reason, HealthDevice property table wasn't been registered.
> ---
>  profiles/health/hdp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
> index 622d95b..48dad52 100644
> --- a/profiles/health/hdp.c
> +++ b/profiles/health/hdp.c
> @@ -2145,7 +2145,8 @@ static struct hdp_device *create_health_device(struct btd_device *device)
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         path, HEALTH_DEVICE,
>                                         health_device_methods,
> -                                       health_device_signals, NULL,
> +                                       health_device_signals,
> +                                       health_device_properties,
>                                         dev, health_device_destroy)) {
>                 error("D-Bus failed to register %s interface", HEALTH_DEVICE);
>                 goto fail;
> --
> 1.8.5.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
