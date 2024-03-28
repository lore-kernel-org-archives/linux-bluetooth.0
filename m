Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC385BADB
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645713; cv=none; b=atJ56poyUM0B1jqZJw0eg7ZnuwSXmdEhJfolNKDGQG0guuwRzVtgPafAkOnEzCfvX2NEB9co1IFRlMX7pyv6dZbStrQF8UmlehCMPnwju1NMjHB71c4Jgbp9prdt/2D/NXpLHuJQ65B2DO5GGWA4+Uiwijzpxg1zoYQF50mN16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645713; c=relaxed/simple;
	bh=Rh3IW5rU3PVv5IFrd5c61y98olbgKxP6Ang6BwVP4sk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NGYPv5B6vhzAHlSL60ZE0S5ELxB/rM7f6qBRQSxujX5xLe1A95Kwo1vlNBPNUjvlCR7BJuWQODzA5VYn/z3hrEcAJTQsCjIqDzwvM/ntgR7Os/amRz+a6hFf4kULlzr4uegN6qKguFaS49xjxC4ekZeu8ZX+URyxQMMUR1TVclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfU0jKmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfU0jKmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E77C433F1;
	Thu, 28 Mar 2024 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711645713;
	bh=Rh3IW5rU3PVv5IFrd5c61y98olbgKxP6Ang6BwVP4sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XfU0jKmZ5/DwK/e0JJoj3+r36+1vGwjN5Dd8Gm36y1XMg8f38w1JI2VVeWNAlUFtN
	 IoJkypHMkICMYJnBBfa6AUsCV13/2Htz1Uh2XoGFCpYrz4vvXGO4tCd5lZpEk2UI/H
	 adS6spLh3jWOD72aFEp4AibF5zal/mHZ1FSYPHzd+kN3DvT8Mre6GRD3cRi/pZfZrw
	 rkfPAo23VtQvdcgFzKOmdRMmHhVzaI2PiRXk5lrfVlu2eTh2FbRe/bpdP4bD5CL1Rd
	 IKG5VW7QzAmqdpt18D8qC2auEm6hKVrCpiuat4cYCo5xwt7rnaxF29JoIwvoZx7edF
	 HYo7utAwV0//Q==
Date: Thu, 28 Mar 2024 12:08:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar <chandrashekar.devegowda@intel.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add *setup* function to
 download firmware
Message-ID: <20240328170831.GA1570559@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328111904.992068-3-kiran.k@intel.com>

On Thu, Mar 28, 2024 at 04:49:04PM +0530, Kiran K wrote:
> Add to support to download firmware.

s/Add to/Add/

> +static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
> +				    struct sk_buff *skb)
> +{
> +	struct data_buf *buf;
> +	struct tfd *tfd;
> +
> +	tfd = &txq->tfds[tfd_index];
> +	memset(tfd, 0, sizeof(*tfd));
> +
> +	/* Get the buffer of the tfd index for DMA */

s/tfd/TFD/ for consistency.

> +static int btintel_pcie_hci_send_frame(struct hci_dev *hdev,
> +				       struct sk_buff *skb)
> +{
> +	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> +	int ret;
> +	u32 type;
> +
> +	/* Due to the fw limitation, the type header of the packet should be
> +	 * 4 bytes unlikely 1 byte for UART. In UART, the firmware can reads
> +	 * the first byte to get the packet type and redirect the rest of data
> +	 * packet to the right handler. But for PCIe, THF(Transfer Flow Handler)
> +	 * fetches the 4 bytes of data from DMA memory and by the time it reads
> +	 * the first 4 bytes, it already consumes some part of packet. Thus
> +	 * the packet type indicator for iBT PCIe is 4 bytes.
> +	 * Luckily, when HCI core creates the skb, it allocated 8 bytes of
> +	 * head room for profile and driver use, and before sending the data
> +	 * to the device, append the iBT PCIe packet type in the front.

s/unlikely/unlike/
s/can reads/can read/
s/it already consumes/it has already consumed/

Add blank line between paragraphs.

> +	 */
> +	switch (hci_skb_pkt_type(skb)) {
> +	case HCI_COMMAND_PKT:
> +		type = BTINTEL_PCIE_HCI_CMD_PKT;
> +		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
> +			struct hci_command_hdr *cmd = (void *)skb->data;
> +			__u16 opcode = le16_to_cpu(cmd->opcode);
> +
> +			/* When the 0xfc01 command is issued to boot into
> +			 * the operational firmware, it will actually not
> +			 * send a command complete event. To keep the flow
> +			 * control working inject that event here.
> +			 */
> +			if (opcode == 0xfc01)
> +				btintel_pcie_inject_cmd_complete(hdev, opcode);
> +		}
> +		hdev->stat.cmd_tx++;
> +		break;
> +	case HCI_ACLDATA_PKT:
> +		type = BTINTEL_PCIE_HCI_ACL_PKT;
> +		hdev->stat.acl_tx++;
> +		break;
> +	case HCI_SCODATA_PKT:
> +		type = BTINTEL_PCIE_HCI_SCO_PKT;
> +		hdev->stat.sco_tx++;
> +		break;
> +	default:
> +		bt_dev_err(hdev, "Unknown HCI packet type");
> +		ret = -EILSEQ;
> +		goto exit_error;
> +	}
> +	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
> +	       BTINTEL_PCIE_HCI_TYPE_LEN);
> +
> +	ret = btintel_pcie_send_sync(data, skb);
> +	if (ret) {
> +		hdev->stat.err_tx++;
> +		bt_dev_err(hdev, "Failed to send frame (%d)", ret);
> +		goto exit_error;
> +	} else {
> +		hdev->stat.byte_tx += skb->len;
> +		kfree_skb(skb);
> +	}
> +
> +exit_error:
> +
> +	return ret;

There's no cleanup here, so it would be simpler to omit "ret"
completely and return directly above instead of using the goto.

> +}
