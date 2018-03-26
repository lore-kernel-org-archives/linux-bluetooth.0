Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180323133703.12499-1-luiz.dentz@gmail.com>
References: <20180323133703.12499-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Mar 2018 16:20:51 +0300
Message-ID: <CABBYNZ+DGn9uV2TiuutQaj7GNERWLadt8a0s+zE+UyaN-P8vyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] doc/gatt-api: Update documentation regarding link option
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 23, 2018 at 3:37 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This reflects what the code has already doing so any server operation which
> requires the device option shall also get the link type as well.
> ---
>  doc/gatt-api.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 60a997cbf..0f1cc9029 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -84,6 +84,7 @@ Methods               array{byte} ReadValue(dict options)
>
>                         Possible options: "offset": Start offset
>                                           "device": Device path (Server only)
> +                                         "link": Link type (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
>                                          org.bluez.Error.InProgress
> @@ -117,6 +118,7 @@ Methods             array{byte} ReadValue(dict options)
>
>                         Possible options: "device": Object Device (Server only)
>                                           "MTU": Exchanged MTU (Server only)
> +                                         "link": Link type (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
>                                          org.bluez.Error.NotSupported
> @@ -152,6 +154,7 @@ Methods             array{byte} ReadValue(dict options)
>
>                         Possible options: "device": Object Device (Server only)
>                                           "MTU": Exchanged MTU (Server only)
> +                                         "link": Link type (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
>                                          org.bluez.Error.NotSupported
> --
> 2.14.3

Applied.


-- 
Luiz Augusto von Dentz
