Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F433993
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868497; cv=none; b=ZW24KJbDUR+M25Hv3wizfwju9eeI8SkWcNva0VXeRh/ipBcwX5QBYWY1MEsa7GEVQ9ewRV3lQIyYlwoy9KS7UVE3p2L9UngzVGkKmM9XoyiZb+uTH+FHaXJQT0VDcJCtyGb0Pk1XZ6a15nvtrOJ3MBL8ckl1pEkqPCVbInOSYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868497; c=relaxed/simple;
	bh=+OycoL6r6KizSDbbONd0tnze/b68xHOyQkToA8DbY88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecKySblKtbTGHScZsGB9EFvjmyxir30+s7sKwvbetkFjuMQ+KOsaoiwWp65DSIdK9zZWhLose6+8limZBliVmI02MmtmQB6vC4P80kmUSRSXO5wIan+TlWJ13jh5C3pK118I9O3SrpT1fwKQDQ5e94sj3iMH6GwnrTfj9SzXNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.196] (p5dc55720.dip0.t-ipconnect.de [93.197.87.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DBA6D61E647A3;
	Mon, 07 Jul 2025 08:07:51 +0200 (CEST)
Message-ID: <e3bcf617-7b9f-4229-89a0-12ea9e0e001b@molgen.mpg.de>
Date: Mon, 7 Jul 2025 08:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
To: Kiran K <kiran.k@intel.com>, Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, linux-bluetooth@vger.kernel.org
References: <20250707034657.929092-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250707034657.929092-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sai, dear Kiran,


Thank you for your patch.

Am 07.07.25 um 05:46 schrieb Kiran K:
> Firmware raises an alive interrupt upon receiving the 0xfc01 (Intel
> reset) command. This change fixes the driver to properly wait for the
> alive interrupt.

What is the consequence of not waiting?

> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
> ---
>   drivers/bluetooth/btintel_pcie.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 1113a6310bd0..f893ad6fc87a 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -947,11 +947,13 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
>   	case BTINTEL_PCIE_INTEL_HCI_RESET1:
>   		if (btintel_pcie_in_op(data)) {
>   			submit_rx = true;
> +			signal_waitq = true;
>   			break;
>   		}
>   
>   		if (btintel_pcie_in_iml(data)) {
>   			submit_rx = true;
> +			signal_waitq = true;
>   			data->alive_intr_ctxt = BTINTEL_PCIE_FW_DL;
>   			break;
>   		}
> @@ -1985,8 +1987,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>   			if (opcode == 0xfc01)
>   				btintel_pcie_inject_cmd_complete(hdev, opcode);
>   		}
> -		/* Firmware raises alive interrupt on HCI_OP_RESET */
> -		if (opcode == HCI_OP_RESET)
> +
> +		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/

A space is missing before */.

> +		if (opcode == HCI_OP_RESET || opcode == 0xfc01)

Please define a macro for the magic number.

>   			data->gp0_received = false;
>   
>   		hdev->stat.cmd_tx++;
> @@ -2025,17 +2028,15 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>   		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
>   			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
>   			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
> -		if (opcode == HCI_OP_RESET) {
> -			ret = wait_event_timeout(data->gp0_wait_q,
> -						 data->gp0_received,
> -						 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> -			if (!ret) {
> -				hdev->stat.err_tx++;
> -				bt_dev_err(hdev, "No alive interrupt received for %s",
> -					   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
> -				ret = -ETIME;
> -				goto exit_error;
> -			}
> +		ret = wait_event_timeout(data->gp0_wait_q,
> +					 data->gp0_received,
> +					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +		if (!ret) {
> +			hdev->stat.err_tx++;
> +			bt_dev_err(hdev, "No alive interrupt received for %s",
> +				   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));

In a follow-up patch, the log message could be improved by also adding 
the timeout value to it.

> +			ret = -ETIME;
> +			goto exit_error;
>   		}
>   	}
>   	hdev->stat.byte_tx += skb->len;


Kind regards,

Paul
