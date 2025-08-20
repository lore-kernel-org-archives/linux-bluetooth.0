Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81165280325
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704662; cv=none; b=Utsw12jXnAhjGJCXdC4h/VoC9UC4cFkMzTiZXRXsVmwr8PE8Zmo8YSuEnjZ9yqPyFYj1UeQlR0bwjUgTXxpK6qHqaJun/vyisouH6fORHSYZQ+QHyBiHCtH1YHI9vktsVrdHgr66OI19IN9cRZ2Vzk/+XiyQwJd+zg52t7Iaumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704662; c=relaxed/simple;
	bh=MHJyk/clSGwfG3EiEfu4nQBV/+Ii8FtW4xfCp8pmsmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mtzZH4PfNzZ1KFFQtM/1PSw4uTma+kfexJkLgNZXGmWf83zxuxOqzY87rV0xuGG01GvpdyNiyn2PNiNpGpCs4Pnz0FTg2tRhbKWiSB7ZUflzsIZjXhsBFRRCV3oxMU3Xj8UOSnNyvhrd1JYR6cIR5XpDGhPD0wh0f5FgdUyvywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9507060288273;
	Wed, 20 Aug 2025 17:44:14 +0200 (CEST)
Message-ID: <668b4ac0-705f-4135-9ff4-4b27976b33d2@molgen.mpg.de>
Date: Wed, 20 Aug 2025 17:44:14 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix not exposing debug UUID on
 MGMT_OP_READ_EXP_FEATURES_INFO
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250820145829.1766185-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250820145829.1766185-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for the patch.

Am 20.08.25 um 16:58 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The debug UUID was only getting set if MGMT_OP_READ_EXP_FEATURES_INFO
> was not called with a specific index which breaks the likes of
> bluetoothd since it only invokes MGMT_OP_READ_EXP_FEATURES_INFO when an
> adapter is plugged, so instead of depending hdev not to be set just
> enable the UUID on any index like it was done with iso_sock_uuid.
> 
> Fixes: e625e50ceee1 ("Bluetooth: Introduce debug feature when dynamic debug is disabled")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/mgmt.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3166f5fb876b..2db93b70e07f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4413,13 +4413,11 @@ static int read_controller_cap(struct sock *sk, struct hci_dev *hdev,
>   				 rp, sizeof(*rp) + cap_len);
>   }
>   
> -#ifdef CONFIG_BT_FEATURE_DEBUG
>   /* d4992530-b9ec-469f-ab01-6c481c47da1c */
>   static const u8 debug_uuid[16] = {
>   	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
>   	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
>   };
> -#endif
>   
>   /* 330859bc-7506-492d-9370-9a6f0614037f */
>   static const u8 quality_report_uuid[16] = {
> @@ -4468,15 +4466,13 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>   	if (!rp)
>   		return -ENOMEM;
>   
> -#ifdef CONFIG_BT_FEATURE_DEBUG
> -	if (!hdev) {
> +	if (IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)) {
>   		flags = bt_dbg_get() ? BIT(0) : 0;
>   
>   		memcpy(rp->features[idx].uuid, debug_uuid, 16);
>   		rp->features[idx].flags = cpu_to_le32(flags);
>   		idx++;
>   	}
> -#endif
>   
>   	if (hdev && hci_dev_le_state_simultaneous(hdev)) {
>   		if (hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
