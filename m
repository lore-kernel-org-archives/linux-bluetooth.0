Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <zwvZX5AOgP4GvmJFQHUWMoqsFDMz7RVyW7rbyd54IxZ88ITxAgI3nIei-QvtRsT6AafMiNl9JbKgdYxftG_TY4hns3GEhmvhQXXWMK3ZFUE=@krauser.org>
References: <zwvZX5AOgP4GvmJFQHUWMoqsFDMz7RVyW7rbyd54IxZ88ITxAgI3nIei-QvtRsT6AafMiNl9JbKgdYxftG_TY4hns3GEhmvhQXXWMK3ZFUE=@krauser.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Jul 2018 17:21:59 +0300
Message-ID: <CABBYNZ+nOdHuYPYm9CQ_uPnK1J-mP_UHg7uvNKs=ypTnq4uStA@mail.gmail.com>
Subject: Re: [PATCH v3 BlueZ 2/4] doc: provide MTU on GATT value reads and writes
To: David Krauser <david@krauser.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sun, Jul 8, 2018 at 5:09 AM, David Krauser <david@krauser.org> wrote:
> ---
>  doc/gatt-api.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 2a8da75b0..ff4bc333a 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -68,6 +68,7 @@ Methods               array{byte} ReadValue(dict options)
>                         operation was successful.
>
>                         Possible options: "offset": uint16 offset
> +                                         "mtu": Exchanged MTU (Server only)
>                                           "device": Object Device (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
> @@ -83,6 +84,7 @@ Methods               array{byte} ReadValue(dict options)
>                         characteristic.
>
>                         Possible options: "offset": Start offset
> +                                         "mtu": Exchanged MTU (Server only)
>                                           "device": Device path (Server only)
>                                           "link": Link type (Server only)
>                                           "prepare-authorize": boolean Is prepare
> @@ -120,7 +122,9 @@ Methods             array{byte} ReadValue(dict options)
>                         reconnections as the MTU has to be renegotiated.
>
>                         Possible options: "device": Object Device (Server only)
> -                                         "MTU": Exchanged MTU (Server only)
> +                                         "mtu": Exchanged MTU (Server only)
> +                                         "MTU": Exchanged MTU (Deprecated,
> +                                                               Server only)
>                                           "link": Link type (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
> @@ -156,7 +160,9 @@ Methods             array{byte} ReadValue(dict options)
>                         reconnections as the MTU has to be renegotiated.
>
>                         Possible options: "device": Object Device (Server only)
> -                                         "MTU": Exchanged MTU (Server only)
> +                                         "mtu": Exchanged MTU (Server only)
> +                                         "MTU": Exchanged MTU (Deprecated,
> +                                                               Server only)

Id just changed these to mtu since these APIs were introduced recently
I don't think there would be a problem, besides it should be possible
to handle this in the client by just ignoring the casing.

>                                           "link": Link type (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
