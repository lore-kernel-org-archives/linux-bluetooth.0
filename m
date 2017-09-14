Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170914234748.79584-3-yunhanw@google.com>
References: <20170914234748.79584-1-yunhanw@google.com> <20170914234748.79584-3-yunhanw@google.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Thu, 14 Sep 2017 16:52:36 -0700
Message-ID: <CALvjcs-K1m30XA8+dmg0-ncRjvLJZk-jSpp7P8mFc_WbrWNrqw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] doc/gatt-api: Add UpdateMTU and MTU
To: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Yunhan Wang <yunhanw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

In order to implement packet fragmentation/assembly in upper layer
application, may we get ATT MTU extraction API in peripheral/server
side? Basic idea is to get ATT mtu after MTU exchange complete and
write comes in. This patch is the draft implementation.

Thanks
Best wishes
Yunhan

On Thu, Sep 14, 2017 at 4:47 PM, Yunhan Wang <yunhanw@google.com> wrote:
> Add updateMTU in gatt method to get att mtu value in server side.
> Add MTU property in gatt property.
> ---
>  doc/gatt-api.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index cdd15f301..419308a7e 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -169,6 +169,13 @@ Methods            array{byte} ReadValue(dict options)
>
>                         Possible Errors: org.bluez.Error.Failed
>
> +               void UpdateMTU() [optional] (Server only)
> +
> +                       This method doesn't expect a reply so it is just
> +                       MTU value update in user space at server side.
> +
> +                       Possible Errors: org.bluez.Error.Failed
> +
>  Properties     string UUID [read-only]
>
>                         128-bit characteristic UUID.
> @@ -225,6 +232,10 @@ Properties string UUID [read-only]
>                                 "secure-read" (Server only)
>                                 "secure-write" (Server only)
>
> +               uint16_t MTU [read-only, optional]
> +
> +                       ATT MTU value
> +
>  Characteristic Descriptors hierarchy
>  ====================================
>
> --
> 2.14.1.690.gbb1197296e-goog
>
