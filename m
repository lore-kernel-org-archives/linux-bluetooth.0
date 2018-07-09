Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7IJfxPVAI3OFibEao3WDjPS2j0dCVLH6IigW0Q6Xob_jViEwzBNQts9kf3ekqRt_Q6cTloeu6C8GLSuwBnGiRfGIoXmSKj5IEAEt1PTAMpM=@krauser.org>
References: <7IJfxPVAI3OFibEao3WDjPS2j0dCVLH6IigW0Q6Xob_jViEwzBNQts9kf3ekqRt_Q6cTloeu6C8GLSuwBnGiRfGIoXmSKj5IEAEt1PTAMpM=@krauser.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Jul 2018 17:24:46 +0300
Message-ID: <CABBYNZLVCMT9cO=C6z3c2QJBjhQKhmzv_DENcZZji-iY0Gv5jw@mail.gmail.com>
Subject: Re: [PATCH v3 BlueZ 4/4] src: rename MinEncKeySize
To: David Krauser <david@krauser.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sun, Jul 8, 2018 at 5:11 AM, David Krauser <david@krauser.org> wrote:
> ---
>  src/main.c    | 16 +++++++++++++---
>  src/main.conf |  4 ++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index b70e6044b..060c2cc33 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -104,7 +104,8 @@ static const char *policy_options[] = {
>
>  static const char *gatt_options[] = {
>         "Cache",
> -       "MinEncKeySize",
> +       "MinEncKeySize", /* deprecated */

Afaik this was introduced just for testing purpose, so Id say we don't
need to deprecate just change it directly, we never really did
deprecation on the daemon options anyway.

> +       "MinEncryptionKeySize",
>         "DefaultLeMtu",
>         NULL
>  };
> @@ -411,12 +412,21 @@ static void parse_config(GKeyFile *config)
>         }
>
>         val = g_key_file_get_integer(config, "GATT",
> -                                               "MinEncKeySize", &err);
> +                                               "MinEncryptionKeySize", &err);
> +
> +       /* Retry with deprecated option on error. */
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +               val = g_key_file_get_integer(config, "GATT",
> +                                                       "MinEncKeySize", &err);
> +       }
> +
>         if (err) {
>                 DBG("%s", err->message);
>                 g_clear_error(&err);
>         } else {
> -               DBG("MinEncKeySize=%d", val);
> +               DBG("MinEncryptionKeySize=%d", val);
>
>                 if (val >=7 && val <= 16)
>                         main_opts.min_enc_key_size = val;
> diff --git a/src/main.conf b/src/main.conf
> index c503040a5..4b0ae757b 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -63,7 +63,7 @@
>  # Possible values: "off", "device", "network"
>  # "network" option not supported currently
>  # Defaults to "off"
> -# Privacy = off
> +#Privacy = off
>
>  [GATT]
>  # GATT attribute cache.
> @@ -80,7 +80,7 @@
>  # Minimum required Encryption Key Size for accessing secured characteristics.
>  # Possible values: 0 and 7-16. 0 means don't care.
>  # Defaults to 0
> -# MinEncKeySize = 0
> +#MinEncryptionKeySize = 0
>
>  # Default LE MTU size.
>  # Possible values: 23-517
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
