Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D36189919
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868960; cv=none; b=Y5KkDExbUNCfyld0nyXxM8Zp0ZvP7P+UZ99spVu/Ro9MKoxyEWK0gunN+4oavkp2PfWX6hyN6ARkA0kN/rD6ZngCfv8PVrsQFhvqnV3J7386Bh4+Lmld0eu8SQ8HmWsirJN6WWLKH4q/NUw/KI8CkbcljM52FijRFOWCqDtmE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868960; c=relaxed/simple;
	bh=St/UoVyTdm512zZMcv5ELMiQBZ+k9mSU4AexweSeufs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+2vWUesCv0TBJUQQamQcHlSE9peRGaQhQEDxeVyAD4ISp2wLMyxZs0BfNLnwD7MF+zpGpTxv7c2N2NoJM9PxuzjTv0GIkbHi4TzWwnYREVOUy4nbX55/XMMJqnwzNemBzNUao48DarI84bwH9CHBMN8LPQMHg4TwXTDTAAQ45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.196] (p5dc55720.dip0.t-ipconnect.de [93.197.87.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E251761E647A3;
	Mon, 07 Jul 2025 08:15:41 +0200 (CEST)
Message-ID: <c670c490-04eb-4d5e-921e-e2645489e180@molgen.mpg.de>
Date: Mon, 7 Jul 2025 08:15:40 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
To: Kiran K <kiran.k@intel.com>, Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, linux-bluetooth@vger.kernel.org
References: <20250707034657.929092-1-kiran.k@intel.com>
 <20250707034657.929092-2-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250707034657.929092-2-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran, dear Sai,


Thank you for the patch.

Am 07.07.25 um 05:46 schrieb Kiran K:
> Firmware raises alive interrpt on sending 0xfc01 command. Alive context

interr*u*pt

(I would have hoped, two developers would spot such a typo, a spell 
checker also highlights.)

> maintained in driver needs to be updated before sending 0xfc01 (Intel
> Reset) or 0x03c0 (HCI Reset) to avoid the potential race condition where
> the context is also updated in threaded irq.

Do you have a reproducer for the issue?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")

I’d add the Fixes tag before the Signed-off-by lines.

> ---
>   drivers/bluetooth/btintel_pcie.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index f893ad6fc87a..d29103b102e4 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1988,10 +1988,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>   				btintel_pcie_inject_cmd_complete(hdev, opcode);
>   		}
>   
> -		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
> -		if (opcode == HCI_OP_RESET || opcode == 0xfc01)
> -			data->gp0_received = false;
> -
>   		hdev->stat.cmd_tx++;
>   		break;
>   	case HCI_ACLDATA_PKT:
> @@ -2012,6 +2008,20 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>   	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
>   	       BTINTEL_PCIE_HCI_TYPE_LEN);
>   
> +	if (type == BTINTEL_PCIE_HCI_CMD_PKT) {
> +		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
> +		if (opcode == HCI_OP_RESET || opcode == 0xfc01) {

Why not keep the form of just one if statement with && in the condition? 
as below?

> +			data->gp0_received = false;
> +			old_ctxt = data->alive_intr_ctxt;
> +			data->alive_intr_ctxt =
> +				(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
> +					BTINTEL_PCIE_HCI_RESET);
> +			bt_dev_dbg(data->hdev, "sending cmd: 0x%4.4x alive context changed: %s  ->  %s",
> +				   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
> +				   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
> +		}
> +	}
> +
>   	ret = btintel_pcie_send_sync(data, skb);
>   	if (ret) {
>   		hdev->stat.err_tx++;
> @@ -2021,13 +2031,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>   
>   	if (type == BTINTEL_PCIE_HCI_CMD_PKT &&
>   	    (opcode == HCI_OP_RESET || opcode == 0xfc01)) {
> -		old_ctxt = data->alive_intr_ctxt;
> -		data->alive_intr_ctxt =
> -			(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
> -				BTINTEL_PCIE_HCI_RESET);
> -		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
> -			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
> -			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
>   		ret = wait_event_timeout(data->gp0_wait_q,
>   					 data->gp0_received,
>   					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));


Kind regards,

Paul
