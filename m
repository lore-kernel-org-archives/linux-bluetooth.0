Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0153195EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521152; cv=none; b=rzTpzR4dUrn7qJTCsnvLnDDQ7nxFgum49loGzlc1LHTuW0r7Ujq49ixMGun+lPYVjWu1Jr/FKqneVxz1tRTvmWonSpYDb31YSDzifgdmGPqElEkfQCmbgt1vritdIl5BDtsjYZhBbr37/+pJTV+apvPvOC/eo+zNaOCv0e99zrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521152; c=relaxed/simple;
	bh=s7jXKQVWpbT6qBOPDQgxdEbZMBhdsSK2mdiBlN1LRhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXdafnUmXNxfj91PgF44320adOsP/pn2FQDRBqO01eC5ktWV/dbhRJt0+JayHiUEr7T7JTG2a+4tRzRouLQlZ6MgM3zZgvRG2yWsR7Y9arnLqXK9FK2gxTaYKXT99QsOkaF3WNGOTqugz5uXSkytBZYwdnwZRTuDfLoxwaiweKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVDuHTpc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVDuHTpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760521150; x=1792057150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s7jXKQVWpbT6qBOPDQgxdEbZMBhdsSK2mdiBlN1LRhA=;
  b=bVDuHTpc65pdkpwFKDmfWXqc3DFfruJl4E+iwscpfRoLNLOeyr2if1QH
   qqJ/nm6pLPiY1n9Ob2b92BK3+hewCW8jraaB4bM78uVvR7MH8A8H4Koox
   I4ltybtZUH0zM85i2R9HTgbaJDIj/k881mrUhGktnNSOC6S8CHI5S1UHy
   DQYzouadEPXVIT6RJq84TE8zD37GNNTKeerCkF3HNcikXJFKuETs9N50v
   /FhX4idaXxWXKNra2XOi9eeDlQIt6mbQWRW2Eu38KWE1pA9+Gsm7djVrl
   mzJ+qeyYe8C4RwYOmgMCxaWQqglcuTyJnsvEc9wxFXTWPNr2fIVtF+/9A
   g==;
X-CSE-ConnectionGUID: d8ULUBlqRKObKkaAmK/87Q==
X-CSE-MsgGUID: DaOwZ1EPQkWk2x8tztyIng==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66518911"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66518911"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:39:08 -0700
X-CSE-ConnectionGUID: 3Dqrx91jS4+QRWhrzleVjw==
X-CSE-MsgGUID: KpCcR5EvSGywtuuR0Xrxiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="213069941"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.226.112])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2025 02:39:06 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Ravindra <ravindra@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel_pcie: Support for S4 (Hibernate)
Date: Wed, 15 Oct 2025 15:09:02 +0530
Message-ID: <20251015093903.480282-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During S4 (hibernate), the Bluetooth device loses power. Upon resume,
the driver performs the following actions:

1. Unregisters hdev
2. Calls function level reset
3. Registers hdev

Test case:
- run command sudo rtcwake -m disk -s 60

Signed-off-by: Ravindra <ravindra@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 41 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6d3963bd56a9..2f4517d3fe13 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -825,6 +825,11 @@ static inline bool btintel_pcie_in_d0(struct btintel_pcie_data *data)
 	return !(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY);
 }
 
+static inline bool btintel_pcie_in_device_halt(struct btintel_pcie_data *data)
+{
+	return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED;
+}
+
 static void btintel_pcie_wr_sleep_cntrl(struct btintel_pcie_data *data,
 					u32 dxstate)
 {
@@ -2531,6 +2536,8 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	dxstate = (mesg.event == PM_EVENT_SUSPEND ?
 		   BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);
 
+	data->pm_sx_event = mesg.event;
+
 	data->gp0_received = false;
 
 	start = ktime_get();
@@ -2580,6 +2587,20 @@ static int btintel_pcie_resume(struct device *dev)
 
 	start = ktime_get();
 
+	/* When the system enters S4 (hibernate) mode, bluetooth device loses
+	 * power, which results in the erasure of its loaded firmware.
+	 * Consequently, function level reset (flr) is required on system
+	 * resume to bring the controller back into an operational state by
+	 * initiating a new firmware download.
+	 */
+
+	if (data->pm_sx_event == PM_EVENT_FREEZE ||
+	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
+		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+		btintel_pcie_reset(data->hdev);
+		return 0;
+	}
+
 	/* Refer: 6.4.11.7 -> Platform power management */
 	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
 	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
@@ -2588,6 +2609,26 @@ static int btintel_pcie_resume(struct device *dev)
 		bt_dev_err(data->hdev,
 			   "Timeout (%u ms) on alive interrupt for D0 entry",
 			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+
+		/* Trigger function level reset if the controller is in error
+		 * state during resume() to bring back the controller to
+		 * operational mode
+		 */
+
+		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
+				BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+		if (btintel_pcie_in_error(data) ||
+				btintel_pcie_in_device_halt(data)) {
+			bt_dev_err(data->hdev, "Controller in error state for D0 entry");
+			if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS,
+					      &data->flags)) {
+				data->dmp_hdr.trigger_reason =
+					BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
+				queue_work(data->workqueue, &data->rx_work);
+			}
+			set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
+			btintel_pcie_reset(data->hdev);
+		}
 		return -EBUSY;
 	}
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 04b21f968ad3..48e1ae1793e5 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -464,6 +464,7 @@ struct btintel_pcie_dump_header {
  * @txq: TX Queue struct
  * @rxq: RX Queue struct
  * @alive_intr_ctxt: Alive interrupt context
+ * @pm_sx_event: PM event on which system got suspended
  */
 struct btintel_pcie_data {
 	struct pci_dev	*pdev;
@@ -513,6 +514,7 @@ struct btintel_pcie_data {
 	u32	alive_intr_ctxt;
 	struct btintel_pcie_dbgc	dbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
+	u8	pm_sx_event;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

