Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171030125925.17784-1-luiz.dentz@gmail.com>
References: <20171030125925.17784-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Nov 2017 14:09:11 +0200
Message-ID: <CABBYNZ+HjBixUo4zkpEfRFcXHgriOuQvN3fTjA6jkrxkx7Sdtw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] doc/gatt-api: Add link option
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 30, 2017 at 2:59 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds link option to ReadValue and WriteValue so the application
> can determine which bearer the request is coming from.
> ---
>  doc/gatt-api.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 400470631..8a367783c 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -264,6 +264,7 @@ Methods             array{byte} ReadValue(dict flags)
>
>                         Possible options: "offset": Start offset
>                                           "device": Device path (Server only)
> +                                         "link": Link type (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
>                                          org.bluez.Error.InProgress
> @@ -278,6 +279,7 @@ Methods             array{byte} ReadValue(dict flags)
>
>                         Possible options: "offset": Start offset
>                                           "device": Device path (Server only)
> +                                         "link": Link type (Server only)
>
>                         Possible Errors: org.bluez.Error.Failed
>                                          org.bluez.Error.InProgress
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz
