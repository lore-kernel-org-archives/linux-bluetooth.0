Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0680C08
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534097; cv=none; b=a8gE5pVDu/8sD+iUz7ufJjPjXtJ6mrpR5DCgOaUIp++lwFKBE6QQh75vOTs+W97yFxh29xKAhGoneiVeb9kZPVQeOGPXmKUWgRM84FJq4K+NDkkXSJ4EJt4iRbcYI6PS+E4vZRDQ88F3X4zq1GaCrwA7vhjtquXgJnoQkZGds4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534097; c=relaxed/simple;
	bh=EaEg+1b+10YWmcbtQuD0L0OyIozr7NF0uGTsgis6N7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIuGIqoRY/3Y38N8yWdSrlAFTF6ovmp2ym4FUkXUdDmtL+Sa5Mb4laYOtI5sRoxp3uWGuMRF7LvJMXOYKtJoYmnRohpdiMDh82t/SkKxAdF8cVRX+ehb01skrM0CGwQ1AgjkTYzmM0IgE2OJXWbXHWHp7ZULBqz7Au+wQBMojWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4531661E5FE01;
	Wed, 21 Feb 2024 17:47:50 +0100 (CET)
Message-ID: <6df743f5-d2ae-4d07-ac32-7ed0b89fa77f@molgen.mpg.de>
Date: Wed, 21 Feb 2024 17:47:49 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel: Print Firmware Sequencer
 information
Content-Language: en-US
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com
References: <20240221133346.3295639-1-kiran.k@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240221133346.3295639-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for incorperating the feedback.

Am 21.02.24 um 14:33 schrieb Kiran K:
> Firmware sequencer (FSEQ) is a common code shared across Bluetooth
> and Wifi. Printing FSEQ will help to debug if there is any mismatch
> between Bluetooth and Wifi FSEQ.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 114 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
> 
> Kernel log snippet:
> 
> [    3.643765] Bluetooth: hci0: Fseq status: Success (0x00)
> [    3.643769] Bluetooth: hci0: Fseq executed: 00.00.02.41
> [    3.643771] Bluetooth: hci0: Fseq BT Top: 00.00.02.41

Next time I think this could go into the proper commit message.

> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e5b043d96207..a083c4b8621c 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2670,6 +2670,119 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
>   	}
>   }
>   
> +static void btintel_print_fseq_info(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	u8 *p;
> +	u32 val;
> +	const char *str;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfcb3, 0, NULL, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_dbg(hdev, "Reading fseq status command failed (%ld)",
> +			   PTR_ERR(skb));
> +		return;
> +	}
> +
> +	if (skb->len < (sizeof(u32) * 16 + 2)) {
> +		bt_dev_dbg(hdev, "Malformed packet of length %u received",
> +			   skb->len);

I would have also printed the value of `sizeof(u32) * 16 + 2`:

     bt_dev_dbg(hdev, "Malformed packet of length %u received: too short 
< %u", skb->len, sizeof(u32) * 16 + 2)


Kind regards,

Paul


> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	p = skb_pull_data(skb, 1);
> +	if (*p) {
> +		bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)", *p);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	p = skb_pull_data(skb, 1);
> +	switch (*p) {
> +	case 0:
> +		str = "Success";
> +		break;
> +	case 1:
> +		str = "Fatal error";
> +		break;
> +	case 2:
> +		str = "Semaphore acquire error";
> +		break;
> +	default:
> +		str = "Unknown error";
> +		break;
> +	}
> +
> +	if (*p) {
> +		bt_dev_err(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	bt_dev_info(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Reason: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Global version: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Installed version: 0x%8.8x", val);
> +
> +	p = skb->data;
> +	skb_pull_data(skb, 4);
> +	bt_dev_info(hdev, "Fseq executed: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
> +		    p[2], p[3]);
> +
> +	p = skb->data;
> +	skb_pull_data(skb, 4);
> +	bt_dev_info(hdev, "Fseq BT Top: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
> +		    p[2], p[3]);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq Top init version: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq Cnvio init version: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq MBX Wifi file version: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq BT version: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq Top reset address: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq MBX timeout: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq MBX ack: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq CNVi id: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq CNVr id: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq Error handle: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq Magic noalive indication: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq OTP version: 0x%8.8x", val);
> +
> +	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	bt_dev_dbg(hdev, "Fseq MBX otp version: 0x%8.8x", val);
> +
> +	kfree_skb(skb);
> +}
> +
>   static int btintel_setup_combined(struct hci_dev *hdev)
>   {
>   	const u8 param[1] = { 0xFF };
> @@ -2902,6 +3015,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   
>   		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
>   		btintel_register_devcoredump_support(hdev);
> +		btintel_print_fseq_info(hdev);
>   		break;
>   	default:
>   		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
