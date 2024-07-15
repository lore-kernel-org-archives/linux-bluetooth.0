Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13E18F2D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055615; cv=none; b=b3qYdl2onwMR/JbRf/CWCP0oocb24vl96OuGiHsZ2mixR3QQSvosGxZRCuF9UpZm3CjY/matybh0+YrD/7iI7/pKwK4FF+5o97tmyDAhC6uYBIF7YySsuFIEglqLAJDd+qNlRYD3BegrqQBgb6euYqVWSwC561mFDe0NJt8OyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055615; c=relaxed/simple;
	bh=ZRh27qwaOy1D50Ut/0InVaHyGWEefYBVm7CSPXM0Y3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=i9cD4D86W9hcxm5VbjVc1ImgckZmYS5qMZ9oc6vslxQkuUw3z6yismNdA54RVHY2JgaaIe227hUAs/KAKFkoyvPMO0KMHoF7l6ZtMP2Pv0cM1dn8dIJXfhKpekbNScIdCe84zlUaPPNPubQ0MnbmhubHwVj/WhTcO2E50AUQSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.47.230] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AEDEE61E5FE36;
	Mon, 15 Jul 2024 17:00:00 +0200 (CEST)
Message-ID: <4fd7e7bc-43de-4a67-bff0-889fc0b24fdd@molgen.mpg.de>
Date: Mon, 15 Jul 2024 16:59:56 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix suspending with wrong filter
 policy
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240715144730.311392-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240715144730.311392-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for the patch.

Am 15.07.24 um 16:47 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When suspending the scan filter policy cannot be 0x00 (no acceptlist)
> since that means the host has to process every advertisement report
> waking up the system, so this attempt to check if hdev is marked as

attempt*s*

> suspended and the resulting filter policy would be 0x00 (no acceptlist)

… *if* the …?

> then skip passive scanning.
> 
> Note: This disables remote wakeup for devices using privacy when LL
> privacy is not enabled since that would require the controller to
> resolve the addresses.

Would that regress certain use-cases?

> Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_sync.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index cd2ed16da8a4..0996f159c675 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2976,6 +2976,13 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
>   	 */
>   	filter_policy = hci_update_accept_list_sync(hdev);
>   
> +	/* If suspended and filter_policy set to 0x00 (no acceptlist) then
> +	 * passive scanning cannot be started since that would require the host
> +	 * to be wakeup.

to be woken up

> +	 */
> +	if (hdev->suspended && !filter_policy)
> +		return 0;
> +
>   	/* When the controller is using random resolvable addresses and
>   	 * with that having LE privacy enabled, then controllers with
>   	 * Extended Scanner Filter Policies support can now enable support


Kind regards,

Paul
