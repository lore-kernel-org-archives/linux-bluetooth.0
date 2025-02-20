Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D01BCA0F;
	Thu, 20 Feb 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053088; cv=none; b=g5Kp+nYmQiVQ+wDsMyy0t7hu7vlPevqxXfLPJn0wYrbMc85xgXJ3ajuxrr37zUqPYumfTlCDhxMjsHYhzD5SsGNhHpMz+F0KC4hP4rtDsWJo4+2otHBntlyLKkjPYoouoCDEa47yfnAftLwKFBHJxSGZMGQditMHMuw3qjEnE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053088; c=relaxed/simple;
	bh=P7l71zGGOCBiuGUiOWJslraeV8jPeviTVd3ghPcopaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKGJZ+Vfz0qvuEMUpHhVzCRjg+KUy40iVhSdbm9GiLi/veoZkM2mezfIN7Xr9lbcdxhMP63BoqTnvxlbc6WUXxtrVv9xvAFQlzGwfPkGvuzkefeafZQJ2TIA6AyZBeotmOQ5o4KqzgECIf6qG8CW1priT7IMcPqK8bdBPwMcZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4d1.dynamic.kabel-deutschland.de [95.90.244.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C8F6F61E6478A;
	Thu, 20 Feb 2025 13:04:30 +0100 (CET)
Message-ID: <9b67d408-3557-46d5-81ad-e3d6636a5e0d@molgen.mpg.de>
Date: Thu, 20 Feb 2025 13:04:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Bluetooth: btnxpuart: Add support for set BD
 address
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com,
 johan.korsnes@remarkable.no, kristian.krohn@remarkable.no,
 manjeet.gupta@nxp.com
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
 <20250220114157.232997-2-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250220114157.232997-2-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Neeraj,


Thank you for your patch. In the summary/title you could use *to set* or 
*for setting*.

Am 20.02.25 um 12:41 schrieb Neeraj Sanjay Kale:
> This adds support for setting BD address during hci registration. NXP
> FW does not allow vendor commands unless it receives a reset command
> after FW download and initialization done.

I’d add a blank line between paragraphs.

> As a workaround, the .set_bdaddr callback function will first send the
> HCI reset command, followed by the actual vendor command to set BD
> address.

Where is the command 0xfc22 documented?

How did you verify this? Maybe document the commands how to set the BD 
address, and how to verify it.

Does Linux log new messages with your patch?

> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
> Signed-off-by: Kristian HusevÃ¥g Krohn <kristian.krohn@remarkable.no>

The last name has some wrong character.

> Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v4: hci0 interface shows RAW mode if 'local-bd-address' not defined and
>      HCI_QUIRK_USE_BDADDR_PROPERTY is set. Add Quirk only if device tree
>      property 'local-bd-address' found. (Neeraj)
> v5: Initialize local variable ba, update Copywrite year. (Kristian)
> ---
>   drivers/bluetooth/btnxpuart.c | 39 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 1230045d78a5..dd9161bfd52c 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    *  NXP Bluetooth driver
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2025 NXP
>    */
>   
>   #include <linux/module.h>
> @@ -1197,6 +1197,34 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
>   	return hci_recv_frame(hdev, skb);
>   }
>   
> +static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> +{
> +	u8 data[8] = { 0xfe, 0x06, 0, 0, 0, 0, 0, 0 };
> +	struct sk_buff *skb;
> +	int err;
> +
> +	memcpy(data + 2, bdaddr, 6);
> +

Add a comment about the firmware limitation/requirement?

> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
> +			   PTR_ERR(skb));
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(data), data, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Changing device address failed (%d)", err);
> +		return err;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
>   /* NXP protocol */
>   static int nxp_setup(struct hci_dev *hdev)
>   {
> @@ -1500,6 +1528,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>   {
>   	struct hci_dev *hdev;
>   	struct btnxpuart_dev *nxpdev;
> +	bdaddr_t ba = {0};
>   
>   	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
>   	if (!nxpdev)
> @@ -1547,8 +1576,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>   	hdev->send  = nxp_enqueue;
>   	hdev->hw_error = nxp_hw_err;
>   	hdev->shutdown = nxp_shutdown;
> +	hdev->set_bdaddr = nxp_set_bdaddr;
> +
>   	SET_HCIDEV_DEV(hdev, &serdev->dev);
>   
> +	device_property_read_u8_array(&nxpdev->serdev->dev,
> +				      "local-bd-address",
> +				      (u8 *)&ba, sizeof(ba));
> +	if (bacmp(&ba, BDADDR_ANY))
> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);

Please elaborate in the commit message, why the quirk is needed.

> +
>   	if (hci_register_dev(hdev) < 0) {
>   		dev_err(&serdev->dev, "Can't register HCI device\n");
>   		goto probe_fail;


Kind regards,

Paul
