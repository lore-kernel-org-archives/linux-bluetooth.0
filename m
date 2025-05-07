Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2421F5F6;
	Wed,  7 May 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603999; cv=none; b=tV6tsGGg9/luEb4oUKrShmAuRTDZvTqT/aZrtkSikTf6PHRMHdren3izaVi6PICpYvy2V+3wv9e4i3J4g6kKPObBlw0gfz4d9TqKUlp52xVPBlmNznJ414+/3mo8JeRgmGP4icry0NclGAxMDaPOx8y24ftGw6s4oAJrpFn39fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603999; c=relaxed/simple;
	bh=CSJbBMxbiFZ9Dwrizn0+7PYBa9x5P9Q4GNd96rnCSSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrIX0g1lBhxbUyLqifpNTSy5goNmWc9tfR3BRUgthw96Q7kFPtbzn+hDbfiLx+kX1flvmGsfIkV8/oC604N1Mpejyp95z9ow4lG5+n4dhaa+PlRZhduTfux2TMW9uAColLaFnm65+IukPUYJ32pSRaYy4T5gFsfPVsvfILCCvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af47d.dynamic.kabel-deutschland.de [95.90.244.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D000161EA1BF8;
	Wed, 07 May 2025 09:46:24 +0200 (CEST)
Message-ID: <98f52c3b-349f-4a32-9a47-443996c95bd5@molgen.mpg.de>
Date: Wed, 7 May 2025 09:46:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: fix socket matching ambiguity between BIS and
 CIS
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507-iso-v1-1-6f60d243e037@amlogic.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250507-iso-v1-1-6f60d243e037@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Yang,


Thank you for your patch.

Am 07.05.25 um 09:30 schrieb Yang Li via B4 Relay:
> From: Yang Li <yang.li@amlogic.com>

It’d be great if you could start by describing the problem.

> The iso_get_sock function adds dst address matching to
> distinguish BIS and CIS sockets.
> 
> Link: https://github.com/bluez/bluez/issues/1224

How can this patch be tested?

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>   net/bluetooth/hci_event.c | 35 ++++++++++++++++++++---------------
>   net/bluetooth/iso.c       | 12 +++++++++---
>   2 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..c1f32e98ef8a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6413,6 +6413,8 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
>   
>   	conn->sync_handle = le16_to_cpu(ev->handle);
>   	conn->sid = HCI_SID_INVALID;
> +	conn->dst = ev->bdaddr;
> +	conn->dst_type = ev->bdaddr_type;
>   
>   	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, BIS_LINK,
>   				      &flags);
> @@ -6425,7 +6427,8 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
>   		goto unlock;
>   
>   	/* Add connection to indicate PA sync event */
> -	pa_sync = hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
> +

Why the extra blank line?

> +	pa_sync = hci_conn_add_unset(hdev, BIS_LINK, &ev->bdaddr,
>   				     HCI_ROLE_SLAVE);
>   
>   	if (IS_ERR(pa_sync))


Kind regards,

Paul


> @@ -6456,13 +6459,6 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
>   
>   	hci_dev_lock(hdev);
>   
> -	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
> -	if (!(mask & HCI_LM_ACCEPT))
> -		goto unlock;
> -
> -	if (!(flags & HCI_PROTO_DEFER))
> -		goto unlock;
> -
>   	pa_sync = hci_conn_hash_lookup_pa_sync_handle
>   			(hdev,
>   			le16_to_cpu(ev->sync_handle));
> @@ -6470,6 +6466,13 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
>   	if (!pa_sync)
>   		goto unlock;
>   
> +	mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
> +	if (!(mask & HCI_LM_ACCEPT))
> +		goto unlock;
> +
> +	if (!(flags & HCI_PROTO_DEFER))
> +		goto unlock;
> +
>   	if (ev->data_status == LE_PA_DATA_COMPLETE &&
>   	    !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
>   		/* Notify iso layer */
> @@ -6993,6 +6996,8 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>   			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
>   
>   		bis->sync_handle = conn->sync_handle;
> +		bis->dst = conn->dst;
> +		bis->dst_type = conn->dst_type;
>   		bis->iso_qos.bcast.big = ev->handle;
>   		memset(&interval, 0, sizeof(interval));
>   		memcpy(&interval, ev->latency, sizeof(ev->latency));
> @@ -7038,13 +7043,6 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>   
>   	hci_dev_lock(hdev);
>   
> -	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
> -	if (!(mask & HCI_LM_ACCEPT))
> -		goto unlock;
> -
> -	if (!(flags & HCI_PROTO_DEFER))
> -		goto unlock;
> -
>   	pa_sync = hci_conn_hash_lookup_pa_sync_handle
>   			(hdev,
>   			le16_to_cpu(ev->sync_handle));
> @@ -7054,6 +7052,13 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>   
>   	pa_sync->iso_qos.bcast.encryption = ev->encryption;
>   
> +	mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
> +	if (!(mask & HCI_LM_ACCEPT))
> +		goto unlock;
> +
> +	if (!(flags & HCI_PROTO_DEFER))
> +		goto unlock;
> +
>   	/* Notify iso layer */
>   	hci_connect_cfm(pa_sync, 0);
>   
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 6e2c752aaa8f..1dc233f04dbe 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -641,11 +641,12 @@ static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
>   			continue;
>   
>   		/* Exact match. */
> -		if (!bacmp(&iso_pi(sk)->src, src)) {
> +		if (!bacmp(&iso_pi(sk)->src, src)
> +		     && !bacmp(&iso_pi(sk)->dst, dst)
> +			){
>   			sock_hold(sk);
>   			break;
>   		}
> -
>   		/* Closest match */
>   		if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
>   			if (sk1)
> @@ -1962,7 +1963,7 @@ static void iso_conn_ready(struct iso_conn *conn)
>   		}
>   
>   		if (!parent)
> -			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
> +			parent = iso_get_sock(&hcon->src, &hcon->dst,
>   					      BT_LISTEN, NULL, NULL);
>   
>   		if (!parent)
> @@ -2203,6 +2204,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
>   	} else {
>   		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>   				  BT_LISTEN, NULL, NULL);
> +		if (!sk)
> +			sk = iso_get_sock(&hdev->bdaddr, bdaddr,
> +					  BT_LISTEN, NULL, NULL);
> +		else
> +			iso_pi(sk)->dst = *bdaddr;
>   	}
>   
>   done:
