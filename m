Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623A23236D;
	Thu, 14 Aug 2025 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151959; cv=none; b=JKogVMi8C9RUR6dWKGOfkJIOTAV37ethM0iuGRhXhuDgS4O7jp/1pfxk+cQGw0hLx3RyRo72h6hsi+RAcMYXSSa66t2+k2QXWHT3F8G4qgxebWMV0oEHXHW/yfPSWylF5IgHXgBEbzGv4UaDvPM3/U0WLI5k5QPWkjPV6L5J+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151959; c=relaxed/simple;
	bh=HhqdTqAQI61cMeGuephxSYD7Bpb9wxpphea/hzUc40s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNznKCUMPM64w7cdk6cFtOp5swFk9tEuwjdFDs4YncP5glVBnExE+1xUsrYR0B6JWoXLk5i1XtXBPh4/Sysn02JYbHIEU/1em6AxKpxQ6K5lrZXL/IKoSQjJeehr39dx1wgXqwcHty+5/8dovrAxV3Cn8WyTuvL8uMPpA7z7A+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7f5.dynamic.kabel-deutschland.de [95.90.247.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7344361E647BA;
	Thu, 14 Aug 2025 08:12:05 +0200 (CEST)
Message-ID: <3a75e696-d634-40d4-bd6d-1ee9e87cb5e2@molgen.mpg.de>
Date: Thu, 14 Aug 2025 08:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: fix rtl_dump.fw_version for firmware v2
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Lu <alex_lu@realsil.com.cn>, Hilda Wu <hildawu@realtek.com>
References: <20250814025552.10627-1-liujiajia@kylinos.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250814025552.10627-1-liujiajia@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Alex, +Hilda]

Dear Jiajia,


Thank you for the patch.

Am 14.08.25 um 04:55 schrieb Jiajia Liu:
> rtl_dump.fw_version is not set for firmware v2. Since
> rtl_epatch_header_v2.fw_version seems to be different with the
> release version, set it to the fw version read after downloading
> firmware.

What is the released version, and what value does it have?

Please add, how your patch can be tested.

> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>   drivers/bluetooth/btrtl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 6abd962502e3..6ad3ba7901e9 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -822,6 +822,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>   	int j = 0;
>   	struct sk_buff *skb;
>   	struct hci_rp_read_local_version *rp;
> +	struct btrealtek_data *coredump_info = hci_get_priv(hdev);
>   
>   	dl_cmd = kmalloc(sizeof(*dl_cmd), GFP_KERNEL);
>   	if (!dl_cmd)
> @@ -873,6 +874,9 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>   	rp = (struct hci_rp_read_local_version *)skb->data;
>   	rtl_dev_info(hdev, "fw version 0x%04x%04x",
>   		     __le16_to_cpu(rp->hci_rev), __le16_to_cpu(rp->lmp_subver));
> +	if (coredump_info->rtl_dump.fw_version == 0)
> +		coredump_info->rtl_dump.fw_version =
> +			__le16_to_cpu(rp->hci_rev) << 16 | __le16_to_cpu(rp->lmp_subver);
>   	kfree_skb(skb);
>   
>   out:


Kind regards,

Paul
