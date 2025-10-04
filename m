Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC14CA5E
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594288; cv=none; b=qn8WgtHnzpir1yOYYR0Zkg6V+YgtFYbLWVXOzH/dVppvqcQH94ZOzJZRXnfIpbxekQOhXVPHZXUMiKfYyyApAEI6AxqnckrDtvU3dCO8jnO7Lp2FQGocKxe4mgFkb/W/jNBuEEPxwpmNvlrjkhp4+s4AKZIMrQyIHB09Lhu72Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594288; c=relaxed/simple;
	bh=SxkAkB4sjVB5gnO6NAa283JuH/v+ztggRmT7Lz0fdRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAa4+kEka5i7BXQQo+gzrDS7RfxgYWCZooTR/0ws7idqVsMS7c97RTCH84dG8W5jf2Yl07enqMhSN0tLlX/6Nscwd73lsMAwK2T0kK4quN2v2vTrTUrOD7uRd/KzEr9r/2WUUkxy7qbPnlVSqNASNntkYLqe1A25iK5tdUsftL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.203] (unknown [185.238.219.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 76C3061E647BA;
	Sat, 04 Oct 2025 18:11:09 +0200 (CEST)
Message-ID: <f899159a-3373-45f5-855a-b8d6e6d237ce@molgen.mpg.de>
Date: Sat, 4 Oct 2025 18:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: MGMT: fix crash in set_mesh_sync and
 set_mesh_complete
To: Pauli Virtanen <pauli.virtanen@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
References: <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
 <eea69851-226e-4e39-aadd-42453fa1bf27@molgen.mpg.de>
 <851c70ee159d777610c906ca882fcab2f5efd80e.camel@iki.fi>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <851c70ee159d777610c906ca882fcab2f5efd80e.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Am 04.10.25 um 18:04 schrieb Pauli Virtanen:
> la, 2025-10-04 kello 17:46 +0200, Paul Menzel kirjoitti:

>> Am 03.10.25 um 21:07 schrieb Pauli Virtanen:
>>> There is a BUG: KASAN: stack-out-of-bounds in set_mesh_sync due to
>>> memcpy from badly declared on-stack flexible array.
>>>
>>> Another crash is in set_mesh_complete() due to double list_del via
>>> mgmt_pending_valid + mgmt_pending_remove.
>>>
>>> Use DEFINE_FLEX to declare the flexible array right, and don't memcpy
>>> outside bounds.
>>>
>>> As mgmt_pending_valid removes the cmd from list, use mgmt_pending_free,
>>> and also report status on error.
>>>
>>> Fixes: 302a1f674c00d ("Bluetooth: MGMT: Fix possible UAFs")
>>> Signed-off-by: Pauli Virtanen <pav@iki.fi>
>>> ---
>>>    include/net/bluetooth/mgmt.h |  2 +-
>>>    net/bluetooth/mgmt.c         | 26 +++++++++++++++-----------
>>>    2 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>>> index 74edea06985b..bca0333f1e99 100644
>>> --- a/include/net/bluetooth/mgmt.h
>>> +++ b/include/net/bluetooth/mgmt.h
>>> @@ -853,7 +853,7 @@ struct mgmt_cp_set_mesh {
>>>    	__le16 window;
>>>    	__le16 period;
>>>    	__u8   num_ad_types;
>>> -	__u8   ad_types[];
>>> +	__u8   ad_types[] __counted_by(num_ad_types);
>>>    } __packed;
>>>    #define MGMT_SET_MESH_RECEIVER_SIZE	6
>>>    
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index a3d16eece0d2..24e335e3a727 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -2175,19 +2175,24 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
>>>    	sk = cmd->sk;
>>>    
>>>    	if (status) {
>>> +		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
>>> +				status);
>>>    		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
>>>    				     cmd_status_rsp, &status);
>>> -		return;
>>> +		goto done;
>>>    	}
>>>    
>>> -	mgmt_pending_remove(cmd);
>>>    	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, NULL, 0);
>>> +
>>> +done:
>>> +	mgmt_pending_free(cmd);
>>>    }
>>>    
>>>    static int set_mesh_sync(struct hci_dev *hdev, void *data)
>>>    {
>>>    	struct mgmt_pending_cmd *cmd = data;
>>> -	struct mgmt_cp_set_mesh cp;
>>> +	DEFINE_FLEX(struct mgmt_cp_set_mesh, cp, ad_types, num_ad_types,
>>> +		    sizeof(hdev->mesh_ad_types));
>>>    	size_t len;
>>>    
>>>    	mutex_lock(&hdev->mgmt_pending_lock);
>>> @@ -2197,27 +2202,26 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
>>>    		return -ECANCELED;
>>>    	}
>>>    
>>> -	memcpy(&cp, cmd->param, sizeof(cp));
>>> +	len = cmd->param_len;
>>> +	memcpy(cp, cmd->param, min(__struct_size(cp), len));
>>>    
>>>    	mutex_unlock(&hdev->mgmt_pending_lock);
>>>    
>>> -	len = cmd->param_len;
>>> -
>>>    	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
>>>    
>>> -	if (cp.enable)
>>> +	if (cp->enable)
>>>    		hci_dev_set_flag(hdev, HCI_MESH);
>>>    	else
>>>    		hci_dev_clear_flag(hdev, HCI_MESH);
>>>    
>>> -	hdev->le_scan_interval = __le16_to_cpu(cp.period);
>>> -	hdev->le_scan_window = __le16_to_cpu(cp.window);
>>> +	hdev->le_scan_interval = __le16_to_cpu(cp->period);
>>> +	hdev->le_scan_window = __le16_to_cpu(cp->window);
>>>    
>>> -	len -= sizeof(cp);
>>> +	len -= sizeof(struct mgmt_cp_set_mesh);
>>>    
>>>    	/* If filters don't fit, forward all adv pkts */
>>>    	if (len <= sizeof(hdev->mesh_ad_types))
>>> -		memcpy(hdev->mesh_ad_types, cp.ad_types, len);
>>> +		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
>>>    
>>>    	hci_update_passive_scan_sync(hdev);
>>>    	return 0;
>>
>> Would it be possible to make this two commits? Either way:
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Both issues were introduced in 302a1f674c00d, which is why also the fix
> here is a single patch.

Hmm, for me this is not a strong reason. In my humble opinion, two 
commits would make it patch smaller and easier to review, and would 
improve bisect/pinpoint results and allow easier reverts.


Kind regards,

Paul
