Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D531960B
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521156; cv=none; b=Qk95CVHd0tRYPcZIlMSxflvuZY0n6k7hpGBIbdCoSC9ggHrDqIvDCdp/PrdDQjvCK1l3TTVroIyZ9I+XWICjSMDUbI7U/f8hAu2kdicz+X7OqcT0N7zkZIJvd/FSWYcgsMy3Nfk5ekSEzrGEvIXoKM/gLKDg9Lb9kFCcZsKDl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521156; c=relaxed/simple;
	bh=h1BYt9LvXhHWNZchgOBXLtf3qOsXRSBTtmYGSJSrvB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uciMLN+0KPvPs+o2a6f3ybHfsw84kL8zVL/yYSJGEH/LRKUi8lL5o6TbXe5/tVi1iydCSv7OPtqXZhheaboZ09t8ZQlEZ+VagwGCmJjtPizYuGNrCapGwacfCosQmOrGe1eGuhS3mSQcqsQODTk3GnhF4MG3x1iw2n0ecYLGJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaANUmn+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaANUmn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760521152; x=1792057152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1BYt9LvXhHWNZchgOBXLtf3qOsXRSBTtmYGSJSrvB8=;
  b=YaANUmn+OcCnrUfnLixdmZdi9WO+gq+ccGK1/U0Dt4zLwIM+6duK1/4A
   4LJrVksCKyFC2fNSMZQNF65Yn2fh5SjutnPPewQ4fMcc3hm4K6MmNkhLk
   0qrp5TL8pBFvOaWW7jHRXqkNtmNAo6ND6MAwzAkaPu6pwjzYyPK4XDgAe
   XZUFTgg7uy6AGITcGISe4SdLwqWScc4/R23QbqSs0zzJy3tWXRw591P7K
   ae5QMxdsBX8ylZs7osXop+s3Ydc9wMsbYfyDqT1j+XdSJuIoP6H0+NjX4
   xZxbsV3vRtLr6j7h1Sx0WmFznWdcz5X/vm8iuUMJS14mrhsIHM1ZWobme
   Q==;
X-CSE-ConnectionGUID: slM+mJqlQPybUVCL5kjo7A==
X-CSE-MsgGUID: DlspjMB6TRKJh6JhIhem0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66518918"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66518918"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:39:10 -0700
X-CSE-ConnectionGUID: wmOQkwTQT/WMzLuyJOXb1Q==
X-CSE-MsgGUID: 8y5F3PY/TSCLyoRFR5YPlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="213069944"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.226.112])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2025 02:39:08 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Ravindra <ravindra@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling
Date: Wed, 15 Oct 2025 15:09:03 +0530
Message-ID: <20251015093903.480282-2-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015093903.480282-1-ravindra@intel.com>
References: <20251015093903.480282-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a hardware bug during suspend/resume, the controller may miss a
doorbell interrupt. To address this, a retry mechanism has been added to
inform the controller before reporting a failure.

Test case:
- run suspend and resume cycles.

Signed-off-by: Ravindra <ravindra@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 113 +++++++++++++++++++------------
 drivers/bluetooth/btintel_pcie.h |   2 +
 2 files changed, 73 insertions(+), 42 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2f4517d3fe13..fbb4cc29138c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2523,6 +2523,48 @@ static void btintel_pcie_coredump(struct device *dev)
 }
 #endif
 
+static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
+{
+	int retry = 0, status;
+	u32 dx_intr_timeout_ms = 200;
+
+	do {
+		data->gp0_received = false;
+
+		btintel_pcie_wr_sleep_cntrl(data, dxstate);
+
+		status = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+			msecs_to_jiffies(dx_intr_timeout_ms));
+
+		if (status)
+			return 0;
+
+		bt_dev_warn(data->hdev,
+			   "Timeout (%u ms) on alive interrupt for D%d entry, retry count %d",
+			   dx_intr_timeout_ms, dxstate, retry);
+
+		/* clear gp0 cause */
+		btintel_pcie_clr_reg_bits(data,
+					  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
+					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
+
+		/* A hardware bug may cause the alive interrupt to be missed.
+		 * Check if the controller reached the expected state and retry
+		 * the operation only if it hasn't.
+		 */
+		if (dxstate == BTINTEL_PCIE_STATE_D0) {
+			if (btintel_pcie_in_d0(data))
+				return 0;
+		} else {
+			if (btintel_pcie_in_d3(data))
+				return 0;
+		}
+
+	} while (++retry < BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES);
+
+	return -EBUSY;
+}
+
 static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2538,26 +2580,18 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 
 	data->pm_sx_event = mesg.event;
 
-	data->gp0_received = false;
-
 	start = ktime_get();
 
 	/* Refer: 6.4.11.7 -> Platform power management */
-	btintel_pcie_wr_sleep_cntrl(data, dxstate);
-	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
-				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
-	if (err == 0) {
-		bt_dev_err(data->hdev,
-			   "Timeout (%u ms) on alive interrupt for D3 entry",
-			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
-		return -EBUSY;
-	}
+	err = btintel_pcie_set_dxstate(data, dxstate);
+
+	if (err)
+		return err;
 
 	bt_dev_dbg(data->hdev,
 		   "device entered into d3 state from d0 in %lld us",
 		   ktime_to_us(ktime_get() - start));
-
-	return 0;
+	return err;
 }
 
 static int btintel_pcie_suspend(struct device *dev)
@@ -2602,40 +2636,35 @@ static int btintel_pcie_resume(struct device *dev)
 	}
 
 	/* Refer: 6.4.11.7 -> Platform power management */
-	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
-	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
-				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	err = btintel_pcie_set_dxstate(data, BTINTEL_PCIE_STATE_D0);
+
 	if (err == 0) {
-		bt_dev_err(data->hdev,
-			   "Timeout (%u ms) on alive interrupt for D0 entry",
-			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		bt_dev_dbg(data->hdev,
+			   "device entered into d0 state from d3 in %lld us",
+			   ktime_to_us(ktime_get() - start));
+		return err;
+	}
 
-		/* Trigger function level reset if the controller is in error
-		 * state during resume() to bring back the controller to
-		 * operational mode
-		 */
+	/* Trigger function level reset if the controller is in error
+	 * state during resume() to bring back the controller to
+	 * operational mode
+	 */
 
-		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
-				BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
-		if (btintel_pcie_in_error(data) ||
-				btintel_pcie_in_device_halt(data)) {
-			bt_dev_err(data->hdev, "Controller in error state for D0 entry");
-			if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS,
-					      &data->flags)) {
-				data->dmp_hdr.trigger_reason =
-					BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
-				queue_work(data->workqueue, &data->rx_work);
-			}
-			set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
-			btintel_pcie_reset(data->hdev);
+	data->boot_stage_cache = btintel_pcie_rd_reg32(data,
+			BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	if (btintel_pcie_in_error(data) ||
+			btintel_pcie_in_device_halt(data)) {
+		bt_dev_err(data->hdev, "Controller in error state for D0 entry");
+		if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS,
+				      &data->flags)) {
+			data->dmp_hdr.trigger_reason =
+				BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
+			queue_work(data->workqueue, &data->rx_work);
 		}
-		return -EBUSY;
+		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+		btintel_pcie_reset(data->hdev);
 	}
-
-	bt_dev_dbg(data->hdev,
-		    "device entered into d0 state from d3 in %lld us",
-		     ktime_to_us(ktime_get() - start));
-	return 0;
+	return err;
 }
 
 static const struct dev_pm_ops btintel_pcie_pm_ops = {
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 48e1ae1793e5..e3d941ffef4a 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -158,6 +158,8 @@ enum msix_mbox_int_causes {
 /* Default interrupt timeout in msec */
 #define BTINTEL_DEFAULT_INTR_TIMEOUT_MS	3000
 
+#define BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES	3
+
 /* The number of descriptors in TX queues */
 #define BTINTEL_PCIE_TX_DESCS_COUNT	32
 
-- 
2.43.0

