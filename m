Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042840;
	b=3gRCATMuRkaMsYli8RGGjAxkLDj07WIR80VsQ1OViovorwIr/vQfaqoSi8my1W9Ih+J+
	 zTChAfvZcs0ugIj9dcFNL2Brx1gA+K1uaYuCuiVyTQjJJQZKwxZgBglKo1apVhj6SAhV9
	 4dz/ZzTT9hzyEWLsb0/jxqpoJ8GX7m+kOoBSt62ZV4bKvBDvjYardtpw//SOmAylphUCR
	 DqmGDCQTF4r4QlR21TwMuYztsRGtUNlwSFVO3KKVu0nFGkhuRvDLI5irGClUIWfqMNeWs
	 XcEtVpg32J8LsTvhThENKTyEOjeTRQXVVglcZ3KI6Eu+IZ3LDeCOHlrSURoFKRyLy6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042840;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JodqEzLe/8ZipBgPigEZQ3E3H3/tXsz6ZMcAbkUIsy0=;
	b=sYDfadNpA/MBdfDIUBGQ9WlHIklK12rzDqLZLrpevCwjkrUdn6uze9Cn3p+S+EJzTN6f
	 wkd6zxeSatZclabeClFx8G6elrsSE4WQlFoB9PIFAwkuZIXIVeyX84cuawqOENuNH85ym
	 ziFiDa0r8OYLOyz8cFjzx2ZGJ8t0/PEyiWN0/ZSV0Yr0CqaA6IaRmtco8rPJrCHFucMpx
	 eSUF4aqDUl6FBkjCneoT6XZJeajmvhqPYmteJLAn6XAj/QikmWAyT78XVYysZOEhNiXx/
	 c0uKvugchZxTluQpXqUn054CF3s+FsgNo7q/TNkIZpa5cenyUyotPETA2H2YkOSBJ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AwnLH8Hq;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E09606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E09606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AwnLH8Hq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795042839; x=1826578839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pABnLkEKKwrsu/GhOC28SMA4+gjwvMsJdvdONGIQXPw=;
  b=AwnLH8Hq+6Q0Oetq7ZW9EE1QOUUNwh026YnAmv/BsBUV/9Ezu6k2P2Jk
   /7sRz47UKxpvyOrbswWBz0pRPBwEawZ4GgDiUIguw6UCUTnnof1G4xt8C
   FfUyxXoMpxC2wgAHrmknV/nnHOiKh486TkhD9rEpV+a7fcg4VaPQpypBz
   CK8WOkXWf+Z3e+6OJvLrX7zaCGKJedkbFqBnB3CKlnJmsKFnvLUPOlW1D
   Pz8VQOmzeCA1toXvqD4QE2Fy01thCkGLnmGpM8FREkbzIGS369lkUYQn/
   xnSOUBXedRezLwai1bRPaKhQVK+d/8t5/REdPgdrpY4DJk/BUPmxJ/ZQk
   w==;
X-CSE-ConnectionGUID: dlwNTmQITBWIY8Teaz3yJg==
X-CSE-MsgGUID: sYU6fvhfTKO3Ep3yEQqFvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3887835"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3887835"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 15:00:38 -0800
X-CSE-ConnectionGUID: IM2a+TplTxyobLNSBkU8xQ==
X-CSE-MsgGUID: fo6KICpDTO2YI2lSiEoXsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10516138"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 15:00:36 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Reject user coredump until firmware is operational
Date: Thu, 19 Nov 2026 04:50:43 +0530
Message-ID: <20261118232043.1987049-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
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

A user can request a device coredump through the PCI coredump sysfs
attribute at any time, including while firmware is being downloaded
from btintel_pcie_setup(). The request then rings the DBGC flush
doorbell on bootloader firmware that does not service it, or, if the
core halted, reads debug regions under MAC access while the setup
retry path is resetting and re-enabling the device.

The same applies once recovery has been requested. The sysfs callback
runs synchronously and can ring the doorbell while
btintel_pcie_reset_work() is quiescing the device or while the ACPI
_PRR reset runs. A flag check in the callback alone cannot close this,
as recovery can be requested right after the check.

Make the callback only check that the firmware is operational and
queue a work item on dump_workqueue, so all device access happens in
that worker. The worker rechecks the state and is drained by
btintel_pcie_reset_work() before the device is quiesced, and by
remove(), probe cleanup and suspend, so the doorbell can no longer race
with reset.

The firmware is considered operational once BTINTEL_PCIE_SETUP_DONE is
set and until BTINTEL_PCIE_RECOVERY_IN_PROGRESS is set. Neither flag is
cleared for the lifetime of the driver data, as recovery re-probes the
device. Firmware-initiated dumps are not affected.

Fixes: 07e6bddb54b4 ("Bluetooth: btintel_pcie: Add support for device coredump")
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 60 ++++++++++++++++++++++++++------
 drivers/bluetooth/btintel_pcie.h |  1 +
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 382e02851758..12a2cca09d7d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -658,6 +658,7 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 }
 
 static inline bool btintel_pcie_in_d3(struct btintel_pcie_data *data);
+static void btintel_pcie_user_dump_req_worker(struct work_struct *work);
 
 static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 				  struct sk_buff *skb, u32 pkt_type, u16 opcode)
@@ -4116,6 +4117,7 @@ static void btintel_pcie_probe_cleanup(struct btintel_pcie_data *data)
 	btintel_pcie_disable_interrupts(data);
 	btintel_pcie_synchronize_irqs(data);
 
+	disable_work_sync(&data->user_dump_req_work);
 	disable_work_sync(&data->coredump_work);
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
@@ -4596,6 +4598,8 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	if (!data)
 		goto out;
 
+	disable_work_sync(&data->user_dump_req_work);
+
 	btintel_pcie_mask_hw_rfkill(data);
 	btintel_pcie_synchronize_irqs(data);
 	disable_delayed_work_sync(&data->hw_rfkill_work);
@@ -4632,6 +4636,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	}
 
 	if (btintel_pcie_perform_flr(data)) {
+		enable_work(&data->user_dump_req_work);
 		enable_work(&data->coredump_work);
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
@@ -4947,6 +4952,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	INIT_WORK(&data->fwtrigger_work, btintel_pcie_fwtrigger_worker);
 	INIT_WORK(&data->mbox_work, btintel_pcie_mbox_worker);
 	INIT_DELAYED_WORK(&data->user_dump_work, btintel_pcie_user_dump_worker);
+	INIT_WORK(&data->user_dump_req_work, btintel_pcie_user_dump_req_worker);
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
@@ -5039,6 +5045,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	 * the disable counters stay >= 1 even after reset_work()'s
 	 * balanced enable_work() (counter 2 -> 1, never reaching 0).
 	 */
+	disable_work_sync(&data->user_dump_req_work);
 	disable_work_sync(&data->coredump_work);
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
@@ -5088,7 +5095,6 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
-#ifdef CONFIG_DEV_COREDUMP
 static u32 btintel_pcie_ipc_ctrl_toggle(struct btintel_pcie_data *data, u32 bits)
 {
 	unsigned long flags;
@@ -5115,13 +5121,26 @@ static void btintel_pcie_trigger_fw_dump_collect(struct btintel_pcie_data *data)
 		    "IPC doorbell sent to FW for DBGC flush (IPC_CTRL=0x%08x)", reg);
 }
 
-static void btintel_pcie_coredump(struct device *dev)
+static bool btintel_pcie_fw_operational(struct btintel_pcie_data *data)
 {
-	struct  pci_dev *pdev = to_pci_dev(dev);
-	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
+	return test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags) &&
+	       !test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+}
 
-	if (!data)
+/* Drained by reset_work() before the device is quiesced */
+static void btintel_pcie_user_dump_req_worker(struct work_struct *work)
+{
+	struct btintel_pcie_data *data = container_of(work,
+					struct btintel_pcie_data, user_dump_req_work);
+
+	if (!data->hdev)
+		return;
+
+	if (!btintel_pcie_fw_operational(data)) {
+		bt_dev_warn(data->hdev,
+			    "coredump rejected: firmware not operational");
 		return;
+	}
 
 	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags) ||
 	    test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
@@ -5143,9 +5162,8 @@ static void btintel_pcie_coredump(struct device *dev)
 		return;
 	}
 
-	/* Only a halted core cannot answer the doorbell. FW services it
-	 * regardless of host setup or recovery state, so no other state
-	 * needs to be excluded; collect directly here.
+	/* Only a halted core cannot answer the doorbell; collect directly
+	 * here.
 	 */
 	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags)) {
 		btintel_pcie_queue_coredump(data,
@@ -5163,9 +5181,8 @@ static void btintel_pcie_coredump(struct device *dev)
 	 * runs with the flag clear and leaves it set without a timer.
 	 *
 	 * The flag/arm/doorbell sequence is not atomic against the interrupt
-	 * handler or reset. A firmware trigger while the request is pending
-	 * may take the user-dump reason, and a reset in it may leave the flag
-	 * set until the next reset. Both are rare and do not affect the dump
+	 * handler. A firmware trigger while the request is pending may take
+	 * the user-dump reason. This is rare and does not affect the dump
 	 * contents.
 	 */
 	set_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
@@ -5179,6 +5196,26 @@ static void btintel_pcie_coredump(struct device *dev)
 
 	btintel_pcie_trigger_fw_dump_collect(data);
 }
+
+#ifdef CONFIG_DEV_COREDUMP
+static void btintel_pcie_coredump(struct device *dev)
+{
+	struct  pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
+
+	if (!data)
+		return;
+
+	if (!btintel_pcie_fw_operational(data)) {
+		bt_dev_warn(data->hdev,
+			    "coredump rejected: firmware not operational");
+		return;
+	}
+
+	if (!queue_work(data->dump_workqueue, &data->user_dump_req_work))
+		bt_dev_warn(data->hdev,
+			    "coredump rejected: request pending or workqueue disabled");
+}
 #endif
 
 static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
@@ -5290,6 +5327,7 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	 * request, then let an in-flight timeout worker and any queued dump
 	 * finish before the device enters D3.
 	 */
+	cancel_work_sync(&data->user_dump_req_work);
 	clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
 	cancel_delayed_work_sync(&data->user_dump_work);
 	flush_work(&data->fwtrigger_work);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index b60e24ca558d..28acc20eefdf 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -818,6 +818,7 @@ struct btintel_pcie_data {
 	struct work_struct	fwtrigger_work;
 	struct work_struct	mbox_work;
 	struct delayed_work	user_dump_work;
+	struct work_struct	user_dump_req_work;
 
 	struct dma_pool	*dma_pool;
 	dma_addr_t	dma_p_addr;
-- 
2.54.0

