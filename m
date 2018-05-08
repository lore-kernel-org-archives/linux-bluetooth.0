Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
In-Reply-To: <20180507161403.14181-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 08 May 2018 07:40:58 +0000
Message-ID: <CABBYNZLSror-VgNZkL8MM_Vb+FKWrWqQ4OqgEWQcCO_+LE_Fbg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] doc/advertising-api: Add Flags property
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: david@flypig.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,
On Mon, May 7, 2018 at 7:14 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com>
wrote:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

> This adds Flags which the application can use in case it want to set
> it own flags.

> Note: This would allow for example an application to advertise as
> discoverable even if the adapter is not discoverable which may be
> required by dual-mode as it may not require BR/EDR to be discoverable.
> ---
>   doc/advertising-api.txt | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index eef98ad91..4e015f282 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -78,6 +78,21 @@ Properties   string Type
>                                  <Transport Discovery> <Organization
Flags...>
>                                  0x26                   0x01
0x01...

> +               array{byte} Flags [Experimental]
> +
> +                       Advertising Flags to include. When present this
will
> +                       override existing flags such as Discoverable.
> +
> +                       Note: This property shall not be set when Type is
set
> +                       to broadcast.
> +
> +                       Possible value:
> +                               bit 0 - LE Limited Discoverable Mode
> +                               bit 1 - LE General Discoverable Mode
> +                               bit 2 - BR/EDR Not Supported
> +                               bit 3 - Simultaneous LE and BR/EDR
(Controller)
> +                               bit 4 - Simultaneous LE and BR/EDR (Host)
> +
>                  array{string} Includes

>                          List of features to be included in the advertising
> --
> 2.14.3

Any feedback this set?


-- 
Luiz Augusto von Dentz
