Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E6332638
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131099; cv=none; b=PZnSFFIhr1DhWYV0kFqG6E7264aK74AAwYomYDH/I3WlBYGqD+QcfaK3NbKXApfHlvVdpsYdhou2ZAe1wAEeAQ9GSzViWmkY2VhRZUmJbsblIbhYPpVEzZiIzwsQu42GHvppgPdaTqRsKCpBvrOf9KDSpaCZVgrZ54SCPpecxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131099; c=relaxed/simple;
	bh=gkFVR+bLtw7X6xaoYtwEZ+fp99LDMlY5xhkrtrHgrG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzA9R5g9dDevV2CJYyz2Mj+hstijjYYuLud3lCJClXzSM8jWQlbaymQOAL9h6q+rWFqxEARiJC/dVKb9jpufwUmkwvB2uD6AZ0E2Hf7NP69JU9SflTgWyrL/6nW4KdCMmLEL28/W7WK8zn5m9s/i/LvqwPMSo4LFtAnmlCMRfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIU9Y8Zc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIU9Y8Zc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784131098; x=1815667098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gkFVR+bLtw7X6xaoYtwEZ+fp99LDMlY5xhkrtrHgrG8=;
  b=FIU9Y8ZckNxaDLMY2cD4RhPuQPPsZ46yV1gCf60jVyMRyH4RXz33Vfu1
   Mqn8WIdammqwqGo81624MXKr1Ae+BDXxCESttPrDKo2v88aORbbelrr72
   zdBV2jHnSYHKG+S4qXZNuEjEnYbCPBVIMkJqHwFSdtnCrXSAWfJxSbbDH
   w1vx0gkn++NNMW6Q1oQsduhqrBeO7U6LQEgbjk8IeiMP+buz6x1FhDLPE
   /USmHZCXVFdVsejYApWXAGTcICfNoWbPR9kaW8n4WfqQ4JB71DhjV0+G7
   P+59CzyS/xKQJJp1nnATkjdKLcpn8Cnqsy41Psu+OdF6JDyVncr3kaTWh
   Q==;
X-CSE-ConnectionGUID: lHEos+pQSEOhLjvDJiM1JQ==
X-CSE-MsgGUID: luO32ryOT96QGX5slWhn7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88450392"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88450392"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:58:18 -0700
X-CSE-ConnectionGUID: YvtOlD1kRoatt8e3P/gF/g==
X-CSE-MsgGUID: ofRDiSiOSpSgC8hsWCpJNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="254474010"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 15 Jul 2026 08:58:16 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS
Date: Wed, 15 Jul 2026 21:47:53 +0530
Message-ID: <20260715161754.213393-1-kiran.k@intel.com>
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

     The hdev->reset callback (.reset = btintel_pcie_reset,
     invoked via the sysfs reset attribute
     /sys/class/bluetooth/hciX/reset and from hci_cmd_timeout())
     compounded this by not writing reset_type at all -- it
     inherited whatever value a previous hw_error / resume() had
     left, which could be PLDR.

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
    hdev->reset callback (invoked via the sysfs reset attribute
    /sys/class/bluetooth/hciX/reset and from hci_cmd_timeout())
    that always requests FLR explicitly, so these paths no longer
    inherit stale state from prior error events.

  - Add an early test_bit(RECOVERY_IN_PROGRESS) gate at the top of
    hw_error() so dump_debug_registers() and the recovery-counter
    bookkeeping are skipped when a reset is already in flight; the
    authoritative test_and_set lives in request_reset() and races
    cleanly against any caller that passes the optimistic check.

  - Convert the two resume() reset sites (FREEZE/HIBERNATE and the
    D0-error path) to request_reset(data, FLR), removing the
    redundant manual reset_type writes.

Assisted-by: GitHub-Copilot:claude-4.7-opus
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
- corrected comment above btintel_pcie_request_reset() from "HCI ioctl"
to "sysfs reset attribute, hci_cmd_timeout()", matching the actual
hdev->reset invocation sites in hci_sysfs:reset_store() and
hci_core.c:hci_cmd_timeout()

- Amend the commit message bullet for btintel_pcie_reset() to replace
the incorrect HCIDEVRESET reference (that ioctl goes through
hci_dev_do_reset() and issues HCI_OP_RESET, not hdev->reset) with sysfs
reset attribute and hci_cmd_timeout() paths.

 drivers/bluetooth/btintel_pcie.c | 75 ++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 013568197a39..2e28847263ab 100644
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
@@ -2749,56 +2747,86 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	pci_unlock_rescan_remove();
 }
 
-static void btintel_pcie_reset(struct hci_dev *hdev)
+/* Schedule a device reset of the requested type.
+ *
+ * BTINTEL_PCIE_RECOVERY_IN_PROGRESS serializes all reset requesters
+ * (sysfs reset attribute, hci_cmd_timeout(), hw_error, resume error
+ * path, etc.) so that:
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
@@ -2888,7 +2916,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->hw_error = btintel_pcie_hw_error;
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
-	hdev->reset = btintel_pcie_reset;
+	hdev->reset = btintel_pcie_hci_reset;
 	hdev->wakeup = btintel_pcie_wakeup;
 	hdev->hci_drv = &btintel_pcie_hci_drv;
 
@@ -3176,8 +3204,7 @@ static int btintel_pcie_resume(struct device *dev)
 	if (data->pm_sx_event == PM_EVENT_FREEZE ||
 	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
-		data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
-		btintel_pcie_reset(data->hdev);
+		btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
 		return 0;
 	}
 
@@ -3204,7 +3231,7 @@ static int btintel_pcie_resume(struct device *dev)
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

