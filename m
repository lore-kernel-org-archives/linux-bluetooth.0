Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787A47D92D
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037895; cv=none; b=QfIP9wUs4eEEctdz1KxSmCkKVFwG4AAUvatbTFUfPyQdT6ekgdmzKWzjlr7XjhM3fJBs6VKPfRYCEy1SGdiHUE4z4BE8ErDxmYSNrRcswiEqqILJj2S8uaBJ7HTVsY7/V/OIC3W64mPGHYqv9Ti+KDzzWwHfEv0RG8+nuQKg/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037895; c=relaxed/simple;
	bh=aczmG7/khz/S5sDnKpZ536JNBfsAfiydQvXTne6gqYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haCG8qsmiqzC7KpuTOCZSOHsBIOApsRbmSbU/K3Gullxl7oLY9SUmp5eIhtgyjzAH/3x/5TPUF9MGCxOfFpnTHKG/cqwBtgToTF3VdZjs5OQJKMkULGlivNz6wDO3cCUZHVLUc2GcVMVvFdZr5odwYfN5kmb257spMIPOAG196k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jymbgm0d; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jymbgm0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037891; x=1815573891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aczmG7/khz/S5sDnKpZ536JNBfsAfiydQvXTne6gqYI=;
  b=jymbgm0dR1B9VAiqGd91FClHcKGbs6QosTP9dB9NG1q8ZB5pcjkhpkbE
   MbQbB1V+dQz0EO3GXzLCmacRyEdDSbpC88CZFYdiD44vwowOKPnL6n5/D
   eQePaDj0xXaF9D3bpJAqzHJrbwOVU6bOvk6Ejv+wRkSHWbjcLyTFvo5SE
   3zyORkgIq6CGLQulx185i9eYwWvQa/vJvAXLa5nwY/6wK99XYPbFuShMZ
   udSsZlt1xWgOf5CT6f2pKeJgdkLCxiSPifqjT388+UFo9TykpIYqnnUqf
   FmvtbBDKWmOy0CDoDdZyLycFCmblPhBeDnhx9K9XX6Z4BhxLhhPQ+KPpr
   g==;
X-CSE-ConnectionGUID: k3Ve8p7nSFOdXY6064RKRg==
X-CSE-MsgGUID: ICTN2aacQdO464Klp4gCiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84445058"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84445058"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:04:49 -0700
X-CSE-ConnectionGUID: DS7KirjKRuaMdBbTb4ocxw==
X-CSE-MsgGUID: 9euRofwzSF6Y63y6Nih41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="251911113"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jul 2026 07:04:47 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS
Date: Tue, 14 Jul 2026 19:54:30 +0530
Message-ID: <20260714142430.200689-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset path had two concurrency holes. Both are reachable in
practice when btintel_pcie_hw_error() is invoked from the HCI rx
path while another reset is being requested or is already in
flight.

  1. data->reset_type was a plain shared field. The hw_error path
     wrote it BEFORE the test_and_set_bit(RECOVERY_IN_PROGRESS)
     guard inside btintel_pcie_reset(), so a second hw_error could
     clobber the type chosen by an earlier in-flight request:

       CPU0 (reset_work)             CPU1 (hw_error #2)
                                     dev_data->reset_type = PLDR
       T2: read reset_type
                                     dev_data->reset_type = FLR
                                     reset() test_and_set sees 1
                                     -> drops, but type already
                                        clobbered

     The HCI reset path (.reset = btintel_pcie_reset, used by
     HCIDEVRESET / `hciconfig hciX reset`) compounded this by not
     writing reset_type at all -- it inherited whatever value a
     previous hw_error / resume() had left, which could be PLDR.

  2. btintel_pcie_dump_debug_registers() was called unconditionally
     at the top of hw_error(). When reset_work was already running
     pci_try_reset_function(), the BT MMIO window can read all-1s
     or trigger AER for the duration of the FLR, polluting the
     debug dump with no useful information.

Refactor the reset path to make RECOVERY_IN_PROGRESS the sole
serializer for both the type write and the work scheduling:

  - Replace btintel_pcie_reset(hdev) with
    btintel_pcie_request_reset(data, type). The helper takes the
    desired reset variant as a parameter and writes
    data->reset_type only after winning test_and_set_bit(); losers
    return without touching the field, so concurrent triggers can
    no longer clobber an in-flight reset's type. reset_work()'s
    read of reset_type is now ordered after the bit transition via
    schedule_work()'s memory barrier.

  - Add a thin btintel_pcie_hci_reset() wrapper for the
    hdev->reset callback that always requests FLR explicitly. The
    HCIDEVRESET path no longer inherits stale state from prior
    error events.

  - Add an early test_bit(RECOVERY_IN_PROGRESS) gate at the top of
    hw_error() so dump_debug_registers() and the recovery-counter
    bookkeeping are skipped when a reset is already in flight; the
    authoritative test_and_set lives in request_reset() and races
    cleanly against any caller that passes the optimistic check.

  - Convert the two resume() reset sites (FREEZE/HIBERNATE and the
    D0-error path) to request_reset(data, FLR), removing the
    redundant manual reset_type writes.

No new locks are introduced; the fix relies on the existing
RECOVERY_IN_PROGRESS bit transition for ordering.

Assisted-by: GitHub-Copilot:claude-4.7-opus
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 88 +++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 013568197a39..2a10476bae4b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2550,8 +2550,6 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 	}
 }
 
-static void btintel_pcie_reset(struct hci_dev *hdev);
-
 static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 {
 	union acpi_object *obj, argv4;
@@ -2749,56 +2747,99 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	pci_unlock_rescan_remove();
 }
 
-static void btintel_pcie_reset(struct hci_dev *hdev)
+/* Schedule a device reset of the requested type.
+ *
+ * BTINTEL_PCIE_RECOVERY_IN_PROGRESS serializes all reset requesters
+ * (HCI ioctl, hw_error, resume error path, etc.) so that:
+ *
+ *   - dev_data->reset_type is written by exactly one caller (the
+ *     thread that wins test_and_set_bit), eliminating the race where
+ *     a second hw_error could clobber an already-scheduled reset's
+ *     type;
+ *   - the write happens AFTER the bit is set, so reset_work observes
+ *     it through schedule_work()'s memory ordering;
+ *   - losers return without touching reset_type or scheduling the
+ *     work, so concurrent triggers are silently coalesced into the
+ *     in-flight one (whose recovery will reinitialize the device
+ *     regardless of the dropped trigger's variant).
+ *
+ * The bit is cleared only by .remove() / re-probe via fresh devm
+ * allocation, which is the intended one-shot semantics: a reset
+ * tears down and re-probes 'data', so there is no "in-flight"
+ * reset to follow up after device_reprobe() succeeds.
+ */
+static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
+				       enum btintel_pcie_reset_type type)
 {
-	struct btintel_pcie_data *data;
-
-	data = hci_get_drvdata(hdev);
-
 	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
 		return;
 
 	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
 		return;
 
+	data->reset_type = type;
+
 	pci_dev_get(data->pdev);
 	schedule_work(&data->reset_work);
 }
 
+/* hdev->reset callback (HCIDEVRESET ioctl, e.g. `hciconfig hciX reset`).
+ *
+ * User-triggered resets always use FLR; PLDR is reserved for the
+ * hw_error path (controller-reported fatal exceptions, code 0x13).
+ */
+static void btintel_pcie_hci_reset(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
+	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
+}
+
 static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 {
-	struct btintel_pcie_dev_recovery *data;
+	struct btintel_pcie_dev_recovery *rec;
 	struct btintel_pcie_data *dev_data = hci_get_drvdata(hdev);
 	struct pci_dev *pdev = dev_data->pdev;
+	enum btintel_pcie_reset_type type;
 	time64_t retry_window;
 
+	/* Cheap pre-check: if a reset is already in flight, skip MMIO
+	 * reads in dump_debug_registers() and the recovery-counter
+	 * bookkeeping entirely. The PCI core may be mid-FLR (BME / config
+	 * window torn down by pci_try_reset_function()), in which case
+	 * those reads return all-1s or trigger AER. The authoritative
+	 * guard is the test_and_set_bit() inside
+	 * btintel_pcie_request_reset(), which races cleanly against
+	 * concurrent triggers that pass this check.
+	 */
+	if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &dev_data->flags))
+		return;
+
 	btintel_pcie_dump_debug_registers(hdev);
 
-	data = btintel_pcie_get_recovery(pdev, &hdev->dev);
-	if (!data)
+	rec = btintel_pcie_get_recovery(pdev, &hdev->dev);
+	if (!rec)
 		return;
 
-	if (code == 0x13)
-		dev_data->reset_type = BTINTEL_PCIE_IOSF_PRR_PLDR;
-	else
-		dev_data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
+	type = (code == 0x13) ? BTINTEL_PCIE_IOSF_PRR_PLDR
+			      : BTINTEL_PCIE_IOSF_PRR_FLR;
 
 	bt_dev_err(hdev, "Encountered exception err:0x%x triggering: %s", code,
-		   dev_data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR");
-	retry_window = ktime_get_boottime_seconds() - data->last_error;
+		   type == BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR");
+	retry_window = ktime_get_boottime_seconds() - rec->last_error;
 
 	if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
-	    data->count >= BTINTEL_PCIE_FLR_MAX_RETRY) {
+	    rec->count >= BTINTEL_PCIE_FLR_MAX_RETRY) {
 		bt_dev_err(hdev, "Exhausted maximum: %d recovery attempts: %d",
-			   BTINTEL_PCIE_FLR_MAX_RETRY, data->count);
+			   BTINTEL_PCIE_FLR_MAX_RETRY, rec->count);
 		bt_dev_dbg(hdev, "Boot time: %lld seconds",
 			   ktime_get_boottime_seconds());
 		bt_dev_dbg(hdev, "last error at: %lld seconds",
-			   data->last_error);
+			   rec->last_error);
 		return;
 	}
 	btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
-	btintel_pcie_reset(hdev);
+	btintel_pcie_request_reset(dev_data, type);
 }
 
 static bool btintel_pcie_wakeup(struct hci_dev *hdev)
@@ -2888,7 +2929,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->hw_error = btintel_pcie_hw_error;
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
-	hdev->reset = btintel_pcie_reset;
+	hdev->reset = btintel_pcie_hci_reset;
 	hdev->wakeup = btintel_pcie_wakeup;
 	hdev->hci_drv = &btintel_pcie_hci_drv;
 
@@ -3176,8 +3217,7 @@ static int btintel_pcie_resume(struct device *dev)
 	if (data->pm_sx_event == PM_EVENT_FREEZE ||
 	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
-		data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
-		btintel_pcie_reset(data->hdev);
+		btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
 		return 0;
 	}
 
@@ -3204,7 +3244,7 @@ static int btintel_pcie_resume(struct device *dev)
 		btintel_pcie_queue_coredump(data,
 					    BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT);
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
-		btintel_pcie_reset(data->hdev);
+		btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
 	}
 	return err;
 }
-- 
2.54.0

