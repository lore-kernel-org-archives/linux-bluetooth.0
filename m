Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A53F8890
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910602; cv=none; b=Lr7bBocTHqrL0ikS+sIv2NunBSm7kw8473CUcLVsKsYlygsVaQL4s1QesAZ+e7p/GH6XYfsExNOQ4Qhm9QcIvY6v89xXnzElPvdE+nE7Wsdz9QiDg88XiyI1nXJ3GkXVynnMCrbVTUUUS45bbyGfsUs3vmfSbEOQiMubricV+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910602; c=relaxed/simple;
	bh=EKZBCQRx3ly4Or5rU2nYL007IW1OdtVM5kiKGUqahqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcEgroPOM6ue9Le/T1dFj5IGsam+bzfzxH5MC1WfmBtI5PTSGKjYxhlUbnCBuU7M+JSiDS8FAYENlN/U96zk+ChMdFvYl55nFNlNgW6cbG3ehHfuGqivL2ppDjnB2wq9RUGnsvMya4adIoyOH7+jL28i/edeYBIVFy14EOxHSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecXDaZv6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecXDaZv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787910596; x=1819446596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EKZBCQRx3ly4Or5rU2nYL007IW1OdtVM5kiKGUqahqU=;
  b=ecXDaZv6uhsugzCdsg+lcqbN+xJfXphB6A9QzDu7pt3puro7tJZ2EQhC
   TCPGp5EsUD4njilitgMJSsxvJEhSdoWajGryz52a37ZkWDFx0zxkKnXoS
   f5R4iIcHUmCyHV9BL1Xv+k69s8HcBHK03oYVdYWPPbcxdf0Q+owiE006M
   mXeLs9uJAyadrSEEZ5OTYTHqJJhIyAUcnd2IrLbFGbsx7SZgpDpAy/CiE
   rT3tGEsA9hxb7JMOSA57R+oUGPxa8lt+AjN4VHl00bEDLWjCXb93n5iW0
   Iy90w8gITCB1GP8KxMWq+rxO44zzP/4jSwwkrcOBGRYMSh8tmwmbvsVP1
   w==;
X-CSE-ConnectionGUID: EE0mHGPHTCOpDzXFrngYeQ==
X-CSE-MsgGUID: x//lVmILQdOjWzMLoM1KQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75961068"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="75961068"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 02:49:52 -0700
X-CSE-ConnectionGUID: gJ711ncMQ4OOF4osdITLuA==
X-CSE-MsgGUID: 2myGrogrRE6ugtNa0F1+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="306317986"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2026 02:49:50 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Date: Fri, 28 Aug 2026 15:21:59 +0530
Message-ID: <20260828095159.2370857-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use pm_suspend_target_state to differentiate S0ix from S3/S4. Set the
controller to D3_HOT for S0ix (PM_SUSPEND_TO_IDLE) and D3_COLD for S3/S4
to prevent post-resume instability.

Remove .freeze, .thaw, and .poweroff callbacks to avoid redundant D3
handshakes that time out and abort hibernation. Add .restore to force
FLR-based firmware recovery after S4 and S3 (PM_SUSPEND_MEM), as power
is lost. S0ix resumes via a normal D0 transition.

Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
Assisted-by: GitHub-Copilot:GPT5
Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 63 ++++++++++++++++----------------
 drivers/bluetooth/btintel_pcie.h |  2 -
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 005c77a4f5eb..ba5d16a3b3a5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
 
 #include <linux/unaligned.h>
 #include <linux/devcoredump.h>
@@ -3134,11 +3135,14 @@ static void btintel_pcie_coredump(struct device *dev)
 
 static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 {
-	int retry = 0, status;
+	int retry = 0;
+	long status;
 	u32 dx_intr_timeout_ms = 200;
 
+	/* Set outside the loop to avoid discarding late interrupts on retry. */
+	data->gp0_received = false;
+
 	do {
-		data->gp0_received = false;
 
 		btintel_pcie_wr_sleep_cntrl(data, dxstate);
 
@@ -3184,18 +3188,20 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 
 	data = pci_get_drvdata(pdev);
 
-	dxstate = (mesg.event == PM_EVENT_SUSPEND ?
+	/* Set D3_HOT for S0ix (s2idle) and D3_COLD for S3 (suspend-to-RAM). */
+	dxstate = (pm_suspend_target_state == PM_SUSPEND_TO_IDLE ?
 		   BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);
 
-	data->pm_sx_event = mesg.event;
-
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
@@ -3208,17 +3214,7 @@ static int btintel_pcie_suspend(struct device *dev)
 	return btintel_pcie_suspend_late(dev, PMSG_SUSPEND);
 }
 
-static int btintel_pcie_hibernate(struct device *dev)
-{
-	return btintel_pcie_suspend_late(dev, PMSG_HIBERNATE);
-}
-
-static int btintel_pcie_freeze(struct device *dev)
-{
-	return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
-}
-
-static int btintel_pcie_resume(struct device *dev)
+static int btintel_pcie_resume_event(struct device *dev, pm_message_t mesg)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct btintel_pcie_data *data;
@@ -3226,19 +3222,15 @@ static int btintel_pcie_resume(struct device *dev)
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
@@ -3247,7 +3239,9 @@ static int btintel_pcie_resume(struct device *dev)
 	/* Refer: 6.4.11.7 -> Platform power management */
 	err = btintel_pcie_set_dxstate(data, BTINTEL_PCIE_STATE_D0);
 
-	if (err == 0) {
+	if (err) {
+		bt_dev_err(data->hdev, "Failed to set D0 state (%d)", err);
+	} else {
 		bt_dev_dbg(data->hdev,
 			   "device entered into d0 state from d3 in %lld us",
 			   ktime_to_us(ktime_get() - start));
@@ -3272,13 +3266,20 @@ static int btintel_pcie_resume(struct device *dev)
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
 static const struct dev_pm_ops btintel_pcie_pm_ops = {
 	.suspend = btintel_pcie_suspend,
 	.resume = btintel_pcie_resume,
-	.freeze = btintel_pcie_freeze,
-	.thaw = btintel_pcie_resume,
-	.poweroff = btintel_pcie_hibernate,
-	.restore = btintel_pcie_resume,
+	.restore = btintel_pcie_restore,
 };
 
 static struct pci_driver btintel_pcie_driver = {
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 749369b24031..980eb62fdf8b 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -479,7 +479,6 @@ struct btintel_pcie_dump_header {
  * @txq: TX Queue struct
  * @rxq: RX Queue struct
  * @alive_intr_ctxt: Alive interrupt context
- * @pm_sx_event: PM event on which system got suspended
  */
 struct btintel_pcie_data {
 	struct pci_dev	*pdev;
@@ -536,7 +535,6 @@ struct btintel_pcie_data {
 	enum btintel_pcie_reset_type	reset_type;
 	struct btintel_pcie_dbgc	dbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
-	u8	pm_sx_event;
 	u32	debug_evt_addr;
 	u32	debug_evt_size;
 };
-- 
2.43.0

