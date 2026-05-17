Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852073093D8
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779036937; cv=none; b=gcdXFPjGnHikXbcLWCXcJvZwnZreEcHHCc6hDIo8fZSsoT62p7c/A7EsmQj7rnAB3+BGLKyY1eqrjs721jVO//4v/PFh9sY6cCtIea6nzY8Jwz5sLH6nEIdHLYlSmGRiTGZ+MFR/+h7aYQCoUDGP8Indk4ZQmfNYj4f1moux59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779036937; c=relaxed/simple;
	bh=KilqzaA0hLDIZ+qQ211YAHNj7GgAvuvoyt4Ky1BySpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=K2pc4RtxwkMZHbQJvcOI8Jw18MYfbuuCrNhS5BoPG85FsVvhDU1nRMd6bGc6AtF9VKKPdbJPgjNc6RGEy9mYc8eCSp6LeXZqNW4r0sQQSUIQFYKR7n1T5CAruSArxiU0i9Gd+P4uUBBZPz4qVygovNmPCe1M9Yx+FP8Aq6+qETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.16.28.56] (user-109-243-196-8.play-internet.pl [109.243.196.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5BC4D4C2C37D56;
	Sun, 17 May 2026 18:54:58 +0200 (CEST)
Message-ID: <e12a170f-5340-4f45-8550-127039de805a@molgen.mpg.de>
Date: Sun, 17 May 2026 18:54:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btintel: Use skb_pull_data return for
 bounds check
To: Quan Sun <2022090917019@std.uestc.edu.cn>
References: <20260517060142.24510-1-2022090917019@std.uestc.edu.cn>
Content-Language: en-US
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kiran.k@intel.com,
 linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260517060142.24510-1-2022090917019@std.uestc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Quan,


Thank you for your patch.

Am 17.05.26 um 08:01 schrieb Quan Sun:
> The length check at the top of btintel_print_fseq_info() verifies
> the skb has at least 66 bytes (sizeof(u32) * 16 + 2), but the
> function actually consumes 74 bytes (2 * 1 + 18 * 4). When firmware
> returns a packet of exactly 66 bytes, the last two skb_pull_data()
> calls return NULL, which is passed directly to get_unaligned_le32(),
> resulting in a NULL pointer dereference.

How did you find this? Manual review, or some tool?

> Remove the insufficient length check and instead validate every
> skb_pull_data() return value, branching to a malformed label that
> logs the error and frees the skb.

Where you able to test the new code on hardware?

> Fixes: a7ba218a44aa ("Bluetooth: btintel: Print Firmware Sequencer information")
> Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> ---
>   drivers/bluetooth/btintel.c | 106 +++++++++++++++++++++++++++---------
>   1 file changed, 79 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5e9cac090bd8..0c42ee53fe2e 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3358,14 +3358,9 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
>   		return;
>   	}
>   
> -	if (skb->len < (sizeof(u32) * 16 + 2)) {
> -		bt_dev_dbg(hdev, "Malformed packet of length %u received",
> -			   skb->len);
> -		kfree_skb(skb);
> -		return;
> -	}
> -
>   	p = skb_pull_data(skb, 1);
> +	if (!p)
> +		goto malformed;
>   	if (*p) {
>   		bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)", *p);
>   		kfree_skb(skb);
> @@ -3373,6 +3368,8 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
>   	}
>   
>   	p = skb_pull_data(skb, 1);
> +	if (!p)
> +		goto malformed;
>   	switch (*p) {
>   	case 0:
>   		str = "Success";
> @@ -3396,65 +3393,120 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
>   
>   	bt_dev_info(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Reason: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Global version: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Installed version: 0x%8.8x", val);
>   
> -	p = skb->data;
> -	skb_pull_data(skb, 4);
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
>   	bt_dev_info(hdev, "Fseq executed: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
>   		    p[2], p[3]);
>   
> -	p = skb->data;
> -	skb_pull_data(skb, 4);
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
>   	bt_dev_info(hdev, "Fseq BT Top: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
>   		    p[2], p[3]);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq Top init version: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq Cnvio init version: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq MBX Wifi file version: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq BT version: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq Top reset address: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq MBX timeout: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq MBX ack: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq CNVi id: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq CNVr id: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq Error handle: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq Magic noalive indication: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq OTP version: 0x%8.8x", val);
>   
> -	val = get_unaligned_le32(skb_pull_data(skb, 4));
> +	p = skb_pull_data(skb, 4);
> +	if (!p)
> +		goto malformed;
> +	val = get_unaligned_le32(p);
>   	bt_dev_dbg(hdev, "Fseq MBX otp version: 0x%8.8x", val);
>   
>   	kfree_skb(skb);
> +	return;
> +
> +malformed:
> +	bt_dev_dbg(hdev, "Malformed packet received");

It’d be great to log more information, wouldn’t it?

> +	kfree_skb(skb);
>   }
>   EXPORT_SYMBOL_GPL(btintel_print_fseq_info);
>   


Kind regards,

Paul
