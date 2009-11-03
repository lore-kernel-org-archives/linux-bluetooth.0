Return-Path: <cyrus@holtmann.org>
Message-ID: <4AF02DAF.5050603@csr.com>
Date: Tue, 03 Nov 2009 13:18:39 +0000
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Tomas Winkler <tomas.winkler@intel.com>
CC: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        guy.cohen@intel.com, ron.rindjunsky@intel.com
Subject: Re: [PATCH net-next] iwmc3200bt: Add iwmc3200 bluetooth driver
References: <1257204990-18669-1-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1257204990-18669-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Tomas Winkler wrote:
> Add Intel Wireless MultiCom 3200 SDIO BT driver
> IWMC3200 is 4Wireless Com CHIP (GPS/BT/WiFi/WiMAX).
> wmc3200bt is derived from btsdio driver

Can you list the hardware differences between this chip and the standard?

> +	unsigned char tx_buf[2048];
> +	unsigned char rx_buf[2048];

I don't think these buffers are cache line aligned so can't be used for DMA.

> +		/* in IWMC_BT we need to read the transfer length
> +		 * before interrupt clearing */
> +		val1 = sdio_readb(data->func, REG_H2D_COUNT_L, &err);
> +		IBT_DBG(data->func, "%s to read len1,"
> +			" reg_addr=%x ret=%d val=%x\n",
> +			err ? "Failed" : "Succeeded",
> +			REG_H2D_COUNT_L, err, err ? 0xff : val1);
> +		if (err == 0) {
> +			val2 = sdio_readb(data->func, REG_H2D_COUNT_H, &err);
> +			IBT_DBG(data->func, "%s to read len2,"
> +				" reg_addr=%x ret=%d val=%x\n",
> +				err ? "Failed" : "Succeeded",
> +				REG_H2D_COUNT_H, err, err ? 0xff : val2);

Wow.  Intel really messed up the hardware here.  An extra two SDIO
commands per packet?  I guess no one was thinking of performance...

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
