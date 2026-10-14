Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A294B8DF2
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978518; cv=none; b=ZW0sA1cceEdA3cYDoUODcuriuYu0Kc5VZbyLWgS2gI996OyyXZjKWW3Pr/ocEUtNVIO0XMipjV/QzH71JvTeV2wjjx67Q1+lSQPE7yt2O58jU0YaVOqJiR5kvafkv/30Rl6c77aoOoenko/mLrdKgzUrELaYYNn9Z20+39jidz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978518; c=relaxed/simple;
	bh=ljKKw4baJSqU66eyxL9d9wtB+D1kbolzp9HUXdckE1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC1jM/hVLY8fRgYmPOeBkiAeGlSw0Gpxl62Z8Yg9n40R9VPIeS4mhfc63WHeVuyKkQZp2Tm7kgTJmZvRyjN6LSDk8VzDfEBwyjU92IUSPfEDaiati5XMOf1BtSDkNdF2v3JV8wXhikS3Mh9fpswa5L6dbq3vXBNzrAYIBBrj00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNQE39z2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNQE39z2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791978507; x=1823514507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljKKw4baJSqU66eyxL9d9wtB+D1kbolzp9HUXdckE1Y=;
  b=SNQE39z2ZE//SelmnvBC8DkTMIOqmIMlOHcIQqMNn43Nl6DGVo3FpfLf
   NtQEfIyJv3q2eFsKjao0cQa006Fwr0WgebsAPXicdCOERNHmPJ1dnUyw2
   NxcmQOw2XDBQLvPgJFqwrikZ3nGM3WYfu4eEisT+9U5GPoAlX44QOBdEO
   OX60012dhOjBydabecoPHph22s+2WqsP0jm4zXIBkyg0Oh/RD/HlNPeRr
   Sjx+FsyktNczqy5aP/NGHvIEAdCXnW46aE6vKMlA47y/NVkVRQpH1IhSq
   ja8K2w4NvTdfYbyJZjRTfKLV32X/spWw8/0CN4TmakBKsjsRxck8ZVL1M
   w==;
X-CSE-ConnectionGUID: /4LiYO7DQYCGguxV0h0Kmg==
X-CSE-MsgGUID: Bk4cM+U2QwCj/d0EZrr6Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="627118"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="627118"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:48:26 -0700
X-CSE-ConnectionGUID: As8t4DbMSRiP7beGv3V5vw==
X-CSE-MsgGUID: kIAAqkMaTKiqu8btEgSlOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1873478"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2026 04:48:24 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH 2/2] Bluetooth: btintel_pcie: Add TOP silent reset support
Date: Wed, 14 Oct 2026 17:17:51 +0530
Message-ID: <20261014114752.174669-2-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014114752.174669-1-chandrashekar.devegowda@intel.com>
References: <20261014114752.174669-1-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TOP (Total On-chip Platform) silent reset, a lighter recovery
than PLDR for HW >= SCP2 on subsystem PEP. Both BT- and
WiFi-initiated resets are supported, falling back to PLDR on
failure.

On a BT-initiated reset, hw_error() marks the per-BDF recovery
struct and triggers an FLR; the reprobe restores INTEL_TOP_RESET,
and btintel_pcie_do_top_reset() asserts the reset bit in
FUNC_SCRATCH and replays btintel_send_intel_reset() using the
cached boot_addr, then waits for the GP1 mailbox event and
BOOT_STAGE_REG to clear before a final FLR reprobes the device.

On a WiFi-initiated reset, the GP1 handler decodes the
TOP_SILENT_RESET sub-events from mbox2; if BT is the follower it
goes straight to PLDR instead.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 638 ++++++++++++++++++++++++++++---
 drivers/bluetooth/btintel_pcie.h |  58 ++-
 2 files changed, 644 insertions(+), 52 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 91b1ee9d6010..a513bba1d21c 100644
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
@@ -526,6 +530,14 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 	hci_recv_diag(hdev, skb);
 }
 
+static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data);
+static void btintel_pcie_reset_ia(struct btintel_pcie_data *data);
+static int btintel_pcie_start_rx(struct btintel_pcie_data *data);
+static struct btintel_pcie_dev_recovery *
+btintel_pcie_get_recovery(struct pci_dev *pdev);
+static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
+				       enum btintel_pcie_reset_type type);
+
 static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 				  struct sk_buff *skb, u32 pkt_type, u16 opcode)
 {
@@ -593,6 +605,33 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 	}
 
 	if (wait_on_alive) {
+		/* After TOP reset, device returns to ROM state. The normal
+		 * alive interrupt won't arrive since FW isn't loaded yet.
+		 * Reinitialize RX/TX queues and skip the alive wait so FW
+		 * re-download can proceed immediately.
+		 */
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) &&
+		    btintel_pcie_in_rom(data)) {
+			bool armed;
+
+			/* Claim the transition under irq_lock, same as the
+			 * dxstate fallback above, so a concurrent gp0 handler
+			 * run observing the same boot stage cannot also arm
+			 * RX and race this thread's reset_ia()/start_rx().
+			 */
+			spin_lock(&data->irq_lock);
+			armed = data->alive_intr_ctxt == BTINTEL_PCIE_FW_DL;
+			if (!armed)
+				data->alive_intr_ctxt = BTINTEL_PCIE_FW_DL;
+			spin_unlock(&data->irq_lock);
+
+			if (!armed) {
+				btintel_pcie_reset_ia(data);
+				btintel_pcie_start_rx(data);
+			}
+			return 0;
+		}
+
 		ret = wait_event_timeout(data->gp0_wait_q,
 					 data->gp0_received,
 					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
@@ -1488,6 +1527,13 @@ static inline bool btintel_pcie_in_iml(struct btintel_pcie_data *data)
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
@@ -1870,27 +1916,172 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	return err;
 }
 
+/* Returns true when either the boot-stage register reads 0, or the
+ * recorded generation differs from @gen (the GP1 handler bumped it,
+ * meaning data->top_reset_deadline was extended and should be
+ * re-evaluated by the caller's wait loop).
+ */
+static inline bool btintel_pcie_top_reset_done(struct btintel_pcie_data *data,
+					       unsigned int gen)
+{
+	return btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG) == 0 ||
+	       READ_ONCE(data->top_reset_gen) != gen;
+}
+
+/* Handle a TOP silent reset MBOX2 sub-event. Called directly from the GP1
+ * handler as soon as it arrives, whether or not data->hdev is valid yet.
+ * bt_dev_*() is safe with a NULL hdev (bt_dev_name() falls back to
+ * "null"), and all state this function touches lives on 'data' (always
+ * allocated whenever MSI-X is live), not the separately-allocated
+ * recovery struct, so there is nothing here that depends on hdev being
+ * set or on a GFP_ATOMIC allocation succeeding.
+ */
+static void btintel_pcie_handle_top_reset_mbox2(struct btintel_pcie_data *data,
+						u32 mbox2)
+{
+	u32 expires = BTINTEL_PCIE_TOP_RESET_INTERVAL_MS;
+	u32 reg;
+
+	switch (mbox2) {
+	case BTINTEL_PCIE_TOP_RESET_WIFI_REQUEST:
+		bt_dev_info(data->hdev,
+			    "TOP reset request from WiFi, triggering PLDR");
+		if (!test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+			bt_dev_info(data->hdev,
+				    "BT is follower, triggering PLDR");
+			set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+			if (!btintel_pcie_request_reset(data,
+							BTINTEL_PCIE_IOSF_PRR_PLDR)) {
+				/* Rejected because BTINTEL_PCIE_SETUP_DONE
+				 * is not set yet; retry once setup
+				 * completes instead of dropping the
+				 * WiFi-follower request (see
+				 * BTINTEL_PCIE_TOP_RESET_WIFI_PLDR_PENDING
+				 * in btintel_pcie_setup()).
+				 */
+				bt_dev_warn(data->hdev,
+					    "TOP reset: PLDR request rejected, deferring until setup completes");
+				clear_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+				set_bit(BTINTEL_PCIE_TOP_RESET_WIFI_PLDR_PENDING,
+					&data->flags);
+
+				/* Close the race with btintel_pcie_setup()'s
+				 * one-shot replay of this flag at
+				 * BTINTEL_PCIE_SETUP_DONE time: if SETUP_DONE
+				 * is already visible here, that replay may
+				 * already have run (and found nothing
+				 * pending, since we had not set the flag
+				 * yet) before this point, so replay it
+				 * ourselves instead of leaving it stuck until
+				 * a SETUP_DONE transition that already
+				 * happened. test_and_clear_bit() ensures only
+				 * one of the two sides actually replays if
+				 * both observe the race window.
+				 */
+				if (test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags) &&
+				    test_and_clear_bit(BTINTEL_PCIE_TOP_RESET_WIFI_PLDR_PENDING,
+						       &data->flags)) {
+					bt_dev_info(data->hdev,
+						    "Replaying deferred WiFi-follower PLDR request");
+					set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+					if (!btintel_pcie_request_reset(data,
+									BTINTEL_PCIE_IOSF_PRR_PLDR))
+						clear_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+				}
+			}
+			return;
+		}
+		break;
+	case BTINTEL_PCIE_TOP_RESET_WIFI_ACK:
+		bt_dev_info(data->hdev, "TOP reset ack from WiFi");
+		break;
+	case BTINTEL_PCIE_TOP_RESET_WIFI_NACK:
+		bt_dev_info(data->hdev, "TOP reset NACK from WiFi");
+		set_bit(BTINTEL_PCIE_TOP_RESET_FAILED, &data->flags);
+		break;
+	case BTINTEL_PCIE_TOP_RESET_WIFI_REQ_ROLE_SWITCH:
+		bt_dev_info(data->hdev, "TOP reset WIFI_REQ_ROLE_SWITCH");
+		expires = BTINTEL_PCIE_TOP_RESET_ROLE_SWITCH_MS;
+		reg = btintel_pcie_rd_reg32(data,
+					    BTINTEL_PCIE_CSR_RESET_DEBUG_AD);
+		if (reg == BTINTEL_PCIE_TOP_RESET_DBG_RESET_REG)
+			bt_dev_dbg(data->hdev, "TOP reset initiated by WiFi");
+		break;
+	case BTINTEL_PCIE_TOP_RESET_WIFI_NO_RESPONSE:
+		bt_dev_err(data->hdev, "TOP reset WIFI_NO_RESPONSE");
+		set_bit(BTINTEL_PCIE_TOP_RESET_FAILED, &data->flags);
+		break;
+	case BTINTEL_PCIE_TOP_RESET_WIFI_RESPONSE_INVALID:
+		bt_dev_err(data->hdev, "TOP reset WIFI_RESPONSE_INVALID");
+		set_bit(BTINTEL_PCIE_TOP_RESET_FAILED, &data->flags);
+		break;
+	default:
+		bt_dev_err(data->hdev, "TOP reset with undefined MBOX2 0x%8.8x",
+			   mbox2);
+		/* An unrecognized sub-event means the negotiation outcome
+		 * is unknown; do not let a stale boot_stage==0 read be
+		 * mistaken for success further down and select FLR.
+		 */
+		set_bit(BTINTEL_PCIE_TOP_RESET_FAILED, &data->flags);
+		break;
+	}
+
+	data->top_reset_expires = expires;
+	/* Record an absolute deadline and bump the generation counter so
+	 * an in-progress second wait in btintel_pcie_do_top_reset() can
+	 * notice a later extension (e.g. WIFI_REQ_ROLE_SWITCH) instead of
+	 * timing out against a stale, shorter value.
+	 */
+	WRITE_ONCE(data->top_reset_deadline,
+		   jiffies + msecs_to_jiffies(expires));
+	WRITE_ONCE(data->top_reset_gen, data->top_reset_gen + 1);
+	set_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &data->flags);
+	bt_dev_info(data->hdev, "TOP reset timer expires in %u ms", expires);
+	wake_up(&data->gp0_wait_q);
+}
+
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
@@ -1929,10 +2120,38 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
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
+	/*
+	 * Handle TOP silent reset mbox notification inline. MBOX1 =
+	 * TOP_SILENT_RESET signals a TOP reset event, but the actual
+	 * sub-event code lives in MBOX2. If MBOX1 arrived alone,
+	 * BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING pairs it with this MBOX2
+	 * interrupt instead of using stale mailbox data. Handled directly
+	 * here (not deferred) regardless of whether data->hdev is valid
+	 * yet: btintel_pcie_handle_top_reset_mbox2() only touches state on
+	 * 'data', which is always allocated whenever MSI-X is live.
+	 */
+	if (top_reset_mbox)
+		btintel_pcie_handle_top_reset_mbox2(data, data->mbox.mbox2);
+
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
@@ -1987,11 +2206,27 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 		signal_waitq = true;
 		break;
 	case BTINTEL_PCIE_FW_DL:
-		/* Error case is already handled. Ideally control shall not
-		 * reach here
+		/* During a TOP silent reset the controller returns to
+		 * boot_stage 0 while alive_intr_ctxt is still FW_DL (set
+		 * by btintel_pcie_send_sync()'s post-TOP fast-path).
+		 * btintel_pcie_do_top_reset()'s second wait polls
+		 * BOOT_STAGE_REG == 0 on gp0_wait_q; without this wake
+		 * the wait only re-checks on timer expiry and the driver
+		 * needlessly waits the full 250 ms / 5000 ms timeout even
+		 * if the FW signalled ready earlier.
 		 */
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+			signal_waitq = true;
 		break;
 	case BTINTEL_PCIE_INTEL_HCI_RESET1:
+		/* As with the FW_DL case above, a TOP silent reset can
+		 * bring GP0 here while still waiting on BOOT_STAGE_REG == 0
+		 * in btintel_pcie_do_top_reset()'s second wait. Wake it so
+		 * it re-checks immediately instead of timing out.
+		 */
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+			signal_waitq = true;
+
 		if (btintel_pcie_in_op(data)) {
 			submit_rx = true;
 			signal_waitq = true;
@@ -2835,6 +3070,7 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x00 },
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x21 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
 };
@@ -3526,12 +3762,160 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	return err;
 }
 
+static int btintel_pcie_do_top_reset(struct btintel_pcie_data *data,
+				     struct hci_dev *hdev)
+{
+	struct btintel_data *intel_data = hci_get_priv(hdev);
+	long ret;
+	u32 reg;
+	int err;
+
+	/* Set scratch register to indicate TOP silent reset to FW */
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR,
+				  BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILENT_RESET);
+
+	/* Clear mbox flag before sending reset to avoid race with ISR.
+	 * Both flags live on data->flags (not the separately-allocated
+	 * recovery struct): they are scoped to this single call and do
+	 * not need to survive a device_reprobe(), so tracking them here
+	 * removes any dependency on btintel_pcie_get_recovery()'s
+	 * GFP_ATOMIC allocation succeeding.
+	 */
+	clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &data->flags);
+	clear_bit(BTINTEL_PCIE_TOP_RESET_FAILED, &data->flags);
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
+				 test_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &data->flags),
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
+	/* Second wait: mbox received, wait for boot_stage == 0 against the
+	 * absolute deadline in data->top_reset_deadline. The GP1 handler
+	 * can extend that deadline (e.g. on WIFI_REQ_ROLE_SWITCH) and bumps
+	 * top_reset_gen when it does; loop so such an extension is honored
+	 * instead of being capped by whatever remaining time was passed to
+	 * an already-running wait_event_timeout().
+	 */
+	for (;;) {
+		unsigned int gen = READ_ONCE(data->top_reset_gen);
+		long remaining = (long)READ_ONCE(data->top_reset_deadline) -
+				  (long)jiffies;
+
+		if (remaining <= 0) {
+			ret = 0;
+			break;
+		}
+
+		wait_event_timeout(data->gp0_wait_q,
+				   btintel_pcie_top_reset_done(data, gen),
+				   remaining);
+
+		reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+		if (reg == 0) {
+			ret = 1;
+			break;
+		}
+		/* Either genuinely timed out, or woken by a generation bump
+		 * (deadline extended) with boot_stage still nonzero; either
+		 * way, loop back and recompute remaining time against the
+		 * latest deadline.
+		 */
+	}
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	bt_dev_info(hdev, "After side band reset boot-stage: 0x%8.8x", reg);
+
+	/* A NACK / no-response / invalid-response from WiFi means the TOP
+	 * reset negotiation itself failed, regardless of what boot_stage
+	 * happens to read right now; do not treat that as success.
+	 */
+	if (test_bit(BTINTEL_PCIE_TOP_RESET_FAILED, &data->flags)) {
+		bt_dev_warn(hdev,
+			    "TOP reset: WiFi reported failure, triggering PLDR");
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+	} else if (!ret && reg != 0) {
+		bt_dev_warn(hdev,
+			    "TOP reset failed (boot_stage:0x%08x), triggering PLDR",
+			    reg);
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+	} else {
+		data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+	}
+
+done:
+	clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &data->flags);
+	btintel_clear_flag(hdev, INTEL_TOP_RESET);
+	btintel_pcie_clr_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR,
+				  BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILENT_RESET);
+
+	/* BTINTEL_PCIE_TOP_RESET is still set on data->flags, allowing
+	 * btintel_pcie_request_reset() to proceed without SETUP_DONE.
+	 * The flag is cleared by reset_work after recovery completes.
+	 */
+	btintel_pcie_request_reset(data, data->reset_type);
+
+	/* Return -ECANCELED so btintel_pcie_setup() propagates failure
+	 * up to hci_dev_open_sync(). The reset_work scheduled above
+	 * will tear down this hdev instance via device_reprobe(); if
+	 * HCI init proceeded on the current instance it would race
+	 * with that teardown and enqueue commands to a controller that
+	 * is being reset.
+	 */
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
+	/* Restore TOP_RESET intent from persistent recovery data across
+	 * device_reprobe(). The recovery struct is keyed by PCI BDF and
+	 * outlives the freed 'data' from the previous instance.
+	 */
+	rec = btintel_pcie_get_recovery(data->pdev);
+	if (rec && test_and_clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+				      &rec->flags)) {
+		set_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+	}
+
+	while ((err = btintel_pcie_setup_internal(hdev)) != 0) {
+		if (err == -ENODEV)
+			break;
+
+		/* Any failure while a TOP reset is pending means the
+		 * normal firmware-download retry below is not going to
+		 * help (the controller is in the silent-reset state the
+		 * TOP reset exists to recover from); dispatch it instead
+		 * of exhausting retries on a path that cannot succeed.
+		 * Checked on every failing iteration, not just via the
+		 * loop condition, so a TOP reset pending during the final
+		 * retry attempt (whatever error it returns, not only
+		 * -ECANCELED) is not missed.
+		 */
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
+			return btintel_pcie_do_top_reset(data, hdev);
+
+		if (fw_dl_retry++ >= 1)
+			break;
 
-	while ((err = btintel_pcie_setup_internal(hdev)) && fw_dl_retry++ < 1) {
 		bt_dev_err(hdev, "Firmware download retry count: %d",
 			   fw_dl_retry);
 		btintel_pcie_dump_debug_registers(hdev);
@@ -3554,30 +3938,53 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		btintel_pcie_start_rx(data);
 	}
 
-	if (!err)
+	if (!err) {
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
+
+		/* Retry a WiFi-follower PLDR request that
+		 * btintel_pcie_handle_top_reset_mbox2() had to defer
+		 * because setup had not completed yet, instead of
+		 * leaving it dropped.
+		 */
+		if (test_and_clear_bit(BTINTEL_PCIE_TOP_RESET_WIFI_PLDR_PENDING,
+				       &data->flags)) {
+			bt_dev_info(hdev,
+				    "Replaying deferred WiFi-follower PLDR request");
+			set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+			if (!btintel_pcie_request_reset(data,
+							BTINTEL_PCIE_IOSF_PRR_PLDR))
+				clear_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+		}
+	}
 	return err;
 }
 
 static struct btintel_pcie_dev_recovery *
-btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
+btintel_pcie_get_recovery(struct pci_dev *pdev)
 {
 	struct btintel_pcie_dev_recovery *tmp, *data = NULL;
 	const char *name = pci_name(pdev);
 	const size_t name_len = strlen(name) + 1;
-	struct hci_dev *hdev = to_hci_dev(dev);
+	unsigned long flags;
 
-	spin_lock(&btintel_pcie_recovery_lock);
+	/*
+	 * This function runs both in process context (setup, reset_work,
+	 * request_reset, hw_error) and in hardirq context (GP1 MSI-X
+	 * handler). Use irqsave/irqrestore so a GP1 interrupt firing on
+	 * the same CPU while a process-context caller holds the lock
+	 * cannot spin waiting on itself and hard-lock the system.
+	 */
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
-		bt_dev_dbg(hdev, "Found restart data for BDF: %s", data->name);
+		dev_dbg(&pdev->dev, "Found restart data for BDF: %s", data->name);
 		return data;
 	}
 
@@ -3586,9 +3993,23 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
 		return NULL;
 
 	strscpy(data->name, name, name_len);
-	spin_lock(&btintel_pcie_recovery_lock);
+	spin_lock_irqsave(&btintel_pcie_recovery_lock, flags);
+	/* Re-search under lock to avoid a TOCTOU race where a concurrent
+	 * caller (GP1 ISR, hw_error, setup or reset_work) inserted an
+	 * entry for the same BDF between the initial search and this
+	 * insertion. Without this check the list can end up with
+	 * duplicate entries and later lookups may return an orphaned
+	 * struct that no longer receives updates.
+	 */
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
@@ -3604,13 +4025,12 @@ static void btintel_pcie_free_restart_list(void)
 	}
 }
 
-static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
-					    struct device *dev)
+static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev)
 {
 	struct btintel_pcie_dev_recovery *data;
 	time64_t retry_window;
 
-	data = btintel_pcie_get_recovery(pdev, dev);
+	data = btintel_pcie_get_recovery(pdev);
 	if (!data)
 		return;
 
@@ -3681,7 +4101,16 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 	return ret;
 }
 
-static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
+/* Returns 0 if the ACPI _PRR reset succeeded and device_reprobe() tore
+ * down and re-probed 'data' (which is therefore no longer valid to
+ * touch), or a negative errno if the reset itself failed and 'data' is
+ * still alive and needs the caller's failure cleanup. Must not be
+ * inferred from device_reprobe()'s own return value: device_reprobe()
+ * always runs .remove() (freeing 'data') before attempting the fresh
+ * probe, so a nonzero device_reprobe() result does not mean 'data' is
+ * still alive.
+ */
+static int btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 {
 	struct pci_dev *pdev = data->pdev;
 	struct pci_dev *wifi = NULL;
@@ -3702,7 +4131,7 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 
 	bus = pdev->bus;
 	if (!bus)
-		return;
+		return -ENODEV;
 
 	list_for_each_entry(tmp, &bus->devices, bus_list) {
 		if (pci_match_id(wifi_device_ids, tmp)) {
@@ -3729,10 +4158,10 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 		pci_dev_put(wifi);
 	}
 
-	if (!ret) {
-		if (device_reprobe(&pdev->dev))
-			BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
-	}
+	if (!ret && device_reprobe(&pdev->dev))
+		BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
+
+	return ret;
 }
 
 /*
@@ -3769,6 +4198,27 @@ static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
 	return 0;
 }
 
+/* Restore the reset-serialization/bookkeeping state after a reset attempt
+ * failed with 'data' still alive (no device_reprobe() tore it down and
+ * started fresh), so a later recovery attempt is not permanently blocked.
+ * Does not touch BTINTEL_PCIE_CORE_HALTED, which is a separate one-shot
+ * latch intentionally cleared only by re-probe (see
+ * btintel_pcie_msix_hw_exp_handler()).
+ */
+static void btintel_pcie_reset_failed(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_dev_recovery *rec = btintel_pcie_get_recovery(data->pdev);
+
+	clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+	clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+	if (rec)
+		clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags);
+	enable_work(&data->coredump_work);
+	enable_work(&data->hwexp_work);
+	enable_work(&data->fwtrigger_work);
+	enable_work(&data->mbox_work);
+}
+
 static void btintel_pcie_reset_work(struct work_struct *wk)
 {
 	struct btintel_pcie_data *data =
@@ -3810,15 +4260,39 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
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
+		struct btintel_pcie_dev_recovery *rec;
+
+		rec = btintel_pcie_get_recovery(data->pdev);
+		if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+			bt_dev_warn(data->hdev,
+				    "TOP reset FLR failed, falling back to PLDR");
+			clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
+			if (rec)
+				clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+					  &rec->flags);
+			data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
+			/* The TOP_RESET bypass above was consumed by this
+			 * fallback attempt; if it also fails, run the
+			 * shared cleanup below instead of leaving the
+			 * device stuck with no further recovery.
+			 */
+			if (btintel_pcie_perform_pldr(data))
+				btintel_pcie_reset_failed(data);
+			goto out;
+		}
+
+		/* FLR failed: 'data' is still alive and no fresh probe
+		 * ran to consume the persistent TOP-reset intent. Restore
+		 * the bookkeeping used by the reset-serialization contract
+		 * so a later recovery can proceed.
+		 */
+		btintel_pcie_reset_failed(data);
 	}
 
 out:
@@ -3848,19 +4322,51 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
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
 
 	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
-		return;
+		return false;
+
+	/* Normal path requires SETUP_DONE. TOP reset recovery calls this
+	 * from btintel_pcie_do_top_reset() before setup completes; the
+	 * BTINTEL_PCIE_TOP_RESET flag authorizes bypassing that gate.
+	 */
+	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags) &&
+	    !test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+		return false;
+	}
+
+	if (type == BTINTEL_PCIE_IOSF_TOP_RESET) {
+		rec = btintel_pcie_get_recovery(data->pdev);
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
@@ -3907,10 +4413,41 @@ static struct attribute *btintel_pcie_attrs[] = {
 
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
@@ -3920,15 +4457,18 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 
 	btintel_pcie_dump_debug_registers(hdev);
 
-	rec = btintel_pcie_get_recovery(pdev, &hdev->dev);
+	rec = btintel_pcie_get_recovery(pdev);
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
@@ -3941,8 +4481,9 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 			   rec->last_error);
 		return;
 	}
-	btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
-	btintel_pcie_request_reset(dev_data, type);
+
+	if (btintel_pcie_request_reset(dev_data, type))
+		btintel_pcie_inc_recovery_count(pdev);
 }
 
 static bool btintel_pcie_wakeup(struct hci_dev *hdev)
@@ -4045,10 +4586,15 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 
 	/* Publish hdev only after successful registration; the coredump
 	 * worker bails on !data->hdev, so it never observes a half-set-up
-	 * device.
+	 * device. A TOP reset MBOX2 event racing this publish is handled
+	 * directly by the GP1 handler regardless of ordering (see
+	 * btintel_pcie_handle_top_reset_mbox2()), so no synchronization is
+	 * needed here.
 	 */
 	data->hdev = hdev;
+
 	data->dmp_hdr.driver_name = KBUILD_MODNAME;
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3030b4e8b750..3911bfcd8f6f 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -10,6 +10,7 @@
 #define BTINTEL_PCIE_CSR_BASE			(0x000)
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
 #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
+#define BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR	(BTINTEL_PCIE_CSR_BASE + 0x02C)
 #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_REG		(BTINTEL_PCIE_CSR_BASE + 0x108)
 #define BTINTEL_PCIE_CSR_IPC_CONTROL_REG	(BTINTEL_PCIE_CSR_BASE + 0x10C)
@@ -24,6 +25,7 @@
 #define BTINTEL_PCIE_CSR_MBOX_3_REG		(BTINTEL_PCIE_CSR_BASE + 0x178)
 #define BTINTEL_PCIE_CSR_MBOX_4_REG		(BTINTEL_PCIE_CSR_BASE + 0x17C)
 #define BTINTEL_PCIE_CSR_MBOX_STATUS_REG	(BTINTEL_PCIE_CSR_BASE + 0x180)
+#define BTINTEL_PCIE_CSR_RESET_DEBUG_AD	(BTINTEL_PCIE_CSR_BASE + 0x220)
 #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG		(BTINTEL_PCIE_CSR_BASE + 0x440)
 #define BTINTEL_PCIE_PRPH_DEV_RD_REG		(BTINTEL_PCIE_CSR_BASE + 0x458)
 #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR	(BTINTEL_PCIE_CSR_BASE + 0x460)
@@ -125,6 +127,13 @@
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
@@ -158,7 +167,23 @@ enum {
 	BTINTEL_PCIE_SETUP_DONE,
 	BTINTEL_PCIE_MAIL_BOX_INTR,
 	BTINTEL_PCIE_MBOX_PARSE_PENDING,
-	BTINTEL_PCIE_MBOX_PARSE_READY
+	BTINTEL_PCIE_MBOX_PARSE_READY,
+	BTINTEL_PCIE_TOP_RESET,
+	BTINTEL_PCIE_MBOX_TOP_RESET,
+	BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
+	/* Set on data->flags: a WiFi-follower PLDR request was rejected by
+	 * btintel_pcie_request_reset() because setup had not completed yet;
+	 * retried once BTINTEL_PCIE_SETUP_DONE is set.
+	 */
+	BTINTEL_PCIE_TOP_RESET_WIFI_PLDR_PENDING,
+	/* Only BTINTEL_PCIE_REC_TOP_RESET_PENDING below lives on rec->flags
+	 * (it must survive device_reprobe(), which frees 'data'); the rest
+	 * of the TOP reset mbox negotiation state is scoped to a single
+	 * btintel_pcie_do_top_reset() call and lives on data->flags so it
+	 * never depends on the recovery struct's GFP_ATOMIC allocation.
+	 */
+	BTINTEL_PCIE_REC_TOP_RESET_PENDING,
+	BTINTEL_PCIE_TOP_RESET_FAILED,
 };
 
 enum btintel_pcie_tlv_type {
@@ -188,14 +213,25 @@ enum msix_mbox_int_causes {
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
@@ -783,6 +819,16 @@ struct btintel_pcie_data {
 	wait_queue_head_t	mbox_parse_wait_q;
 	/* Timestamp captured in GP1 handler when mbox interrupt is received */
 	ktime_t	mbox_intr_ts;
+	wait_queue_head_t	coredump_wait_q;
+	u32			top_reset_expires;
+	/* Absolute jiffies deadline for the second wait in
+	 * btintel_pcie_do_top_reset(); top_reset_gen is bumped every
+	 * time the GP1 handler updates the deadline so an in-progress
+	 * wait_event_timeout() notices the change instead of timing
+	 * out against a stale value (e.g. on WIFI_REQ_ROLE_SWITCH).
+	 */
+	unsigned long		top_reset_deadline;
+	unsigned int		top_reset_gen;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

