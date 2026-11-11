Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425511;
	b=kvNA9HYU5s6uwILiFY0fwVXM5DXwxENELgHYEHSbC+uOzuXC2NKg1EojrVSk/NGxSesC
	 KC+cAIISbGHxNSxvK2udb8HGieGFhtbNN+0M/xPDI1NrJZgvIMpEtRlCS3CRxIRxs3CKu
	 vPT7VTa56GDPaF91yjhdJaSbcD2gGe45lL9Z7iZZzWQj652bpodJXlcJx/kGEJJWZMKnf
	 mmzxHQeq/yrGpMEsMj0/bd9uSfpR+JoswbqAcOBUUOxAEO7oN6F3wKLIYIsBhz39FEm+x
	 zwm3ruIn6GDJsDN4CAv7j4hQhJjxFa6xdRlx+GyiRimn30OhylY4/aA+Yk0h+oahDow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425511;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gnWB5/WbrA/VyJ7kOu7ZzVdRQNx4Wf5nyAA8lHb7kwY=;
	b=VTj3oism5aKOUWkIf+Yh0UYucxbMthnbvNwp32leFKTr+L7MQZyL+EBAZNmLK8FMMNFx
	 UoDf64vQHjwHTj9rfJgsdWuXI7k+tJgJNRw297YCnt9GSYOew4fxRblkN4dl8h5XDayY5
	 c/cfCbetjsY7/BjSAJnO0M91h7az7ncpGCsF9Ttcw/3Jy60VfoNwT4iRchHJdHOh1700T
	 oL+MkyZkl2P9YiZBXoHCNTXc9QWZ2vUEjeiyEEJOD8tPLP4maEH+nBjucIX1KVoHmfurw
	 9lUjqFOXn2TtR6PcIvranQMJkirxqOf9wpP62PzFKSSerMe+KWhbPHHyk5ekLrM1XWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VtUqJX9P;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92B606A33D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F92B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VtUqJX9P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794425510; x=1825961510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tjNMfl8y6PUILl5gdB4TGXr/3k5p98r1Nury7lBnQOY=;
  b=VtUqJX9P3QDHMcWOVsue7fHqDBQJsRtIfbZ+phS4nyt6hily6bhF612d
   AoPpN1NKbilCK3KtV4TdnYORyBMJTpYSYvpBOmSBrdc0r5zapXS0jh76N
   nJCD2v6/OTaFq1wM/89JO8Zd1lQYKJgWcV9gmZdLIvCgvROEfW7ocQJ8C
   oKLUgDV1+oL2Q5FUMcdhoklFepbIoY+343ZUOy1BosF77fHP7HvVteWfY
   HPIsevAlNrWpBSLpx98CSZwNiuAbu3NcJPf7nzIgDUMoA3v39JPU6CJml
   IpEUDykJxqf3SgjR0i7XvlOhQIeuUG/BlLOnYRbjpwYvPzkj47vr3WtzH
   g==;
X-CSE-ConnectionGUID: KvSMPzuKSMKMEBkwgpM5mQ==
X-CSE-MsgGUID: YovZ4ushTyetnWtLfADkkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3086902"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3086902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 11:31:47 -0800
X-CSE-ConnectionGUID: EOF+SLhvSWmqLu5M1Y1SdA==
X-CSE-MsgGUID: 00coVyR+TYiLXAEL1RtTYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8529043"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa006.jf.intel.com with ESMTP; 11 Nov 2026 11:31:46 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v5 2/2] Bluetooth: btintel_pcie: Add TOP silent reset support
Date: Thu, 12 Nov 2026 01:01:03 +0530
Message-ID: <20261111193103.2992252-2-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111193103.2992252-1-chandrashekar.devegowda@intel.com>
References: <20261111193103.2992252-1-chandrashekar.devegowda@intel.com>
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
Changes in v5:
- Publish data->hdev from setup() before use; skip setup() while a
  reset is in progress so it cannot consume the reprobed device's
  TOP reset request.
- On setup failure, open a dedicated gate before re-checking for a
  pending WiFi PLDR request, so the next setup() still retries the
  firmware download; do the same if do_top_reset() fails to queue.
- Retry the FLR or PLDR for a bounded time when the device lock is
  briefly busy, and order the WiFi request handoff with full barriers.
- Escalate every reset request to PLDR after a TOP reset or PLDR retry,
  including hw_error and resume.
- Drop a stale TOP reset request when the reprobe fails, the device is
  left unbound after it, or the device is removed.
- Let a repeated hardware error right after a TOP reset fall back to
  PLDR instead of being dropped by the retry limit.
- Fall back to PLDR on an undefined TOP reset mailbox value.

Changes in v4:
- Fix a pci_dev leak and stale TOP reset request when remove() cancels
  a queued reset_work.
- Allow a PLDR retry after the post-TOP-reset FLR fails with -EAGAIN.
- Keep a pending WiFi PLDR request across setup and failed resets;
  trylock the BT device around the ACPI WiFi detach.

Changes in v3:
- Harden WiFi-coordinated reset handling (role switch, NACK, PLDR
  replay, reset-type races) and exclude BZRIW.
- Check ACPI _PRR and use a non-blocking PCI lock before detaching WiFi.

Changes in v2:
- Use a published, role-switch-extendable timeout; fall back to PLDR on
  any failure and replay a pending WiFi PLDR request across reprobe.

v4: https://lore.kernel.org/linux-bluetooth/20261027151930.386971-1-chandrashekar.devegowda@intel.com/
v3: https://lore.kernel.org/linux-bluetooth/20261027054408.318002-1-chandrashekar.devegowda@intel.com/
v2: https://lore.kernel.org/linux-bluetooth/20261023094033.212251-1-chandrashekar.devegowda@intel.com/
v1: https://lore.kernel.org/linux-bluetooth/20261014114752.174669-1-chandrashekar.devegowda@intel.com/

 drivers/bluetooth/btintel_pcie.c | 695 ++++++++++++++++++++++++++++---
 drivers/bluetooth/btintel_pcie.h |  39 +-
 2 files changed, 665 insertions(+), 69 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index dadd79e4392f..65366555535c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 
 struct btintel_pcie_dev_recovery {
 	struct list_head list;
+	unsigned long flags;
 	u8 count;
 	time64_t last_error;
 	char name[];
@@ -96,6 +97,11 @@ struct btintel_pcie_dev_recovery {
 
 #define BTINTEL_PCIE_RESET_WINDOW_SECS		5
 #define BTINTEL_PCIE_FLR_MAX_RETRY	1
+#define BTINTEL_PCIE_TOP_RESET_INTERVAL_MS	250
+#define BTINTEL_PCIE_RESET_BUSY_RETRIES	25
+#define BTINTEL_PCIE_RESET_BUSY_DELAY_MS	20
+#define BTINTEL_PCIE_TOP_RESET_ROLE_SWITCH_MS	5000
+#define BTINTEL_PCIE_TOP_RESET_FALLBACK_MS	250
 
 /* Alive interrupt context */
 enum {
@@ -657,6 +663,16 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 	hci_recv_diag(hdev, skb);
 }
 
+static void btintel_pcie_reset_ia(struct btintel_pcie_data *data);
+static int btintel_pcie_start_rx(struct btintel_pcie_data *data);
+static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data);
+static struct btintel_pcie_dev_recovery *
+btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev);
+static bool btintel_pcie_queue_reset(struct btintel_pcie_data *data,
+				     enum btintel_pcie_reset_type type);
+static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
+				       enum btintel_pcie_reset_type type);
+
 static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 				  struct sk_buff *skb, u32 pkt_type, u16 opcode)
 {
@@ -664,6 +680,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 	u16 tfd_index;
 	u32 old_ctxt;
 	bool wait_on_alive = false;
+	bool top_rom = false;
 	struct hci_dev *hdev = data->hdev;
 
 	struct txq *txq = &data->txq;
@@ -685,7 +702,20 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
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
@@ -726,6 +756,14 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
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
@@ -2043,11 +2081,18 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 
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
 		data->mbox.mbox1 = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_1_REG);
 		if (data->mbox.mbox1 ==
@@ -2055,14 +2100,29 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 			if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
 				bt_dev_info(data->hdev,
 					    "mailbox for target access");
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
@@ -2103,10 +2163,105 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
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
+		u32 expires = BTINTEL_PCIE_TOP_RESET_INTERVAL_MS;
+		struct hci_dev *hdev = READ_ONCE(data->hdev);
+		struct btintel_pcie_dev_recovery *rec;
+		u32 reg;
+
+		rec = btintel_pcie_get_recovery(data->pdev,
+						hdev ? &hdev->dev : NULL);
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
+			set_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				&rec->flags);
+			/* Order against the TOP_RESET and SETUP_DONE tests */
+			smp_mb__after_atomic();
+			if (!test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+				bt_dev_info(hdev,
+					    "BT is follower, triggering PLDR");
+				if (btintel_pcie_request_reset(data,
+							       BTINTEL_PCIE_IOSF_PRR_PLDR))
+					set_bit(BTINTEL_PCIE_CORE_HALTED,
+						&data->flags);
+				goto skip_top_reset;
+			}
+			set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
+				&rec->flags);
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
+			set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
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
@@ -2163,9 +2318,9 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
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
@@ -3286,6 +3441,7 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x00 },
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x21 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x22 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
@@ -4092,17 +4248,158 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev,
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
+	if (test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags)) {
+		bt_dev_info(hdev, "TOP reset: WiFi PLDR pending; doing PLDR");
+		reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+		goto done;
+	}
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
+				    &rec->flags) ||
+		 test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags);
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
+	if (test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags))
+		reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+
+	if (!btintel_pcie_queue_reset(data, reset_type)) {
+		/* No reprobe will follow; let a PLDR request through. Open the
+		 * gate before dropping TOP_RESET so that a GP1 request cannot
+		 * see both clear.
+		 */
+		set_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
+		smp_mb__after_atomic(); /* Pairs with GP1 handler */
+		clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		return -EIO;
+	}
+
+	/* Fail the open; reset_work reprobes the device */
+	return -ECANCELED;
+}
+
 static int btintel_pcie_setup(struct hci_dev *hdev)
 {
-	int err, fw_dl_retry = 0;
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
-	bool fips_crc_failed;
+	struct btintel_pcie_dev_recovery *rec;
+	int err, fw_dl_retry = 0;
+	bool pldr_retry, fips_crc_failed;
+
+	/* power_on can run before probe publishes hdev */
+	WRITE_ONCE(data->hdev, hdev);
+
+	/* A queued reset reprobes the device and consumes the TOP reset intent
+	 * kept in rec->flags, so leave it for the reprobed instance.
+	 */
+	if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
+		return -ECANCELED;
+
+	/* Prevent async callers from scheduling reset_work during setup */
+	clear_bit(BTINTEL_PCIE_SETUP_FAILED, &data->flags);
+	pldr_retry = test_and_clear_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
+
+	/* Restore TOP reset intent saved across device_reprobe() */
+	rec = btintel_pcie_get_recovery(data->pdev, &hdev->dev);
+	if (rec && test_and_clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+				      &rec->flags)) {
+		set_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+	}
 
 	btintel_pcie_fatal_err_load(data);
 
 	while ((err = btintel_pcie_setup_internal(hdev, &fips_crc_failed)) &&
 	       fw_dl_retry++ < 1) {
-		if (fips_crc_failed)
+		if (err == -ENODEV || fips_crc_failed || pldr_retry ||
+		    test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) ||
+		    (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				     &rec->flags)))
 			break;
 
 		bt_dev_err(hdev, "Firmware download retry count: %d",
@@ -4127,6 +4424,44 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		btintel_pcie_start_rx(data);
 	}
 
+	if (err == -ECANCELED && test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+		return btintel_pcie_do_top_reset(data, hdev);
+
+	if (err) {
+		/* Open the PLDR gate before testing the WiFi request so that
+		 * either this path or the GP1 handler queues the PLDR. Use
+		 * SETUP_FAILED rather than PLDR_RETRY, which the next setup()
+		 * would take as a failed PLDR and skip its firmware retry.
+		 */
+		set_bit(BTINTEL_PCIE_SETUP_FAILED, &data->flags);
+		smp_mb__after_atomic(); /* Pairs with GP1 handler */
+		/* The first lookup can fail; look again after the gate opens */
+		if (!rec)
+			rec = btintel_pcie_get_recovery(data->pdev, &hdev->dev);
+		if (pldr_retry ||
+		    test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) ||
+		    (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				     &rec->flags))) {
+			bt_dev_err(hdev,
+				   "TOP silent reset setup failed (%d), doing PLDR",
+				   err);
+			if (btintel_pcie_queue_reset(data,
+						     BTINTEL_PCIE_IOSF_PRR_PLDR)) {
+				if (rec &&
+				    test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+					     &rec->flags))
+					set_bit(BTINTEL_PCIE_CORE_HALTED,
+						&data->flags);
+				return -ECANCELED;
+			}
+
+			/* No reprobe will follow; a later reset must be PLDR */
+			set_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
+			clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+			btintel_clear_flag(hdev, INTEL_TOP_RESET);
+		}
+	}
+
 	if (!err) {
 		/* Fatal error test mode: arm the post-setup injection before
 		 * SETUP_DONE so the rfkill work cannot inject a fault ahead of
@@ -4134,7 +4469,23 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		 */
 		if (btintel_pcie_fatal_err_testmode_active(data))
 			set_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING, &data->flags);
+		clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		btintel_clear_flag(hdev, INTEL_TOP_RESET);
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
+		smp_mb__after_atomic(); /* Pairs with GP1 handler */
+		if (!rec)
+			rec = btintel_pcie_get_recovery(data->pdev, &hdev->dev);
+		if (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
+				    &rec->flags)) {
+			clear_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
+			if (btintel_pcie_queue_reset(data,
+						     BTINTEL_PCIE_IOSF_PRR_PLDR) ||
+			    test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
+				     &data->flags))
+				set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+			return -ECANCELED;
+		}
+
 		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
 		btintel_pcie_unmask_hw_rfkill(data);
 		btintel_delayed_hw_rfkill(data, true);
@@ -4145,19 +4496,21 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 static struct btintel_pcie_dev_recovery *
 btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
 {
+	struct hci_dev *hdev = dev ? to_hci_dev(dev) : NULL;
 	struct btintel_pcie_dev_recovery *tmp, *data = NULL;
 	const char *name = pci_name(pdev);
 	const size_t name_len = strlen(name) + 1;
-	struct hci_dev *hdev = to_hci_dev(dev);
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
@@ -4169,9 +4522,17 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
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
@@ -4211,7 +4572,8 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 }
 
 #ifdef CONFIG_ACPI
-static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
+static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data,
+					  struct pci_dev *wifi)
 {
 	union acpi_object *obj, argv4;
 	acpi_handle handle;
@@ -4242,6 +4604,21 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 		return -ENODEV;
 	}
 
+	/* Unbind may hold the device lock while waiting for reset_work. */
+	if (!pci_dev_trylock(data->pdev))
+		return -EAGAIN;
+
+	if (wifi) {
+		pci_dev_unlock(data->pdev);
+		device_release_driver(&wifi->dev);
+		if (!pci_dev_trylock(data->pdev)) {
+			if (device_reprobe(&wifi->dev))
+				BT_ERR("WiFi reprobe failed for BDF:%s",
+				       pci_name(wifi));
+			return -EAGAIN;
+		}
+	}
+
 	argv4.buffer.type = ACPI_TYPE_BUFFER;
 	argv4.buffer.length = sizeof(mode);
 	argv4.buffer.pointer = (void *)&mode;
@@ -4250,29 +4627,33 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
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
+	if (wifi && device_reprobe(&wifi->dev))
+		BT_ERR("WiFi reprobe failed for BDF:%s", pci_name(wifi));
 	return ret;
 }
 #else
-static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
+static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data,
+					  struct pci_dev *wifi)
 {
 	bt_dev_err(data->hdev, "No support for ACPI, cold boot");
 	return -EOPNOTSUPP;
 }
 #endif
 
-static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
+static int btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 {
 	struct pci_dev *pdev = data->pdev;
 	struct pci_dev *wifi = NULL;
@@ -4293,7 +4674,7 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 
 	bus = pdev->bus;
 	if (!bus)
-		return;
+		return -ENODEV;
 
 	list_for_each_entry(tmp, &bus->devices, bus_list) {
 		if (pci_match_id(wifi_device_ids, tmp)) {
@@ -4302,9 +4683,6 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 		}
 	}
 
-	if (wifi)
-		device_release_driver(&wifi->dev);
-
 	/* Wi-Fi is fully unbound before the reset and fully reprobed after
 	 * the normal PCI probe path handles all state setup from scratch.
 	 * BT needs pci_save_state()/pci_restore_state() because the BT driver
@@ -4312,18 +4690,25 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 	 * The PCI device needs to remain minimally functional so that
 	 * device_reprobe(&pdev->dev) can work afterward
 	 */
-	ret = btintel_pcie_acpi_reset_method(data);
+	ret = btintel_pcie_acpi_reset_method(data, wifi);
 
-	if (wifi) {
-		if (device_reprobe(&wifi->dev))
-			BT_ERR("WiFi reprobe failed for BDF:%s", pci_name(wifi));
+	if (wifi)
 		pci_dev_put(wifi);
-	}
 
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
@@ -4336,7 +4721,7 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
 {
 	struct pci_dev *pdev = data->pdev;
-	int err;
+	int err, reprobe_err;
 
 	/* pci_try_reset_function() avoids the device_lock ABBA against
 	 * btintel_pcie_remove(): .remove() runs with device_lock held and
@@ -4351,20 +4736,86 @@ static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
 	}
 
 	/* device_reprobe() always detaches the driver first (running
-	 * .remove(), which frees 'data'); any re-probe failure leaves the
-	 * device unbound but 'data' is already gone, so just log it.
+	 * .remove(), which frees 'data'). A failed probe leaves the device
+	 * unbound without necessarily making device_reprobe() fail, so check
+	 * the binding as well. 'data' is already gone, so just log it.
 	 */
-	if (device_reprobe(&pdev->dev))
-		BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
+	reprobe_err = device_reprobe(&pdev->dev);
+	if (reprobe_err || !device_is_bound(&pdev->dev)) {
+		struct btintel_pcie_dev_recovery *rec;
+
+		BT_ERR("BT reprobe failed for BDF:%s (%d)", pci_name(pdev),
+		       reprobe_err);
+
+		/* No setup() will consume the TOP reset intent */
+		rec = btintel_pcie_get_recovery(pdev, NULL);
+		if (rec)
+			clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+				  &rec->flags);
+	}
 
 	return 0;
 }
 
+/* No reprobe will follow a failed reset; undo the reset state */
+static void btintel_pcie_reset_failed(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_dev_recovery *rec;
+	bool top_reset;
+
+	rec = btintel_pcie_get_recovery(data->pdev, &data->hdev->dev);
+	top_reset = test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+
+	/* SETUP_DONE is not set during a TOP reset reprobe; allow a PLDR retry
+	 * so that later reset requests are not rejected.
+	 */
+	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR || top_reset)
+		set_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
+	if (rec)
+		clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags);
+	clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+	btintel_clear_flag(data->hdev, INTEL_TOP_RESET);
+	enable_work(&data->coredump_work);
+	enable_work(&data->hwexp_work);
+	enable_work(&data->fwtrigger_work);
+	enable_work(&data->mbox_work);
+	enable_delayed_work(&data->user_dump_work);
+	enable_delayed_work(&data->hw_rfkill_work);
+	btintel_pcie_enable_interrupts(data);
+	if (test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
+		btintel_pcie_unmask_hw_rfkill(data);
+	clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+	smp_mb__after_atomic(); /* Pairs with GP1 handler */
+
+	if (data->reset_type != BTINTEL_PCIE_IOSF_PRR_PLDR &&
+	    rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags) &&
+	    btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR))
+		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+}
+
+/* The reset helpers only trylock the device to stay clear of remove(), so
+ * ride out brief PM or probe contention instead of giving up. On success the
+ * device is reprobed and 'data' is gone, so only the result is used.
+ */
+static int btintel_pcie_reset_retry_busy(struct btintel_pcie_data *data,
+					 int (*reset)(struct btintel_pcie_data *))
+{
+	int err, i = 0;
+
+	while ((err = reset(data)) == -EAGAIN &&
+	       i++ < BTINTEL_PCIE_RESET_BUSY_RETRIES)
+		msleep(BTINTEL_PCIE_RESET_BUSY_DELAY_MS);
+
+	return err;
+}
+
 static void btintel_pcie_reset_work(struct work_struct *wk)
 {
 	struct btintel_pcie_data *data =
 		container_of(wk, struct btintel_pcie_data, reset_work);
+	struct btintel_pcie_dev_recovery *rec;
 	struct pci_dev *pdev = data->pdev;
+	int err;
 
 	pci_lock_rescan_remove();
 
@@ -4392,10 +4843,17 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 
+	rec = btintel_pcie_get_recovery(pdev,
+					data->hdev ? &data->hdev->dev : NULL);
+	if (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags)) {
+		clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags);
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+	}
+
 	/* Both reset paths follow the same contract: on success they
 	 * destroy 'data' via device_reprobe() (a fresh probe re-INIT_WORKs
 	 * the dump workers with disable count 0), so enable_work() must
-	 * NOT be called on the success path. Only the FLR path can fail
+	 * NOT be called on the success path. Either reset can fail
 	 * with 'data' still alive, in which case we balance the
 	 * disable_work_sync() calls above so a later successful reset is
 	 * not permanently blocked.
@@ -4405,17 +4863,27 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	 * or removed from the bus list while this code runs.
 	 */
 	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR) {
-		btintel_pcie_perform_pldr(data);
+		if (btintel_pcie_reset_retry_busy(data, btintel_pcie_perform_pldr))
+			btintel_pcie_reset_failed(data);
 		goto out;
 	}
 
-	if (btintel_pcie_perform_flr(data)) {
-		enable_work(&data->coredump_work);
-		enable_work(&data->hwexp_work);
-		enable_work(&data->fwtrigger_work);
-		enable_work(&data->mbox_work);
-		enable_delayed_work(&data->user_dump_work);
-		enable_delayed_work(&data->hw_rfkill_work);
+	err = btintel_pcie_reset_retry_busy(data, btintel_pcie_perform_flr);
+	if (err) {
+		if (err != -EAGAIN &&
+		    test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+			bt_dev_warn(data->hdev,
+				    "FLR failure after TOP silent reset, falling back to PLDR");
+			data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+			if (rec)
+				clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+					  &rec->flags);
+			if (!btintel_pcie_reset_retry_busy(data,
+							   btintel_pcie_perform_pldr))
+				goto out;
+		}
+
+		btintel_pcie_reset_failed(data);
 	}
 
 out:
@@ -4440,24 +4908,64 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
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
-				       enum btintel_pcie_reset_type type)
+static bool btintel_pcie_queue_reset(struct btintel_pcie_data *data,
+				     enum btintel_pcie_reset_type type)
 {
-	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
-		return;
+	struct btintel_pcie_dev_recovery *rec = NULL;
 
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
+}
+
+static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
+				       enum btintel_pcie_reset_type type)
+{
+	/* Any failure during or after a TOP silent reset falls back to PLDR */
+	if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) ||
+	    test_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags))
+		type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+
+	/* Allow resets after setup completes, retries of a failed PLDR, or a
+	 * PLDR after a failed setup.
+	 */
+	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags) &&
+	    !(type == BTINTEL_PCIE_IOSF_PRR_PLDR &&
+	      (test_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags) ||
+	       test_bit(BTINTEL_PCIE_SETUP_FAILED, &data->flags))))
+		return false;
+
+	return btintel_pcie_queue_reset(data, type);
 }
 
 static void btintel_pcie_hci_reset(struct hci_dev *hdev)
@@ -4504,13 +5012,47 @@ static struct attribute *btintel_pcie_attrs[] = {
 
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
+	    hw_variant != BTINTEL_HWID_BZRIW &&
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
+	bool top_reset;
+	int max_retry = BTINTEL_PCIE_FLR_MAX_RETRY;
 
 	if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &dev_data->flags))
 		return;
@@ -4521,25 +5063,37 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 	if (!rec)
 		return;
 
-	type = (code == 0x13) ? BTINTEL_PCIE_IOSF_PRR_PLDR
-			      : BTINTEL_PCIE_IOSF_PRR_FLR;
+	top_reset = code == 0x13 && btintel_pcie_top_reset_supported(dev_data);
+	retry_window = ktime_get_boottime_seconds() - rec->last_error;
+
+	if (code != 0x13) {
+		type = BTINTEL_PCIE_IOSF_PRR_FLR;
+	} else if (top_reset && !(retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
+				  rec->count)) {
+		type = BTINTEL_PCIE_IOSF_TOP_RESET;
+	} else {
+		type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+		/* A repeated error right after a TOP reset gets one PLDR */
+		if (top_reset)
+			max_retry++;
+	}
 
 	bt_dev_err(hdev, "Encountered exception err:0x%x triggering: %s", code,
-		   type == BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR");
-	retry_window = ktime_get_boottime_seconds() - rec->last_error;
+		   btintel_pcie_resettype_to_str(type));
 
 	if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
-	    rec->count >= BTINTEL_PCIE_FLR_MAX_RETRY) {
+	    rec->count >= max_retry) {
 		bt_dev_err(hdev, "Exhausted maximum: %d recovery attempts: %d",
-			   BTINTEL_PCIE_FLR_MAX_RETRY, rec->count);
+			   max_retry, rec->count);
 		bt_dev_dbg(hdev, "Boot time: %lld seconds",
 			   ktime_get_boottime_seconds());
 		bt_dev_dbg(hdev, "last error at: %lld seconds",
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
@@ -4668,7 +5222,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	 * worker bails on !data->hdev, so it never observes a half-set-up
 	 * device.
 	 */
-	data->hdev = hdev;
+	WRITE_ONCE(data->hdev, hdev);
 	data->dmp_hdr.driver_name = KBUILD_MODNAME;
 	return 0;
 }
@@ -4803,6 +5357,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 static void btintel_pcie_remove(struct pci_dev *pdev)
 {
+	struct btintel_pcie_dev_recovery *rec;
 	struct btintel_pcie_data *data;
 
 	data = pci_get_drvdata(pdev);
@@ -4826,9 +5381,21 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	 * within the reset work itself (PLDR device_reprobe path) to avoid
 	 * deadlock. current_work() returns the work_struct of the caller if
 	 * we are in a workqueue context.
+	 *
+	 * If a queued reset_work is cancelled before it runs, release the
+	 * pci_dev reference that it owned. The TOP reset intent is dropped
+	 * either way, as no setup() will run to consume it.
 	 */
-	if (current_work() != &data->reset_work)
-		disable_work_sync(&data->reset_work);
+	if (current_work() != &data->reset_work) {
+		if (disable_work_sync(&data->reset_work))
+			pci_dev_put(pdev);
+
+		rec = btintel_pcie_get_recovery(pdev,
+						data->hdev ? &data->hdev->dev : NULL);
+		if (rec)
+			clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+				  &rec->flags);
+	}
 
 	btintel_pcie_mask_hw_rfkill(data);
 	btintel_pcie_synchronize_irqs(data);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 4125601b78d7..00da94900de8 100644
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
@@ -136,6 +138,13 @@
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
@@ -176,6 +185,14 @@ enum {
 	BTINTEL_PCIE_MBOX_PARSE_PENDING,
 	BTINTEL_PCIE_MBOX_PARSE_READY,
 	BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING,
+	BTINTEL_PCIE_TOP_RESET,
+	BTINTEL_PCIE_PLDR_RETRY,
+	BTINTEL_PCIE_SETUP_FAILED,
+	BTINTEL_PCIE_MBOX_TOP_RESET,
+	BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
+	BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+	BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+	BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
 };
 
 enum btintel_pcie_tlv_type {
@@ -205,14 +222,25 @@ enum msix_mbox_int_causes {
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
@@ -845,6 +873,7 @@ struct btintel_pcie_data {
 	/* Timestamp captured in GP1 handler when mbox interrupt is received */
 	ktime_t	mbox_intr_ts;
 	bool		pcie_alloc_init;
+	u32			top_reset_expires;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

