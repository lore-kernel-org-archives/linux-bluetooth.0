Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428001168-32822-13-git-send-email-jamuraa@chromium.org>
References: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
	<1428001168-32822-13-git-send-email-jamuraa@chromium.org>
Date: Thu, 2 Apr 2015 16:19:27 -0700
Message-ID: <CAHrH25R4KzZCQZg=1mTbgbUL5LepRjA_POCOi+Z6is+x0Zv59Q@mail.gmail.com>
Subject: Re: [BlueZ v9 12/12] core: Only start Advertising Manager when experimental
From: Arman Uguray <armansito@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> On Thu, Apr 2, 2015 at 11:59 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Check the experimental flag, there is no value in starting the
> Advertising Manager when there is no method for advertising.
>
> This also makes startup quieter when experimental is not set.
> ---
>  src/adapter.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index ccc67fc..7ffd302 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7334,16 +7334,14 @@ static int adapter_register(struct btd_adapter *adapter)
>                 return -EINVAL;
>         }
>
> -       /* Don't start advertising managers on non-LE controllers. */
> -       if (adapter->supported_settings & MGMT_SETTING_LE) {
> -               adapter->adv_manager = btd_advertising_manager_new(adapter);
> -
> -               /* LEAdvertisingManager1 is experimental so optional */
> -               if (!adapter->adv_manager)
> -                       error("Failed to register LEAdvertisingManager1 "
> -                                               "interface for adapter");
> -       } else {
> -               info("Not starting LEAdvertisingManager, LE not supported");
> +       if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {

I think this check for experimental is not necessary. I'd just
silently fail here here and perhaps just add a TODO saying that we
should log an error when this moves out of experimental. We probably
don't need to add a g_dbus_get_flags function just for this case.

> +               /* Don't start advertising managers on non-LE controllers. */
> +               if (adapter->supported_settings & MGMT_SETTING_LE) {
> +                       adapter->adv_manager =
> +                                       btd_advertising_manager_new(adapter);
> +               } else {
> +                       info("LEAdvertisingManager skipped, LE unavailable");
> +               }
>         }
>
>         db = btd_gatt_database_get_db(adapter->database);
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm going to test these patches and then probably apply patches 1-10
if nobody else objects. I can add the TODO to log error here myself
and perhaps just log DBG for now if we fail to create the manager.

Thanks,
Arman
