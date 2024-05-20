Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86B1CD39
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223989; cv=none; b=uUyUOuheGGer4sItlP45a2p9AU+nqyOQBuBcItWhfjnaLne91CCD3eFl+p2J6PheiZwAVH1L1CXO7EqmeD3JE9XuolZEZfGaekDZgGCeb0n7/yZD/tZc22sUuAHg2hhhtc5Uf9G5w4PZNvgqQxdlhkfNF5ca2PA2rYnr+gpm9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223989; c=relaxed/simple;
	bh=08wQ9wqaBf/hERFFbQrNpPKZuJ5L0VMWtQlCHbXSeno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fz7Goy7HNm16VONFFiisquJBAb+WyRhK8HxILNu41+d8+SLyNBhR6WBWdDb/dPE4UbMcYKHwBZfOJYYb4PnBKH7ijaCaAojr2jqEniCxJ9uBRG+CiPe/8StrA4GkDBR6I4XXT2C03evbbY7ZTflb27G4ouhhPWIWuGtYPZqOGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (unknown [95.90.244.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 953BF61E5FE01;
	Mon, 20 May 2024 18:52:56 +0200 (CEST)
Message-ID: <48e9ba9c-1bc8-4086-b7da-31a7d78b2a16@molgen.mpg.de>
Date: Mon, 20 May 2024 18:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Patch for CYW4373 hci up fail issue
To: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
References: <016dd2b28cd5435ba6f13b01d4da0d44@infineon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <016dd2b28cd5435ba6f13b01d4da0d44@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Nobuaki,


Thank you for your patch. Some comments on formalities.

First, please prefix the subject with `Bluetooth:`, and be more specific 
about the change:

Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373

Am 20.05.24 um 10:22 schrieb Nobuaki.Tsunashima@infineon.com:

Please use your full name:

     git config --global user.name "Nobuaki Tsunashima"
     git commit --amend --author="Nobuaki Tsunashima 
<nobuaki.tsunashima@infineon.com>" -s

> CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command as supported in a response
> of Read_Local_Supported_Command command but rejects the LE_Read_Transmit_Power command with
> "Unknown HCI Command" status.
> Due to the issue, Bluetooth driver of 5.15 and later kernel fails to hci up.

Why not 5.14?

> Especially in USB i/f case, it would be difficult to download patch FW that includes Its fix unless hci is up.
> The patch forces the driver to skip LE_Read_Transmit_Power Command when it detects CYW4373 with ROM
> FW build.

Please re-flow for 75 characters per line and add a blank between 
paragraphs.


Kind regards,

Paul


> Signed-off-by: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
> 
> ---
> V1 -> V2: Fix several coding style warnings.
> 
>   drivers/bluetooth/btbcm.c | 33 ++++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btusb.c |  4 ++++
>   2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 0a5445ac5e1b..da4718a268d0 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -437,18 +437,49 @@ static const struct dmi_system_id disable_broken_read_transmit_power[] = {
>   	{ }
>   };
>   
> +struct bcm_chip_version_table {
> +	u8	chip_id;
> +	u16 baseline;
> +};
> +#define BCM_ROMFW_BASELINE_NUM	0xFFFF
> +static const struct bcm_chip_version_table disable_broken_read_transmit_power_by_chip_ver[] = {
> +	{0x87, BCM_ROMFW_BASELINE_NUM}		/* CYW4373/4373E */
> +};
> +static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id, u16 baseline)
> +{
> +	int i;
> +	int table_size = ARRAY_SIZE(disable_broken_read_transmit_power_by_chip_ver);
> +	const struct bcm_chip_version_table *entry =
> +							&disable_broken_read_transmit_power_by_chip_ver[0];
> +
> +	for (i = 0 ; i < table_size ; i++, entry++)
> +	{
> +		if ((chip_id == entry->chip_id) && (baseline == entry->baseline))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static int btbcm_read_info(struct hci_dev *hdev)
>   {
>   	struct sk_buff *skb;
> +	u8 chip_id;
> +	u16 baseline;
>   
>   	/* Read Verbose Config Version Info */
>   	skb = btbcm_read_verbose_config(hdev);
>   	if (IS_ERR(skb))
>   		return PTR_ERR(skb);
> -
> +	chip_id = skb->data[1];
> +	baseline = skb->data[3] | (skb->data[4] << 8);
>   	bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
>   	kfree_skb(skb);
>   
> +	/* Check Chip ID and disable broken Read LE Min/Max Tx Power */
> +	if (btbcm_is_disable_broken_read_tx_power_by_chip_ver(chip_id, baseline))
> +		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d31edad7a056..52561c8d8828 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -142,6 +142,10 @@ static const struct usb_device_id btusb_table[] = {
>   	{ USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
>   	  .driver_info = BTUSB_BCM_PATCHRAM },
>   
> +	/* Cypress devices with vendor specific id */
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x04b4, 0xff, 0x01, 0x01),
> +	  .driver_info = BTUSB_BCM_PATCHRAM },
> +
>   	/* Broadcom devices with vendor specific id */
>   	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
>   	  .driver_info = BTUSB_BCM_PATCHRAM },
