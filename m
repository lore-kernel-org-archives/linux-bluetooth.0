Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1F3AB269
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010662; cv=none; b=l+X2me0lECYrI2lWkS+dctUZSTxct7xwC+vFnfNaIFbIdI3t/3Y2MYKrh3MxyKtc56epjfTDX2C/mKw7g5jVhHGqKeF3AggDgFCx5Zhe+/te8FJUxOIt2ZcgpxDTB06TAhbL1DuDsaZyiHPyFYgh/+hKBUGLIuXQXUtdCPHt5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010662; c=relaxed/simple;
	bh=XpLtEMygQUv5qQxguK1Xj2NmhlO9LIr+X9IznbsHnuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZIMLTEpAG2Tos+y85k+iUusLpD8Tcr8r4EZQnapEdjpYpCIohD16E/VNB33VcskdMpUsHgnBmjWcMysTqi1R3vevjrZ7u3pCq4QcH/CgBxjsS2UvK/PwrK6HWU0QgTjkPj2lXxmnOYC7ezZ5iIUvEjQhVxdz0sDgUWW/I8R5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4krK4AT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4krK4AT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783010660; x=1814546660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XpLtEMygQUv5qQxguK1Xj2NmhlO9LIr+X9IznbsHnuk=;
  b=b4krK4AT8mo33W5Dfm7oHEKOCMd+ffEVNURBZzz1YdHl0UuzDM406ZlK
   p2JI/NYT8cuGCEKzzAi77mlBSDyKS3PcSf+igPRcBef/k0gOBkAteEn5L
   1CFfDRsFxeFFgichnoGSh8Um9wIlnm9APbD9UHA8BdEgP8zWDUQR7wyXc
   HyN0VIOgQGRtplVs9X87Hy625vZaM5gTxuurCRm6vmmoh26u08D9YBm6I
   +0YSKTaR00ET7X29nQAuPMJQWteZgmC9JSPFFIpFjxWa9+RwXHiGtv8hS
   RWICR9/STktOsIetVy9yLbGMGl34kbaJ+QlLjzWTJ08ybynJThfViPtMk
   A==;
X-CSE-ConnectionGUID: I+IQpMq+RC+loCadmA/HKw==
X-CSE-MsgGUID: 3KNAsDhhTdOwKCnII6FN6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83819614"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="83819614"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 09:44:19 -0700
X-CSE-ConnectionGUID: gVV7+Y1hQ66QewONqYGrMA==
X-CSE-MsgGUID: jdSNXyR0QrOpfTR9dGpwzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="256804292"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 02 Jul 2026 09:44:15 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: split coredump worker into per-trigger works
Date: Thu,  2 Jul 2026 22:33:59 +0530
Message-ID: <20260702170359.26233-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_coredump_worker() handled three unrelated jobs in one
work item: collect a DRAM trace coredump, read the hardware exception
event, and read the firmware-trigger event. The worker walked three
flag bits at runtime and each interrupt path mutated multiple bits
to communicate which sub-jobs the worker should run, which made the
ownership rules for those bits hard to reason about and entangled
the trigger reason with the in-progress accounting.

Replace the single combined worker with three single-purpose ones,
each owning exactly one flag:

  coredump_work    -> btintel_pcie_dump_traces()
                      guarded by COREDUMP_INPROGRESS
  hwexp_work       -> btintel_pcie_read_hwexp()
                      guarded by CORE_HALTED (already permanent until
                      re-probe; HWEXP_INPROGRESS is now redundant
                      and removed)
  fwtrigger_work   -> btintel_pcie_dump_fwtrigger_event()
                      guarded by FWTRIGGER_DUMP_INPROGRESS

All three workers are queued on a shared ordered workqueue (renamed
coredump_workqueue -> dump_workqueue) so a companion event reader
(hwexp/fwtrigger) and the coredump always run FIFO. Companion work
is queued before coredump_work so dmp_hdr.event_type/event_id are
populated by the time dump_traces() consumes them, preserving the
original ordering.

Introduce btintel_pcie_queue_coredump() to centralize the coredump
trigger contract: it is the single writer of COREDUMP_INPROGRESS and
of dmp_hdr.trigger_reason, sets both atomically against concurrent
triggers, and rolls back the bit if the workqueue is disabled
(reset/remove in progress) so a later trigger after re-probe can
succeed. All four trigger sites (HWEXP IRQ, FW-trigger IRQ,
devcoredump user trigger, resume() D0 error path) go through the
helper.

Per-work guard bits are now cleared at the tail of each worker
rather than in the middle of the combined worker, which closes a
subtle race where a duplicate IRQ could observe a cleared bit and
requeue while the previous pass was still finalizing
dev_coredumpv().

reset_work() and remove() now disable_work_sync() all three workers
and, on the FLR-failure path, enable_work() all three to keep their
disable counters balanced. The PLDR/FLR-success contract (re-probe
re-INIT_WORKs everything with counter 0) is preserved.

No functional change to the dump payloads; this is a pure
restructuring of the worker dispatch and its synchronization.

Signed-off-by: Kiran K <kiran.k@intel.com>
Assisted-by: GitHub-Copilot:claude-4.7-opus
---
 drivers/bluetooth/btintel_pcie.c | 185 ++++++++++++++++++++-----------
 drivers/bluetooth/btintel_pcie.h |  12 +-
 2 files changed, 130 insertions(+), 67 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2b7231be5973..013568197a39 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1446,72 +1446,134 @@ static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
 	return err;
 }
 
+/* Queue a coredump dump_traces() pass.
+ *
+ * Returns true if a new coredump was queued, false if one was already
+ * in-flight (the BTINTEL_PCIE_COREDUMP_INPROGRESS bit serves as the
+ * single-writer guard for the @coredump_work item) or the workqueue is
+ * disabled (reset / remove in progress).
+ *
+ * Always queue this AFTER any companion event-reader work (hwexp /
+ * fwtrigger) so that, on the ordered @dump_workqueue, the event reader
+ * runs first and populates dmp_hdr.event_type / event_id before
+ * dump_traces consumes them.
+ */
+static bool btintel_pcie_queue_coredump(struct btintel_pcie_data *data,
+					u16 trigger_reason)
+{
+	if (test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
+		return false;
+
+	data->dmp_hdr.trigger_reason = trigger_reason;
+
+	if (queue_work(data->dump_workqueue, &data->coredump_work))
+		return true;
+
+	/* Workqueue is disabled (reset/remove drained it). Release the
+	 * guard so a later trigger, after re-probe, can succeed.
+	 */
+	clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
+	return false;
+}
+
 static void btintel_pcie_msix_fw_trigger_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_dbg(data->hdev, "Received firmware smart trigger cause");
 
-	if (test_and_set_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags))
+	/* Per-work guard: deduplicate concurrent FW-trigger interrupts.
+	 * Cleared at the tail of btintel_pcie_fwtrigger_worker().
+	 */
+	if (test_and_set_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
+			     &data->flags))
 		return;
 
-	/* Trigger device core dump when there is FW assert */
-	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
-		data->dmp_hdr.trigger_reason = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
+	if (!queue_work(data->dump_workqueue, &data->fwtrigger_work)) {
+		clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
+		return;
+	}
 
-	queue_work(data->coredump_workqueue, &data->coredump_work);
+	/* Queue coredump after the fwtrigger event reader so dmp_hdr.event_*
+	 * is populated before dump_traces consumes it.
+	 */
+	btintel_pcie_queue_coredump(data, BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT);
 }
 
 static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_err(data->hdev, "Received hw exception interrupt");
 
+	/* CORE_HALTED is the single-writer guard for this handler. It is
+	 * set once on first HW exception and cleared only by re-probe
+	 * (data is reallocated), so it also serializes hwexp_work
+	 * scheduling without needing a separate bit.
+	 */
 	if (test_and_set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
 		return;
 
-	if (test_and_set_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags))
-		return;
-
-	/* Trigger device core dump when there is HW  exception */
-	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
-		data->dmp_hdr.trigger_reason = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
+	/* Queue companion coredump first so it is appended after hwexp_work
+	 * on the ordered @dump_workqueue (preserves the original
+	 * coredump-then-hwexp ordering).
+	 */
+	btintel_pcie_queue_coredump(data, BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT);
 
-	queue_work(data->coredump_workqueue, &data->coredump_work);
+	queue_work(data->dump_workqueue, &data->hwexp_work);
 }
 
 static void btintel_pcie_coredump_worker(struct work_struct *work)
 {
 	struct btintel_pcie_data *data = container_of(work,
 					struct btintel_pcie_data, coredump_work);
-	int err;
 
 	/* hdev is NULL until setup_hdev() succeeds, and is cleared on
 	 * teardown after disable_work_sync() drains us; bail in that case.
 	 */
+	if (!data->hdev)
+		goto out;
+
+	btintel_pcie_dump_traces(data->hdev);
+out:
+	/* Release guard last so a new trigger can run only after this
+	 * pass has fully completed (including dev_coredumpv()).
+	 */
+	clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
+}
+
+static void btintel_pcie_hwexp_worker(struct work_struct *work)
+{
+	struct btintel_pcie_data *data = container_of(work,
+					struct btintel_pcie_data, hwexp_work);
+
 	if (!data->hdev)
 		return;
 
-	if (test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
-		err = btintel_pcie_dump_fwtrigger_event(data);
-		if (err)
-			bt_dev_warn(data->hdev, "failed to log fwtrigger event");
-		clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
-	}
+	/* Unlike usb products, controller will not send hardware exception
+	 * event on exception. Instead controller writes the hardware event
+	 * to device memory along with optional debug events, raises MSIX
+	 * and halts. Driver shall read the exception event from device
+	 * memory and passes it to the stack for further processing.
+	 *
+	 * Re-entry is gated by BTINTEL_PCIE_CORE_HALTED in the IRQ
+	 * handler, which is only cleared by re-probe; no per-work bit
+	 * is needed here.
+	 */
+	btintel_pcie_read_hwexp(data);
+}
 
-	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
-		btintel_pcie_dump_traces(data->hdev);
-		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
-	}
+static void btintel_pcie_fwtrigger_worker(struct work_struct *work)
+{
+	struct btintel_pcie_data *data = container_of(work,
+					struct btintel_pcie_data, fwtrigger_work);
+	int err;
 
-	if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
-		/* Unlike usb products, controller will not send hardware
-		 * exception event on exception. Instead controller writes the
-		 * hardware event to device memory along with optional debug
-		 * events, raises MSIX and halts. Driver shall read the
-		 * exception event from device memory and passes it stack for
-		 * further processing.
-		 */
-		btintel_pcie_read_hwexp(data);
-		clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
-	}
+	if (!data->hdev)
+		goto out;
+
+	err = btintel_pcie_dump_fwtrigger_event(data);
+	if (err)
+		bt_dev_warn(data->hdev, "failed to log fwtrigger event");
+out:
+	/* Release guard last; matches set in fw_trigger handler. */
+	clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
 }
 
 static void btintel_pcie_rx_work(struct work_struct *work)
@@ -2650,20 +2712,22 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	btintel_pcie_synchronize_irqs(data);
 
 	flush_work(&data->rx_work);
-	/* Drain any in-flight coredump and block new ones across reset.
-	 * Safe from self-deadlock: coredump_work runs on a separate wq.
+	/* Drain any in-flight dump workers and block new ones across reset.
+	 * Safe from self-deadlock: they all run on a separate wq.
 	 */
 	disable_work_sync(&data->coredump_work);
+	disable_work_sync(&data->hwexp_work);
+	disable_work_sync(&data->fwtrigger_work);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 
 	/* Both reset paths follow the same contract: on success they
 	 * destroy 'data' via device_reprobe() (a fresh probe re-INIT_WORKs
-	 * the coredump_work with disable count 0), so enable_work() must
+	 * the dump workers with disable count 0), so enable_work() must
 	 * NOT be called on the success path. Only the FLR path can fail
 	 * with 'data' still alive, in which case we balance the
-	 * disable_work_sync() above so a later successful reset is not
-	 * permanently blocked.
+	 * disable_work_sync() calls above so a later successful reset is
+	 * not permanently blocked.
 	 *
 	 * pci_lock_rescan_remove() (held above) serializes against PCI
 	 * device addition/removal (hotplug), so no device can be added to
@@ -2674,8 +2738,11 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		goto out;
 	}
 
-	if (btintel_pcie_perform_flr(data))
+	if (btintel_pcie_perform_flr(data)) {
 		enable_work(&data->coredump_work);
+		enable_work(&data->hwexp_work);
+		enable_work(&data->fwtrigger_work);
+	}
 
 out:
 	pci_dev_put(pdev);
@@ -2869,8 +2936,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	if (!data->workqueue)
 		return -ENOMEM;
 
-	data->coredump_workqueue = alloc_ordered_workqueue(KBUILD_MODNAME "_cd", 0);
-	if (!data->coredump_workqueue) {
+	data->dump_workqueue = alloc_ordered_workqueue(KBUILD_MODNAME "_cd", 0);
+	if (!data->dump_workqueue) {
 		destroy_workqueue(data->workqueue);
 		return -ENOMEM;
 	}
@@ -2879,6 +2946,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
 	INIT_WORK(&data->reset_work, btintel_pcie_reset_work);
 	INIT_WORK(&data->coredump_work, btintel_pcie_coredump_worker);
+	INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_worker);
+	INIT_WORK(&data->fwtrigger_work, btintel_pcie_fwtrigger_worker);
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
@@ -2921,7 +2990,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
 
-	destroy_workqueue(data->coredump_workqueue);
+	destroy_workqueue(data->dump_workqueue);
 
 	pci_clear_master(pdev);
 
@@ -2940,12 +3009,14 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 		return;
 	}
 
-	/* Permanently block coredump triggers and drain the worker before
-	 * tearing down. Must run before cancel_work_sync(&reset_work) so
-	 * the disable counter stays >= 1 even after reset_work()'s
+	/* Permanently block all dump triggers and drain the workers before
+	 * tearing down. Must run before disable_work_sync(&reset_work) so
+	 * the disable counters stay >= 1 even after reset_work()'s
 	 * balanced enable_work() (counter 2 -> 1, never reaching 0).
 	 */
 	disable_work_sync(&data->coredump_work);
+	disable_work_sync(&data->hwexp_work);
+	disable_work_sync(&data->fwtrigger_work);
 
 	/* Cancel pending reset work. Skip only when remove() is called from
 	 * within the reset work itself (PLDR device_reprobe path) to avoid
@@ -2973,7 +3044,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	btintel_pcie_release_hdev(data);
 
-	destroy_workqueue(data->coredump_workqueue);
+	destroy_workqueue(data->dump_workqueue);
 	destroy_workqueue(data->workqueue);
 
 	btintel_pcie_free(data);
@@ -2992,16 +3063,8 @@ static void btintel_pcie_coredump(struct device *dev)
 	if (!data)
 		return;
 
-	if (test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
-		return;
-
-	data->dmp_hdr.trigger_reason  = BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER;
-	/* queue_work() returns false if the work is disabled (reset or
-	 * remove in progress); clear the in-progress bit so a later
-	 * trigger can succeed once the work is re-enabled.
-	 */
-	if (!queue_work(data->coredump_workqueue, &data->coredump_work))
-		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
+	btintel_pcie_queue_coredump(data,
+				    BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER);
 }
 #endif
 
@@ -3138,12 +3201,8 @@ static int btintel_pcie_resume(struct device *dev)
 	if (btintel_pcie_in_error(data) ||
 			btintel_pcie_in_device_halt(data)) {
 		bt_dev_err(data->hdev, "Controller in error state for D0 entry");
-		if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS,
-				      &data->flags)) {
-			data->dmp_hdr.trigger_reason =
-				BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
-			queue_work(data->coredump_workqueue, &data->coredump_work);
-		}
+		btintel_pcie_queue_coredump(data,
+					    BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT);
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
 		btintel_pcie_reset(data->hdev);
 	}
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 7caee093e316..749369b24031 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -118,7 +118,6 @@ enum {
 
 enum {
 	BTINTEL_PCIE_CORE_HALTED,
-	BTINTEL_PCIE_HWEXP_INPROGRESS,
 	BTINTEL_PCIE_COREDUMP_INPROGRESS,
 	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
 	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
@@ -466,8 +465,11 @@ struct btintel_pcie_dump_header {
  * @workqueue: workqueue for RX work
  * @rx_skb_q: SKB queue for RX packet
  * @rx_work: RX work struct to process the RX packet in @rx_skb_q
- * @coredump_workqueue: dedicated workqueue for coredump collection
- * @coredump_work: work struct for coredump trace collection
+ * @dump_workqueue: dedicated ordered workqueue serializing the coredump,
+ *	hardware exception, and firmware-trigger dump workers
+ * @coredump_work: work struct for DRAM trace coredump collection
+ * @hwexp_work: work struct for hardware exception event read
+ * @fwtrigger_work: work struct for firmware-triggered diagnostic event read
  * @dma_pool: DMA pool for descriptors, index array and ci
  * @dma_p_addr: DMA address for pool
  * @dma_v_addr: address of pool
@@ -516,8 +518,10 @@ struct btintel_pcie_data {
 	struct work_struct	rx_work;
 	struct work_struct      reset_work;
 
-	struct workqueue_struct	*coredump_workqueue;
+	struct workqueue_struct	*dump_workqueue;
 	struct work_struct	coredump_work;
+	struct work_struct	hwexp_work;
+	struct work_struct	fwtrigger_work;
 
 	struct dma_pool	*dma_pool;
 	dma_addr_t	dma_p_addr;
-- 
2.54.0

