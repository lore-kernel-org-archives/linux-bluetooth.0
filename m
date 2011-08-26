Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Aug 2011 14:50:54 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Burt Silverman <burtms@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Printing errors returned from dbus_error_is_set()
Message-ID: <20110826175053.GA18683@samus.indt.org>
References: <CAP0-SexLdcFXGL1qwwho4CPN80nPwUXXBUJj7xXrVe_SMr4dow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP0-SexLdcFXGL1qwwho4CPN80nPwUXXBUJj7xXrVe_SMr4dow@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Burt,

On 13:38 Fri 26 Aug, Burt Silverman wrote:
> Here is a patch for connect_dbus() in src/main.c that follows the
> usage suggested by the dbus package. This was very important for me
> when I accidentally moved a configuration file
> /etc/bluetooth/main.conf. Most other places in bluetooth handle the
> error correctly.
> 
> From dbus/dbus/dbus-errors.c:
>  * In essence D-Bus error reporting works as follows:
>  *
>  * @code
>  * DBusError error;
>  * dbus_error_init (&error);
>  * dbus_some_function (arg1, arg2, &error);
>  * if (dbus_error_is_set (&error))
>  *   {
>  *     fprintf (stderr, "an error occurred: %s\n", error.message);
>  *     dbus_error_free (&error);
>  *   }
>  * @endcode
> 
> Here's the patch:
> diff --git a/src/main.c b/src/main.c
> index 7fecc5a..db78da8 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -311,6 +311,7 @@ static int connect_dbus(void)
>         conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
>         if (!conn) {
>                 if (dbus_error_is_set(&err)) {
> +                       fprintf(stderr, "an error occurred: %s\n", err.message);

The patch looks good, you just may want to use g_printerr() instead.

>                         dbus_error_free(&err);
>                         return -EIO;
>                 }
> 
> Is this the correct place to send the patch?

Yes, this is the correct place. Just send a properly formatted patch,
the easiest way is using git format-patch and git send-email.

> 
> Thank you,
> Burt Silverman
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
