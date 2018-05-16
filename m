Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180509110553.28989-1-grzegorz.kolodziejczyk@codecoup.pl> <20180509110553.28989-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180509110553.28989-3-grzegorz.kolodziejczyk@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 May 2018 10:16:19 +0300
Message-ID: <CABBYNZLO+1=tcqqsdF+Y2Yf7qROGmC-dPAek47N=z5nQFYfP9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] doc/gatt-api: Add authorization options for attributes
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,
On Wed, May 9, 2018 at 2:08 PM Grzegorz Kolodziejczyk <
grzegorz.kolodziejczyk@codecoup.pl> wrote:

> This patch adds authorization property for attributes and prepare write
> request for authorization option for write request. This is require to
> handle correctly prepare writes, which may response with insufficient
> authorization error.
> ---
>   doc/gatt-api.txt | 9 +++++++++
>   1 file changed, 9 insertions(+)

> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 0f1cc9029..7d2517ccc 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -85,6 +85,8 @@ Methods               array{byte} ReadValue(dict
options)
>                          Possible options: "offset": Start offset
>                                            "device": Device path (Server
only)
>                                            "link": Link type (Server only)
> +                                         "prep-authz-req": boolean Is
prepare write
> +                                                           authorization
request

I'd keep it simple and just call it authorize.

>                          Possible Errors: org.bluez.Error.Failed
>                                           org.bluez.Error.InProgress
> @@ -251,6 +253,11 @@ Properties string UUID [read-only]
>                                  "secure-read" (Server only)
>                                  "secure-write" (Server only)

> +               boolean Authorize [read-only, optional] (Server only)
> +
> +                       True, if authorization is required for attribute
> +                       operations.

We should probably mention the default is false if the property is not
available.

>   Characteristic Descriptors hierarchy
>   ====================================

> @@ -284,6 +291,8 @@ Methods             array{byte} ReadValue(dict flags)
>                          Possible options: "offset": Start offset
>                                            "device": Device path (Server
only)
>                                            "link": Link type (Server only)
> +                                         "prep-authz-req": boolean Is
prepare write
> +                                                           authorization
request

Do we need and authorize flag for read? I thought this was only for prepare
write.

>                          Possible Errors: org.bluez.Error.Failed
>                                           org.bluez.Error.InProgress
> --
> 2.13.6

> --
> To unsubscribe from this list: send the line "unsubscribe
linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
