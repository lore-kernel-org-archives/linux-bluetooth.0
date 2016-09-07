Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1473159891-11621-1-git-send-email-luiz.dentz@gmail.com>
References: <1473159891-11621-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Sep 2016 16:14:43 +0300
Message-ID: <CABBYNZJ9ujeP1X3FNv-NnjpTzQdVspZw0cDh=7J6LxqKwHjY3A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/device: Make it more clear random addresses
 can only be used with LE
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 6, 2016 at 2:04 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Any random address type can only be connected over LE as BR/EDR only
> support public addresses.
> ---
>  src/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index b8556f1..9586022 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1748,8 +1748,8 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
>         else if (!dev->bredr_state.bonded && dev->le_state.bonded)
>                 return dev->bdaddr_type;
>
> -       /* If the address is private it can only be connected over LE */
> -       if (device_address_is_private(dev))
> +       /* If the address is random it can only be connected over LE */
> +       if (dev->bdaddr_type == BDADDR_LE_RANDOM)
>                 return dev->bdaddr_type;
>
>         if (dev->bredr_seen) {
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
