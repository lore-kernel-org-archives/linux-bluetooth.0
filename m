Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B21A706A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349766; cv=none; b=WPcO14YcuDiaj1xizYZJwenrA/oi7Y7Y5/Sagj6mqNyQDSj1YqG9pEwxr12DrJYbRwIGVH8zQh02DCSlXSC7NqhxSO8mEOixq5UqfmRoyR02O3bBjJipoGh+KfXtT57DcyJa7TV1gCcT27ss/t2e4Yk4DozAqUhi0hEsMv/fN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349766; c=relaxed/simple;
	bh=+CDDH0P2KoFjvGdXh/UOsNOlEj1q8Js88nfQw9SAvmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I9oX2ESj/YM2Fusbrr5YzQEtW93fvKRv/CKxpyAr5ejCLa/cJ7Y/FRHRgPzniqzXh1Zm3JSD55/bjlw2brWRhxxPmsihq2k7nxuaXwtxmKE6hkFoSYxrCrARWlCiE395P9/tdfEHHucAi+CKZd/iKyPYrXHoFIm9YdzEKfBH4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqF+aaaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqF+aaaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8ABC4CECF;
	Mon, 11 Nov 2024 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731349766;
	bh=+CDDH0P2KoFjvGdXh/UOsNOlEj1q8Js88nfQw9SAvmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tqF+aaaMtDKZoRg1/ddvK+/7UAi9Zjypb5IXPX7T0WN8MldVjJvX1cgg68wT/887Z
	 SdOF0tfbmIXybxZdOUCtw/d5nahYJFymgGjekYPVmtXUNueiljgVAiIPz0oWaaq1Tt
	 nFnBNs3T8uZn2A2eLoMHHjk7b1d67LZpE+zh1viyobDh1L4fDWx206rA8AiQ0pKlix
	 OrtbI7ky6b5AfAg22CcCzt5KIkGUUSGKKl2WXVwKhAhAI2uDQ6SEqFyqaaDGAKZlCy
	 2wh2D8aag/uANc+Ux/X9UO/RUvbkcss+BtZY4xHA26B0/wyq7a7OfH+cNfpH8e70qc
	 6xL3sjj/wYbBQ==
Date: Mon, 11 Nov 2024 12:29:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between
 driver and firmware
Message-ID: <20241111182923.GA1802958@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001104451.626964-1-kiran.k@intel.com>

On Tue, Oct 01, 2024 at 04:14:50PM +0530, Kiran K wrote:
> The following handshake mechanism needs be followed after firmware
> download is completed to bring the firmware to running state.
> 
> After firmware fragments of Operational image are downloaded and
> secure sends result of the image succeeds,
> 
> 1. Driver sends HCI Intel reset with boot option #1 to switch FW image.
> 2. FW sends Alive GP[0] MSIx
> 3. Driver enables data path (doorbell 0x460 for RBDs, etc...)
> 4. Driver gets Bootup event from firmware
> 5. Driver performs D0 entry to device (WRITE to IPC_Sleep_Control =0x0)
> 6. FW sends Alive GP[0] MSIx
> 7. Device host interface is fully set for BT protocol stack operation.
> 8. Driver may optionally get debug event with ID 0x97 which can be dropped
> 
> For Intermediate loadger image, all the above steps are applicable
> expcept #5 and #6.

I see this is already applied to bluetooth-next and is probably
immutable, but if not...

s/loadger/loader/
s/expcept/except/

But more importantly, the race below is still in linux-next as of
next-20241111.  I mentioned this before at
https://lore.kernel.org/all/20241023191352.GA924610@bhelgaas/#t, but
it probably got lost in the suspend/resume conversation.

> @@ -1053,8 +1272,11 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>  				       struct sk_buff *skb)
>  {
>  	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> +	struct hci_command_hdr *cmd;
> +	__u16 opcode = ~0;
>  	int ret;
>  	u32 type;
> +	u32 old_ctxt;
>  
>  	/* Due to the fw limitation, the type header of the packet should be
>  	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
> @@ -1073,6 +1295,8 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>  	switch (hci_skb_pkt_type(skb)) {
>  	case HCI_COMMAND_PKT:
>  		type = BTINTEL_PCIE_HCI_CMD_PKT;
> +		cmd = (void *)skb->data;
> +		opcode = le16_to_cpu(cmd->opcode);
>  		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
>  			struct hci_command_hdr *cmd = (void *)skb->data;
>  			__u16 opcode = le16_to_cpu(cmd->opcode);
> @@ -1111,6 +1335,30 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>  		bt_dev_err(hdev, "Failed to send frame (%d)", ret);
>  		goto exit_error;
>  	}
> +
> +	if (type == BTINTEL_PCIE_HCI_CMD_PKT &&
> +	    (opcode == HCI_OP_RESET || opcode == 0xfc01)) {
> +		old_ctxt = data->alive_intr_ctxt;
> +		data->alive_intr_ctxt =
> +			(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
> +				BTINTEL_PCIE_HCI_RESET);
> +		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
> +			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
> +			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
> +		if (opcode == HCI_OP_RESET) {
> +			data->gp0_received = false;
> +			ret = wait_event_timeout(data->gp0_wait_q,
> +						 data->gp0_received,
> +						 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));

This looks like a race.  You're apparently started something
previously that will eventually result in data->gp0_received being
set.  The ordering you expect is this:

  1) Tell device to do something and interrupt on completion
  2) Set data->gp0_received = false here
  3) Call wait_event_timeout() here
  4) Completion interrupt causes btintel_pcie_msix_gp0_handler() to be
     called
  5) btintel_pcie_msix_gp0_handler() sets data->gp0_received = true
  6) wait_event_timeout() completes

But this ordering can also happen:

  1) Tell device to do something and interrupt on completion
  2) Completion interrupt causes
     btintel_pcie_msix_gp0_handler() to be called
  3) btintel_pcie_msix_gp0_handler() sets data->gp0_received = true
  4) Set data->gp0_received = false here, overwriting the "true"
  5) Call wait_event_timeout() here
  6) wait_event_timeout() times out because completion interrupt has
     already happened
  7) We complain "No alive interrupt received" here

You should be able to force this failure by adding a sleep before
setting data->gp0_received = false in this patch.

> +			if (!ret) {
> +				hdev->stat.err_tx++;
> +				bt_dev_err(hdev, "No alive interrupt received for %s",
> +					   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
> +				ret = -ETIME;
> +				goto exit_error;
> +			}
> +		}
> +	}
>  	hdev->stat.byte_tx += skb->len;
>  	kfree_skb(skb);
