Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69C19FA9F
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145452; cv=none; b=O1jkL+ya/bcJ0O0rKzSjadPu73GOTI11hyado6edDfZYrKDxzgR3plpH0/1XbPW1sRwBUXk0usLvbHbELnjoQTGik5cVDFHGb4pJbH27xKtM9NH6kxn1tNgkW3M7N9hOYgAd4R7Qs/A1Xewue/2e7YY8bGFv6U58eCA51/eJekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145452; c=relaxed/simple;
	bh=6BLzLB+GG2joEMn+yeyuC3I97EKhKWJsTvKNGXJbQQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=uxpM2dl86F7QX4FOP31/ujnYzQjTcyDzMDgcpZFkMggvggIpXun9wRrRLBMYbbuJaD7XWDbsPMBxCxQtmU1eGIsmJ/w4MqFLKyV1vqMYacLZc8GxKA8T6a5jmS5AZ2krv55sNGlTYrzhWNYIunMFIGBC0O2GuOFslnYJyNSSats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af178.dynamic.kabel-deutschland.de [95.90.241.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 402B661E5FE05;
	Tue, 16 Jul 2024 17:57:17 +0200 (CEST)
Message-ID: <ef3fef97-d090-4fa4-8053-58125e7c030e@molgen.mpg.de>
Date: Tue, 16 Jul 2024 17:57:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix suspending with wrong filter
 policy
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240716150126.512727-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20240716150126.512727-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for the patch. Four minor comments.

Am 16.07.24 um 17:01 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When suspending the scan filter policy cannot be 0x00 (no acceptlist)
> since that means the host has to process every advertisement report
> waking up the system, so this attempts to check if hdev is marked as
> suspended and if the resulting filter policy would be 0x00 (no
> acceptlist) then skip passive scanning if thre no devices in the

there are

> acceptlist otherwise reset the filter policy to 0x01 so the acceptlist
> is used since the devices programmed there can still wakeup be system.

wake the system up?

> Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_sync.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index cd2ed16da8a4..a31d39a821f4 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2976,6 +2976,27 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
>   	 */
>   	filter_policy = hci_update_accept_list_sync(hdev);
>   
> +	/* If suspended and filter_policy set to 0x00 (no acceptlist) then
> +	 * passive scanning cannot be started since that would require the host
> +	 * to be woken up to process the reports.
> +	 */
> +	if (hdev->suspended && !filter_policy) {
> +		/* Check if accept list is empty then there is no need to scan
> +		 * while suspended.
> +		 */
> +		if (list_empty(&hdev->le_accept_list))
> +			return 0;
> +
> +		/* If there are devices is the accept_list that means some

i*n* the

> +		 * devices could not be programmed which in non-suspended case
> +		 * means filter_policy needs to be set to 0x00 so the host needs
> +		 * to filter, but since this is treating suspended case we
> +		 * can ignore device needing host to filter to allow devices in
> +		 * the acceptlist to be able to wakeup the system.

to wake up

> +		 */
> +		filter_policy = 0x01;
> +	}
> +
>   	/* When the controller is using random resolvable addresses and
>   	 * with that having LE privacy enabled, then controllers with
>   	 * Extended Scanner Filter Policies support can now enable support


Kind regards,

Paul
