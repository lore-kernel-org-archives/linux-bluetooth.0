Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth:hci_bcm:Check return value from devm_clk_get
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180717120635.25259-1-raghuhack78@gmail.com>
Date: Wed, 18 Jul 2018 14:09:55 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <5018E00B-7642-435F-AB9E-1EEB7DD5A885@holtmann.org>
References: <5b4ddae5.1c69fb81.61055.042e.GMRIR@mx.google.com>
 <20180717120635.25259-1-raghuhack78@gmail.com>
To: RAGHU Halharvi <raghuhack78@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raghu,

> * Check return value from devm_clk_get & return appropriate error.
> ---
> drivers/bluetooth/hci_bcm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 441f5e1deb11..1295cc89d702 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -910,6 +910,8 @@ static int bcm_get_resources(struct bcm_device *dev)
> 		return 0;
> 
> 	dev->clk = devm_clk_get(dev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);

so I assumed this was not done on purpose and allow for dev->clk = NULL since all other clock handling functions will cope with it. Can someone NAK or ACK this patch?

Regards

Marcel

