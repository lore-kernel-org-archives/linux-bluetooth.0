Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627511;
	b=HUAKeheGd7Ll06mblge/cTTcYUlJHeTVuzLxfXmesRwBX0Ru7nftPxg3+hPNwn5wAosB
	 i+R+R7rf0XYoXWeKTCX8q+JzlEBPvpKHE2VunpK5PvqgGunuHva4HNHNwnZAhMxmcs1AY
	 Z4pcIaNa2GwFa9pgyBl3VQI2utXw5hrNm+MkG1B4kcnsejoQrfrgT9taF05YDd+IsV5wb
	 +h1j+EgYnAhr1bPNwT36H93AoVpUFSewVv6/61gvS8GiEea/IDE3AMWHElfDlV94x/zpY
	 MCifY3cLaz/qm7crPkiAXJGL7jmQZdb3dC1p2PWvUQ4qc/MapUOf/V94OgtjGTose8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627511;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6ZBrZJd1zfaQqH9bIbJsxriKxcef7wYa/kY6sxkJupw=;
	b=0LEhDJME327W7ND5dyvxW9Eu3MocCfMxLwYezFJtvDSQt8lFnmbtmeB0jiIUCpbyjK9Z
	 9HU2PPCD190F8v+5BPHHTsiGBbZDFb06dfvRskhmdt8x5FzgjLM9228gHPXymLcVz/pA1
	 FdDYSEvKoGSaDayMWFhDnYtdpi6u0WWFpeHNY/SnX9k5JyXUR/b26OTuoA/DZr7E1ZoRq
	 D0Yq9kkRAtwbbuULuIXcUmURDJP5TrRelSLZw8xIaxnKBvNrqnSH3jjhgJJiKV3XDyMAW
	 XFNqbyjRHUIF6HQBbF8KZUJdQprTXJ69wRhuWEAgkAZoLHZWub8EfB8hOHqbxbOyPfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NUH7mB2H;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC9606A335
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 13:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0DC9606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NUH7mB2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793627510; x=1825163510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9nNPRq0OZrlmBCrUWBSYr7p55rbrszlOhHHoPdDOgoM=;
  b=NUH7mB2HrKcGCw62/3VAjgmgRPyYUCM4qtnG/awHfbK9ZkTslCgj/Mr0
   /Uhwo9gztcaLpLWoYkkxCNbixjsU3Wh3+p8w122LHUqQVZ8UJLvilT36O
   7cC1Xp+ACjCVAb++8bDRDdyhHRRaCxGdf1itAEilsMCiuxO3SaFrJzRYw
   pv99OFrelA3bW9px22d4jrat4lQvnVGXKjHenJESOqu/lerscfHt80NVp
   jHvq2582Pxkj5Y3pMGccRGkAwYU4xYqAUzruDsODa5XlB5Wc2VCA0yZaU
   oqQCNBoaAamrosU/W2hAd1kH9nOCfO0NxnK3/bhDpEWAr8al3hd/c1syF
   Q==;
X-CSE-ConnectionGUID: 5dFfyH0zQa+DUzhtIKbZ9w==
X-CSE-MsgGUID: CrLlXWroT4eXxPgZ1lR85g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2330014"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2330014"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 05:51:49 -0800
X-CSE-ConnectionGUID: 6Lt0n3osTny2EZ4bahbx+g==
X-CSE-MsgGUID: LQzgrsSrRSe+R1DxI9SWZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6450145"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa009.fm.intel.com with ESMTP; 02 Nov 2026 05:51:48 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: DBGC flush doorbell and dump rate-limit
Date: Mon,  2 Nov 2026 19:13:19 +0530
Message-ID: <20261102134319.2280200-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
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

DBGC data in SMEM may not be up to date when a dump is collected. Make
btintel_pcie_coredump() arm USER_TRIGGERED_DUMP and ring the
IPC_CONTROL.COLLECT_DUMP_REQ doorbell first, so the firmware flushes
the SMEM contents to DRAM and the dump holds valid data. The resulting
fwTriggerDump interrupt queues the coredump with
TRIGGER_REASON_USER_TRIGGER and skips the firmware trigger event, as
there is none for a host-initiated flush. Firmware-initiated triggers
still emit the diagnostic frame with TRIGGER_REASON_FW_ASSERT.

The doorbell only concerns Bluetooth DBGC. When traces are routed to
the WiFi DBGC there is no host buffer to flush into, so skip the
request. When the core is halted the firmware cannot answer, so queue
the dump directly. If the firmware does not answer within 1 second,
treat the doorbell as missed and collect the dump directly.

Quiesce the doorbell path before entering D3: mask the firmware trigger
interrupt, drop a pending request, and wait for an in-flight timeout or
dump to finish. Unmask it again on resume or if suspend fails.

Allow one collection per second, measured from the end of the last
dump, and reject concurrent dumps. A rate-limited firmware trigger
still emits the diagnostic frame; only the dump is skipped.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
v2: quiesce the doorbell path in suspend_late: mask the firmware trigger
    interrupt, flush pending dump work, and unmask it on resume or if
    suspend fails (Sashiko review of v1)

 drivers/bluetooth/btintel_pcie.c | 239 +++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |  12 ++
 2 files changed, 243 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 7d84c8106cf1..adb2bc44abbe 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2788,25 +2788,87 @@ static bool btintel_pcie_queue_coredump(struct btintel_pcie_data *data,
 	return false;
 }
 
+static bool btintel_pcie_dump_rate_limited(struct btintel_pcie_data *data)
+{
+	unsigned long last = READ_ONCE(data->last_dump_jiffies);
+
+	return last && time_before(jiffies, last +
+			secs_to_jiffies(BTINTEL_PCIE_DBG_DUMP_COLLECT_MIN_INTERVAL_SEC));
+}
+
+/* Consume the user-trigger flag and disarm the doorbell timeout. Returns
+ * true when the interrupt answers a pending user-triggered doorbell.
+ */
+static bool btintel_pcie_consume_user_dump(struct btintel_pcie_data *data)
+{
+	if (!test_and_clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags))
+		return false;
+
+	cancel_delayed_work(&data->user_dump_work);
+	return true;
+}
+
 static void btintel_pcie_msix_fw_trigger_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_dbg(data->hdev, "Received firmware smart trigger cause");
 
+	/* A reply to a pending doorbell during a running dump is dropped; a
+	 * real firmware trigger still continues to emit its event.
+	 */
+	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags) &&
+	    btintel_pcie_consume_user_dump(data)) {
+		bt_dev_warn(data->hdev,
+			    "user-triggered dump dropped: dump already in progress");
+		return;
+	}
+
 	/* Per-work guard: deduplicate concurrent FW-trigger interrupts.
-	 * Cleared at the tail of btintel_pcie_fwtrigger_worker().
+	 * Cleared at the tail of btintel_pcie_fwtrigger_worker() on the
+	 * FW-initiated path, or inline on the user-triggered path.
 	 */
 	if (test_and_set_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
-			     &data->flags))
+			     &data->flags)) {
+		if (btintel_pcie_consume_user_dump(data))
+			bt_dev_warn(data->hdev,
+				    "user-triggered dump dropped: dump already in progress");
+		return;
+	}
+
+	if (btintel_pcie_dump_rate_limited(data)) {
+		if (btintel_pcie_consume_user_dump(data)) {
+			bt_dev_warn(data->hdev,
+				    "user-triggered dump rate-limited (< 1 sec since last dump)");
+			clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
+				  &data->flags);
+			return;
+		}
+
+		/* Only the dump is limited; still report the FW event */
+		bt_dev_warn(data->hdev,
+			    "fwTriggerDump dump skipped: rate-limited (< 1 sec since last dump)");
+		if (!queue_work(data->dump_workqueue, &data->fwtrigger_work))
+			clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
+				  &data->flags);
+		return;
+	}
+
+	/* A doorbell-initiated flush has no firmware event to read, so skip
+	 * fwtrigger_work and release the guard here.
+	 */
+	if (btintel_pcie_consume_user_dump(data)) {
+		if (!btintel_pcie_queue_coredump(data,
+						 BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER))
+			bt_dev_warn(data->hdev,
+				    "user-triggered dump dropped: coredump not queued");
+		clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
 		return;
+	}
 
 	if (!queue_work(data->dump_workqueue, &data->fwtrigger_work)) {
 		clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
 		return;
 	}
 
-	/* Queue coredump after the fwtrigger event reader so dmp_hdr.event_*
-	 * is populated before dump_traces consumes it.
-	 */
 	btintel_pcie_queue_coredump(data, BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT);
 }
 
@@ -2814,6 +2876,9 @@ static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_err(data->hdev, "Received hw exception interrupt");
 
+	/* A halted core cannot answer a pending doorbell */
+	btintel_pcie_consume_user_dump(data);
+
 	/* CORE_HALTED is the single-writer guard for this handler. It is
 	 * set once on first HW exception and cleared only by re-probe
 	 * (data is reallocated), so it also serializes hwexp_work
@@ -2852,6 +2917,8 @@ static void btintel_pcie_coredump_worker(struct work_struct *work)
 	}
 
 	btintel_pcie_dump_traces(data->hdev);
+	/* 0 means no dump yet, so never store it */
+	WRITE_ONCE(data->last_dump_jiffies, jiffies ?: 1);
 out:
 	/* Release guard last so a new trigger can run only after this
 	 * pass has fully completed (including dev_coredumpv()).
@@ -2897,6 +2964,39 @@ static void btintel_pcie_fwtrigger_worker(struct work_struct *work)
 	clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
 }
 
+/* FW did not answer the DBGC flush doorbell in time; collect directly. The
+ * coredump guard is taken before the flag is cleared, so a late fwTriggerDump
+ * interrupt is dropped rather than treated as a firmware-initiated trigger.
+ *
+ * Known, accepted limitations: a doorbell reply arriving after this worker
+ * has finished is indistinguishable from a firmware trigger, and the worker
+ * and the interrupt handler may both try to claim one pending request. The
+ * COREDUMP_INPROGRESS guard still ensures a single dump; the worst case is
+ * an extra diagnostic frame or a misleading warning.
+ */
+static void btintel_pcie_user_dump_worker(struct work_struct *work)
+{
+	struct btintel_pcie_data *data = container_of(to_delayed_work(work),
+					struct btintel_pcie_data, user_dump_work);
+
+	if (!data->hdev ||
+	    !test_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags))
+		return;
+
+	if (btintel_pcie_dump_rate_limited(data) ||
+	    !btintel_pcie_queue_coredump(data,
+					 BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER)) {
+		clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
+		bt_dev_warn(data->hdev,
+			    "DBGC flush doorbell timed out, dump dropped: busy or rate-limited");
+		return;
+	}
+
+	clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
+	bt_dev_warn(data->hdev,
+		    "DBGC flush doorbell timed out, collecting dump directly");
+}
+
 static void btintel_pcie_mbox_worker(struct work_struct *work)
 {
 	struct btintel_pcie_data *data = container_of(work,
@@ -3208,7 +3308,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 			btintel_pcie_msix_tx_handle(data);
 	}
 
-	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG)
+	/* A masked cause still latches; ignore it once masked (suspend). */
+	if ((intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG) &&
+	    !(hw_mask & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG))
 		btintel_pcie_msix_fw_trigger_handler(data);
 
 	/* A masked cause still latches; ignore it once masked. */
@@ -3855,6 +3957,27 @@ static void btintel_pcie_unmask_hw_rfkill(struct btintel_pcie_data *data)
 	spin_unlock(&data->irq_lock);
 }
 
+static void btintel_pcie_mask_fwtrig(struct btintel_pcie_data *data)
+{
+	spin_lock(&data->irq_lock);
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,
+				  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG);
+	spin_unlock(&data->irq_lock);
+}
+
+static void btintel_pcie_unmask_fwtrig(struct btintel_pcie_data *data)
+{
+	spin_lock(&data->irq_lock);
+	/* Drop a reply latched while masked so it is not taken as a
+	 * firmware trigger.
+	 */
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
+			      BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG);
+	btintel_pcie_clr_reg_bits(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,
+				  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG);
+	spin_unlock(&data->irq_lock);
+}
+
 static void btintel_pcie_enable_interrupts(struct btintel_pcie_data *data)
 {
 	spin_lock(&data->irq_lock);
@@ -3880,6 +4003,7 @@ static void btintel_pcie_probe_cleanup(struct btintel_pcie_data *data)
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
 	disable_work_sync(&data->mbox_work);
+	disable_delayed_work_sync(&data->user_dump_work);
 	disable_delayed_work_sync(&data->hw_rfkill_work);
 
 	flush_work(&data->rx_work);
@@ -4099,6 +4223,7 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	if (!err) {
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
 		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
+		btintel_pcie_unmask_fwtrig(data);
 		btintel_pcie_unmask_hw_rfkill(data);
 		btintel_delayed_hw_rfkill(data, true);
 	}
@@ -4351,6 +4476,8 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
 	disable_work_sync(&data->mbox_work);
+	disable_delayed_work_sync(&data->user_dump_work);
+	clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 
 	/* Both reset paths follow the same contract: on success they
@@ -4375,6 +4502,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
 		enable_work(&data->mbox_work);
+		enable_delayed_work(&data->user_dump_work);
 		enable_delayed_work(&data->hw_rfkill_work);
 	}
 
@@ -4684,6 +4812,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_worker);
 	INIT_WORK(&data->fwtrigger_work, btintel_pcie_fwtrigger_worker);
 	INIT_WORK(&data->mbox_work, btintel_pcie_mbox_worker);
+	INIT_DELAYED_WORK(&data->user_dump_work, btintel_pcie_user_dump_worker);
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
@@ -4778,6 +4907,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
 	disable_work_sync(&data->mbox_work);
+	disable_delayed_work_sync(&data->user_dump_work);
 
 	/* Cancel pending reset work. Skip only when remove() is called from
 	 * within the reset work itself (PLDR device_reprobe path) to avoid
@@ -4822,6 +4952,32 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_DEV_COREDUMP
+static u32 btintel_pcie_ipc_ctrl_toggle(struct btintel_pcie_data *data, u32 bits)
+{
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->ipc_lock, flags);
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG);
+	reg ^= bits;
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG, reg);
+	spin_unlock_irqrestore(&data->ipc_lock, flags);
+	return reg;
+}
+
+/* FW treats any transition of COLLECT_DUMP_REQ as a request, so the bit is
+ * toggled rather than set and never needs to be cleared by the host.
+ */
+static void btintel_pcie_trigger_fw_dump_collect(struct btintel_pcie_data *data)
+{
+	u32 reg;
+
+	reg = btintel_pcie_ipc_ctrl_toggle(data,
+					   BTINTEL_PCIE_CSR_IPC_CONTROL_COLLECT_DUMP_REQ);
+	bt_dev_info(data->hdev,
+		    "IPC doorbell sent to FW for DBGC flush (IPC_CTRL=0x%08x)", reg);
+}
+
 static void btintel_pcie_coredump(struct device *dev)
 {
 	struct  pci_dev *pdev = to_pci_dev(dev);
@@ -4830,8 +4986,59 @@ static void btintel_pcie_coredump(struct device *dev)
 	if (!data)
 		return;
 
-	btintel_pcie_queue_coredump(data,
-				    BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER);
+	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags) ||
+	    test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
+		bt_dev_warn(data->hdev,
+			    "coredump rejected: collection already in progress");
+		return;
+	}
+
+	if (btintel_pcie_dump_rate_limited(data)) {
+		bt_dev_warn(data->hdev,
+			    "coredump rejected: rate-limited (< 1 sec since last dump)");
+		return;
+	}
+
+	/* No host DBGC buffer exists to flush into when traces go to WiFi */
+	if (btintel_pcie_dbg_to_wifi(data)) {
+		bt_dev_info(data->hdev,
+			    "coredump skipped: debug traces routed to WiFi DBGC");
+		return;
+	}
+
+	/* Only a halted core cannot answer the doorbell. FW services it
+	 * regardless of host setup or recovery state, so no other state
+	 * needs to be excluded; collect directly here.
+	 */
+	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags)) {
+		btintel_pcie_queue_coredump(data,
+					    BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER);
+		return;
+	}
+
+	if (test_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags)) {
+		bt_dev_warn(data->hdev,
+			    "coredump rejected: user-triggered dump already pending");
+		return;
+	}
+
+	/* Arm the timeout before the flag so an interrupt cannot cancel a
+	 * timer that is not queued yet.
+	 *
+	 * The arm/flag/doorbell sequence is not atomic against the interrupt
+	 * handler or reset. A firmware trigger in this window may take the
+	 * user-dump reason, and a reset in it may leave the flag set until
+	 * the next reset. Both are rare and do not affect the dump contents.
+	 */
+	if (!queue_delayed_work(data->dump_workqueue, &data->user_dump_work,
+				secs_to_jiffies(BTINTEL_PCIE_USER_DUMP_TIMEOUT_SEC))) {
+		bt_dev_warn(data->hdev,
+			    "coredump rejected: dump workqueue is disabled");
+		return;
+	}
+
+	set_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
+	btintel_pcie_trigger_fw_dump_collect(data);
 }
 #endif
 
@@ -4936,9 +5143,19 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	data = pci_get_drvdata(pdev);
 
 	btintel_pcie_mask_hw_rfkill(data);
+	btintel_pcie_mask_fwtrig(data);
 	btintel_pcie_synchronize_irqs(data);
 	cancel_delayed_work_sync(&data->hw_rfkill_work);
 
+	/* No new firmware trigger can arrive now. Drop a pending doorbell
+	 * request, then let an in-flight timeout worker and any queued dump
+	 * finish so that nothing touches the device while it enters D3.
+	 */
+	clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
+	cancel_delayed_work_sync(&data->user_dump_work);
+	flush_work(&data->fwtrigger_work);
+	flush_work(&data->coredump_work);
+
 	/* S0ix (s2idle) uses D3_HOT; S3, freeze and hibernate use D3_COLD. */
 	if (mesg.event == PM_EVENT_SUSPEND &&
 	    pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
@@ -4958,6 +5175,7 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	err = btintel_pcie_set_dxstate(data, dxstate);
 
 	if (err) {
+		btintel_pcie_unmask_fwtrig(data);
 		btintel_pcie_unmask_hw_rfkill(data);
 		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
 		btintel_delayed_hw_rfkill(data, true);
@@ -5023,6 +5241,11 @@ static int btintel_pcie_resume_event(struct device *dev, pm_message_t mesg)
 	/* Refer: 6.4.11.7 -> Platform power management */
 	err = btintel_pcie_set_dxstate(data, BTINTEL_PCIE_STATE_D0);
 
+	/* Restore the firmware trigger interrupt even if D0 entry failed, so
+	 * a later recovery does not leave it masked.
+	 */
+	btintel_pcie_unmask_fwtrig(data);
+
 	if (err) {
 		bt_dev_err(data->hdev, "Failed to set D0 state (%d)", err);
 	} else {
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index f04dfb0b30fa..2db674a3eb9d 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -44,6 +44,7 @@
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET		(BIT(31))
 
 /* BTINTEL PCIE CSR IPC Control Register */
+#define BTINTEL_PCIE_CSR_IPC_CONTROL_COLLECT_DUMP_REQ	(BIT(6))
 #define BTINTEL_PCIE_CSR_IPC_CONTROL_HW_RFKILL		(BIT(7))
 
 /* BTINTEL PCIE CSR IPC Status Register */
@@ -166,6 +167,7 @@ enum {
 	BTINTEL_PCIE_CORE_HALTED,
 	BTINTEL_PCIE_COREDUMP_INPROGRESS,
 	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
+	BTINTEL_PCIE_USER_TRIGGERED_DUMP,
 	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
 	BTINTEL_PCIE_HWRFKILL_ON,
 	BTINTEL_PCIE_HW_RFKILL_STATE_CHECK,
@@ -223,6 +225,14 @@ enum btintel_pcie_mbox_msg {
 /* Default poll time for MAC access during init */
 #define BTINTEL_DEFAULT_MAC_ACCESS_TIMEOUT_US	200000
 
+/* Minimum interval (in seconds) between debug dump collections */
+#define BTINTEL_PCIE_DBG_DUMP_COLLECT_MIN_INTERVAL_SEC	1
+
+/* Time (in seconds) to wait for FW to answer a DBGC flush doorbell; an
+ * unanswered doorbell is treated as missed and the dump is collected directly.
+ */
+#define BTINTEL_PCIE_USER_DUMP_TIMEOUT_SEC		1
+
 /* Default interrupt timeout in msec */
 #define BTINTEL_DEFAULT_INTR_TIMEOUT_MS	3000
 #define BTINTEL_PCIE_MBOX_INTR_TIMEOUT_MS	500
@@ -803,6 +813,7 @@ struct btintel_pcie_data {
 	struct work_struct	hwexp_work;
 	struct work_struct	fwtrigger_work;
 	struct work_struct	mbox_work;
+	struct delayed_work	user_dump_work;
 
 	struct dma_pool	*dma_pool;
 	dma_addr_t	dma_p_addr;
@@ -824,6 +835,7 @@ struct btintel_pcie_data {
 	u32	debug_table_size;
 	struct btintel_pcie_dump_mem_info	dump_info;
 	struct btintel_pcie_mbox	mbox;
+	unsigned long	last_dump_jiffies;
 
 	/* Wait queue for mbox_worker to wait for GP0 alive interrupt */
 	wait_queue_head_t	mbox_parse_wait_q;
-- 
2.53.0

