Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079886;
	b=h120SViAqAmUmkXJ+3HgOW40vOD8EwPCwRBlNpYsiyuiQu5cX/Hlwr1VypSHttSraoR9
	 1p+C5AgrNh4Xx5snwltwtNY4J3rDAsFrzjjyNlAZ0+m+ryKDfcfaW1A3FPLQeMh0qZqap
	 l1E6FfC56GvgZ5lHQ0ook7mUovZ65om/PBaEhc/ceqj093ebUf2SJOzKhsYAKWZMPR3WU
	 x5QRTMCH9LpE0zFpGAFOfS1D7fbNS443e9zt8jDkX7yr3tRcvRyKYCfdHjW7qRKy+cTma
	 ILffoqaIAVTxRO4DvjqLHWcPOKk7esq5by6v4gqWuYvK56yFc6kEoEKKzKscKus615A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079886;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iSFtXlHX7cugvz3dKK9Xj+sOfYhuwKeWNXNW1lzK3s8=;
	b=K3uTvPfqmlaEEFBlg8VYZUmWTb1kk4TkyZqDUb6UyWECWHVW+ueicWt//kG4PIwXHmHP
	 3QYNFsLomYui6A/vFDH8TbpEXgG07FtETjHuQ2lpP0fkXdbEsFOcOgStuYQX6wFDzK03H
	 fpa+pE1eLnrOwAL/ZydigzhE+AKJVVgstNFyzee3PgQvhj+B8u50xx+ZS3mg1wA+Jw9Il
	 4QNc2l91sTQobDpEYAWMj7EdpDPy8LRHgx6EprQ+JylL91dymswMOBKfI3wPL8Bnxu9iI
	 gDuuDkd/H0MNvGNJBb9SoICTAK1n5zndLMU885e2B3YLf3cAZkEFzmk5MqiztAvpuEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nnTNVM+D;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2098606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 05:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2098606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nnTNVM+D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793079886; x=1824615886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kF5TkFlY4wylls8urDvcDqNlsXGIcThq7UUcA/ThAaE=;
  b=nnTNVM+Dm+lyDk7uWX1jdFLlXlAWub6ugnhaEZR+/gExA0gFvasbXOGC
   nfLUaxVsWCXSLuD6HyEPCoynW6z1TPOSQQ8QeMhzmBrQZzLm2xuam+DSZ
   wGAgZO3y+k/4gFHaroadlE7dWubQqg7n77ksXg41Kv+P3Nj+Gw7ECyYOS
   7UHXFmLyG36CQ/xqLYlZJz4VmIN5lfbmCBYcoCMdfaApIJKGr9ySG8buj
   Hf76SVfCs/e3wBzbplnF1SMfx5munXOiAmMBbq+IAxRpPVmgQsRvSt9tR
   CJGd9lwBLE268xLYl3q8DIl5VRp7dQJTazP3VR83+th988QGBzkxYo30+
   w==;
X-CSE-ConnectionGUID: 0GSo/FCHSaWhJHsFm+MW6g==
X-CSE-MsgGUID: zlHXwMbbTzmDxnc9E/V9dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1672604"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1672604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 22:44:46 -0700
X-CSE-ConnectionGUID: cBisBFfvSi6BgM35dYdNug==
X-CSE-MsgGUID: +BM22D0lQaGsnRX6QWTP6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4495606"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa004.fm.intel.com with ESMTP; 26 Oct 2026 22:44:44 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v3 2/2] Bluetooth: btintel_pcie: Add TOP silent reset support
Date: Tue, 27 Oct 2026 11:14:08 +0530
Message-ID: <20261027054408.318002-2-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027054408.318002-1-chandrashekar.devegowda@intel.com>
References: <20261027054408.318002-1-chandrashekar.devegowda@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TOP silent reset as a lighter alternative to PLDR for HW >= SCP2
on subsystem PEP. After the FLR reprobe, send the Intel soft reset
with the cached boot_addr, wait for the GP1 mailbox event and boot
stage 0, then request a final FLR. Any failure falls back to PLDR.

A WiFi-initiated request makes BT follow with PLDR.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v3:
- Rebase onto current bluetooth-next; pass hdev explicitly into
  btintel_pcie_do_top_reset().
- Harden WiFi-coordinated reset/recovery handling (role switch
  timeout, NACK/no-response, PLDR replay, race-safe reset-type
  tracking).
- Use a non-blocking PCI lock for ACPI reset; fix ROM fast-path
  ordering in send_sync().
- Use ktime_to_us() for the mailbox ack debug print (was ~2% low).

Changes in v2:
- Replace generation/deadline tracking with a published timeout,
  extended on a role switch event.
- Fall back to PLDR on any mailbox/soft-reset failure; preserve and
  replay a pending WiFi PLDR request across reprobe.
- Synchronize IRQs instead of irq_lock when skipping the alive wait.

v2: https://lore.kernel.org/linux-bluetooth/20261023094033.212251-1-chandrashekar.devegowda@intel.com/
v1: https://lore.kernel.org/linux-bluetooth/20261014114752.174669-1-chandrashekar.devegowda@intel.com/

 drivers/bluetooth/btintel_pcie.c | 522 ++++++++++++++++++++++++++++---
 drivers/bluetooth/btintel_pcie.h |  40 ++-
 2 files changed, 512 insertions(+), 50 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 4fbefaa3129a..dcff44bbd216 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -67,6 +67,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 
 struct btintel_pcie_dev_recovery {
 	struct list_head list;
+	unsigned long flags;
 	u8 count;
 	time64_t last_error;
 	char name[];
@@ -87,6 +88,9 @@ struct btintel_pcie_dev_recovery {
 
 #define BTINTEL_PCIE_RESET_WINDOW_SECS		5
 #define BTINTEL_PCIE_FLR_MAX_RETRY	1
+#define BTINTEL_PCIE_TOP_RESET_INTERVAL_MS	250
+#define BTINTEL_PCIE_TOP_RESET_ROLE_SWITCH_MS	5000
+#define BTINTEL_PCIE_TOP_RESET_FALLBACK_MS	250
 
 /* Alive interrupt context */
 enum {
@@ -690,6 +694,15 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 	hci_recv_diag(hdev, skb);
 }
 
+static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data);
+static void btintel_pcie_reset_ia(struct btintel_pcie_data *data);
+static int btintel_pcie_start_rx(struct btintel_pcie_data *data);
+static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data);
+static struct btintel_pcie_dev_recovery *
+btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev);
+static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
+				       enum btintel_pcie_reset_type type);
+
 static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 				  struct sk_buff *skb, u32 pkt_type, u16 opcode)
 {
@@ -697,6 +710,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 	u16 tfd_index;
 	u32 old_ctxt;
 	bool wait_on_alive = false;
+	bool top_rom = false;
 	struct hci_dev *hdev = data->hdev;
 
 	struct txq *txq = &data->txq;
@@ -718,7 +732,20 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 	wait_on_alive = (pkt_type == BTINTEL_PCIE_HCI_CMD_PKT &&
 		(opcode == BTINTEL_HCI_OP_RESET || opcode == HCI_OP_RESET));
 
-	if (wait_on_alive) {
+	/* After TOP reset the controller is in ROM; no alive interrupt follows */
+	if (wait_on_alive && test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+		u32 stage = btintel_pcie_rd_reg32(data,
+						  BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+
+		top_rom = (stage & BTINTEL_PCIE_CSR_BOOT_STAGE_ROM) &&
+			  !(stage & (BTINTEL_PCIE_CSR_BOOT_STAGE_IML |
+				     BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW));
+	}
+
+	if (top_rom) {
+		/* Set before the doorbell so GP0 never sees a transient context */
+		data->alive_intr_ctxt = BTINTEL_PCIE_FW_DL;
+	} else if (wait_on_alive) {
 		data->gp0_received = false;
 		old_ctxt = data->alive_intr_ctxt;
 		data->alive_intr_ctxt =
@@ -756,6 +783,14 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 		return -ETIME;
 	}
 
+	if (top_rom) {
+		/* Let the TX completion handler finish updating the IA */
+		btintel_pcie_synchronize_irqs(data);
+		btintel_pcie_reset_ia(data);
+		btintel_pcie_start_rx(data);
+		return 0;
+	}
+
 	if (wait_on_alive) {
 		ret = wait_event_timeout(data->gp0_wait_q,
 					 data->gp0_received,
@@ -1665,6 +1700,13 @@ static inline bool btintel_pcie_in_iml(struct btintel_pcie_data *data)
 		!(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW);
 }
 
+static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data)
+{
+	return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ROM &&
+		!(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_IML) &&
+		!(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW);
+}
+
 static inline bool btintel_pcie_in_d3(struct btintel_pcie_data *data)
 {
 	return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY;
@@ -2049,25 +2091,46 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 
 static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 {
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	bool top_reset_mbox = false;
 	bool target_access = false;
+	bool mbox2_status;
 	u32 addr = 0, size = 0;
 
+	calltime = ktime_get();
+
 	/* Read the Mail box status and registers */
 	data->mbox.mbox_status = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_STATUS_REG);
+	mbox2_status = data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2;
 	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) {
-		data->mbox.mbox1 = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_1_REG);
-		if (data->mbox.mbox1 ==
-		    BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING) {
-			bt_dev_info(data->hdev,
-				    "mailbox for target access");
+		data->mbox.mbox1 = btintel_pcie_rd_reg32(data,
+							 BTINTEL_PCIE_CSR_MBOX_1_REG);
+		if (data->mbox.mbox1 == BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING) {
+			bt_dev_info(data->hdev, "mailbox for target access");
+			clear_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+				  &data->flags);
 			target_access = true;
+		} else if (data->mbox.mbox1 == BTINTEL_PCIE_TOP_SILENT_RESET) {
+			if (mbox2_status)
+				top_reset_mbox = true;
+			else
+				set_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+					&data->flags);
+		} else {
+			clear_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+				  &data->flags);
 		}
 	}
 
-	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2) {
-		data->mbox.mbox2 = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_2_REG);
+	if (mbox2_status) {
+		data->mbox.mbox2 = btintel_pcie_rd_reg32(data,
+							 BTINTEL_PCIE_CSR_MBOX_2_REG);
 		if (target_access)
 			addr = data->mbox.mbox2;
+		if (test_and_clear_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+				       &data->flags))
+			top_reset_mbox = true;
 	}
 
 	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3) {
@@ -2106,10 +2169,106 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 		}
 	}
 
+	/* Handle SCU state change inline, just log it */
+	if ((data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) &&
+	    data->mbox.mbox1 == BTINTEL_PCIE_CNVI_SCU_REG_MAIN_FSM_STICKY &&
+	    mbox2_status) {
+		if (data->mbox.mbox2 == BTINTEL_PCIE_SCU_CORE_IDLE_SET)
+			bt_dev_dbg(data->hdev, "TOP reset SCU CORE IDLE set");
+		if (data->mbox.mbox2 == BTINTEL_PCIE_SCU_CORE_IDLE_RESET)
+			bt_dev_dbg(data->hdev, "TOP reset SCU CORE IDLE reset");
+	}
+
+	/* Handle TOP silent reset mbox notification inline */
+	if (top_reset_mbox) {
+		struct btintel_pcie_dev_recovery *rec;
+		u32 expires = BTINTEL_PCIE_TOP_RESET_INTERVAL_MS;
+		struct hci_dev *hdev = READ_ONCE(data->hdev);
+		u32 reg;
+
+		if (!hdev)
+			goto skip_top_reset;
+
+		rec = btintel_pcie_get_recovery(data->pdev, &hdev->dev);
+		if (!rec) {
+			bt_dev_err(hdev,
+				   "TOP reset: failed to get recovery data");
+			goto skip_top_reset;
+		}
+
+		switch (data->mbox.mbox2) {
+		case BTINTEL_PCIE_TOP_RESET_WIFI_REQUEST:
+			bt_dev_info(hdev,
+				    "TOP reset request from WiFi, triggering PLDR");
+			if (!test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+				bt_dev_info(hdev,
+					    "BT is follower, triggering PLDR");
+				set_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+					&rec->flags);
+				smp_mb__after_atomic(); /* Order against SETUP_DONE test */
+				if (btintel_pcie_request_reset(data,
+							       BTINTEL_PCIE_IOSF_PRR_PLDR)) {
+					clear_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+						  &rec->flags);
+					set_bit(BTINTEL_PCIE_CORE_HALTED,
+						&data->flags);
+				}
+				goto skip_top_reset;
+			}
+			break;
+		case BTINTEL_PCIE_TOP_RESET_WIFI_ACK:
+			bt_dev_info(hdev, "TOP reset ack from WiFi");
+			break;
+		case BTINTEL_PCIE_TOP_RESET_WIFI_NACK:
+			bt_dev_info(hdev, "TOP reset NACK from WiFi");
+			set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
+			break;
+		case BTINTEL_PCIE_TOP_RESET_WIFI_REQ_ROLE_SWITCH:
+			bt_dev_info(hdev,
+				    "TOP reset WIFI_REQ_ROLE_SWITCH");
+			expires = BTINTEL_PCIE_TOP_RESET_ROLE_SWITCH_MS;
+			reg = btintel_pcie_rd_reg32(data,
+						    BTINTEL_PCIE_CSR_RESET_DEBUG_AD);
+			if (reg == BTINTEL_PCIE_TOP_RESET_DBG_RESET_REG)
+				bt_dev_dbg(hdev,
+					   "TOP reset initiated by WiFi");
+			break;
+		case BTINTEL_PCIE_TOP_RESET_WIFI_NO_RESPONSE:
+			bt_dev_err(hdev, "TOP reset WIFI_NO_RESPONSE");
+			set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
+			break;
+		case BTINTEL_PCIE_TOP_RESET_WIFI_RESPONSE_INVALID:
+			bt_dev_err(hdev,
+				   "TOP reset WIFI_RESPONSE_INVALID");
+			set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
+			break;
+		default:
+			bt_dev_err(hdev,
+				   "TOP reset with undefined MBOX2 0x%8.8x",
+				   data->mbox.mbox2);
+			break;
+		}
+
+		/* A later event must not shorten an earlier role switch timeout */
+		expires = max(expires, READ_ONCE(data->top_reset_expires));
+		WRITE_ONCE(data->top_reset_expires, expires);
+		smp_mb__before_atomic(); /* Publish expires before the flag */
+		set_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags);
+		bt_dev_info(hdev,
+			    "TOP reset timer expires in %u ms", expires);
+		wake_up(&data->gp0_wait_q);
+	}
+
+skip_top_reset:
 	/* Mailbox is read, ack to FW */
 	btintel_pcie_set_reg_bits(data,
 				  BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC_REG,
 				  BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM);
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = ktime_to_us(delta);
+	bt_dev_dbg(data->hdev, "Mailbox acked in %llu usecs", duration);
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
@@ -2164,9 +2323,9 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 		signal_waitq = true;
 		break;
 	case BTINTEL_PCIE_FW_DL:
-		/* Error case is already handled. Ideally control shall not
-		 * reach here
-		 */
+		/* Wake the TOP reset boot-stage wait */
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+			signal_waitq = true;
 		break;
 	case BTINTEL_PCIE_INTEL_HCI_RESET1:
 		if (btintel_pcie_in_op(data)) {
@@ -3153,6 +3312,7 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x00 },
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x21 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x22 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
@@ -3581,7 +3741,8 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
 		return -ENODEV;
 
-	if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
+	if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags) ||
+	    test_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags))
 		return -ENODEV;
 
 	/* Account for the 4-byte PCIe type header prepended before the
@@ -3896,12 +4057,127 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	return err;
 }
 
+static bool btintel_pcie_top_reset_done(struct btintel_pcie_data *data,
+					struct btintel_pcie_dev_recovery *rec)
+{
+	return !btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG) ||
+	       test_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
+}
+
+static int btintel_pcie_do_top_reset(struct btintel_pcie_data *data,
+				     struct hci_dev *hdev)
+{
+	struct btintel_data *intel_data = hci_get_priv(hdev);
+	enum btintel_pcie_reset_type reset_type;
+	struct btintel_pcie_dev_recovery *rec;
+	u32 expires, latest;
+	long ret;
+	bool failed;
+	u32 reg;
+	int err;
+
+	rec = btintel_pcie_get_recovery(data->pdev, &hdev->dev);
+	if (!rec)
+		return -ENOMEM;
+
+	/* Set scratch register to indicate TOP silent reset to FW */
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR,
+				  BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILENT_RESET);
+
+	/* Clear mbox flag before sending reset to avoid race with ISR */
+	clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags);
+	clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
+
+	if (!intel_data->boot_addr) {
+		bt_dev_err(hdev, "TOP reset: no boot address; doing PLDR");
+		reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+		goto done;
+	}
+
+	err = btintel_send_intel_reset(hdev, intel_data->boot_addr);
+	if (err) {
+		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
+		reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+		goto done;
+	}
+
+	/* First wait: wait for initial mbox event from FW */
+	ret = wait_event_timeout(data->gp0_wait_q,
+				 test_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags),
+				 msecs_to_jiffies(BTINTEL_PCIE_TOP_RESET_FALLBACK_MS));
+
+	if (!ret) {
+		bt_dev_warn(hdev,
+			    "TOP reset: no mbox received within %u ms; doing PLDR",
+			    BTINTEL_PCIE_TOP_RESET_FALLBACK_MS);
+		reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+		goto done;
+	}
+
+	/* Second wait: mbox received, wait for boot_stage == 0 using the
+	 * timeout determined by the GP1 handler based on mbox2.
+	 */
+	smp_rmb(); /* Pairs with smp_mb__before_atomic() in the GP1 handler */
+	expires = READ_ONCE(data->top_reset_expires);
+	ret = wait_event_timeout(data->gp0_wait_q,
+				 btintel_pcie_top_reset_done(data, rec),
+				 msecs_to_jiffies(expires));
+	latest = READ_ONCE(data->top_reset_expires);
+	if (!ret && latest > expires)
+		ret = wait_event_timeout(data->gp0_wait_q,
+					 btintel_pcie_top_reset_done(data, rec),
+					 msecs_to_jiffies(latest - expires));
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	bt_dev_info(hdev, "After side band reset boot-stage: 0x%8.8x", reg);
+
+	failed = test_and_clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
+				    &rec->flags);
+	if ((!ret && reg != 0) || failed) {
+		bt_dev_warn(hdev,
+			    "TOP reset failed (boot_stage:0x%08x), triggering PLDR",
+			    reg);
+		reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+	} else {
+		reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+	}
+
+done:
+	clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags);
+	btintel_clear_flag(hdev, INTEL_TOP_RESET);
+	btintel_pcie_clr_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR,
+				  BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILENT_RESET);
+
+	/* TOP_RESET lets request_reset() proceed without SETUP_DONE */
+	if (!btintel_pcie_request_reset(data, reset_type))
+		return -EIO;
+
+	/* Fail the open; reset_work reprobes the device */
+	return -ECANCELED;
+}
+
 static int btintel_pcie_setup(struct hci_dev *hdev)
 {
-	int err, fw_dl_retry = 0;
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	struct btintel_pcie_dev_recovery *rec;
+	int err, fw_dl_retry = 0;
+
+	/* Restore TOP reset intent saved across device_reprobe() */
+	rec = btintel_pcie_get_recovery(data->pdev, &hdev->dev);
+	if (rec && test_and_clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+				      &rec->flags)) {
+		set_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+	}
 
 	while ((err = btintel_pcie_setup_internal(hdev)) && fw_dl_retry++ < 1) {
+		if (err == -ENODEV)
+			break;
+
+		if ((err == -ECANCELED || err == -EALREADY) &&
+		    test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+			break;
+
 		bt_dev_err(hdev, "Firmware download retry count: %d",
 			   fw_dl_retry);
 		btintel_pcie_dump_debug_registers(hdev);
@@ -3924,11 +4200,38 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		btintel_pcie_start_rx(data);
 	}
 
+	if (err == -ECANCELED && test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+		return btintel_pcie_do_top_reset(data, hdev);
+
+	if (err && test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+		bt_dev_err(hdev, "TOP silent reset setup failed (%d), doing PLDR",
+			   err);
+		if (btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR))
+			return -ECANCELED;
+
+		clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		btintel_clear_flag(hdev, INTEL_TOP_RESET);
+	}
+
 	if (!err) {
+		clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		btintel_clear_flag(hdev, INTEL_TOP_RESET);
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
 		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
 		btintel_pcie_unmask_hw_rfkill(data);
 		btintel_delayed_hw_rfkill(data, true);
+
+		if (rec && test_and_clear_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+					      &rec->flags)) {
+			if (btintel_pcie_request_reset(data,
+						       BTINTEL_PCIE_IOSF_PRR_PLDR)) {
+				set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+				return -ECANCELED;
+			}
+
+			set_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				&rec->flags);
+		}
 	}
 	return err;
 }
@@ -3940,15 +4243,17 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
 	const char *name = pci_name(pdev);
 	const size_t name_len = strlen(name) + 1;
 	struct hci_dev *hdev = to_hci_dev(dev);
+	unsigned long flags;
 
-	spin_lock(&btintel_pcie_recovery_lock);
+	/* Also called from the GP1 irq thread */
+	spin_lock_irqsave(&btintel_pcie_recovery_lock, flags);
 	list_for_each_entry(tmp, &btintel_pcie_recovery_list, list) {
 		if (strcmp(tmp->name, name))
 			continue;
 		data = tmp;
 		break;
 	}
-	spin_unlock(&btintel_pcie_recovery_lock);
+	spin_unlock_irqrestore(&btintel_pcie_recovery_lock, flags);
 
 	if (data) {
 		bt_dev_dbg(hdev, "Found restart data for BDF: %s", data->name);
@@ -3960,9 +4265,17 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
 		return NULL;
 
 	strscpy(data->name, name, name_len);
-	spin_lock(&btintel_pcie_recovery_lock);
+	spin_lock_irqsave(&btintel_pcie_recovery_lock, flags);
+	/* Recheck: another caller may have added this BDF meanwhile */
+	list_for_each_entry(tmp, &btintel_pcie_recovery_list, list) {
+		if (strcmp(tmp->name, name))
+			continue;
+		spin_unlock_irqrestore(&btintel_pcie_recovery_lock, flags);
+		kfree(data);
+		return tmp;
+	}
 	list_add_tail(&data->list, &btintel_pcie_recovery_list);
-	spin_unlock(&btintel_pcie_recovery_lock);
+	spin_unlock_irqrestore(&btintel_pcie_recovery_lock, flags);
 
 	return data;
 }
@@ -4033,6 +4346,10 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 		return -ENODEV;
 	}
 
+	/* Unbind may hold the device lock while waiting for reset_work. */
+	if (!pci_dev_trylock(data->pdev))
+		return -EAGAIN;
+
 	argv4.buffer.type = ACPI_TYPE_BUFFER;
 	argv4.buffer.length = sizeof(mode);
 	argv4.buffer.pointer = (void *)&mode;
@@ -4041,17 +4358,18 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 				BTINTEL_PCIE_DSM_DYNAMIC_PLDR, &argv4);
 	if (!obj) {
 		bt_dev_err(data->hdev, "Failed to call dsm to set reset method");
-		return -EIO;
+		ret = -EIO;
+		goto out_unlock;
 	}
 	ACPI_FREE(obj);
 
-	pci_dev_lock(data->pdev);
 	pci_save_state(data->pdev);
 	ret = btintel_acpi_reset_method(hdev);
 	if (ret)
 		bt_dev_err(data->hdev, "ACPI _PRR reset failed (%d), PLDR incomplete",
 			   ret);
 	pci_restore_state(data->pdev);
+out_unlock:
 	pci_dev_unlock(data->pdev);
 	return ret;
 }
@@ -4063,7 +4381,7 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 }
 #endif
 
-static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
+static int btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 {
 	struct pci_dev *pdev = data->pdev;
 	struct pci_dev *wifi = NULL;
@@ -4084,7 +4402,7 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 
 	bus = pdev->bus;
 	if (!bus)
-		return;
+		return -ENODEV;
 
 	list_for_each_entry(tmp, &bus->devices, bus_list) {
 		if (pci_match_id(wifi_device_ids, tmp)) {
@@ -4112,9 +4430,19 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 	}
 
 	if (!ret) {
+		struct btintel_pcie_dev_recovery *rec;
+
+		/* This PLDR also reset WiFi; do not replay its request */
+		rec = btintel_pcie_get_recovery(pdev, &data->hdev->dev);
+		if (rec)
+			clear_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				  &rec->flags);
+
 		if (device_reprobe(&pdev->dev))
 			BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
 	}
+
+	return ret;
 }
 
 /*
@@ -4151,6 +4479,33 @@ static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
 	return 0;
 }
 
+/* No reprobe will follow a failed reset; undo the reset state */
+static void btintel_pcie_reset_failed(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_dev_recovery *rec;
+
+	rec = btintel_pcie_get_recovery(data->pdev, &data->hdev->dev);
+
+	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR)
+		set_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
+	if (rec)
+		clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags);
+	clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+	btintel_clear_flag(data->hdev, INTEL_TOP_RESET);
+	enable_work(&data->coredump_work);
+	enable_work(&data->hwexp_work);
+	enable_work(&data->fwtrigger_work);
+	enable_work(&data->mbox_work);
+	enable_delayed_work(&data->hw_rfkill_work);
+	clear_bit_unlock(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+
+	if (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags) &&
+	    btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR)) {
+		clear_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags);
+		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+	}
+}
+
 static void btintel_pcie_reset_work(struct work_struct *wk)
 {
 	struct btintel_pcie_data *data =
@@ -4184,7 +4539,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	/* Both reset paths follow the same contract: on success they
 	 * destroy 'data' via device_reprobe() (a fresh probe re-INIT_WORKs
 	 * the dump workers with disable count 0), so enable_work() must
-	 * NOT be called on the success path. Only the FLR path can fail
+	 * NOT be called on the success path. Either reset can fail
 	 * with 'data' still alive, in which case we balance the
 	 * disable_work_sync() calls above so a later successful reset is
 	 * not permanently blocked.
@@ -4194,16 +4549,28 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	 * or removed from the bus list while this code runs.
 	 */
 	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR) {
-		btintel_pcie_perform_pldr(data);
+		if (btintel_pcie_perform_pldr(data))
+			btintel_pcie_reset_failed(data);
 		goto out;
 	}
 
 	if (btintel_pcie_perform_flr(data)) {
-		enable_work(&data->coredump_work);
-		enable_work(&data->hwexp_work);
-		enable_work(&data->fwtrigger_work);
-		enable_work(&data->mbox_work);
-		enable_delayed_work(&data->hw_rfkill_work);
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+			struct btintel_pcie_dev_recovery *rec;
+
+			bt_dev_warn(data->hdev,
+				    "FLR failure after TOP silent reset, falling back to PLDR");
+			data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+			rec = btintel_pcie_get_recovery(data->pdev,
+							&data->hdev->dev);
+			if (rec)
+				clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+					  &rec->flags);
+			if (!btintel_pcie_perform_pldr(data))
+				goto out;
+		}
+
+		btintel_pcie_reset_failed(data);
 	}
 
 out:
@@ -4228,31 +4595,63 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
  *     in-flight one (whose recovery will reinitialize the device
  *     regardless of the dropped trigger's variant).
  *
- * The bit is cleared only by .remove() / re-probe via fresh devm
- * allocation, which is the intended one-shot semantics: a reset
- * tears down and re-probes 'data', so there is no "in-flight"
- * reset to follow up after device_reprobe() succeeds.
+ * Successful resets tear down and re-probe 'data'. On failure,
+ * reset_failed() releases the bit after restoring the recovery state.
  */
-static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
+static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
 				       enum btintel_pcie_reset_type type)
 {
-	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
-		return;
+	struct btintel_pcie_dev_recovery *rec = NULL;
+
+	/* Allow TOP recovery and retries of a failed PLDR before SETUP_DONE. */
+	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags) &&
+	    !test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) &&
+	    !(type == BTINTEL_PCIE_IOSF_PRR_PLDR &&
+	      test_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags)))
+		return false;
 
 	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
-		return;
+		return false;
+
+	if (type == BTINTEL_PCIE_IOSF_TOP_RESET) {
+		rec = btintel_pcie_get_recovery(data->pdev, &data->hdev->dev);
+		if (!rec) {
+			clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
+				  &data->flags);
+			return false;
+		}
+
+		set_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		set_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags);
+	}
 
 	data->reset_type = type;
 
 	pci_dev_get(data->pdev);
-	schedule_work(&data->reset_work);
+	if (!schedule_work(&data->reset_work)) {
+		pci_dev_put(data->pdev);
+		if (type == BTINTEL_PCIE_IOSF_TOP_RESET) {
+			clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+			clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+				  &rec->flags);
+		}
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+		return false;
+	}
+
+	return true;
 }
 
 static void btintel_pcie_hci_reset(struct hci_dev *hdev)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
 
-	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
+	/* Any failure during a TOP silent reset falls back to PLDR */
+	btintel_pcie_request_reset(data,
+				   (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) ||
+				    test_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags)) ?
+				   BTINTEL_PCIE_IOSF_PRR_PLDR :
+				   BTINTEL_PCIE_IOSF_PRR_FLR);
 }
 
 static ssize_t vendor_reset_store(struct device *dev,
@@ -4292,10 +4691,41 @@ static struct attribute *btintel_pcie_attrs[] = {
 
 ATTRIBUTE_GROUPS(btintel_pcie);
 
+static const char *btintel_pcie_resettype_to_str(u8 reset_type)
+{
+	switch (reset_type) {
+	case BTINTEL_PCIE_IOSF_PRR_FLR:
+		return "FLR";
+	case BTINTEL_PCIE_IOSF_PRR_PLDR:
+		return "PLDR";
+	case BTINTEL_PCIE_IOSF_TOP_RESET:
+		return "TOP_RESET";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static bool btintel_pcie_top_reset_supported(struct btintel_pcie_data *data)
+{
+	struct btintel_data *cnvi_data = hci_get_priv(data->hdev);
+	u8 hw_variant = INTEL_HW_VARIANT(cnvi_data->cnvi_bt);
+
+	if (hw_variant >= BTINTEL_HWID_SCP2 &&
+	    data->pdev->subsystem_device == BTINTEL_PCIE_SUBSYSTEM_ID_PEP) {
+		bt_dev_info(data->hdev, "HW variant 0x%02x supports top-reset",
+			    hw_variant);
+		return true;
+	}
+
+	bt_dev_dbg(data->hdev,
+		   "HW variant 0x%02x does not support top-reset", hw_variant);
+	return false;
+}
+
 static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 {
-	struct btintel_pcie_dev_recovery *rec;
 	struct btintel_pcie_data *dev_data = hci_get_drvdata(hdev);
+	struct btintel_pcie_dev_recovery *rec;
 	struct pci_dev *pdev = dev_data->pdev;
 	enum btintel_pcie_reset_type type;
 	time64_t retry_window;
@@ -4309,11 +4739,14 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 	if (!rec)
 		return;
 
-	type = (code == 0x13) ? BTINTEL_PCIE_IOSF_PRR_PLDR
-			      : BTINTEL_PCIE_IOSF_PRR_FLR;
+	if (code == 0x13 && btintel_pcie_top_reset_supported(dev_data))
+		type = BTINTEL_PCIE_IOSF_TOP_RESET;
+	else
+		type = (code == 0x13) ? BTINTEL_PCIE_IOSF_PRR_PLDR
+				      : BTINTEL_PCIE_IOSF_PRR_FLR;
 
 	bt_dev_err(hdev, "Encountered exception err:0x%x triggering: %s", code,
-		   type == BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR");
+		   btintel_pcie_resettype_to_str(type));
 	retry_window = ktime_get_boottime_seconds() - rec->last_error;
 
 	if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
@@ -4326,8 +4759,9 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 			   rec->last_error);
 		return;
 	}
-	btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
-	btintel_pcie_request_reset(dev_data, type);
+
+	if (btintel_pcie_request_reset(dev_data, type))
+		btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
 }
 
 static bool btintel_pcie_wakeup(struct hci_dev *hdev)
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index fff31ac8f87a..0de2e48bc135 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -12,6 +12,7 @@
 #define BTINTEL_PCIE_CSR_BASE			(0x000)
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
 #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
+#define BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR	(BTINTEL_PCIE_CSR_BASE + 0x02C)
 #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_REG		(BTINTEL_PCIE_CSR_BASE + 0x108)
 #define BTINTEL_PCIE_CSR_IPC_CONTROL_REG	(BTINTEL_PCIE_CSR_BASE + 0x10C)
@@ -26,6 +27,7 @@
 #define BTINTEL_PCIE_CSR_MBOX_3_REG		(BTINTEL_PCIE_CSR_BASE + 0x178)
 #define BTINTEL_PCIE_CSR_MBOX_4_REG		(BTINTEL_PCIE_CSR_BASE + 0x17C)
 #define BTINTEL_PCIE_CSR_MBOX_STATUS_REG	(BTINTEL_PCIE_CSR_BASE + 0x180)
+#define BTINTEL_PCIE_CSR_RESET_DEBUG_AD	(BTINTEL_PCIE_CSR_BASE + 0x220)
 #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG		(BTINTEL_PCIE_CSR_BASE + 0x440)
 #define BTINTEL_PCIE_PRPH_DEV_RD_REG		(BTINTEL_PCIE_CSR_BASE + 0x458)
 #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR	(BTINTEL_PCIE_CSR_BASE + 0x460)
@@ -135,6 +137,13 @@
 #define BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2	0xD346
 #define BTINTEL_PCIE_DEVICE_ID_PTL_FMP2		0xE476
 
+#define BTINTEL_PCIE_SUBSYSTEM_ID_PEP	0x0012
+
+#define BTINTEL_PCIE_TOP_RESET_DBG_RESET_REG		0x0AAAFFFF
+#define BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILENT_RESET	BIT(9)
+#define BTINTEL_PCIE_SCU_CORE_IDLE_SET			0x0000000F
+#define BTINTEL_PCIE_SCU_CORE_IDLE_RESET		0x0000000E
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
@@ -172,7 +181,14 @@ enum {
 	BTINTEL_PCIE_SETUP_DONE,
 	BTINTEL_PCIE_MAIL_BOX_INTR,
 	BTINTEL_PCIE_MBOX_PARSE_PENDING,
-	BTINTEL_PCIE_MBOX_PARSE_READY
+	BTINTEL_PCIE_MBOX_PARSE_READY,
+	BTINTEL_PCIE_TOP_RESET,
+	BTINTEL_PCIE_PLDR_RETRY,
+	BTINTEL_PCIE_MBOX_TOP_RESET,
+	BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
+	BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+	BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+	BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
 };
 
 enum btintel_pcie_tlv_type {
@@ -202,14 +218,25 @@ enum msix_mbox_int_causes {
 enum btintel_pcie_reset_type {
 	BTINTEL_PCIE_IOSF_PRR_FLR = 0,
 	BTINTEL_PCIE_IOSF_PRR_PLDR = 1,
+	BTINTEL_PCIE_IOSF_TOP_RESET = 2,
 };
 
-enum btintel_pcie_mbox_msg {
+enum btintel_pcie_mbox1_msg {
 	BTINTEL_PCIE_NO_USE = 0,
-	BTINTEL_PCIE_TOP_SILENT_RESET,
-	BTINTEL_PCIE_SB_AUDIO_DEVICE_REPORT,
-	BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING,
-	BTINTEL_PCIE_LAST_MESSAGE = 4095
+	BTINTEL_PCIE_TOP_SILENT_RESET = 1,
+	BTINTEL_PCIE_SB_AUDIO_DEVICE_REPORT = 2,
+	BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING = 3,
+	BTINTEL_PCIE_CNVI_SCU_REG_MAIN_FSM_STICKY = 0xC08,
+	BTINTEL_PCIE_LAST_MESSAGE = 0xFFF,
+};
+
+enum btintel_pcie_mbox2_msg {
+	BTINTEL_PCIE_TOP_RESET_WIFI_REQUEST = 257, /* 0x101 */
+	BTINTEL_PCIE_TOP_RESET_WIFI_ACK = 513, /* 0x201 */
+	BTINTEL_PCIE_TOP_RESET_WIFI_NACK = 514, /* 0x202 */
+	BTINTEL_PCIE_TOP_RESET_WIFI_REQ_ROLE_SWITCH = 515, /* 0x203 */
+	BTINTEL_PCIE_TOP_RESET_WIFI_NO_RESPONSE = 771, /* 0x303 */
+	BTINTEL_PCIE_TOP_RESET_WIFI_RESPONSE_INVALID = 4095, /* 0xFFF */
 };
 
 #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE	BIT(7)
@@ -827,6 +854,7 @@ struct btintel_pcie_data {
 	/* Timestamp captured in GP1 handler when mbox interrupt is received */
 	ktime_t	mbox_intr_ts;
 	bool		pcie_alloc_init;
+	u32			top_reset_expires;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

