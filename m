Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180726141723.20199-1-luiz.dentz@gmail.com>
References: <20180726141723.20199-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 1 Aug 2018 14:59:09 +0300
Message-ID: <CABBYNZK8aOhWk=eOf7muOmiTwEWMO7_LYHVNv8j0LS7wHrb8iw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] doc/adapter-api: Add Discoverable option to SetDiscoveryFilter
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 26, 2018 at 5:17 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables the client to set its discoverable setting while
> discovering which is very typical situation as usually the setings
> application would allow incoming pairing request while scanning, so
> this would reduce the number of calls setting Discoverable and
> DiscoverableTimeout and restoring after done with discovery.
> ---
>  doc/adapter-api.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index d14d0ca50..4791af2c7 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -113,6 +113,12 @@ Methods            void StartDiscovery()
>                                 generated for either ManufacturerData and
>                                 ServiceData everytime they are discovered.
>
> +                       bool Discoverable (Default: false)
> +
> +                               Make adapter discoverable while discovering,
> +                               if the adapter is already discoverable this
> +                               setting this filter won't do anything.
> +
>                         When discovery filter is set, Device objects will be
>                         created as new devices with matching criteria are
>                         discovered regardless of they are connectable or
> --
> 2.17.1

Applied.


-- 
Luiz Augusto von Dentz
