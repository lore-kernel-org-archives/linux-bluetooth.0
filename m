Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748475;
	b=gxbe5GOu5hHywu9CjH+PenmBLCKSHwhBPyQSDiwI4RxlbMtAYEX9EgeOPobKGu5RYi6t
	 WOLdB8z3yls2yg6YU0V1OmW+KR8TaPQxppm7rGnRMFz9YxVQspfVdDKxKhSb19ERJGLsK
	 jtBhjLkT1Ck+MwHNxbGUo1gCk2bQ3JZrtih7apl/t0lmdBA50/PFUNHCPRVToJXNo/KVt
	 FFFCfsqArrGN27lJlsSSMu4qbSX1FsYTVPHDWuUi05Qpn7iKKxAZfaC7nBa7KS52fjlGN
	 1Qiiuujrfo1CmRotrhvOedUUH+70KtbJLFYSTBImSqQw2wEbvmSQzIoPPkuZd0yrCfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748475;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OzsDv3BmdKU8Ga/RPP6jIfZ1ZWihi5dNS+mMtNpRKLs=;
	b=pdGBYI5q7y+3oi16QUCWhh14t2Zr9pLzE5dtcA28WoLut6sc4tPtPpEWZHaNT5lY1oka
	 WT7hqvb53cnFY6SNibI/GNo1ahR6uP3mMXXqPrap7E1/NsjdpE+MW9LOQP933u/hfxuQL
	 sV1atUBuDvXrfcnNpFWYgJRAWEofVf4mZhnbWYTE/sE4gX3gVeXLMsk/B54DEwWuWU/Cx
	 yntd+T+oBFUzelSnFOQEpLEBTWkbQTrEhSVdZ1eKTNp6SENA6vm2wbbuqKZcer8BMrZVc
	 o28PR/sTf7aOXmbhJIutw94tGJAiK6GPXblDFRqgTEKnfb4shbSLb+B58y70FEo8HLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D4D4KX5T;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C52606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 09:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C52606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D4D4KX5T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792748474; x=1824284474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GFJcmz0/Up5/uZZ629fDIezDqwxnCTBw+VTs30KP8kw=;
  b=D4D4KX5T7fL4iqNcEvc32sSRrOUff9FJ0xucbNDFaN/omNtnAJsO9frZ
   lm9l5m6gIldrXmDv8ipd6H3fJSiOtsgVxEfAj8wPfin4XZV+ZwO6wTfPK
   vnKiwaMKm06mMl+9/PGSXilKWAPFVcHR+R+Vx0fijz/0clhZz39J5GMC8
   WXqje5XG7mZCOKsYa6Yt+H1kVMji++L7oHCew2kiZ1nre++mEbV1ZGFtA
   eOkWv8Mwy6uRpMOXsq2fhymLcxWoZo5yhwE2j4szkumtHxRA4Htba4Kws
   OI1bhL8Is1BmyHSdcYk7zXG6WsA+1NRcB+LOWMsIUrPx3wBO/LY3iHPO+
   g==;
X-CSE-ConnectionGUID: uyykAM8kRsuub6wc6V+QnQ==
X-CSE-MsgGUID: NoLzr7kaRvmosidSJ+oqMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1396978"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1396978"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:41:14 -0700
X-CSE-ConnectionGUID: MNJEsF08R9qPwMpmVi71/w==
X-CSE-MsgGUID: NwunvE+zTEi1iD9VkYPcww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3550475"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa002.jf.intel.com with ESMTP; 23 Oct 2026 02:41:12 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btintel_pcie: Add TOP silent reset support
Date: Fri, 23 Oct 2026 15:10:33 +0530
Message-ID: <20261023094033.212251-2-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023094033.212251-1-chandrashekar.devegowda@intel.com>
References: <20261023094033.212251-1-chandrashekar.devegowda@intel.com>
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
Changes in v2:
- Replace top_reset_gen/top_reset_deadline with a timeout published
  before the mailbox flag; extend the wait on a role switch event.
- Treat NACK, NO_RESPONSE and RESPONSE_INVALID as failure and fall back
  to PLDR; also fall back if the soft reset cannot be sent, boot_addr is
  unknown, or setup fails during the reset.
- Restore the reset state if the PLDR itself fails.
- Keep a WiFi PLDR request per BDF across reprobe and replay it after
  setup.
- Synchronize IRQs instead of claiming the transition under irq_lock
  when skipping the alive wait in ROM.

v1: https://lore.kernel.org/linux-bluetooth/20261014114752.174669-1-chandrashekar.devegowda@intel.com/

 drivers/bluetooth/btintel_pcie.c | 441 +++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |  39 ++-
 2 files changed, 446 insertions(+), 34 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index df95d16a163c..8cdde3c6d100 100644
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
@@ -757,6 +770,17 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 	}
 
 	if (wait_on_alive) {
+		/* After TOP reset the controller is in ROM; no alive interrupt */
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) &&
+		    btintel_pcie_in_rom(data)) {
+			/* Let the TX completion handler finish updating the IA */
+			btintel_pcie_synchronize_irqs(data);
+			btintel_pcie_reset_ia(data);
+			btintel_pcie_start_rx(data);
+			data->alive_intr_ctxt = BTINTEL_PCIE_FW_DL;
+			return 0;
+		}
+
 		ret = wait_event_timeout(data->gp0_wait_q,
 					 data->gp0_received,
 					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
@@ -1665,6 +1689,13 @@ static inline bool btintel_pcie_in_iml(struct btintel_pcie_data *data)
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
@@ -2049,25 +2080,46 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 
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
@@ -2106,10 +2158,104 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
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
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+	bt_dev_dbg(data->hdev, "Mailbox acked in %llu usecs", duration);
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
@@ -2164,9 +2310,9 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
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
@@ -3153,6 +3299,7 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x00 },
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x21 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x22 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
@@ -3896,12 +4043,126 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	return err;
 }
 
+static bool btintel_pcie_top_reset_done(struct btintel_pcie_data *data,
+					struct btintel_pcie_dev_recovery *rec)
+{
+	return !btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG) ||
+	       test_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
+}
+
+static int btintel_pcie_do_top_reset(struct btintel_pcie_data *data)
+{
+	struct hci_dev *hdev = data->hdev;
+	struct btintel_data *intel_data = hci_get_priv(hdev);
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
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+		goto done;
+	}
+
+	err = btintel_send_intel_reset(hdev, intel_data->boot_addr);
+	if (err) {
+		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
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
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
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
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+	} else {
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+	}
+
+done:
+	clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags);
+	btintel_clear_flag(hdev, INTEL_TOP_RESET);
+	btintel_pcie_clr_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR,
+				  BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILENT_RESET);
+
+	/* TOP_RESET lets request_reset() proceed without SETUP_DONE */
+	if (!btintel_pcie_request_reset(data, data->reset_type))
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
+		if (err == -ECANCELED &&
+		    test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+			break;
+
 		bt_dev_err(hdev, "Firmware download retry count: %d",
 			   fw_dl_retry);
 		btintel_pcie_dump_debug_registers(hdev);
@@ -3924,11 +4185,33 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		btintel_pcie_start_rx(data);
 	}
 
+	if (err == -ECANCELED && test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+		return btintel_pcie_do_top_reset(data);
+
+	if (err && test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+		bt_dev_err(hdev, "TOP silent reset setup failed (%d), doing PLDR",
+			   err);
+		if (btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR))
+			return -ECANCELED;
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
+						       BTINTEL_PCIE_IOSF_PRR_PLDR))
+				set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+			else
+				set_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+					&rec->flags);
+		}
 	}
 	return err;
 }
@@ -3940,15 +4223,17 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
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
@@ -3960,9 +4245,17 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
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
@@ -4055,7 +4348,7 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 	return ret;
 }
 
-static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
+static int btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 {
 	struct pci_dev *pdev = data->pdev;
 	struct pci_dev *wifi = NULL;
@@ -4076,7 +4369,7 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 
 	bus = pdev->bus;
 	if (!bus)
-		return;
+		return -ENODEV;
 
 	list_for_each_entry(tmp, &bus->devices, bus_list) {
 		if (pci_match_id(wifi_device_ids, tmp)) {
@@ -4107,6 +4400,8 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 		if (device_reprobe(&pdev->dev))
 			BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
 	}
+
+	return ret;
 }
 
 /*
@@ -4191,11 +4486,39 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	}
 
 	if (btintel_pcie_perform_flr(data)) {
+		struct btintel_pcie_dev_recovery *rec;
+
+		rec = btintel_pcie_get_recovery(data->pdev, &data->hdev->dev);
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+			bt_dev_warn(data->hdev,
+				    "FLR failure after TOP silent reset, falling back to PLDR");
+			data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+			if (rec)
+				clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+					  &rec->flags);
+			if (!btintel_pcie_perform_pldr(data))
+				goto out;
+		}
+
+		/* No reprobe will follow; undo the reset state */
+		clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+		if (rec)
+			clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+				  &rec->flags);
 		enable_work(&data->coredump_work);
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
 		enable_work(&data->mbox_work);
 		enable_delayed_work(&data->hw_rfkill_work);
+
+		if (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				    &rec->flags) &&
+		    btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR)) {
+			clear_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				  &rec->flags);
+			set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+		}
 	}
 
 out:
@@ -4225,19 +4548,46 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
  * tears down and re-probes 'data', so there is no "in-flight"
  * reset to follow up after device_reprobe() succeeds.
  */
-static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
+static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
 				       enum btintel_pcie_reset_type type)
 {
-	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
-		return;
+	struct btintel_pcie_dev_recovery *rec = NULL;
+
+	/* TOP_RESET lets TOP recovery proceed before SETUP_DONE */
+	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags) &&
+	    !test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
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
@@ -4284,10 +4634,41 @@ static struct attribute *btintel_pcie_attrs[] = {
 
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
@@ -4301,11 +4682,14 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
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
@@ -4318,8 +4702,9 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
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
index fff31ac8f87a..6f8bd3ccbe4b 100644
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
@@ -172,7 +181,13 @@ enum {
 	BTINTEL_PCIE_SETUP_DONE,
 	BTINTEL_PCIE_MAIL_BOX_INTR,
 	BTINTEL_PCIE_MBOX_PARSE_PENDING,
-	BTINTEL_PCIE_MBOX_PARSE_READY
+	BTINTEL_PCIE_MBOX_PARSE_READY,
+	BTINTEL_PCIE_TOP_RESET,
+	BTINTEL_PCIE_MBOX_TOP_RESET,
+	BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
+	BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+	BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+	BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
 };
 
 enum btintel_pcie_tlv_type {
@@ -202,14 +217,25 @@ enum msix_mbox_int_causes {
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
@@ -827,6 +853,7 @@ struct btintel_pcie_data {
 	/* Timestamp captured in GP1 handler when mbox interrupt is received */
 	ktime_t	mbox_intr_ts;
 	bool		pcie_alloc_init;
+	u32			top_reset_expires;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

