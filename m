Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E6239562
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593289; cv=none; b=n6TF1jcpRJMptJ3WJfLXKgWsN9pcnHlz7eG1CrYAFBZD8lmnynSqD/MXducNR8rcxdbN/FR9S2RVbMJiwpZamFpK8ZUQZGVJWb82dDas7MjSUSsPPxFIO9ut6vU2vg8Ut06V8Ax+Mty10ThdKRK9doQmCkAgoL0VCTp7pPfLzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593289; c=relaxed/simple;
	bh=dDYn9SJLmKMXIrxoPeWmII/4rje5hlWyc9C0l7Kkbzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFqr0kPj7rUtBd5FLW5YRAqJgt/ANj3w4XgkrTR5Q6qdKj8tsmfE77aCx863kz/+7QDIgaCyEI34Ka0GOREg4vCIxqRQfcKtlH6hfjmw3x6Kp1E1wDPxVPpo8b/6m1u5G3f0813DmpikKHW7A0EphQT1wxtH5WH4LIia3AwqguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agI9OxlI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agI9OxlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760593286; x=1792129286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dDYn9SJLmKMXIrxoPeWmII/4rje5hlWyc9C0l7Kkbzo=;
  b=agI9OxlIZFqnwfUJm/6CO/gtvdJDB/WW44QexXGK6qV3Bvt1w3WjjXj+
   SDrzJQsVxC0Kht696xQ/3SUlH2p6pc8VY1kUY87IEEEJfbpHhFPQDK78Y
   gBEh6ovn/UEIdh+6lbcC455SvsuVBv07P7BLx9EQPpeVOjKUW49NHH32l
   D6G+G2z4BQH+29kQLBgKDQG1s5aza111XCWmNxL6y30UECltyUIbz084b
   8qNhWrRvcoWD1dKI9s5uzMBT/qD4YuUX0FhLuJMEhuQQB5/XFtFvVJ1zH
   OEJlAleAXuJPHivpqZRX35urtj9oRACQe2rkDcCWatD1jqRVGT5dl6dgJ
   w==;
X-CSE-ConnectionGUID: 2U8LDHzeSg67pcMRWzI4Nw==
X-CSE-MsgGUID: 5tbCcZaBS2m9hbBwAC0xZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62673956"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62673956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 22:41:26 -0700
X-CSE-ConnectionGUID: ZoJHb3wGRnWBOsGAb2TbRQ==
X-CSE-MsgGUID: s9uNwnTPTh6uMhxQxJrq3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="186764038"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 15 Oct 2025 22:41:23 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>,
	Vijay Satija <vijay.satija@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Add support for smart trigger dump
Date: Thu, 16 Oct 2025 11:27:55 +0530
Message-ID: <20251016055755.2587652-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the debug configuration, firmware can raise MSIX interrupt with
firmware trigger cause bit set on specific events like Disconnection,
Connection Timeout, Page Timeout etc.

Upon receiving an MSIX interrupt with the firmware trigger cause bit
set, the driver performs the following actions:

1. Reads Device Memory: Retrieves data from the device memory,
   constructs an HCI vendor event, and sends it to the monitor. This
   event includes details about the trigger, such as connection timeout or
   page timeout.

2. Dumps Device Coredump: Generates a coredump containing firmware
   traces for further analysis.

Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h      |   1 +
 drivers/bluetooth/btintel_pcie.c | 154 +++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h |   9 +-
 3 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 431998049e68..bb2bf0b17336 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -53,6 +53,7 @@ struct intel_tlv {
 } __packed;
 
 #define BTINTEL_HCI_OP_RESET	0xfc01
+#define BTINTEL_HCI_OP_DEBUG	0xfcd9
 
 #define BTINTEL_CNVI_BLAZARI		0x900
 #define BTINTEL_CNVI_BLAZARIW		0x901
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6d3963bd56a9..438c67f317b5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -121,6 +121,21 @@ struct btintel_pcie_removal {
 	struct work_struct work;
 };
 
+struct btintel_pcie_trigger_evt {
+	u8 type;
+	u8 len;
+	__le32 addr;
+	__le32 size;
+} __packed;
+
+struct btintel_pcie_fwtrigger_evt {
+	__le32 reserved;
+	u8	type; /* Debug Trigger event */
+	__le16	len;
+	u8	event_type;
+	__le16	event_id;
+} __packed;
+
 static LIST_HEAD(btintel_pcie_recovery_list);
 static DEFINE_SPINLOCK(btintel_pcie_recovery_lock);
 
@@ -677,6 +692,11 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 		sizeof(*tlv) + strlen(vendor) +
 		sizeof(*tlv) + strlen(driver);
 
+	if (data->dmp_hdr.trigger_reason == BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT) {
+		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_type);
+		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_id);
+	}
+
 	/*
 	 * sizeof(u32) - signature
 	 * sizeof(data_len) - to store tlv data size
@@ -724,6 +744,15 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
 				  sizeof(data->dmp_hdr.cnvi_top));
 
+	if (data->dmp_hdr.trigger_reason == BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT) {
+		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_TYPE,
+					  &data->dmp_hdr.event_type,
+					  sizeof(data->dmp_hdr.event_type));
+		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_ID,
+					  &data->dmp_hdr.event_id,
+					  sizeof(data->dmp_hdr.event_id));
+	}
+
 	memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUFFER_SIZE);
 	dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);
 	return 0;
@@ -1298,6 +1327,75 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 	kfree(buf);
 }
 
+static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_fwtrigger_evt *evt;
+	struct hci_event_hdr *hdr;
+	struct sk_buff *skb;
+	int len, err;
+	u32 val;
+	u8 *buf;
+
+	if (!data->debug_evt_size || !data->debug_evt_addr)
+		return -EINVAL;
+
+	len = data->debug_evt_size;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	btintel_pcie_mac_init(data);
+
+	err = btintel_pcie_read_device_mem(data, buf, data->debug_evt_addr,
+					   data->debug_evt_size);
+	if (err)
+		goto exit_on_error;
+
+	evt = (void *)buf;
+	data->dmp_hdr.event_type  = evt->event_type;
+	data->dmp_hdr.event_id  = le16_to_cpu(evt->event_id);
+
+	bt_dev_dbg(data->hdev, "event type: 0x%2.2x event id: 0x%4.4x",
+		   data->dmp_hdr.event_type, data->dmp_hdr.event_id);
+
+	skb = bt_skb_alloc(sizeof(*hdr) + len, GFP_KERNEL);
+	if (!skb) {
+		err = -ENOMEM;
+		goto exit_on_error;
+	}
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->evt = 0xff;
+	hdr->plen = len;
+	skb_put_data(skb, buf, len);
+
+	/* copy Intel specific pcie packet type */
+	val = BTINTEL_PCIE_HCI_EVT_PKT;
+	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &val,
+	       BTINTEL_PCIE_HCI_TYPE_LEN);
+
+	btintel_pcie_recv_frame(data, skb);
+
+exit_on_error:
+	kfree(buf);
+	return err;
+}
+
+static void btintel_pcie_msix_fw_trigger_handler(struct btintel_pcie_data *data)
+{
+	bt_dev_dbg(data->hdev, "Received firmware smart trigger cause");
+
+	if (test_and_set_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags))
+		return;
+
+	/* Trigger device core dump when there is FW assert */
+	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
+		data->dmp_hdr.trigger_reason  = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
+
+	queue_work(data->workqueue, &data->rx_work);
+}
+
 static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_err(data->hdev, "Received hw exception interrupt");
@@ -1321,6 +1419,11 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 					struct btintel_pcie_data, rx_work);
 	struct sk_buff *skb;
 
+	if (test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
+		btintel_pcie_dump_fwtrigger_event(data);
+		clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
+	}
+
 	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
 		btintel_pcie_dump_traces(data->hdev);
 		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
@@ -1467,6 +1570,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
 		btintel_pcie_msix_gp1_handler(data);
 
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG)
+		btintel_pcie_msix_fw_trigger_handler(data);
+
 	/* This interrupt is triggered by the firmware after updating
 	 * boot_stage register and image_response register
 	 */
@@ -1555,6 +1661,7 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
 };
 
 /* This function configures the interrupt masks for both HW_INT_CAUSES and
@@ -2031,6 +2138,49 @@ static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data)
 		synchronize_irq(data->msix_entries[i].vector);
 }
 
+static int btintel_pcie_get_debug_info_addr(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	struct btintel_pcie_trigger_evt *evt;
+	u8 param[1] = {0x10};
+	struct sk_buff *skb;
+	int err = 0;
+
+	skb = __hci_cmd_sync(hdev, BTINTEL_HCI_OP_DEBUG, 1, param,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel read debug info address command failed (%ld)",
+			   PTR_ERR(skb));
+		/* Not all Intel products supports this command */
+		if (PTR_ERR(skb) == -EOPNOTSUPP)
+			return 0;
+		return PTR_ERR(skb);
+	}
+
+	/* Check the status */
+	if (skb->data[0]) {
+		bt_dev_err(hdev, "Reading Intel read debug info command failed (0x%2.2x)",
+			   skb->data[0]);
+		err = -EIO;
+		goto exit_error;
+	}
+
+	/* Consume Command Complete Status field */
+	skb_pull(skb, 1);
+
+	evt = (void *)skb->data;
+
+	data->debug_evt_addr = le32_to_cpu(evt->addr);
+	data->debug_evt_size = le32_to_cpu(evt->size);
+
+	bt_dev_dbg(hdev, "config type: %u config len: %u debug event addr: 0x%8.8x size: 0x%8.8x",
+		   evt->type, evt->len, data->debug_evt_addr,
+		   data->debug_evt_size);
+exit_error:
+	kfree_skb(skb);
+	return err;
+}
+
 static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
@@ -2128,6 +2278,10 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	if (ver_tlv.img_type == 0x02 || ver_tlv.img_type == 0x03)
 		data->dmp_hdr.fw_git_sha1 = ver_tlv.git_sha1;
 
+	err = btintel_pcie_get_debug_info_addr(hdev);
+	if (err)
+		goto exit_error;
+
 	btintel_print_fseq_info(hdev);
 exit_error:
 	kfree_skb(skb);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 04b21f968ad3..ef9983891f4b 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -101,6 +101,7 @@ enum msix_hw_int_causes {
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0	= BIT(0),	/* cause 32 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1	= BIT(1),	/* cause 33 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP	= BIT(3),	/* cause 35 */
+	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG	= BIT(5),	/* cause 37 */
 };
 
 /* PCIe device states
@@ -118,6 +119,7 @@ enum {
 	BTINTEL_PCIE_CORE_HALTED,
 	BTINTEL_PCIE_HWEXP_INPROGRESS,
 	BTINTEL_PCIE_COREDUMP_INPROGRESS,
+	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
 	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
 	BTINTEL_PCIE_SETUP_DONE
 };
@@ -133,7 +135,9 @@ enum btintel_pcie_tlv_type {
 	BTINTEL_DUMP_TIME,
 	BTINTEL_FW_BUILD,
 	BTINTEL_VENDOR,
-	BTINTEL_DRIVER
+	BTINTEL_DRIVER,
+	BTINTEL_EVENT_TYPE,
+	BTINTEL_EVENT_ID
 };
 
 /* causes for the MBOX interrupts */
@@ -429,6 +433,8 @@ struct btintel_pcie_dump_header {
 	u32		wrap_ctr;
 	u16		trigger_reason;
 	int		state;
+	u8		event_type;
+	u16		event_id;
 };
 
 /* struct btintel_pcie_data
@@ -513,6 +519,7 @@ struct btintel_pcie_data {
 	u32	alive_intr_ctxt;
 	struct btintel_pcie_dbgc	dbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
+	u32	debug_evt_addr, debug_evt_size;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

