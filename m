Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCC14B946;
	Thu, 29 Aug 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912072; cv=none; b=f3lU+1ofUXXqW1+u1lIsFOoX/QBGAhY9k/MFkgavjWugo2bH+td9VddhCc2zd8MeVsGS7f06JtRi2BCokJ6S8HjaNKbsOjttXoSBn5/jhCSImigzDcuk838VDOTf6qBsWcOb10RfaYxccXpBRNXEFPAUeXwhIrmuz7yM4pwIirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912072; c=relaxed/simple;
	bh=bRvzdSesM2DUfoPm8tIN1Hzg0/PX7HOPVgfqhLkIfUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxpFWKY3FYqEeGcdFuv10umN10tjUZ8HXvu3rsxsFU+2rbXqs/pKDPpJosZpZgVGRFwaPYwc1i11kf3MkX7voZlEj7dHcCY2tCVC1fwdLYECSvzIVdPrMQ8/N4iAsf1qroiqtykikr0r73Y4xoE7eFS750r7RjJes1k/gbc7GHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af162.dynamic.kabel-deutschland.de [95.90.241.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 68B7261E5FE05;
	Thu, 29 Aug 2024 08:13:54 +0200 (CEST)
Message-ID: <83b72389-e12b-4224-aed7-736880e2877f@molgen.mpg.de>
Date: Thu, 29 Aug 2024 08:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btrtl: Set msft ext address filter quirk
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com
References: <20240829034627.676529-1-hildawu@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240829034627.676529-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hilda,


Thank you for your patch.

Am 29.08.24 um 05:46 schrieb Hilda Wu:
> For tracking multiple devices concurrently with a condition.
> The patch enables the HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk
> on RTL8852B controller.

Please add the controller name also to the commit message summary.

> The quirk setting is based on this commit.
> Commit 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by
> address filter")

… is based on commit 9e14606d8f38 ("Bluetooth: msft: Extended monitor 
tracking by address filter").

> With this setting, when a pattern monitor detects a device, this
> feature issues an address monitor for tracking that device. Let the
> original pattern monitor can keep monitor new devices.

Remove *can*?

Please paste possible Linux message before/after the commit into the 
commit message.

> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Change:
> v3: edit commit log and title
> v2: Add reference commit, update commit description
> ---
> ---
>   drivers/bluetooth/btrtl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 4c0f551a9975..2d95b3ea046d 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1308,6 +1308,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>   			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
>   
>   		if (btrtl_dev->project_id == CHIP_ID_8852A ||
> +		    btrtl_dev->project_id == CHIP_ID_8852B ||
>   		    btrtl_dev->project_id == CHIP_ID_8852C)
>   			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);


Kind regards,

Paul
