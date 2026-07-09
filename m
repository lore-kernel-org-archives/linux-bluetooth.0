Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978E3C342B;
	Thu,  9 Jul 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581977; cv=none; b=HBgqQ8co/Qx3mom/rGt7NWWT+qFBVezZBbO1rw5MVQIc/VUYZ87r2upkOOw5dpiRpl5vf2Vp6wZimnvLyFvTBCPALWL1Ah0gjRSkLs1OuuVlnyC2JxmSX5E4hxJbkZHp+yA9UMCQ824TrFy6OUJzSBEmEBzE5c/96Lr5XbcIBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581977; c=relaxed/simple;
	bh=MmQrnX3IFMx9jVADwFhcRhKr0DDNF01lUw9/K2ne7MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMuP4dRamLNTIvVIdeTHLciAhc+px4/hcMOQG8xEIlcE7e5XmFnIn3MnRws4ulj0Tpu7Yfdn0dqIRYFcczXDboVUqSHhqA8ZjyT5uss8Ob+S4h3WrClKEjG2wPI0BPTRsPFYWeXZS31kYwK+T07roCPoxwLri53qbtEXE/QSYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.150] (ip5f5af733.dynamic.kabel-deutschland.de [95.90.247.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BDEF14C288718F;
	Thu, 09 Jul 2026 09:26:02 +0200 (CEST)
Message-ID: <435c7cb7-945e-47c2-b70a-dff137f03699@molgen.mpg.de>
Date: Thu, 9 Jul 2026 09:26:01 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_qca: Clear memdump state on invalid dump
 size
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <20260709062250.4166128-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260709062250.4166128-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Zijun Hu from Qualcomm]

Dear Ruoyu,


Thank you for your patch.

Am 09.07.26 um 08:22 schrieb Ruoyu Wang:
> qca_controller_memdump() allocates qca->qca_memdump before processing
> the first dump packet. For a sequence-zero packet it then disables IBS,
> marks memdump collection active, and reads the advertised dump size.
> 
> If the controller reports a zero dump size, the error path frees the
> local qca_memdump object and returns without clearing qca->qca_memdump
> or undoing the collection state. A later memdump work item initializes
> its local pointer from qca->qca_memdump and skips allocation when that
> pointer is non-NULL, so it can operate on freed memory. The stale
> collection and IBS-disabled flags can also leave waiters or later
> transmit handling blocked behind an aborted dump.
> 
> Clear the saved pointer and memdump state before returning from the
> invalid-size path, matching the cleanup used when hci_devcd_init() fails.
> 
> A static analysis checker reported the stale memdump state, and manual
> source review confirmed the invalid-size failure path.
> 
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   drivers/bluetooth/hci_qca.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b2d1ee3a3d115..1222f97800f4a 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1087,6 +1087,10 @@ static void qca_controller_memdump(struct work_struct *work)
>   			if (!(qca_memdump->ram_dump_size)) {
>   				bt_dev_err(hu->hdev, "Rx invalid memdump size");
>   				kfree(qca_memdump);
> +				qca->qca_memdump = NULL;
> +				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
> +				clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +				clear_bit(QCA_IBS_DISABLED, &qca->flags);
>   				kfree_skb(skb);
>   				mutex_unlock(&qca->hci_memdump_lock);
>   				return;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: gemini/gemini-3.1-pro-preview commented on several pre-existing 
issues [1], ideally Qualcomm would look at.

[1]: 
https://sashiko.dev/#/patchset/20260709062250.4166128-1-ruoyuw560%40gmail.com
