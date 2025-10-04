Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B417A2EA
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759592802; cv=none; b=Mt0G5lI3cFlF2jFUvTtftveNbXht3RBl6c6zTJq/zCIsymQGD4By0rB5rzoYJ0p9DMIsEKjJ/Cin0k84hSqXO6n3HL7z0kgRBMWFQ95TX81Ba4HW6AFH/drUumUPMa3U68WF3v61GYvDimm5dph6IzyGjJ6yiknWHEDvQMVsThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759592802; c=relaxed/simple;
	bh=VbX8hUKM7U8TbdyIsTURBk2JLfWJpTjXvRwJwBZOyRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=VVD8huF/2hikKffPmqPxL1CFK9E26Rv8CBhsbUNUdlbbJsBYib6owZQVMQ+rwdn7B9pkKg6eZZCdurGh5bfNgOPGFwY70kkoru1N1PstHXJf9Wy6KdciQPUQrKLdtE/5kJJFd03ogBpkbjSByNlKrJ7P6e346Vcwf4di0RYcn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p57bd9ba3.dip0.t-ipconnect.de [87.189.155.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AFABC61E647BA;
	Sat, 04 Oct 2025 17:46:19 +0200 (CEST)
Message-ID: <eea69851-226e-4e39-aadd-42453fa1bf27@molgen.mpg.de>
Date: Sat, 4 Oct 2025 17:46:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: MGMT: fix crash in set_mesh_sync and
 set_mesh_complete
To: Pauli Virtanen <pav@iki.fi>
References: <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for your patch.


Am 03.10.25 um 21:07 schrieb Pauli Virtanen:
> There is a BUG: KASAN: stack-out-of-bounds in set_mesh_sync due to
> memcpy from badly declared on-stack flexible array.
> 
> Another crash is in set_mesh_complete() due to double list_del via
> mgmt_pending_valid + mgmt_pending_remove.
> 
> Use DEFINE_FLEX to declare the flexible array right, and don't memcpy
> outside bounds.
> 
> As mgmt_pending_valid removes the cmd from list, use mgmt_pending_free,
> and also report status on error.
> 
> Fixes: 302a1f674c00d ("Bluetooth: MGMT: Fix possible UAFs")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>   include/net/bluetooth/mgmt.h |  2 +-
>   net/bluetooth/mgmt.c         | 26 +++++++++++++++-----------
>   2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 74edea06985b..bca0333f1e99 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -853,7 +853,7 @@ struct mgmt_cp_set_mesh {
>   	__le16 window;
>   	__le16 period;
>   	__u8   num_ad_types;
> -	__u8   ad_types[];
> +	__u8   ad_types[] __counted_by(num_ad_types);
>   } __packed;
>   #define MGMT_SET_MESH_RECEIVER_SIZE	6
>   
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a3d16eece0d2..24e335e3a727 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2175,19 +2175,24 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
>   	sk = cmd->sk;
>   
>   	if (status) {
> +		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
> +				status);
>   		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
>   				     cmd_status_rsp, &status);
> -		return;
> +		goto done;
>   	}
>   
> -	mgmt_pending_remove(cmd);
>   	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, NULL, 0);
> +
> +done:
> +	mgmt_pending_free(cmd);
>   }
>   
>   static int set_mesh_sync(struct hci_dev *hdev, void *data)
>   {
>   	struct mgmt_pending_cmd *cmd = data;
> -	struct mgmt_cp_set_mesh cp;
> +	DEFINE_FLEX(struct mgmt_cp_set_mesh, cp, ad_types, num_ad_types,
> +		    sizeof(hdev->mesh_ad_types));
>   	size_t len;
>   
>   	mutex_lock(&hdev->mgmt_pending_lock);
> @@ -2197,27 +2202,26 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
>   		return -ECANCELED;
>   	}
>   
> -	memcpy(&cp, cmd->param, sizeof(cp));
> +	len = cmd->param_len;
> +	memcpy(cp, cmd->param, min(__struct_size(cp), len));
>   
>   	mutex_unlock(&hdev->mgmt_pending_lock);
>   
> -	len = cmd->param_len;
> -
>   	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
>   
> -	if (cp.enable)
> +	if (cp->enable)
>   		hci_dev_set_flag(hdev, HCI_MESH);
>   	else
>   		hci_dev_clear_flag(hdev, HCI_MESH);
>   
> -	hdev->le_scan_interval = __le16_to_cpu(cp.period);
> -	hdev->le_scan_window = __le16_to_cpu(cp.window);
> +	hdev->le_scan_interval = __le16_to_cpu(cp->period);
> +	hdev->le_scan_window = __le16_to_cpu(cp->window);
>   
> -	len -= sizeof(cp);
> +	len -= sizeof(struct mgmt_cp_set_mesh);
>   
>   	/* If filters don't fit, forward all adv pkts */
>   	if (len <= sizeof(hdev->mesh_ad_types))
> -		memcpy(hdev->mesh_ad_types, cp.ad_types, len);
> +		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
>   
>   	hci_update_passive_scan_sync(hdev);
>   	return 0;

Would it be possible to make this two commits? Either way:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
