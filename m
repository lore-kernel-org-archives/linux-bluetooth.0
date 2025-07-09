Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC48176ADB
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040951; cv=none; b=eCabjiiztjWGsKw8K7xZA+sjX42WR3OdNNtBCrjFaRlReLANHOvx7VbbK6S/YLSR40YEHmcCqtoTignt1jFg4YCYNkj0dPpxu0GLnrczXDTE7yurkNoL8tci1Fyq5wkcYLGLlS/rS+HmhI39gz0A527iaIzFMLU/azDxhaYEGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040951; c=relaxed/simple;
	bh=IytezeDxdmBTCkGdW/XeX8lTbMuejQ7wDOHRKaDEhv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVlQBmfwJ957oGX48SAoaGPQY7Vd81kB44HINTng9MgUGimo2W4c8lcPht6cH6xcYVAmXz7OJNGaRLzWnt4+RKRJ4VykeOeooxcrsYYlpOTBBMb3rXAd1olnAZ5g/+ES5DBZnrHfvAuQC0RM4SndqFnwxPpvmsumnF73fS/Cq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7d1.dynamic.kabel-deutschland.de [95.90.247.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BE8A361E64845;
	Wed, 09 Jul 2025 08:02:11 +0200 (CEST)
Message-ID: <841939db-cd2e-4f8e-a4f5-89d76b52d223@molgen.mpg.de>
Date: Wed, 9 Jul 2025 08:02:11 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
To: Kiran K <kiran.k@intel.com>, Aluvala Sai Teja <aluvala.sai.teja@intel.com>
Cc: Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>,
 Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 linux-bluetooth@vger.kernel.org
References: <20250707034657.929092-1-kiran.k@intel.com>
 <20250707034657.929092-2-kiran.k@intel.com>
 <c670c490-04eb-4d5e-921e-e2645489e180@molgen.mpg.de>
 <PH0PR11MB7585A3C89449C58883012E23F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB7585A3C89449C58883012E23F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your reply.

Am 08.07.25 um 14:30 schrieb K, Kiran:

>> Subject: Re: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state handling

>> Am 07.07.25 um 05:46 schrieb Kiran K:
>>> Firmware raises alive interrpt on sending 0xfc01 command. Alive context
>>
>> interr*u*pt
>>
>> (I would have hoped, two developers would spot such a typo, a spell checker
>> also highlights.)
> 
> Ack. Unfortunately  'interrpt' was missing in my codespell
> dictionary. I have updated the same. Thanks.

hunspell or a/ispell should find it by defautl.

>>> maintained in driver needs to be updated before sending 0xfc01 (Intel
>>> Reset) or 0x03c0 (HCI Reset) to avoid the potential race condition
>>> where the context is also updated in threaded irq.
>>
>> Do you have a reproducer for the issue?
> Yes. Issue was reproduced in stress reboot scenario although reproduction rate is less - 1/25.

It’d be great if you added that to the commit message, and what 
scripts/commands you run for this stress reboot scenario.

>>> Signed-off-by: Kiran K <kiran.k@intel.com>
>>> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
>>> Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
>>
>> I’d add the Fixes tag before the Signed-off-by lines.
> Ack.

There is one more comment below.

>>> ---
>>>    drivers/bluetooth/btintel_pcie.c | 25 ++++++++++++++-----------
>>>    1 file changed, 14 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/btintel_pcie.c
>>> b/drivers/bluetooth/btintel_pcie.c
>>> index f893ad6fc87a..d29103b102e4 100644
>>> --- a/drivers/bluetooth/btintel_pcie.c
>>> +++ b/drivers/bluetooth/btintel_pcie.c
>>> @@ -1988,10 +1988,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>>>    				btintel_pcie_inject_cmd_complete(hdev, opcode);
>>>    		}
>>>
>>> -		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
>>> -		if (opcode == HCI_OP_RESET || opcode == 0xfc01)
>>> -			data->gp0_received = false;
>>> -
>>>    		hdev->stat.cmd_tx++;
>>>    		break;
>>>    	case HCI_ACLDATA_PKT:
>>> @@ -2012,6 +2008,20 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>>>    	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
>>>    	       BTINTEL_PCIE_HCI_TYPE_LEN);
>>>
>>> +	if (type == BTINTEL_PCIE_HCI_CMD_PKT) {
>>> +		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
>>> +		if (opcode == HCI_OP_RESET || opcode == 0xfc01) {
>>
>> Why not keep the form of just one if statement with && in the condition?
>> as below?
>>
>>> +			data->gp0_received = false;
>>> +			old_ctxt = data->alive_intr_ctxt;
>>> +			data->alive_intr_ctxt =
>>> +				(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
>>> +					BTINTEL_PCIE_HCI_RESET);
>>> +			bt_dev_dbg(data->hdev, "sending cmd: 0x%4.4x alive context changed: %s  ->  %s",
>>> +				   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
>>> +				   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
>>> +		}
>>> +	}
>>> +
>>>    	ret = btintel_pcie_send_sync(data, skb);
>>>    	if (ret) {
>>>    		hdev->stat.err_tx++;
>>> @@ -2021,13 +2031,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>>>
>>>    	if (type == BTINTEL_PCIE_HCI_CMD_PKT &&
>>>    	    (opcode == HCI_OP_RESET || opcode == 0xfc01)) {
>>> -		old_ctxt = data->alive_intr_ctxt;
>>> -		data->alive_intr_ctxt =
>>> -			(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1
>> :
>>> -				BTINTEL_PCIE_HCI_RESET);
>>> -		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
>>> -			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
>>> -			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
>>>    		ret = wait_event_timeout(data->gp0_wait_q,
>>>    					 data->gp0_received,
>>>					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));

Kind regards,

Paul
