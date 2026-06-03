Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907538D40E
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500892; cv=none; b=gX9hUksj2dS1FbpPXPsFP6865wra9T7Umd/WO/5BoVqLlaACLWy1gUfzY49N0/Ov+kVCiK1c4ks2tvtbwFm3sT+SEuEQrCSRGfXWhzSLFD7PkL0s+Z1sUvtJrEDTwuYyt9niOBuHT4d3UBshqsK3DKHZPpmzKFlqYZIsn+AjzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500892; c=relaxed/simple;
	bh=kc8G9hlzRmV2SPk2SvCxX8EV6fkvxpCYRpDs434JuHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXhQQjC6znglQNdjywE3LPBajHvsEwNAxv9fAE34Y82pJ8H44k1EN0rK36KEzsgMY/9jdYLZjK4RK3OALAhvSVp3veaKwxRfZZwdJAQ1OHo5YdaT+QqftlIaTEMZs5s36SLegyd7EkX61PrZNQgozVRxOUY5nl4chE13fOpqk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEetnbcU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEetnbcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780500890; x=1812036890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kc8G9hlzRmV2SPk2SvCxX8EV6fkvxpCYRpDs434JuHQ=;
  b=gEetnbcU7fcTjH//rgIr9SM2Yep65HnCBJ+ZzRaAM8ZBv3p3yn6Lt6+u
   b/N8qVmOAmL0fAkk90PvMw5vkPum0ASNF4oA51+CC9T+/lCkxvZoLS5gU
   fuaK3bcGEmML/hBHD07HJXzdK82eqZOoorARKk79xV5lkwQP+GC9OlDPd
   Bv8+1Z/ZeSL0qBopZtSct8Rj41a0UORiN/floUd1ag7I/TprMXfSCw5Gq
   M87gBdawP4bk6aHclvQRRDYyTLhNHgdkiSQwyDfGmJynqh5808sezl++U
   U2/nlZbeUzCXf18/UQEdHAxtHV1Kk8fSZ4b2Y4dgbHv3o750yuEeUfk8i
   g==;
X-CSE-ConnectionGUID: VG02shyzRLy9NG2jGhJthA==
X-CSE-MsgGUID: uzwxrLvETkG0T0yd2rb/hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80457454"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="80457454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:34:49 -0700
X-CSE-ConnectionGUID: ow34vFoGS0uNvngzOU0QMw==
X-CSE-MsgGUID: D7rave8+SuqkZ7NT3vX9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="243210105"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 03 Jun 2026 08:34:47 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Add support for smart trigger dump
Date: Wed,  3 Jun 2026 21:24:15 +0530
Message-ID: <20260603155415.50855-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the debug configuration, firmware can raise MSI-X interrupt with
firmware trigger cause bit set on specific events like Disconnection,
Connection Timeout, Page Timeout etc.

Upon receiving an MSI-X interrupt with the firmware trigger cause bit
set, the driver performs the following actions:

1. Reads Device Memory: Retrieves data from the device memory,
   constructs an HCI diagnostic event, and sends it to the monitor. This
   event includes details about the trigger, such as connection timeout or
   page timeout.

2. Dumps Device Coredump: Generates a coredump containing firmware
   traces for further analysis.

The coredump can be retrieved using:

  $ cat /sys/class/devcoredump/devcd*/data > /tmp/btintel_coredump.bin

HCI traces:
= Vendor Diagnostic (len 12)
        a5 a5 a5 a5 01 03 00 23 00 01 00 00

Signed-off-by: Kiran K <kiran.k@intel.com>
---
Update in v2:
- commit message update to include HCI traces and coredump retrieval
- convert debug data into hci diagnostic event

 drivers/bluetooth/btintel.h      |   1 +
 drivers/bluetooth/btintel_pcie.c | 164 +++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h |  10 +-
 3 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 70d812ad36a2..7cce1bdebae0 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -53,6 +53,7 @@ struct intel_tlv {
 } __packed;
 
 #define BTINTEL_HCI_OP_RESET	0xfc01
+#define BTINTEL_HCI_OP_DEBUG	0xfcd9
 
 #define BTINTEL_CNVI_BLAZARI		0x900	/* BlazarI - Lunar Lake */
 #define BTINTEL_CNVI_BLAZARIW		0x901	/* BlazarIW - Wildcat Lake */
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index eeaefffaaf6b..2baef130d101 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -145,6 +145,22 @@ struct btintel_pcie_dbgc_ctxt {
 	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
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
+	__le16	reserved2;
+} __packed;
+
 static LIST_HEAD(btintel_pcie_recovery_list);
 static DEFINE_SPINLOCK(btintel_pcie_recovery_lock);
 
@@ -696,6 +712,11 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 		sizeof(*tlv) + strlen(vendor) +
 		sizeof(*tlv) + strlen(driver);
 
+	if (data->dmp_hdr.event_type && data->dmp_hdr.event_id) {
+		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_type);
+		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_id);
+	}
+
 	/*
 	 * sizeof(u32) - signature
 	 * sizeof(data_len) - to store tlv data size
@@ -743,6 +764,17 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
 				  sizeof(data->dmp_hdr.cnvi_top));
 
+	if (data->dmp_hdr.event_type && data->dmp_hdr.event_id) {
+		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_TYPE,
+					  &data->dmp_hdr.event_type,
+					  sizeof(data->dmp_hdr.event_type));
+		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_ID,
+					  &data->dmp_hdr.event_id,
+					  sizeof(data->dmp_hdr.event_id));
+		data->dmp_hdr.event_type = 0;
+		data->dmp_hdr.event_id = 0;
+	}
+
 	memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUFFER_SIZE);
 	dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);
 	return 0;
@@ -1330,6 +1362,73 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 	kfree(buf);
 }
 
+static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_fwtrigger_evt *evt;
+	struct sk_buff *skb;
+	unsigned int len;
+	int err;
+	u8 *buf;
+
+	if (!data->debug_evt_size || !data->debug_evt_addr)
+		return -EINVAL;
+
+	len = data->debug_evt_size;
+
+	len = ALIGN_DOWN(len, 4);
+
+	if (len < sizeof(*evt) || len > HCI_MAX_EVENT_SIZE) {
+		bt_dev_err(data->hdev, "Invalid FW trigger data size (%u bytes)", len);
+		return -EINVAL;
+	}
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	btintel_pcie_mac_init(data);
+
+	err = btintel_pcie_read_device_mem(data, buf, data->debug_evt_addr,
+					   len);
+	if (err)
+		goto exit_on_error;
+
+	evt = (void *)buf;
+	data->dmp_hdr.event_type = evt->event_type;
+	data->dmp_hdr.event_id = le16_to_cpu(evt->event_id);
+
+	bt_dev_dbg(data->hdev, "event type: 0x%2.2x event id: 0x%4.4x len: %u",
+		   data->dmp_hdr.event_type, data->dmp_hdr.event_id, len);
+
+	skb = bt_skb_alloc(len, GFP_KERNEL);
+	if (!skb) {
+		err = -ENOMEM;
+		goto exit_on_error;
+	}
+	skb_put_data(skb, buf, len);
+
+	hci_recv_diag(data->hdev, skb);
+	err = 0;
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
+		data->dmp_hdr.trigger_reason = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
+
+	queue_work(data->workqueue, &data->rx_work);
+}
+
 static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_err(data->hdev, "Received hw exception interrupt");
@@ -1352,6 +1451,14 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 	struct btintel_pcie_data *data = container_of(work,
 					struct btintel_pcie_data, rx_work);
 	struct sk_buff *skb;
+	int err;
+
+	if (test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
+		err = btintel_pcie_dump_fwtrigger_event(data);
+		if (err)
+			bt_dev_warn(data->hdev, "failed to log fwtrigger event");
+		clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
+	}
 
 	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
 		btintel_pcie_dump_traces(data->hdev);
@@ -1509,6 +1616,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 			btintel_pcie_msix_tx_handle(data);
 	}
 
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG)
+		btintel_pcie_msix_fw_trigger_handler(data);
+
 	/* This interrupt is triggered by the firmware after updating
 	 * boot_stage register and image_response register
 	 */
@@ -1583,6 +1693,7 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
 };
 
 /* This function configures the interrupt masks for both HW_INT_CAUSES and
@@ -2069,6 +2180,55 @@ static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data)
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
+	if (skb->len < (1 + sizeof(*evt))) {
+		bt_dev_err(hdev, "Debug info response too short (%u bytes)", skb->len);
+		err = -EIO;
+		goto exit_error;
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
@@ -2168,6 +2328,10 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
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
index 7fc8c46ed689..cae84b00a700 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -98,6 +98,7 @@ enum msix_hw_int_causes {
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0	= BIT(0),	/* cause 32 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1	= BIT(1),	/* cause 33 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP	= BIT(3),	/* cause 35 */
+	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG	= BIT(5),	/* cause 37 */
 };
 
 /* PCIe device states
@@ -115,6 +116,7 @@ enum {
 	BTINTEL_PCIE_CORE_HALTED,
 	BTINTEL_PCIE_HWEXP_INPROGRESS,
 	BTINTEL_PCIE_COREDUMP_INPROGRESS,
+	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
 	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
 	BTINTEL_PCIE_SETUP_DONE
 };
@@ -130,7 +132,9 @@ enum btintel_pcie_tlv_type {
 	BTINTEL_DUMP_TIME,
 	BTINTEL_FW_BUILD,
 	BTINTEL_VENDOR,
-	BTINTEL_DRIVER
+	BTINTEL_DRIVER,
+	BTINTEL_EVENT_TYPE,
+	BTINTEL_EVENT_ID
 };
 
 /* causes for the MBOX interrupts */
@@ -430,6 +434,8 @@ struct btintel_pcie_dump_header {
 	u32		wrap_ctr;
 	u16		trigger_reason;
 	int		state;
+	u8		event_type;
+	u16		event_id;
 };
 
 /* struct btintel_pcie_data
@@ -518,6 +524,8 @@ struct btintel_pcie_data {
 	struct btintel_pcie_dbgc	dbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
 	u8	pm_sx_event;
+	u32	debug_evt_addr;
+	u32	debug_evt_size;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.54.0

