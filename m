Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 21 Dec 2011 02:18:35 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: fix bInterval for high/super speed
 isochronous endpoints
Message-ID: <20111221041835.GB2729@joana>
References: <1324433940-16838-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324433940-16838-1-git-send-email-bzhao@marvell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

* Bing Zhao <bzhao@marvell.com> [2011-12-20 18:19:00 -0800]:

> For high-speed/super-speed isochronous endpoints, the bInterval
> value is used as exponent, 2^(bInterval-1). Luckily we have
> usb_fill_int_urb() function that handles it correctly. So we just
> call this function to fill in the RX URB.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/btusb.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)

Applied, thanks.

	Gustavo
