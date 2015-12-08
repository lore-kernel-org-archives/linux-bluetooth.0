Return-Path: <stefan@osg.samsung.com>
Subject: Re: [PATCH v2] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
To: michael.hennerich@analog.com, alex.aring@gmail.com,
 stefan@datenfreihafen.org, marcel@holtmann.org
References: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5666E986.8070105@osg.samsung.com>
Date: Tue, 8 Dec 2015 15:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

One last thing, hopefully. :)

On 08/12/15 12:52, michael.hennerich@analog.com wrote:

[snip]
> +
> +	dev_info(&spi->dev, "mac802154 IRQ-%d registered\n", spi->irq);
> +
> +	return ret;
> +
> +	ieee802154_unregister_hw(lp->hw);

The function call after return will never be called. Guess you want to 
make sure the error handling is correct here.
> +err_hw_init:
> +	mutex_destroy(&lp->bmux);
> +	ieee802154_free_hw(lp->hw);

regards
Stefan Schmidt
