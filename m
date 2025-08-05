Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE327217F36
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754424280; cv=none; b=CAin7gvPPAiHIMAJbHJL46JKK8/n3frneIoiGt7PjjRpTxr6GSAmtkbEO0t7W0cyAXkO4dCwwNY1rpazMltMmMR8Clx3i+JUCutRimIWCc8K68jl3BEWYf/EHYH1/vH8BMcn6WCjtiGfcSvaX9eEg4WgvS1vi5r+tjqU+5yA7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754424280; c=relaxed/simple;
	bh=/wXIzCeyN/RHMrgWV4UGGHo2GVTa44eW/cCDMiYsBuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzME/Aq6Qz7E7TydT1dtTCvpjAWWI42rXHVPQwIdSi5T288dFCWxfNXfeQpoKaU9mtsKq8431n3I6xwGs0IKVphhbqU7AQLevoDSeILWUfZX45Ua2mcZuSN5cdubLWkdI1dzeNQeiCGuX8FCo5DzMnBo+I0Idhzza4SnCNjY3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7fe.dynamic.kabel-deutschland.de [95.90.247.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B70FA61E64849;
	Tue, 05 Aug 2025 22:04:08 +0200 (CEST)
Message-ID: <2e3a2649-ab92-4acb-b55a-6b05848a61ab@molgen.mpg.de>
Date: Tue, 5 Aug 2025 22:04:07 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_conn: do return error from
 hci_enhanced_setup_sync()
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>
References: <14e5f8f1-1f93-461d-9cc7-57e1f0b57911@omp.ru>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <14e5f8f1-1f93-461d-9cc7-57e1f0b57911@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sergey,


Thank you for your patch.

Am 05.08.25 um 21:14 schrieb Sergey Shtylyov:
> The commit e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to
> hci_sync") missed to update the *return* statement under the *case* of
> BT_CODEC_TRANSPARENT in hci_enhanced_setup_sync(), which led to returning
> success (0) instead of the negative error code (-EINVAL).  However, the
> result of hci_enhanced_setup_sync() seems to be ignored anyway, since NULL
> gets passed to hci_cmd_sync_queue() as the last argument in that case and
> the only function interested in that result is specified by that argument.
> 
> Fixes: e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to hci_sync")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> The patch is against the master branch of the bluetooth.git repo...
> 
>   net/bluetooth/hci_conn.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: bluetooth/net/bluetooth/hci_conn.c
> ===================================================================
> --- bluetooth.orig/net/bluetooth/hci_conn.c
> +++ bluetooth/net/bluetooth/hci_conn.c
> @@ -339,7 +339,8 @@ static int hci_enhanced_setup_sync(struc
>   	case BT_CODEC_TRANSPARENT:
>   		if (!find_next_esco_param(conn, esco_param_msbc,
>   					  ARRAY_SIZE(esco_param_msbc)))
> -			return false;
> +			return -EINVAL;
> +
>   		param = &esco_param_msbc[conn->attempt - 1];
>   		cp.tx_coding_format.id = 0x03;
>   		cp.rx_coding_format.id = 0x03;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
