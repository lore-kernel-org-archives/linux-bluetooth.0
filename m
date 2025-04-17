Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6879C4
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744866301; cv=none; b=tLtpE7PXaEI/k9IliEd987jILu9OxUOoJZOTf617lI1mIqdi+m2XLqIdsAmvy9ZEoh5ahtMH4D64pzL7h1RnJih9gLKGsbkzuaBJgDsf/PaOPGHsI8a40CGfdM61Pgb9MzqbV9sxehhoqmiixY0KqAuVeO5GYoJD2abCCveFqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744866301; c=relaxed/simple;
	bh=mmED3/QWPwcp9pBl64qSTV5R3JWH4Erjut1ziKy/bDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIRz9jNLc3ipiFf8Mm1YQ6ILE4WE3YCNW5wu95UNDfGlz/DqJBbLJnue09li8JEvxz73wDp59bBsMLFlPF53rHj1YLiZENDIY6v95uDHqAvBLApVxCTDx3R8R5Ai6sGynlaxHG1Eo4DXtA/mkXYAewDSE9C1280bhxgbsKDX3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.1.26] (dynamic-176-000-055-081.176.0.pool.telefonica.de [176.0.55.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1714061E647A3;
	Thu, 17 Apr 2025 07:04:44 +0200 (CEST)
Message-ID: <a8eb9197-fbf9-4e9a-b10e-db12c79d320f@molgen.mpg.de>
Date: Thu, 17 Apr 2025 07:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Avoid redundant buffer
 allocation
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com
References: <20250417034842.165796-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250417034842.165796-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for your patch.


Am 17.04.25 um 05:48 schrieb Kiran K:
> Reuse the skb buffer provided by the PCIe driver to pass it onto the
> stack, instead of copying it to a new skb.

Does `scripts/bloat-o-meter` verify, that the optimization worked?

> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 33 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index e0b50513403f..b73928e38d34 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -947,8 +947,10 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>   		/* This is a debug event that comes from IML and OP image when it
>   		 * starts execution. There is no need pass this event to stack.
>   		 */
> -		if (skb->data[2] == 0x97)
> +		if (skb->data[2] == 0x97) {
> +			hci_recv_diag(hdev, skb);
>   			return 0;
> +		}
>   	}
>   
>   	return hci_recv_frame(hdev, skb);
> @@ -964,7 +966,6 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
>   	u8 pkt_type;
>   	u16 plen;
>   	u32 pcie_pkt_type;
> -	struct sk_buff *new_skb;
>   	void *pdata;
>   	struct hci_dev *hdev = data->hdev;
>   
> @@ -1041,24 +1042,20 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
>   
>   	bt_dev_dbg(hdev, "pkt_type: 0x%2.2x len: %u", pkt_type, plen);
>   
> -	new_skb = bt_skb_alloc(plen, GFP_ATOMIC);
> -	if (!new_skb) {
> -		bt_dev_err(hdev, "Failed to allocate memory for skb of len: %u",
> -			   skb->len);
> -		ret = -ENOMEM;
> -		goto exit_error;
> -	}
> -
> -	hci_skb_pkt_type(new_skb) = pkt_type;
> -	skb_put_data(new_skb, skb->data, plen);
> +	hci_skb_pkt_type(skb) = pkt_type;
>   	hdev->stat.byte_rx += plen;
> +	skb_trim(skb, plen);
>   
>   	if (pcie_pkt_type == BTINTEL_PCIE_HCI_EVT_PKT)
> -		ret = btintel_pcie_recv_event(hdev, new_skb);
> +		ret = btintel_pcie_recv_event(hdev, skb);
>   	else
> -		ret = hci_recv_frame(hdev, new_skb);
> +		ret = hci_recv_frame(hdev, skb);
> +	skb = NULL; /* skb is freed in the callee  */
>   
>   exit_error:
> +	if (skb)
> +		kfree_skb(skb);
> +
>   	if (ret)
>   		hdev->stat.err_rx++;
>   
> @@ -1192,8 +1189,6 @@ static void btintel_pcie_rx_work(struct work_struct *work)
>   	struct btintel_pcie_data *data = container_of(work,
>   					struct btintel_pcie_data, rx_work);
>   	struct sk_buff *skb;
> -	int err;
> -	struct hci_dev *hdev = data->hdev;
>   
>   	if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
>   		/* Unlike usb products, controller will not send hardware
> @@ -1214,11 +1209,7 @@ static void btintel_pcie_rx_work(struct work_struct *work)
>   
>   	/* Process the sk_buf in queue and send to the HCI layer */
>   	while ((skb = skb_dequeue(&data->rx_skb_q))) {
> -		err = btintel_pcie_recv_frame(data, skb);
> -		if (err)
> -			bt_dev_err(hdev, "Failed to send received frame: %d",
> -				   err);
> -		kfree_skb(skb);
> +		btintel_pcie_recv_frame(data, skb);
>   	}
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
