Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089637144;
	Wed, 22 May 2024 04:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716352993; cv=none; b=A5ePBtmNO1tvRstYk42X1Z0McGOTDrgGcxhvElKsTims2aW6qIPeBcU+fdFUk65g9M3tcY+L0es2QgB/IpBWpECXj7Tb2q1H2QzmmQGqZJfi4PbYBwo17jJq/q40RhnaNqjfJCbtbk6gyP72sd9vB8oxgtVYFEf9sBezuYy34ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716352993; c=relaxed/simple;
	bh=jl24Sv7wbxESitZjVaa+8imt/4LFdBIPK5LZbx4b2fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ytj2EtysVqOE+FFz193Q/3zUSpuDi1UabytsXFU0GqtZzouqRDDVo0EReBl68lC/4H31K3ttapI+XYLklNHwdvkPxPUNIk0mppC0Ro91NEdl3dreKBKpnoRYSeZzlm7yWnei0G0EBAcnzyc2rmZQ/Hq5BrqP14PckrON+pRIEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (unknown [95.90.241.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 70C4E61E5FE05;
	Wed, 22 May 2024 06:42:55 +0200 (CEST)
Message-ID: <1c194c94-54f1-4dfe-a790-913e3d9529c6@molgen.mpg.de>
Date: Wed, 22 May 2024 06:42:54 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
To: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aditya Garg <gargaditya08@live.com>
References: <20240522081735.469503-1-nobuaki.tsunashima@infineon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240522081735.469503-1-nobuaki.tsunashima@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Nobuaki,


Thank you for your patch and addressing the comments. Please note, that 
the time on the system you sent the patch from is in the future:

     Date: Wed, 22 May 2024 17:17:35 +0900

But:

     Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
     	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
     	(No client certificate requested)
     	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC328EA;
     	Wed, 22 May 2024 01:28:45 +0000 (UTC)

Am 22.05.24 um 10:17 schrieb Nobuaki Tsunashima:
> From: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>

I forgot to add btbcm in the summary:

Bluetooth: btbcm: …

> CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command
> as supported in a response of Read_Local_Supported_Command command but
> rejects the LE_Read_Transmit_Power command with "Unknown HCI Command"
> status. Due to the issue, Bluetooth driver of 5.15 and later kernel fails
> to hci up.

As written in the other thread, it’d be great if you bisected the commit.

> Especially in USB i/f case, it would be difficult to download patch FW that
> includes Its fix unless hci is up.

lowercase: its

Which firmware versions are fixed?

> The patch forces the driver to skip LE_Read_Transmit_Power Command when it
> detects CYW4373 with ROM FW build.

Maybe add something like:

The driver already contains infrastructure to apply the quirk, but 
currently it only supports DMI based matching. Add support to match by 
chip id and baseline, which ….

> Signed-off-by: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>
> ---
> V2 -> V3: Fix a few coding style warnings and change the subject as more specific.
> V1 -> V2: Fix several coding style warnings.
> 
>   drivers/bluetooth/btbcm.c | 32 +++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btusb.c |  4 ++++
>   2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 0a5445ac5e1b..c763e368d6ad 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -437,18 +437,48 @@ static const struct dmi_system_id disable_broken_read_transmit_power[] = {
>   	{ }
>   };
>   
> +struct bcm_chip_version_table {
> +	u8	chip_id;

Please use one space. (Please also check the line below.)

> +	u16 baseline;

Add a comment above the struct, what baseline means?

> +};
> +#define BCM_ROMFW_BASELINE_NUM	0xFFFF
> +static const struct bcm_chip_version_table disable_broken_read_transmit_power_by_chip_ver[] = {
> +	{0x87, BCM_ROMFW_BASELINE_NUM}		/* CYW4373/4373E */

Add one space after { and before }?

> +};
> +static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id, u16 baseline)
> +{
> +	int i;
> +	int table_size = ARRAY_SIZE(disable_broken_read_transmit_power_by_chip_ver);

Use size_t?

> +	const struct bcm_chip_version_table *entry =
> +						&disable_broken_read_transmit_power_by_chip_ver[0];
> +
> +	for (i = 0 ; i < table_size ; i++, entry++)	{
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

Commit 801b4c027b44 (Bluetooth: btbcm: disable read tx power for some 
Macs with the T2 Security chip) added the check in 
`btbcm_print_controller_features()`? No idea, where the best place is.

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

Order 0x04b4 before 0x04ca?

>   	/* Broadcom devices with vendor specific id */
>   	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
>   	  .driver_info = BTUSB_BCM_PATCHRAM },


Kind regards,

Paul
