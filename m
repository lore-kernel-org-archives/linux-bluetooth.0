Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180516135538.7817-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180516135538.7817-1-grzegorz.kolodziejczyk@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 May 2018 12:44:22 +0300
Message-ID: <CABBYNZ+5jm-PM=bxsCzROaAR2MED9+NUrxvEsynbKb62jPZ-+w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/5] doc/gatt-api: Add authorization options for attributes
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wed, May 16, 2018 at 4:55 PM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> This patch adds authorization property for attributes and prepare write
> request for authorization option for write request. This is require to
> handle correctly prepare writes, which may response with insufficient
> authorization error.

I noticed there also a new error that we should document.

> ---
>  doc/gatt-api.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 0f1cc9029..7d8c427cd 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -85,6 +85,8 @@ Methods               array{byte} ReadValue(dict options)
>                         Possible options: "offset": Start offset
>                                           "device": Device path (Server only)
>                                           "link": Link type (Server only)
> +                                         "authorize": boolean Is authorization
> +                                                      request
>
>                         Possible Errors: org.bluez.Error.Failed
>                                          org.bluez.Error.InProgress
> @@ -251,6 +253,12 @@ Properties string UUID [read-only]
>                                 "secure-read" (Server only)
>                                 "secure-write" (Server only)
>
> +               boolean Authorize [read-only, optional] (Server only)
> +
> +                       True, if authorization is required for attribute
> +                       operations. By default this valuie is set to false for
> +                       attribute.
> +
>  Characteristic Descriptors hierarchy
>  ====================================
>
> @@ -284,6 +292,8 @@ Methods             array{byte} ReadValue(dict flags)
>                         Possible options: "offset": Start offset
>                                           "device": Device path (Server only)
>                                           "link": Link type (Server only)
> +                                         "authorize": boolean Is authorization
> +                                                      request
>
>                         Possible Errors: org.bluez.Error.Failed
>                                          org.bluez.Error.InProgress
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
