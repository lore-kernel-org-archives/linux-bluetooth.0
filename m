Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE72E36EC
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553727; cv=none; b=hWaKouCf+IkGiUf9WAqjn6urLyCnWkAxeYHhRzx8CJxnas/WLzvleCFC60bbtWoXn274ABOERqhUXIjiqY987LPOWKKcco6haidGNK8Hr5rABaZMWY/xdrub0jfuQdrxmYpXggyYMGl7L+luBGEWZGHE6fc/y6R/Xix0hsU0OUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553727; c=relaxed/simple;
	bh=yMGQpr25tEvNWl/Q7CJMMKRRIRvuCSZHBm+SirF4RPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=L/nXfD9FzARDJnNIU0y5AVOjB9bY6qKz1aNLjAPWHlM9kWbS8YXtnNmFB4uqO3B3Wu1A5+e2FDsAizext2EBx+AqhES+wvRh/WiURjgvq5aE3wOwywvvnMMzelixhCYYXd2hPr65+xxszoLQKfzH1WEAMrVfsJPnXJ77BYFTr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c7.dynamic.kabel-deutschland.de [95.90.247.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 43FF361E647BB;
	Thu, 07 Aug 2025 10:01:51 +0200 (CEST)
Message-ID: <b6d7ab5c-6276-413d-9218-1d83bd5cb068@molgen.mpg.de>
Date: Thu, 7 Aug 2025 10:01:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_core: Fix using ll_privacy_capable
 for current settings
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250806194836.291949-1-luiz.dentz@gmail.com>
 <20250806194836.291949-2-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250806194836.291949-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 06.08.25 um 21:48 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ll_privacy_capable only indicates that the controller supports the
> feature but it doesnt' check that LE is enabled so it end up being
> marked as active in the current settings when it shouldn't.
> 
> Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   include/net/bluetooth/hci_core.h | 1 +
>   net/bluetooth/mgmt.c             | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index bc29f2e2e16f..bb30bde6f0e8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1934,6 +1934,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>   			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
>   
>   #define ll_privacy_capable(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
> +#define ll_privacy_enabled(dev) (le_enabled(dev) && ll_privacy_capable(dev))
>   
>   #define privacy_mode_capable(dev) (ll_privacy_capable(dev) && \
>   				   ((dev)->commands[39] & 0x04))
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index c42dffe77daf..3166f5fb876b 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -934,7 +934,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
>   	if (sync_recv_enabled(hdev))
>   		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
>   
> -	if (ll_privacy_capable(hdev))
> +	if (ll_privacy_enabled(hdev))
>   		settings |= MGMT_SETTING_LL_PRIVACY;
>   
>   	return settings;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
