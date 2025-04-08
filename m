Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B620CCD8
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105052; cv=none; b=B6p/YM6YHuSK8igtbzR9BmjbaLbF8bTqRxNiNs2CIYBjU4ViNWDtkijv3803Sj9Dz6tOwLCBqgY8Nsz+x7RM1Uf3FMhiv/E/yCAGFBbmSwVyy7GZ7W1HXXwpgj52kQwmJznq+f2H2HMgVervp67Ejy/mJexFBX8XntRlBz1vaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105052; c=relaxed/simple;
	bh=I6cJUdFJXRoy3lC1VOhonP7thtChsfvGa5IOWUa39Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stFYQp7c+BUrNUGqMsNC+kaOT0m5nTEDF+p2/h0k6vgvnCpNp0YCqtvnzVY3ZO/FiOP0RUe3RTUgUkm11JRiSbMmvu5zSl4Wgk1BvpU+ovigfNKmsSaSWlIVzoIvU6zEKT9Q4Q8ZNQYWLFn9ASkCAJEO3vAaU4vSKosjIoh2DxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 370BC61E647BB;
	Tue, 08 Apr 2025 11:37:23 +0200 (CEST)
Message-ID: <4db1b876-afa7-4ccb-be2f-36974669f269@molgen.mpg.de>
Date: Tue, 8 Apr 2025 11:37:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Establishing ACL links is
 prohibited when power off
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com,
 quic_chezhou@quicinc.com, quic_zijuhu@quicinc.com,
 quic_mohamull@quicinc.com, linux-bluetooth@vger.kernel.org
References: <20250408024646.1784057-1-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250408024646.1784057-1-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Shuai,


Thank you for your patch. Some minor comments.

It’d be great if you made the summary/title a statement about the action 
of the patch and not about the issue. Maybe:

Prohibit establishing of ACL links during poweroff


Am 08.04.25 um 04:46 schrieb Shuai Zhang:
> If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
> to be left in cmd_sync_work_list. Then the driver will try to send
> the HCI command of creating connection but failed.

s/failed/fails/

> When establishing ACL link, add judgment for BT power off.

Maybe:

Check if the device is *not* starting up, that means powering off, when 
establishing the ACL link, and cancel early in this case.


It’d be great if you documented how to reproduce the bug and test the patch.

> Change-Id: I9844a1ce1f207453e4fadeded3da1738eb4660c9
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>   net/bluetooth/hci_sync.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index aeeadb45e..fdd57132e 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6761,7 +6761,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
>   	struct hci_cp_create_conn cp;
>   	int err;
> 
> -	if (!hci_conn_valid(hdev, conn))
> +	if (!hci_conn_valid(hdev, conn) || !test_bit(HCI_UP, &hdev->flags))
>   		return -ECANCELED;
> 
>   	/* Many controllers disallow HCI Create Connection while it is doing
> --
> 2.34.1

The diff looks reasonable.


Kind regards,

Paul
