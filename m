Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FC535A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623919; cv=none; b=Sp12T5f0U/dTbOs9z01OUn3ONQapoez+fnLUxuHCkvy1vNTL2xe4a278yiFB+K9e5Pr5bjqBy03WvaKUDCALu3HQVvcGgfZaAMzqqG5HyS8+J8Mhzcf2xaPCFYg8yoIWlG4iE06kxgeyU1ipqOivjvsT1s/AqvQMMvXN+OjeitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623919; c=relaxed/simple;
	bh=QSt4Fxphy+gfarQDiK9Su+WIJNcMaTczt99KZFXTQe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WfFJhVpxwj77ORDMtabFFAvRdTv2ouUNjlf9wbLyDqad/Siz8/80dlqX1frWxsxked5P32nY0WGasulpWLqi0p/5m5ecVcDpXZggc6KxRxxEortqw70OjH373vpo5mJQyCyiWbOvF/FID44MxB9miy8TsIds6E5XHyAy3vP+uiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyNtRSVw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyNtRSVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711623918; x=1743159918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QSt4Fxphy+gfarQDiK9Su+WIJNcMaTczt99KZFXTQe4=;
  b=OyNtRSVwqYi5QAvY6wmvkZqLibeUW86iIPoGcIjSTzTsJa5OL4O5eDgp
   W0CsOVmGsz4SZ7jhNC8IyLW004EQHCXaAN7WryACL+ApK+BnqpQt9Iijs
   SEM0x5SwR+0qwDj/L+/b6reoBrsQpbyPRDtS6plshkYXMcpQ8gFx/rGkx
   WMG1EP+RiZVhIJjPAzSu3z77cJRkSOXt1ubzyIR0Xm6gvB497zRzjwiVX
   +Nbiq8sS51lV3yQq+IA/LA+lYFuSYp6g/nT/WOxn9mMEeWpjMfmyWMUEJ
   M5aj2LRe+GS7tKpsc52WoIkY8iQmitr8fmfSSsGCZwZimuApf7+UVwuWS
   Q==;
X-CSE-ConnectionGUID: E2U9W9OcR8ePxOg52iXIKw==
X-CSE-MsgGUID: InH0PAt9R3igJpk1UEASXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10551768"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="10551768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 04:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17021621"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa007.jf.intel.com with ESMTP; 28 Mar 2024 04:05:15 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>,
	Chandrashekar <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add *setup* function to download firmware
Date: Thu, 28 Mar 2024 16:49:04 +0530
Message-Id: <20240328111904.992068-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328111904.992068-1-kiran.k@intel.com>
References: <20240328111904.992068-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add to support to download firmware.

Signed-off-by: Kiran K <kiran.k@intel.com>
Co-developed-by: Chandrashekar <chandrashekar.devegowda@intel.com>
Signed-off-by: Chandrashekar <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 332 ++++++++++++++++++++++++++++++-
 1 file changed, 330 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e6ce2304dc57..f54bbe345c00 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -89,6 +89,12 @@ static void ipc_print_ia_ring(struct ia *ia, u16 queue_num)
 	       ia->cr_hia[queue_num], ia->cr_tia[queue_num]);
 }
 
+static void ipc_print_tfd(struct tfd *tfd, u16 index)
+{
+	BT_DBG("[TXQ] -------------- tfd[%u] --------------", index);
+	BT_DBG("[TXQ] size:%u addr:0x%llx", tfd->size, tfd->addr);
+}
+
 static void ipc_print_urbd0(struct urbd0 *urbd0, u16 index)
 {
 	BT_DBG("[TXQ] -------------- urbd0[%u] --------------", index);
@@ -144,6 +150,20 @@ static struct btintel_pcie_data *btintel_pcie_get_data(struct msix_entry *entry)
 	return container_of(entries, struct btintel_pcie_data, msix_entries[0]);
 }
 
+/* Set the doorbell for TXQ to notify the device that @index(actually index-1)
+ * of the TFD is updated and ready to transmit.
+ */
+static void btintel_pcie_set_tx_db(struct btintel_pcie_data *data, u16 index)
+{
+	u32 val;
+
+	val = index;
+	val |= (0 << 16);
+
+	BT_DBG("[TXQ] Set doorbell for index: %u", index);
+	btintel_pcie_wr_reg32(data, CSR_HBUS_TARG_WRPTR, val);
+}
+
 /* Set the doorbell for RXQ to notify the device that @index(actually index-1)
  * is available to receive the data
  */
@@ -158,6 +178,83 @@ static void btintel_pcie_set_rx_db(struct btintel_pcie_data *data, u16 index)
 	btintel_pcie_wr_reg32(data, CSR_HBUS_TARG_WRPTR, val);
 }
 
+/* Copy the data to next(@tfd_index) data buffer and update the TFD(transfer
+ * descriptor) with the data length and the DMA address of the data buffer.
+ */
+static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
+				    struct sk_buff *skb)
+{
+	struct data_buf *buf;
+	struct tfd *tfd;
+
+	tfd = &txq->tfds[tfd_index];
+	memset(tfd, 0, sizeof(*tfd));
+
+	/* Get the buffer of the tfd index for DMA */
+	buf = &txq->bufs[tfd_index];
+
+	/* Update TFD */
+	tfd->size = skb->len;
+	tfd->addr = buf->data_p_addr;
+
+	btintel_pcie_hci_dump("TFD", (void *)tfd, sizeof(*tfd));
+	ipc_print_tfd(tfd, tfd_index);
+
+	/* Copy the incoming data to DMA buffer */
+	memcpy(buf->data, skb->data, tfd->size);
+	btintel_pcie_hci_dump("TX", buf->data, tfd->size);
+}
+
+static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
+				  struct sk_buff *skb)
+{
+	int ret;
+	u16 tfd_index;
+	struct txq *txq = &data->txq;
+
+	BT_DBG("[TXQ] start tx sync: skb(0x%p) len=%u", skb, skb->len);
+
+	/* Read the next TFD index to use from TR_HIA(Head Index Array) */
+	tfd_index = data->ia.tr_hia[TXQ_NUM];
+	BT_DBG("[TXQ] current tfd_index: %u", tfd_index);
+
+	/* Make sure the index value is within the range. It shouldn't be
+	 * bigger than the total count of the queue.
+	 */
+	if (tfd_index > txq->count) {
+		BT_ERR("[TXQ] TXQ out of range: (0x%x)", tfd_index);
+		return -ERANGE;
+	}
+
+	/* Prepare for TX. It updates the TFD with the length of data and
+	 * address of the DMA buffer, and copy the data to the DMA buffer
+	 */
+	btintel_pcie_prepare_tx(txq, tfd_index, skb);
+
+	/* Update TR_HIA with new TD index */
+	tfd_index = (tfd_index + 1) % txq->count;
+	data->ia.tr_hia[TXQ_NUM] = tfd_index;
+	ipc_print_ia_ring(&data->ia, TXQ_NUM);
+
+	/* Arm wait event condition */
+	data->tx_wait_done = false;
+
+	/* Set the doorbell to notify the device */
+	btintel_pcie_set_tx_db(data, tfd_index);
+
+	/* Wait for the complete interrupt - URBD0 */
+	ret = wait_event_timeout(data->tx_wait_q, data->tx_wait_done,
+				 msecs_to_jiffies(TX_WAIT_TIMEOUT));
+	if (!ret) {
+		BT_ERR("[TXQ] failed to receive urbd0(%u)", tfd_index);
+		return -ETIME;
+	}
+
+	BT_DBG("[TXQ] tx sync completed: skb(0x%p) len=%u", skb, skb->len);
+
+	return 0;
+}
+
 /* Update the FRBD(free buffer descriptor) with the @frbd_index and the
  * DMA address of the free buffer.
  */
@@ -1135,6 +1232,111 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	return err;
 }
 
+static int btintel_pcie_hci_open(struct hci_dev *hdev)
+{
+	bt_dev_dbg(hdev, "btintel_pcie_hci_open");
+
+	return 0;
+}
+
+static int btintel_pcie_hci_close(struct hci_dev *hdev)
+{
+	bt_dev_dbg(hdev, "btintel_pcie_hci_close");
+
+	return 0;
+}
+
+static int btintel_pcie_inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
+{
+	struct sk_buff *skb;
+	struct hci_event_hdr *hdr;
+	struct hci_ev_cmd_complete *evt;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (struct hci_event_hdr *)skb_put(skb, sizeof(*hdr));
+	hdr->evt = HCI_EV_CMD_COMPLETE;
+	hdr->plen = sizeof(*evt) + 1;
+
+	evt = (struct hci_ev_cmd_complete *)skb_put(skb, sizeof(*evt));
+	evt->ncmd = 0x01;
+	evt->opcode = cpu_to_le16(opcode);
+
+	*(u8 *)skb_put(skb, 1) = 0x00;
+
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+
+	return hci_recv_frame(hdev, skb);
+}
+
+static int btintel_pcie_hci_send_frame(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	int ret;
+	u32 type;
+
+	/* Due to the fw limitation, the type header of the packet should be
+	 * 4 bytes unlikely 1 byte for UART. In UART, the firmware can reads
+	 * the first byte to get the packet type and redirect the rest of data
+	 * packet to the right handler. But for PCIe, THF(Transfer Flow Handler)
+	 * fetches the 4 bytes of data from DMA memory and by the time it reads
+	 * the first 4 bytes, it already consumes some part of packet. Thus
+	 * the packet type indicator for iBT PCIe is 4 bytes.
+	 * Luckily, when HCI core creates the skb, it allocated 8 bytes of
+	 * head room for profile and driver use, and before sending the data
+	 * to the device, append the iBT PCIe packet type in the front.
+	 */
+	switch (hci_skb_pkt_type(skb)) {
+	case HCI_COMMAND_PKT:
+		type = BTINTEL_PCIE_HCI_CMD_PKT;
+		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+			struct hci_command_hdr *cmd = (void *)skb->data;
+			__u16 opcode = le16_to_cpu(cmd->opcode);
+
+			/* When the 0xfc01 command is issued to boot into
+			 * the operational firmware, it will actually not
+			 * send a command complete event. To keep the flow
+			 * control working inject that event here.
+			 */
+			if (opcode == 0xfc01)
+				btintel_pcie_inject_cmd_complete(hdev, opcode);
+		}
+		hdev->stat.cmd_tx++;
+		break;
+	case HCI_ACLDATA_PKT:
+		type = BTINTEL_PCIE_HCI_ACL_PKT;
+		hdev->stat.acl_tx++;
+		break;
+	case HCI_SCODATA_PKT:
+		type = BTINTEL_PCIE_HCI_SCO_PKT;
+		hdev->stat.sco_tx++;
+		break;
+	default:
+		bt_dev_err(hdev, "Unknown HCI packet type");
+		ret = -EILSEQ;
+		goto exit_error;
+	}
+	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
+	       BTINTEL_PCIE_HCI_TYPE_LEN);
+
+	ret = btintel_pcie_send_sync(data, skb);
+	if (ret) {
+		hdev->stat.err_tx++;
+		bt_dev_err(hdev, "Failed to send frame (%d)", ret);
+		goto exit_error;
+	} else {
+		hdev->stat.byte_tx += skb->len;
+		kfree_skb(skb);
+	}
+
+exit_error:
+
+	return ret;
+}
+
 static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
 {
 	struct hci_dev *hdev;
@@ -1147,10 +1349,136 @@ static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
 	data->hdev = NULL;
 }
 
+static int btintel_pcie_setup(struct hci_dev *hdev)
+{
+	const u8 param[1] = { 0xFF };
+	struct intel_version_tlv ver_tlv;
+	struct sk_buff *skb;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version command failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	/* Check the status */
+	if (skb->data[0]) {
+		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
+			   skb->data[0]);
+		err = -EIO;
+		goto exit_error;
+	}
+
+	/* Apply the common HCI quirks for Intel device */
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+	set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+	/* Set up the quality report callback for Intel devices */
+	hdev->set_quality_report = btintel_set_quality_report;
+
+	memset(&ver_tlv, 0, sizeof(ver_tlv));
+	/* For TLV type device, parse the tlv data */
+	err = btintel_parse_version_tlv(hdev, &ver_tlv, skb);
+	if (err) {
+		bt_dev_err(hdev, "Failed to parse TLV version information");
+		goto exit_error;
+	}
+
+	switch (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt)) {
+	case 0x37:
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
+			   INTEL_HW_PLATFORM(ver_tlv.cnvi_bt));
+		err = -EINVAL;
+		goto exit_error;
+	}
+
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come
+	 * along.
+	 */
+	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
+	case 0x1e:	/* BzrI */
+		/* Display version information of TLV type */
+		btintel_version_info_tlv(hdev, &ver_tlv);
+
+		/* Apply the device specific HCI quirks for TLV based devices
+		 *
+		 * All TLV based devices support WBS
+		 */
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+
+		/* Apply LE States quirk from solar onwards */
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+
+		/* Setup MSFT Extension support */
+		btintel_set_msft_opcode(hdev,
+					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+
+		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
+		if (err)
+			goto exit_error;
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
+			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+		err = -EINVAL;
+		break;
+	}
+
+exit_error:
+	kfree_skb(skb);
+
+	return err;
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
-	/* TODO: initialize hdev and assign the callbacks to hdev */
-	return -ENODEV;
+	int err;
+	struct hci_dev *hdev;
+
+	hdev = hci_alloc_dev();
+	if (!hdev)
+		return -ENOMEM;
+
+	hdev->bus = HCI_PCI;
+	hci_set_drvdata(hdev, data);
+
+	hdev->dev_type = HCI_PRIMARY;
+
+	data->hdev = hdev;
+	SET_HCIDEV_DEV(hdev, &data->pdev->dev);
+
+	hdev->manufacturer = 2;
+	hdev->open = btintel_pcie_hci_open;
+	hdev->close = btintel_pcie_hci_close;
+	hdev->send = btintel_pcie_hci_send_frame;
+	hdev->setup = btintel_pcie_setup;
+	hdev->shutdown = btintel_shutdown_combined;
+	hdev->hw_error = btintel_hw_error;
+	hdev->set_diag = btintel_set_diag;
+	hdev->set_bdaddr = btintel_set_bdaddr;
+
+	err = hci_register_dev(hdev);
+	if (err < 0) {
+		BT_ERR("Failed to register to hdev (%d)", err);
+		goto exit_error;
+	}
+
+	return 0;
+
+exit_error:
+	hci_free_dev(hdev);
+	return err;
 }
 
 static int btintel_pcie_probe(struct pci_dev *pdev,
-- 
2.34.1

