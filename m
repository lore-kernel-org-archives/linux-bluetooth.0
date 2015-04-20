Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
References: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
Date: Mon, 20 Apr 2015 17:32:18 +0300
Message-ID: <CABBYNZJjNLoeF3Yc5n+f7W7V0pN5tXmek9GyHNNmZ36Vy4Nhjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc/device-api: Add TxPower
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Sat, Apr 18, 2015 at 4:09 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This adds TxPower from advertisement data.
>
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  doc/device-api.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 72c597e..875fd9d 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -196,6 +196,11 @@ Properties string Address [readonly]
>                         Received Signal Strength Indicator of the remote
>                         device (inquiry or advertising).
>
> +               int16 TxPower [readonly, optional]
> +
> +                       Advertised transmitted power level (inquiry or
> +                       advertising).
> +
>                 dict ManufacturerData [readonly, optional]
>
>                         Manufacturer specific advertisement data. Keys are
> --
> 2.2.0.rc0.207.ga3a616c

I thought we discussed about this before and we would like to have the
pathloss instead of TxPower, or do you have something else useful for
TxPower?


-- 
Luiz Augusto von Dentz
