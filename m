Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0B5D914
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840337; cv=none; b=hVdwNgW5k6Db1W8cKztEBuzdwR2VU7c8Rm5UDnHimgUGjRqDQTSxz9ereJBGnYZ2vDgqQmI8y2H/3f+EhwQ9mSOaWFXPaAGxdDtCFSA8nqkrSgXVQp55+tdPgsxegQPoaWRnNhTfX9FavXZvduurWEUlBw/DOZmoUOMUEDmlC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840337; c=relaxed/simple;
	bh=168SXlZNAfV9b4J2Pt5Ng/ZFQPaVez3qit560vOBrOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJsIYA2aIDBGif1DEsNf5epAPYnexBlAsTp0UAqFfmL0Wh86jweX6/5JZGSibmtsnow8sgN8jr3AKQ54RZd816ZvQOkYDXNWf4nUGNVi2rQYV0Eb8iJR0t14Ht1Su8csPEKmuYn8AZf3dpayodfiYiY8ByXlml7/knXvECEHpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2E26061E5FE01;
	Tue, 13 Feb 2024 17:05:10 +0100 (CET)
Message-ID: <d18dd583-9267-48b6-a0c8-61b1018f921a@molgen.mpg.de>
Date: Tue, 13 Feb 2024 17:05:09 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel: Print Firmware Sequencer
 information
Content-Language: en-US
To: Kiran K <kiran.k@intel.com>
Cc: ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
 linux-bluetooth@vger.kernel.org
References: <20240213160152.2836131-1-kiran.k@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240213160152.2836131-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for your patch.

Am 13.02.24 um 17:01 schrieb Kiran K:
> Firmware sequencer(FSEQ) is a common code shared across Bluetooth

Please add a space before (.

> and Wifi. Printing FSEQ will help to debug if there is any mismatch
> between Bluetooth and Wifi FSEQ.

Please give an example output, and document the system, you tested this on.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 106 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e5b043d96207..0d067ee39408 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2670,6 +2670,111 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
>   	}
>   }
>   
> +static void btintel_print_fseq_info(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	u8 *p;
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
> +		bt_dev_dbg(hdev, "Malformed packet");

Please print out the length values.

> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	p = skb->data;
> +	/* skip status */
> +	p = p + 1;
> +
> +	switch (*p) {
> +	case 0:
> +		str = "Success";
> +		break;
> +	case 1:
> +		str = "Fatal error";
> +		break;
> +	case 2:
> +		str = "Sem acq error";

Maybe elaborate here?

> +		break;
> +	default:
> +		str = "Unknown error";
> +		break;
> +	}
> +
> +	bt_dev_info(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
> +	if (*p)
> +		return;

Should non-success levels have a different log level?

> +	p = p + 1;
> +	bt_dev_dbg(hdev, "Reason: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Global version: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Installed version: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_info(hdev, "Fseq executed: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
> +		    p[2], p[3]);
> +
> +	p = p + 4;
> +	bt_dev_info(hdev, "Fseq BT Top: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
> +		    p[2], p[3]);
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq Top init version: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq Cnvio init version: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq MBX Wifi file version: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq BT version: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq Top reset address: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq MBX timeout: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq MBX ack: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq CNVi id: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq CNVr id: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq Error handle: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq Magic noalive indication: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq OTP version: 0x%8.8x", get_unaligned_le32(p));
> +
> +	p = p + 4;
> +	bt_dev_dbg(hdev, "Fseq MBX otp version: 0x%8.8x", get_unaligned_le32(p));
> +}
> +
>   static int btintel_setup_combined(struct hci_dev *hdev)
>   {
>   	const u8 param[1] = { 0xFF };
> @@ -2902,6 +3007,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   
>   		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
>   		btintel_register_devcoredump_support(hdev);
> +		btintel_print_fseq_info(hdev);
>   		break;
>   	default:
>   		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",


Kind regards,

Paul
