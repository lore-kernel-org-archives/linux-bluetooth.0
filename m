Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFD1754B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999259; cv=none; b=dGqx/tUgt/kUwDntBeYmMzli4JWnsRrs7HPhvSMHxTxB/uh9ABX3shVifOAmX7MNvGb4L2IhM7o07NDaYix7oWAv2ED+fh+FULj9lTWl2TEeQF7jMX7MxNKf5k/8ZoXRvFL3wycAmGn8WbO6nnEnOMM9/MaeZryh7iaYn2gSnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999259; c=relaxed/simple;
	bh=b9r5jsH+6yRZhRv62n6zR5WXGCRC747EDwuIPsvXM4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRd29BzGUS92MmtLnCCiU7To9Khityg66QaUINNuOKAw9X29Ojpl4BIspXVBO/nHI6UbRlZxGPIwucRBWxwwp2xMF0vuKex7Th4qFJ8y7FN6vKkYklTEL4aKg3mR+Gb+frh7mkRKm3SUdUQBMU7abAhybaE1mMo2hnQvSx1K3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A23DB61E647A7;
	Tue, 08 Jul 2025 20:27:18 +0200 (CEST)
Message-ID: <c53f34c7-b5cd-44fd-b1cd-8806ec19b89b@molgen.mpg.de>
Date: Tue, 8 Jul 2025 20:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
To: Kiran K <kiran.k@intel.com>, Aluvala Sai Teja <aluvala.sai.teja@intel.com>
Cc: Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>,
 Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 linux-bluetooth@vger.kernel.org
References: <20250707034657.929092-1-kiran.k@intel.com>
 <e3bcf617-7b9f-4229-89a0-12ea9e0e001b@molgen.mpg.de>
 <PH0PR11MB7585AF4917BFA37FD1A29AE4F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB7585AF4917BFA37FD1A29AE4F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Am 08.07.25 um 14:23 schrieb K, Kiran:

>> Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for alive interrupt

>> Am 07.07.25 um 05:46 schrieb Kiran K:
>>> Firmware raises an alive interrupt upon receiving the 0xfc01 (Intel
>>> reset) command. This change fixes the driver to properly wait for the
>>> alive interrupt.
>>
>> What is the consequence of not waiting?
> 
> This is an alignment between driver and firmware. If driver doesn’t
> wait for alive interrupt, then there is chance of stack sending
> commands before the firmware is ready to accept.

Thank you for elaborating. It’d be great if you added it to the commit 
message, when you resend.

>>> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
>>> Signed-off-by: Kiran K <kiran.k@intel.com>
>>> Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")

I would also put the Fixes: tag above the Signed-off-by line.

>>> ---
>>>    drivers/bluetooth/btintel_pcie.c | 27 ++++++++++++++-------------
>>>    1 file changed, 14 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/btintel_pcie.c
>>> b/drivers/bluetooth/btintel_pcie.c
>>> index 1113a6310bd0..f893ad6fc87a 100644
>>> --- a/drivers/bluetooth/btintel_pcie.c
>>> +++ b/drivers/bluetooth/btintel_pcie.c
>>> @@ -947,11 +947,13 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
>>>    	case BTINTEL_PCIE_INTEL_HCI_RESET1:
>>>    		if (btintel_pcie_in_op(data)) {
>>>    			submit_rx = true;
>>> +			signal_waitq = true;
>>>    			break;
>>>    		}
>>>
>>>    		if (btintel_pcie_in_iml(data)) {
>>>    			submit_rx = true;
>>> +			signal_waitq = true;
>>>    			data->alive_intr_ctxt = BTINTEL_PCIE_FW_DL;
>>>    			break;
>>>    		}
>>> @@ -1985,8 +1987,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>>>    			if (opcode == 0xfc01)
>>>    				btintel_pcie_inject_cmd_complete(hdev, opcode);
>>>    		}
>>> -		/* Firmware raises alive interrupt on HCI_OP_RESET */
>>> -		if (opcode == HCI_OP_RESET)
>>> +
>>> +		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
>>
>> A space is missing before */.
> Ack.
> 
>>> +		if (opcode == HCI_OP_RESET || opcode == 0xfc01)
>>
>> Please define a macro for the magic number.
> 
> This is vendor specific opcode and is also shared across btintel.c,
> btusb.c and hci_intel.c. Would it be acceptable to submit a separate
> patch for this change alone?

Sure. Fine by me.

>>>    			data->gp0_received = false;
>>>
>>>    		hdev->stat.cmd_tx++;
>>> @@ -2025,17 +2028,15 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>>>    		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
>>>    			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
>>>    			   btintel_pcie_alivectxt_state2str(data - alive_intr_ctxt));
>>> -		if (opcode == HCI_OP_RESET) {
>>> -			ret = wait_event_timeout(data->gp0_wait_q,
>>> -						 data->gp0_received,
>>> -						 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
>>> -			if (!ret) {
>>> -				hdev->stat.err_tx++;
>>> -				bt_dev_err(hdev, "No alive interrupt received for %s",
>>> -					   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
>>> -				ret = -ETIME;
>>> -				goto exit_error;
>>> -			}
>>> +		ret = wait_event_timeout(data->gp0_wait_q,
>>> +					 data->gp0_received,
>>> +					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
>>> +		if (!ret) {
>>> +			hdev->stat.err_tx++;
>>> +			bt_dev_err(hdev, "No alive interrupt received for %s",
>>> +				   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
>>
>> In a follow-up patch, the log message could be improved by also adding the
>> timeout value to it.
> Ack.
> 
>>> +			ret = -ETIME;
>>> +			goto exit_error;
>>>    		}
>>>    	}
>>>    	hdev->stat.byte_tx += skb->len;

Kind regards,

Paul
