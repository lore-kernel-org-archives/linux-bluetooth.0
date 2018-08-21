Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] hci_bcm.c: fix missing return value check of
 devm_clk_get()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180818020606.12052-1-jasonwood2031@gmail.com>
Date: Tue, 21 Aug 2018 16:38:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B67E0AC3-9761-4DF0-A382-AA5900C1577A@holtmann.org>
References: <20180818020606.12052-1-jasonwood2031@gmail.com>
To: Jiecheng Wu <jasonwood2031@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiecheng,

> Function bcm_get_resources() defined in drivers/bluetooth/hci_bcm.c calls devm_clk_get() that may return an error code. The return value of function bcm_get_resources() should be checked whether it is an error code.
> ---
> drivers/bluetooth/hci_bcm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ddbd8c6..f4089a2 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -906,6 +906,8 @@ static int bcm_get_resources(struct bcm_device *dev)
> 		return 0;
> 
> 	dev->clk = devm_clk_get(dev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);

is this really needed? I assume it all fails gracefully.

Regards

Marcel
