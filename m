Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 5 Sep 2016 21:02:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] core/device: Fix attempting to connect to
 random address over BR/EDR
Message-ID: <20160905180241.GA29844@t440s.P-661HNU-F1>
References: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 02, 2016, Luiz Augusto von Dentz wrote:
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
>  	else if (!dev->bredr_state.bonded && dev->le_state.bonded)
>  		return dev->bdaddr_type;
>  
> +	/* If the address is private it can only be connected over LE */
> +	if (device_address_is_private(dev))
> +		return dev->bdaddr_type;
> +

This doesn't look right to me. The comment also isn't correct since a
dual mode device may use a resolvable private address for LE, i.e.
device_address_is_private(dev) would return true. IIRC the
dev->bdaddr_type value tells the LE address type when LE is supported.
If LE is not supported then dev->bdaddr_type is BDADDR_BREDR.

Johan
