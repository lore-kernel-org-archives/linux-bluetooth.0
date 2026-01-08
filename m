Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1880FC0A;
	Thu,  8 Jan 2026 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840828; cv=none; b=ozwS4yrTbLSDIQWNFFUu3PrVr8kE+citRnDnm4zPn3LDk3gR3wDUQBMDZyw+N5mYj8h3u+xwz4wRn4YJap26WyxJSAp2VMpNcuOmSZCi1NZlT6Z+i9+n7HqHfDWF+761RnJUfFjzHVCHZTOjDrlWp3pfRMSpSqq3lJez7Hhhgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840828; c=relaxed/simple;
	bh=5c6qmgQmTSrPKJBaKpW+7/RNI5Cqpt2mCKDJv1+8fPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD+YQq8zjRzO34p8qaq+yGUyxpTBvKOf3X3vQm6nRcgRrHuwAeLakF2uqQoGDfwVALjfD5UhFWDvYmDYfDtGRNfjh7Vf3SmYzQuaNWx/xIEEWwGy4g5dq+pb7IgJ9oBRoW4sme3dkx9YL4bvWwPNAmFZcaJQ/+IfrhKkjenoap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 24f74082ec3d11f0a38c85956e01ac42-20260108
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:62cd14f3-7aa6-4e90-b5ea-c4941cd1e3b8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:7fefca052aa9002b05eefe3eb0f1a854,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 24f74082ec3d11f0a38c85956e01ac42-20260108
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 210334671; Thu, 08 Jan 2026 10:53:00 +0800
Message-ID: <19c219ec-a4a2-45a1-b50c-db42fb6db4be@kylinos.cn>
Date: Thu, 8 Jan 2026 10:52:57 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Reject autosuspend if discovery is
 active
To: luiz.dentz@gmail.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
References: <CABBYNZ+Zq2HYsfGbOi7V=pnV1GczSv6--rMEbi+=yCXE4p+-6g@mail.gmail.com>
 <20260108020633.1729637-1-lilinmao@kylinos.cn>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <20260108020633.1729637-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/1/8 10:06, Linmao Li 写道:

> If USB autosuspend occurs while discovery is active, the ongoing
> HCI operation may not complete successfully. On some devices, this
> can leave discovery.state stuck in DISCOVERY_FINDING.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>   drivers/bluetooth/btusb.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ded09e94d296..565e276be3b2 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4469,10 +4469,11 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>   
>   	BT_DBG("intf %p", intf);
>   
> -	/* Don't auto-suspend if there are connections; external suspend calls
> -	 * shall never fail.
> +	/* Don't auto-suspend if there are connections or discovery in
> +	 * progress; external suspend calls shall never fail.
>   	 */
> -	if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
> +	if (PMSG_IS_AUTO(message) &&
> +	    (hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
>   		return -EBUSY;
>   
>   	if (data->suspend_count++)
Hi Luiz,

I found that hci_discovery_active() is not exported, so btusb as a
module cannot use it:

ERROR: modpost: "hci_discovery_active" [drivers/bluetooth/btusb.ko] 
undefined!

Should I send a separate patch to export hci_discovery_active(), or
revert to v1 using test_bit(HCI_INQUIRY) and hci_dev_test_flag(HCI_LE_SCAN)?

Best regards,
Linmao
