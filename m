Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com>
References: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Sep 2016 12:46:41 +0300
Message-ID: <CABBYNZJ08sBdsGRzi7QTrzGDgf1XWymv9OSiuCXA58qc=vZEVA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/device: Fix attempting to connect to
 random address over BR/EDR
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 2, 2016 at 3:49 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> BR/EDR don't have the concept of random addresses so the only option is
> to over LE in that case.
> ---
>  src/device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index fb766d1..b8556f1 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1748,6 +1748,10 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
>         else if (!dev->bredr_state.bonded && dev->le_state.bonded)
>                 return dev->bdaddr_type;
>
> +       /* If the address is private it can only be connected over LE */
> +       if (device_address_is_private(dev))
> +               return dev->bdaddr_type;
> +
>         if (dev->bredr_seen) {
>                 bredr_last = current - dev->bredr_seen;
>                 if (bredr_last > SEEN_TRESHHOLD)
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
