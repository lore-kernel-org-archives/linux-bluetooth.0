Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE83BED19
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837593; cv=none; b=LzIgsZuJTEuokGY+Wg/JTVvgUVcYnu1HWw3lwMjJHmPs/gbz3ekAonsWglSQztOa9wH1r5wr0YoF1g7f2whs9E/1Fguk5GpoYB+kPl3C7GkIo2NLpVArCh8mJdykcJD9PT/Kxnm/JBaNiDQmRaamZYvT5AaMw/QjSBagUL5mKdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837593; c=relaxed/simple;
	bh=ckn/7AjmZu/yo01kvgts+dW8ZLXmN7SKS735zQqygp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQ9cmp2BQDnfQs3qTBBxllfFpoCe4kV4fOK7QHE/ptqnLRp8Ik5Iaex9JpquWlCHanEwKZyyygQ6UC+1bAIegBrfw7LZvX1nIJMNpUmOVNhLx1rCR4DmqL0sfJWdLJYzB3KT96cJ7M5dtcb7W3Pf0XXfFL2iqtY6bEj5t3ulReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fz3mhByC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fz3mhByC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782837591; x=1814373591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ckn/7AjmZu/yo01kvgts+dW8ZLXmN7SKS735zQqygp8=;
  b=Fz3mhByCSG9vplP7v5m/UPjCrSYh7Q6JzEbaoORroLqcRTwIwdpYKfk9
   AewzgdoqbT6C6sSrro0clcg3QARJUJhv7UpV0Y2QsSkD/ruYsEUOhVmX6
   B9L7qhK3A+sMU/X4uV2Mdrgq8117AeG1t6GE7/SWVvNyHUJbgrd827FDi
   4U/K0aODMEDRIsmlNvj47cDxgWaTBF2FsZWXdR82lBVrB19EgOjmeKjc4
   SqorIi907z4aZJ1GIePK/AAmTDxJNuwONCyI+pS3dhf7x9uc5UqiiQKuv
   jnLQEi4C7Jz5Bkp5w0XSNXgWuUw5GqSFAi0EzfFyXAFl+LIIdIxhkzqaN
   g==;
X-CSE-ConnectionGUID: toJEpapYTS+Y1avJaBbE6w==
X-CSE-MsgGUID: X1ZTIZQ6T+iHmXRyt9OAug==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94157449"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="94157449"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:39:51 -0700
X-CSE-ConnectionGUID: h4BmhhwWQ1q3VD+zu6XIGg==
X-CSE-MsgGUID: OihZC9g3Q6ayvHoDHVSpTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="282371461"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 30 Jun 2026 09:39:48 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()
Date: Tue, 30 Jun 2026 22:29:19 +0530
Message-ID: <20260630165919.102803-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FLR branch in btintel_pcie_reset_work() open-coded the entire
re-init sequence: btintel_pcie_release_hdev() (hci_unregister_dev +
hci_free_dev), pci_try_reset_function(), enable_interrupts /
config_msix / enable_bt / reset_ia / start_rx, then
btintel_pcie_setup_hdev() (hci_alloc_dev_priv + hci_register_dev).
Every probe() init step had to be kept in sync with this second
copy in the reset path, and any failure mid-sequence left state to
unwind by hand.

The PLDR path already delegates teardown and re-init to the PCI
core via device_reprobe(): .remove() destroys data through devres
and unregisters hdev, then .probe() rebuilds everything from
scratch. Apply the same model to FLR.

Introduce btintel_pcie_perform_flr() mirroring perform_pldr(). It
runs pci_try_reset_function() (required to avoid the device_lock
ABBA against btintel_pcie_remove(), which calls
disable_work_sync(&reset_work) while holding device_lock) followed
by device_reprobe(). On success, data is destroyed and a fresh
probe re-INIT_WORKs coredump_work with disable count 0, so
enable_work() must not be called; on failure, data is still alive
and the caller balances the earlier disable_work_sync(). The
contract is documented on the helper and reiterated at the
reset_work() call site.

reset_work() shrinks to interrupt/worker drain, dispatch on
reset_type, and the single asymmetry between the two paths. The
out_enable label, the manual unregister/register pair, and the
forward declaration of btintel_pcie_setup_hdev() are dropped.

No intended functional change; FLR and PLDR now share one
teardown contract.

Fixes: 256ab9520d15 ("Bluetooth: btintel_pcie: Support Function level reset")
Assisted-by: GitHub-Copilot:claude-4.7-opus
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 102 ++++++++++++++++---------------
 1 file changed, 52 insertions(+), 50 deletions(-)

Changes in v2:
- Let btintel_pcie_send_frame() function return immediately if recovery
  in progress to avoid accessing MMIO registers when reset_work() is
  trying to reset and reprobe the device

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9e39327dc1fe..2b7231be5973 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2127,6 +2127,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
 		return -ENODEV;
 
+	if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
+		return -ENODEV;
+
 	/* Due to the fw limitation, the type header of the packet should be
 	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
 	 * the first byte to get the packet type and redirect the rest of data
@@ -2485,7 +2488,6 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 	}
 }
 
-static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
 static void btintel_pcie_reset(struct hci_dev *hdev);
 
 static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
@@ -2596,12 +2598,45 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 	}
 }
 
+/*
+ * Issue a Function Level Reset and hand teardown/re-init off to the PCI
+ * core via device_reprobe(), mirroring the PLDR path's contract.
+ *
+ * Caller must hold pci_lock_rescan_remove() and must have already
+ * disabled interrupts and drained both rx_work and coredump_work.
+ */
+static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
+{
+	struct pci_dev *pdev = data->pdev;
+	int err;
+
+	/* pci_try_reset_function() avoids the device_lock ABBA against
+	 * btintel_pcie_remove(): .remove() runs with device_lock held and
+	 * then waits for this work via disable_work_sync(); the blocking
+	 * pci_reset_function() would deadlock by trying to re-acquire
+	 * device_lock here.
+	 */
+	err = pci_try_reset_function(pdev);
+	if (err) {
+		BT_ERR("Failed resetting the pcie device (%d)", err);
+		return err;
+	}
+
+	/* device_reprobe() always detaches the driver first (running
+	 * .remove(), which frees 'data'); any re-probe failure leaves the
+	 * device unbound but 'data' is already gone, so just log it.
+	 */
+	if (device_reprobe(&pdev->dev))
+		BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
+
+	return 0;
+}
+
 static void btintel_pcie_reset_work(struct work_struct *wk)
 {
 	struct btintel_pcie_data *data =
 		container_of(wk, struct btintel_pcie_data, reset_work);
 	struct pci_dev *pdev = data->pdev;
-	int err;
 
 	pci_lock_rescan_remove();
 
@@ -2621,60 +2656,27 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	disable_work_sync(&data->coredump_work);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
+
+	/* Both reset paths follow the same contract: on success they
+	 * destroy 'data' via device_reprobe() (a fresh probe re-INIT_WORKs
+	 * the coredump_work with disable count 0), so enable_work() must
+	 * NOT be called on the success path. Only the FLR path can fail
+	 * with 'data' still alive, in which case we balance the
+	 * disable_work_sync() above so a later successful reset is not
+	 * permanently blocked.
+	 *
+	 * pci_lock_rescan_remove() (held above) serializes against PCI
+	 * device addition/removal (hotplug), so no device can be added to
+	 * or removed from the bus list while this code runs.
+	 */
 	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR) {
-		/* This function holds pci_lock_rescan_remove(), which acquires
-		 * pci_rescan_remove_lock. This mutex serializes against PCI device
-		 * addition/removal (hotplug), so no device can be added to or
-		 * removed from the bus list while this code runs.
-		 *
-		 * device_reprobe() inside btintel_pcie_perform_pldr() destroys
-		 * 'data' via .remove(); a fresh probe re-INIT_WORKs the
-		 * coredump_work with disable count 0, so we must not call
-		 * enable_work() on this path.
-		 */
 		btintel_pcie_perform_pldr(data);
 		goto out;
 	}
-	btintel_pcie_release_hdev(data);
-
-	/* Use pci_try_reset_function() rather than pci_reset_function() to
-	 * avoid an ABBA deadlock against btintel_pcie_remove(): the PCI core
-	 * calls .remove() with device_lock held, and remove() then waits for
-	 * this work via cancel_work_sync(); pci_reset_function() would in
-	 * turn try to acquire the same device_lock, deadlocking both paths.
-	 */
-	err = pci_try_reset_function(pdev);
-	if (err) {
-		BT_ERR("Failed resetting the pcie device (%d)", err);
-		goto out_enable;
-	}
 
-	btintel_pcie_enable_interrupts(data);
-	btintel_pcie_config_msix(data);
-
-	err = btintel_pcie_enable_bt(data);
-	if (err) {
-		BT_ERR("Failed to enable bluetooth hardware after reset (%d)",
-		       err);
-		goto out_enable;
-	}
-
-	btintel_pcie_reset_ia(data);
-	btintel_pcie_start_rx(data);
-	data->flags = 0;
+	if (btintel_pcie_perform_flr(data))
+		enable_work(&data->coredump_work);
 
-	err = btintel_pcie_setup_hdev(data);
-	if (err) {
-		BT_ERR("Failed registering hdev (%d)", err);
-		goto out_enable;
-	}
-
-out_enable:
-	/* Balance disable_work_sync() above on every exit. Leaving the
-	 * counter incremented on a failed reset would permanently disable
-	 * coredump_work even after a later successful reset.
-	 */
-	enable_work(&data->coredump_work);
 out:
 	pci_dev_put(pdev);
 	pci_unlock_rescan_remove();
-- 
2.54.0

