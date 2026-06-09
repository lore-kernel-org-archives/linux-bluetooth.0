Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAF36607C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018812; cv=none; b=s7kjp115XTSKKGKudXzsnJOrHi+rTZAJrdjsHte9QFZlaI/Ip2f5Bob2SH43p2BjBWwtusX5L90nxezwKOKSQrAwUjabY4eUWz/jN5EDjCFliDOnnTly+fw7y3hBnxcA6D5RT80LdAZPZes6BYjiUZtTjMTyLich5PFOezjtv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018812; c=relaxed/simple;
	bh=XvTOFV29SWbnesRKDUige8PyVzffMAoHH/nmjwD1SeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfDFzciSFY4QNgZ4HKgZKVv4ctYBAEtKy70HQPALLPV2hS4s5Nh5w9cWTXq1KzfjWykRd6Idb0wyIi+7NbsptaaBiiqkVfRRA6Ffldl787wZ2yGh+ZP/bo8M/+VX1TqpknYry7UyslAHAlcuwVb7b7zOHHDR1Caw3lPvOyloJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNmRlzUN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNmRlzUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781018810; x=1812554810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XvTOFV29SWbnesRKDUige8PyVzffMAoHH/nmjwD1SeU=;
  b=VNmRlzUN+lyzZ/z3lOn1Jc1nWGQTIBwLe6sI8B2hhzwRSZBzv4tXJ+Gf
   uLJHFc3NRPQF9d/kvWMMQoDcAkQOr8HxsIxVk/mKlxV/wmA03Sf/smE+i
   7C+OGGYt4Nbae9idkyZ10EKCuORE7DAiXX3kwT93KbiAKRyyygOvnVH3U
   rVsrCPGgM0wElZapLHjjJkW0j7dxCEJ+k1cBcL1y9Wp7V85y7vdw+y6BA
   S6Ti4zRMUDhkhudQxA/mnzsSK+2cfh1SK5BiP29ChO3RH6n8TCNBw7v/n
   kxiUqKML9l9t/EKGlJVpa1GdaaNMVLs7ScBpp6BfSGs2A+RC1Z8SCw7ZB
   w==;
X-CSE-ConnectionGUID: ztXkfLkEQDyt+DvE3daRrw==
X-CSE-MsgGUID: rwqEE7pFS6Ohy7VnS1gOHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85406459"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="85406459"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:26:50 -0700
X-CSE-ConnectionGUID: YKtOGuDWRLqcS7P1MeFxeA==
X-CSE-MsgGUID: 9fh+0UxlQCS4GwSDY1V1cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="242933418"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jun 2026 08:26:48 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	ravindra@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Separate coredump work from RX work
Date: Tue,  9 Jun 2026 21:16:17 +0530
Message-ID: <20260609154617.218747-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravindra <ravindra@intel.com>

Sharing a single workqueue between coredump processing and RX
delays evacuation of RX events while a coredump is in progress.
The firmware's RX buffers can overflow during that window, leading
to dropped events. The issue was observed in HID use cases where
HID reports arrive in bursts and quickly fill the RX path while a
coredump is being collected.

Move coredump processing to a dedicated ordered coredump_workqueue
with its own coredump_work, so coredumps run independently of RX.
All four coredump trigger sources (FW assert, HW exception, user
sysfs trigger, and resume-error detection) are switched to this new
workqueue. Ordering serialises concurrent triggers without blocking
RX.

Signed-off-by: Ravindra <ravindra@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 86 ++++++++++++++++++++++++++------
 drivers/bluetooth/btintel_pcie.h |  5 ++
 2 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2baef130d101..fbc7b10cdfe3 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1426,7 +1426,7 @@ static void btintel_pcie_msix_fw_trigger_handler(struct btintel_pcie_data *data)
 	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
 		data->dmp_hdr.trigger_reason = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
 
-	queue_work(data->workqueue, &data->rx_work);
+	queue_work(data->coredump_workqueue, &data->coredump_work);
 }
 
 static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
@@ -1443,16 +1443,21 @@ static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
 		data->dmp_hdr.trigger_reason = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
 
-	queue_work(data->workqueue, &data->rx_work);
+	queue_work(data->coredump_workqueue, &data->coredump_work);
 }
 
-static void btintel_pcie_rx_work(struct work_struct *work)
+static void btintel_pcie_coredump_worker(struct work_struct *work)
 {
 	struct btintel_pcie_data *data = container_of(work,
-					struct btintel_pcie_data, rx_work);
-	struct sk_buff *skb;
+					struct btintel_pcie_data, coredump_work);
 	int err;
 
+	/* hdev is NULL until setup_hdev() succeeds, and is cleared on
+	 * teardown after disable_work_sync() drains us; bail in that case.
+	 */
+	if (!data->hdev)
+		return;
+
 	if (test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
 		err = btintel_pcie_dump_fwtrigger_event(data);
 		if (err)
@@ -1476,6 +1481,13 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 		btintel_pcie_read_hwexp(data);
 		clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
 	}
+}
+
+static void btintel_pcie_rx_work(struct work_struct *work)
+{
+	struct btintel_pcie_data *data = container_of(work,
+					struct btintel_pcie_data, rx_work);
+	struct sk_buff *skb;
 
 	/* Process the sk_buf in queue and send to the HCI layer */
 	while ((skb = skb_dequeue(&data->rx_skb_q))) {
@@ -2572,6 +2584,10 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	btintel_pcie_synchronize_irqs(data);
 
 	flush_work(&data->rx_work);
+	/* Drain any in-flight coredump and block new ones across reset.
+	 * Safe from self-deadlock: coredump_work runs on a separate wq.
+	 */
+	disable_work_sync(&data->coredump_work);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR) {
@@ -2579,6 +2595,11 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		 * pci_rescan_remove_lock. This mutex serializes against PCI device
 		 * addition/removal (hotplug), so no device can be added to or
 		 * removed from the bus list while this code runs.
+		 *
+		 * device_reprobe() inside btintel_pcie_perform_pldr() destroys
+		 * 'data' via .remove(); a fresh probe re-INIT_WORKs the
+		 * coredump_work with disable count 0, so we must not call
+		 * enable_work() on this path.
 		 */
 		btintel_pcie_perform_pldr(data);
 		goto out;
@@ -2588,7 +2609,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	err = pci_reset_function(pdev);
 	if (err) {
 		BT_ERR("Failed resetting the pcie device (%d)", err);
-		goto out;
+		goto out_enable;
 	}
 
 	btintel_pcie_enable_interrupts(data);
@@ -2598,7 +2619,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	if (err) {
 		BT_ERR("Failed to enable bluetooth hardware after reset (%d)",
 		       err);
-		goto out;
+		goto out_enable;
 	}
 
 	btintel_pcie_reset_ia(data);
@@ -2608,8 +2629,15 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	err = btintel_pcie_setup_hdev(data);
 	if (err) {
 		BT_ERR("Failed registering hdev (%d)", err);
-		goto out;
+		goto out_enable;
 	}
+
+out_enable:
+	/* Balance disable_work_sync() above on every exit. Leaving the
+	 * counter incremented on a failed reset would permanently disable
+	 * coredump_work even after a later successful reset.
+	 */
+	enable_work(&data->coredump_work);
 out:
 	pci_dev_put(pdev);
 	pci_unlock_rescan_remove();
@@ -2743,7 +2771,6 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->bus = HCI_PCI;
 	hci_set_drvdata(hdev, data);
 
-	data->hdev = hdev;
 	SET_HCIDEV_DEV(hdev, &data->pdev->dev);
 
 	hdev->manufacturer = 2;
@@ -2762,15 +2789,17 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		BT_ERR("Failed to register to hdev (%d)", err);
-		goto exit_error;
+		hci_free_dev(hdev);
+		return err;
 	}
 
+	/* Publish hdev only after successful registration; the coredump
+	 * worker bails on !data->hdev, so it never observes a half-set-up
+	 * device.
+	 */
+	data->hdev = hdev;
 	data->dmp_hdr.driver_name = KBUILD_MODNAME;
 	return 0;
-
-exit_error:
-	hci_free_dev(hdev);
-	return err;
 }
 
 static int btintel_pcie_probe(struct pci_dev *pdev,
@@ -2801,9 +2830,16 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	if (!data->workqueue)
 		return -ENOMEM;
 
+	data->coredump_workqueue = alloc_ordered_workqueue(KBUILD_MODNAME "_cd", 0);
+	if (!data->coredump_workqueue) {
+		destroy_workqueue(data->workqueue);
+		return -ENOMEM;
+	}
+
 	skb_queue_head_init(&data->rx_skb_q);
 	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
 	INIT_WORK(&data->reset_work, btintel_pcie_reset_work);
+	INIT_WORK(&data->coredump_work, btintel_pcie_coredump_worker);
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
@@ -2846,6 +2882,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
 
+	destroy_workqueue(data->coredump_workqueue);
+
 	pci_clear_master(pdev);
 
 	pci_set_drvdata(pdev, NULL);
@@ -2863,6 +2901,13 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 		return;
 	}
 
+	/* Permanently block coredump triggers and drain the worker before
+	 * tearing down. Must run before cancel_work_sync(&reset_work) so
+	 * the disable counter stays >= 1 even after reset_work()'s
+	 * balanced enable_work() (counter 2 -> 1, never reaching 0).
+	 */
+	disable_work_sync(&data->coredump_work);
+
 	/* Cancel pending reset work. Skip only when remove() is called from
 	 * within the reset work itself (PLDR device_reprobe path) to avoid
 	 * deadlock. current_work() returns the work_struct of the caller if
@@ -2889,6 +2934,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	btintel_pcie_release_hdev(data);
 
+	destroy_workqueue(data->coredump_workqueue);
 	destroy_workqueue(data->workqueue);
 
 	btintel_pcie_free(data);
@@ -2904,11 +2950,19 @@ static void btintel_pcie_coredump(struct device *dev)
 	struct  pci_dev *pdev = to_pci_dev(dev);
 	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
 
+	if (!data)
+		return;
+
 	if (test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
 		return;
 
 	data->dmp_hdr.trigger_reason  = BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER;
-	queue_work(data->workqueue, &data->rx_work);
+	/* queue_work() returns false if the work is disabled (reset or
+	 * remove in progress); clear the in-progress bit so a later
+	 * trigger can succeed once the work is re-enabled.
+	 */
+	if (!queue_work(data->coredump_workqueue, &data->coredump_work))
+		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
 }
 #endif
 
@@ -3049,7 +3103,7 @@ static int btintel_pcie_resume(struct device *dev)
 				      &data->flags)) {
 			data->dmp_hdr.trigger_reason =
 				BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
-			queue_work(data->workqueue, &data->rx_work);
+			queue_work(data->coredump_workqueue, &data->coredump_work);
 		}
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
 		btintel_pcie_reset(data->hdev);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index cae84b00a700..b81f933e2315 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -462,6 +462,8 @@ struct btintel_pcie_dump_header {
  * @workqueue: workqueue for RX work
  * @rx_skb_q: SKB queue for RX packet
  * @rx_work: RX work struct to process the RX packet in @rx_skb_q
+ * @coredump_workqueue: dedicated workqueue for coredump collection
+ * @coredump_work: work struct for coredump trace collection
  * @dma_pool: DMA pool for descriptors, index array and ci
  * @dma_p_addr: DMA address for pool
  * @dma_v_addr: address of pool
@@ -510,6 +512,9 @@ struct btintel_pcie_data {
 	struct work_struct	rx_work;
 	struct work_struct      reset_work;
 
+	struct workqueue_struct	*coredump_workqueue;
+	struct work_struct	coredump_work;
+
 	struct dma_pool	*dma_pool;
 	dma_addr_t	dma_p_addr;
 	void		*dma_v_addr;
-- 
2.54.0

