Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C086341
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783987259; cv=none; b=i82Wo8trKDG/0Yw3imCdIWPckxPCl4/yFjqOE/LsCyM34HfWOK5/PmfjHW+3mniipj9pxD7DiAbmfTmr1PZD8h0SmOxT0aYaQcoiZp+GGopOPo2KMglfIWUWFiv6AdzX9hVDfdQ+8ff3PEqXND3iCBUo1juimjbRDvRjUWImc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783987259; c=relaxed/simple;
	bh=b2URWJlXaxtkxdXeB/4/ceGBjzHtmKJkamCR5K7hfZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1HuvIbvmqZkhehszMsfrK7gWGrNf00lnt2+wztBvqSn++4a8RvlJoPsnVcJfs8aBWWsdGEnD1YJUWLH9mNobjd0vZYgRpLU0N2NSip2sJTkkJdxg+TOYBEwCzb7+XoZ1yNVatUTwqINfyoWjmgI64MN5SnYr3scyYAc5aMp4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.150] (ip5f5af733.dynamic.kabel-deutschland.de [95.90.247.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2736B4C2C37D58;
	Tue, 14 Jul 2026 02:00:39 +0200 (CEST)
Message-ID: <0f0d783d-8b03-4048-bd7f-b97dc2bce92f@molgen.mpg.de>
Date: Tue, 14 Jul 2026 02:00:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: btintel: Fix spurious error on FW download
 error recovery
To: Ameen Al-Asady <ameenaladdin@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20260713215537.81222-1-ameenaladdin@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260713215537.81222-1-ameenaladdin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ameen,


Thank you for your patch.

Am 13.07.26 um 23:55 schrieb Ameen Al-Asady:
> When firmware download fails because the controller is running an

“fail” is ambiguous to me. Maybe “errors out”.

> operational image whose version does not match the firmware file on
> disk (the normal case for a firmware upgrade across a warm reboot,
> since the operational image survives in controller RAM),
> btintel_reset_to_bootloader() sends the Intel Reset vendor command to
> force the controller back into bootloader mode for the download retry.
> 
> The controller acts on Intel Reset by resetting and re-enumerating on
> the bus, which can happen before the command complete event is
> delivered. In that case __hci_cmd_sync() fails with -ENODEV and the
> driver logs a misleading error even though recovery is proceeding
> exactly as intended:
> 
>    Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
>    Bluetooth: hci0: Boot Address: 0x100800
>    Bluetooth: hci0: Firmware Version: 202-5.26
>    usb 1-6: USB disconnect, device number 4
>    Bluetooth: hci0: FW download error recovery failed (-19)
>    usb 1-6: new full-speed USB device number 5 using xhci_hcd
>    ...
>    Bluetooth: hci0: Firmware loaded in 2827613 usecs

Any hint how to match the firmware versions, or add a sentence what 
firmware is on the controller and which one is downloaded?

> Treat -ENODEV as the expected outcome of the reset rather than a
> recovery failure, and keep the error message for genuine failures.

Please mention the system you tested this on.

> Signed-off-by: Ameen Al-Asady <ameenaladdin@gmail.com>
> ---
>   drivers/bluetooth/btintel.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5e9cac090..472542bff 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1363,12 +1363,22 @@ static void btintel_reset_to_bootloader(struct hci_dev *hdev)
>   	skb = __hci_cmd_sync(hdev, BTINTEL_HCI_OP_RESET, sizeof(params),
>   			     &params, HCI_INIT_TIMEOUT);
>   	if (IS_ERR(skb)) {
> -		bt_dev_err(hdev, "FW download error recovery failed (%ld)",
> -			   PTR_ERR(skb));
> -		return;
> +		/* The controller acts on Intel Reset by resetting and
> +		 * re-enumerating on the bus, which can happen before the
> +		 * command complete event is delivered. The resulting
> +		 * -ENODEV means the reset took effect, not that recovery
> +		 * failed.
> +		 */
> +		if (PTR_ERR(skb) != -ENODEV) {
> +			bt_dev_err(hdev,
> +				   "FW download error recovery failed (%ld)",
> +				   PTR_ERR(skb));
> +			return;
> +		}
> +	} else {
> +		kfree_skb(skb);
>   	}
>   	bt_dev_info(hdev, "Intel reset sent to retry FW download");
> -	kfree_skb(skb);

Excuse my ignorance, but moving kfree_skb to a new else branch is not 
totally clear to me.

>   
>   	/* Current Intel BT controllers(ThP/JfP) hold the USB reset
>   	 * lines for 2ms when it receives Intel Reset in bootloader mode.
> 
> base-commit: eab19cb7618e5c50fd1f8c1efdc4e66e16575975


Kind regards,

Paul
