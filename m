Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89C244667
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323191; cv=none; b=dtNVC9pfFuha13QEJdFWoYK7tME6C6oBsweIqHYjcuEcCAjKowv9VOfM7ZZ8UbVilDu7VSCHsVJtkShf/IKd+LHAUCkSvI4O5m+iWvPwWXdInR8SuLpYSoLid29+LJy7vkGsLezMBMsSL1Tg1u7WMaM9EuDRPzjFtGFl62b4JjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323191; c=relaxed/simple;
	bh=lyaSlJLhoxnZtwUP3vnt5X8qUd0c7ipOmD1u009eeJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmeQaDZGpB/9Y7EXnAmHyivL2bAjnaMA2mUumOjsqAtso4PW6Lzf6psCcgu2/4i1RgbXmsig5MYKg3cWYN9/yUiQ4GUjF1thZeqo/u2iUrEn4sT+aRYz2XMpbsLsj4PEC09PgeB1CYDlqVP5UHa85Gk/FCb0WOBR5IACm9hyJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KU96JXYC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KU96JXYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788323189; x=1819859189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lyaSlJLhoxnZtwUP3vnt5X8qUd0c7ipOmD1u009eeJo=;
  b=KU96JXYCShBRFYpOv8MP9t7OdFKS89kwk6zKooT1dq1s9RRwZGCTvsre
   NSmrJuxJKsqEpoODG56c+QkcP69XYTRY0JDk6SaL6pS257969oUGXgxBR
   4FYEBu5SRKbGP8PXyWleKkmKUukIG6c3GBd8tc+oUYy4rQ4lTEC5hjIn3
   fTH7U823ixXo99EpTRJvBP+DlMjKyI0+b8xmzYd3QQTklGQYCAvEpvi4Z
   qvIRjfbZqQPlwrusLLnLEaikCsuHVAPiaDN+lMZnKDP+hrrMckn9fVjbn
   HMRkm2V8ClvjXsm4M9B25IwHklEkrtMdAwu26S5V4gYulYUYYDP0GZIvA
   Q==;
X-CSE-ConnectionGUID: aejLyNt3TeGoL+58HeQQLw==
X-CSE-MsgGUID: BplyUyonSwSzyuDMjlJexA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92588742"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92588742"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 21:26:28 -0700
X-CSE-ConnectionGUID: eFgnuSAoSZWpJv++pMKf4A==
X-CSE-MsgGUID: p0QXiIRYT0C9wGSPoTRstA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268755559"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa008.jf.intel.com with ESMTP; 01 Sep 2026 21:26:27 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Date: Wed,  2 Sep 2026 09:58:40 +0530
Message-ID: <20260902042840.2432862-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use pm_suspend_target_state to differentiate S0ix from S3/S4. Set the
controller to D3_HOT for S0ix (PM_SUSPEND_TO_IDLE) and D3_COLD for
S3/S4, freeze and hibernate to prevent post-resume instability.

Register .freeze, .thaw, .poweroff and .restore callbacks for proper
hibernation support. The freeze and poweroff (hibernate) paths set
D3_COLD via btintel_pcie_suspend_late. The thaw path resumes with a
normal D0 transition, while .restore forces FLR-based firmware recovery
after S4 since power is lost. S3 (PM_SUSPEND_MEM) resume also triggers
FLR. S0ix resumes via a normal D0 transition.

Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
Assisted-by: GitHub-Copilot:GPT5
Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 64 ++++++++++++++++++++++----------
 drivers/bluetooth/btintel_pcie.h |  2 -
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 30923eaabed7..90d4a3596f80 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
 
 #include <linux/unaligned.h>
 #include <linux/devcoredump.h>
@@ -3515,11 +3516,16 @@ static void btintel_pcie_coredump(struct device *dev)
 
 static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 {
-	int retry = 0, status;
+	int retry = 0;
+	long status;
 	u32 dx_intr_timeout_ms = 200;
 
+	/* Not reset per retry: dxstate is unchanged, so a late interrupt from
+	 * an earlier attempt still confirms the target state.
+	 */
+	data->gp0_received = false;
+
 	do {
-		data->gp0_received = false;
 
 		btintel_pcie_wr_sleep_cntrl(data, dxstate);
 
@@ -3565,18 +3571,23 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 
 	data = pci_get_drvdata(pdev);
 
-	dxstate = (mesg.event == PM_EVENT_SUSPEND ?
-		   BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);
-
-	data->pm_sx_event = mesg.event;
+	/* S0ix (s2idle) uses D3_HOT; S3, freeze and hibernate use D3_COLD. */
+	if (mesg.event == PM_EVENT_SUSPEND &&
+	    pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
+		dxstate = BTINTEL_PCIE_STATE_D3_HOT;
+	else
+		dxstate = BTINTEL_PCIE_STATE_D3_COLD;
 
 	start = ktime_get();
 
 	/* Refer: 6.4.11.7 -> Platform power management */
 	err = btintel_pcie_set_dxstate(data, dxstate);
 
-	if (err)
+	if (err) {
+		bt_dev_err(data->hdev, "Failed to set dxstate:%u (%d)",
+			   dxstate, err);
 		return err;
+	}
 
 	bt_dev_dbg(data->hdev,
 		   "device entered into d3 state from d0 in %lld us",
@@ -3599,7 +3610,7 @@ static int btintel_pcie_freeze(struct device *dev)
 	return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
 }
 
-static int btintel_pcie_resume(struct device *dev)
+static int btintel_pcie_resume_event(struct device *dev, pm_message_t mesg)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct btintel_pcie_data *data;
@@ -3607,19 +3618,15 @@ static int btintel_pcie_resume(struct device *dev)
 	int err;
 
 	data = pci_get_drvdata(pdev);
-	data->gp0_received = false;
 
 	start = ktime_get();
 
-	/* When the system enters S4 (hibernate) mode, bluetooth device loses
-	 * power, which results in the erasure of its loaded firmware.
-	 * Consequently, function level reset (flr) is required on system
-	 * resume to bring the controller back into an operational state by
-	 * initiating a new firmware download.
+	/* S3 and S4 may cut power, erasing the firmware. Force FLR to recover
+	 * instead of a normal D0 transition.
 	 */
-
-	if (data->pm_sx_event == PM_EVENT_FREEZE ||
-	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
+	if (mesg.event == PM_EVENT_RESTORE ||
+	    (mesg.event == PM_EVENT_RESUME &&
+	     pm_suspend_target_state == PM_SUSPEND_MEM)) {
 		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
 		btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
 		return 0;
@@ -3628,7 +3635,9 @@ static int btintel_pcie_resume(struct device *dev)
 	/* Refer: 6.4.11.7 -> Platform power management */
 	err = btintel_pcie_set_dxstate(data, BTINTEL_PCIE_STATE_D0);
 
-	if (err == 0) {
+	if (err) {
+		bt_dev_err(data->hdev, "Failed to set D0 state (%d)", err);
+	} else {
 		bt_dev_dbg(data->hdev,
 			   "device entered into d0 state from d3 in %lld us",
 			   ktime_to_us(ktime_get() - start));
@@ -3653,13 +3662,28 @@ static int btintel_pcie_resume(struct device *dev)
 	return err;
 }
 
+static int btintel_pcie_resume(struct device *dev)
+{
+	return btintel_pcie_resume_event(dev, PMSG_RESUME);
+}
+
+static int btintel_pcie_restore(struct device *dev)
+{
+	return btintel_pcie_resume_event(dev, PMSG_RESTORE);
+}
+
+static int btintel_pcie_thaw(struct device *dev)
+{
+	return btintel_pcie_resume_event(dev, PMSG_THAW);
+}
+
 static const struct dev_pm_ops btintel_pcie_pm_ops = {
 	.suspend = btintel_pcie_suspend,
 	.resume = btintel_pcie_resume,
 	.freeze = btintel_pcie_freeze,
-	.thaw = btintel_pcie_resume,
+	.thaw = btintel_pcie_thaw,
 	.poweroff = btintel_pcie_hibernate,
-	.restore = btintel_pcie_resume,
+	.restore = btintel_pcie_restore,
 };
 
 static struct pci_driver btintel_pcie_driver = {
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 9baa214d9bbe..290679f45652 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -541,7 +541,6 @@ struct btintel_pcie_dump_header {
  * @txq: TX Queue struct
  * @rxq: RX Queue struct
  * @alive_intr_ctxt: Alive interrupt context
- * @pm_sx_event: PM event on which system got suspended
  */
 struct btintel_pcie_data {
 	struct pci_dev	*pdev;
@@ -600,7 +599,6 @@ struct btintel_pcie_data {
 	enum btintel_pcie_reset_type	reset_type;
 	struct btintel_pcie_dbgc	dbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
-	u8	pm_sx_event;
 	u32	debug_evt_addr;
 	u32	debug_evt_size;
 	dma_addr_t	debug_table_addr;
-- 
2.43.0

