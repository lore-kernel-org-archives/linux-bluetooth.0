Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA51EA80
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976082; cv=none; b=WDOaaHv/pVPZom1S7qy1jeArtiKLkquVG93UJGUQNmhnUU3u7ZiCKm7y8v0ZzD7OeW4RI2JCB6OnxlMpuq/wwBgf2M0QYATceEIUfLbwa3fLW7Lr0lry0mUHBMJ+vjST+EP6ImNTkKWpiwVoseWYQq5I/RmXzr3pOgWqmnlSIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976082; c=relaxed/simple;
	bh=iLlULdSttMZirJccFkJuglVwzxGOKhoGgJYd8ERmz/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAgauobwe+oeEdMsRsUrDA6ZDrxC8kb41BdaxtaCnrnf26BlAH9K80uspKMHkQQ0vCws9PUWMril4ANMw0hUk1GbO59s+R+Q8WVWDTmpxu3a33wpvc9KSGtqOVLnlul5CXkYIMvxDqMAcyP/RbLLb27Sgt3ei0kh46qhJiQsCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 61D2561E5FE05;
	Fri, 21 Jun 2024 15:21:09 +0200 (CEST)
Message-ID: <4b62895f-4244-43ae-8b05-22c2f93e24a9@molgen.mpg.de>
Date: Fri, 21 Jun 2024 15:21:08 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_core: cleanup struct hci_dev
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20240621130155.314280-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240621130155.314280-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Dmitry,


Thank you for the patch. Two minor comments. The verb *clean up* is 
spelled with a space:

> Bluetooth: hci_core: Clean up struct hci_dev


Am 21.06.24 um 15:01 schrieb Dmitry Antipov:
> Remove unused and set but otherwise unused 'discovery_old_state'
> and 'sco_last_tx' members of 'struct hci_dev'. The first one is
> a leftover after commit 182ee45da083 ("Bluetooth: hci_sync: Rework
> hci_suspend_notifier"); the second one is originated from ancient
> 2.4.19 and I was unable to find any actual use since that.

Add a Fixes: tag?

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   include/net/bluetooth/hci_core.h | 2 --
>   net/bluetooth/hci_sync.c         | 1 -
>   2 files changed, 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index eaeaf3dc07aa..31020891fc68 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -476,7 +476,6 @@ struct hci_dev {
>   	unsigned int	iso_pkts;
>   
>   	unsigned long	acl_last_tx;
> -	unsigned long	sco_last_tx;
>   	unsigned long	le_last_tx;
>   
>   	__u8		le_tx_def_phys;
> @@ -528,7 +527,6 @@ struct hci_dev {
>   
>   	struct discovery_state	discovery;
>   
> -	int			discovery_old_state;
>   	bool			discovery_paused;
>   	int			advertising_old_state;
>   	bool			advertising_paused;
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index eff648853ae1..511e995f17e0 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5840,7 +5840,6 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
>   		return err;
>   
>   	hdev->discovery_paused = true;
> -	hdev->discovery_old_state = old_state;
>   	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>   
>   	return 0;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
