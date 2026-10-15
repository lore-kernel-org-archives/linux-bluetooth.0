Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD693E3D9F
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080659; cv=none; b=cPvRTVJTSiH2KJvv+2iHRY+BYwAWkdd0DuSqSI3z6IpGbcd+ueWeCT6+SdCIiVk3tK5j3N2B2G8ZqXIU1mLmh2NA/QYWI+CCNrkAPuvBvEe2jl90yFfmCCnbGWESlPVWMUYL604Fp9Y73dQBYLY9DJoC/65wGABYzfvdr1nzp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080659; c=relaxed/simple;
	bh=hMo4sbyHrePMMN1ozRJ6+FiTIq1YB/Qk0uqqKJFl5d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxvAjlBBp0CLpdHF/ds6Vs2V+xlH0G2fgYeuoKQcfxuVm/5Z0bRBxLV+6luD7sBwyhnmmICImb9f/RTIhi7wCPxlSdHMthJbWDZrpNjurv077yATvAwyWdxcz9biGjT8zqFQZ4uiX1K8TASdWvwho/sAgXFdtqrMoPhTsbut/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfJ2q+Mi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfJ2q+Mi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792080647; x=1823616647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMo4sbyHrePMMN1ozRJ6+FiTIq1YB/Qk0uqqKJFl5d0=;
  b=DfJ2q+MiWWxqUSzTrMbq+zIHfK2zglQFT/NWWELErA2Ue9hZ6TB1r63X
   DLU0TEe/C2Ybah0SENlq7naQwBwFyKnwkXn7lglVFzea8KPeC1LY81J00
   U2px4L768js3MYX8BN21/p4O2y0ITKATEsCZBVqkDwgW+JB94wr+Z/Ybo
   1wBFc/sGgCI6r7JzW62Yshbo2GgJ6o+DZGq6l1XqjBLtlc25aM6OoUiU2
   UHnWYpZumrYDKyNrqTvEzbP45G6KW8LH9PuSwQGcHw232i1Yr4QWSMic4
   aVjYkcZtbNwm8QjVhAU5qG9zaMKYRgA6AAbVHeO/XA3tx3IAlv8LkfwxQ
   Q==;
X-CSE-ConnectionGUID: AUoA5GaaRAq8lcjRCDDlHQ==
X-CSE-MsgGUID: sO1523fKTzCO9hnKx2hdbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="726372"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="726372"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 09:10:46 -0700
X-CSE-ConnectionGUID: FfvO0UIyRASOuNY+6eaOxA==
X-CSE-MsgGUID: +2fRvoUoSiyWMqRDua51JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2085588"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa006.fm.intel.com with ESMTP; 15 Oct 2026 09:10:44 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v7 1/2] Bluetooth: Add HCI interface for HW rfkill events
Date: Thu, 15 Oct 2026 21:32:13 +0530
Message-ID: <20261015160215.1658054-2-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015160215.1658054-1-aluvala.sai.teja@intel.com>
References: <20261015160215.1658054-1-aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hci_rfkill_set_hw_state() so that transport drivers can report
hardware rfkill switch changes to the HCI stack through the same
path used for software rfkill.

hci_rfkill_set_hw_state() checks HCI_UNREGISTER under
hdev->unregister_lock and schedules a new hdev->rfkill_block work
item while still holding that lock, so hci_unregister_dev() cannot
destroy hdev->rfkill before the work runs. The hardware state is
enforced even when no rfkill device exists (e.g. CONFIG_RFKILL=n).
On release, if not soft blocked, HCI_RFKILLED is cleared before
rfkill core sends its async event, so a userspace power-on triggered
by that event does not observe a stale flag.

A new hdev->rfkill_lock serializes hci_rfkill_set_hw_state(),
hdev->rfkill_block and the rfkill core's set_block callback. The
rfkill state is read and HCI_RFKILLED updated under that lock, so a
hardware rfkill event and a concurrent userspace soft block/unblock
cannot leave a stale state applied. The reported hardware state is
tracked in a new HCI_HW_RFKILLED flag, and a soft unblock keeps
HCI_RFKILLED set while it is set, so the controller cannot be
powered on under a hard block. hdev->rfkill_block combines that flag
with rfkill_soft_blocked(). rfkill_blocked() is not used, as around
set_block it still reports the soft block being removed.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 include/net/bluetooth/hci.h      |  2 +
 include/net/bluetooth/hci_core.h |  4 ++
 net/bluetooth/hci_core.c         | 82 +++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9dc714d9145e..f1217ced2831 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -473,6 +473,8 @@ enum {
 	HCI_MESH,
 	HCI_MESH_SENDING,
 
+	HCI_HW_RFKILLED,
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa04dec45153..8f32c860d492 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -503,6 +503,7 @@ struct hci_dev {
 	struct list_head	cmd_sync_work_list;
 	struct mutex		cmd_sync_work_lock;
 	struct mutex		unregister_lock;
+	struct mutex		rfkill_lock;
 	struct work_struct	cmd_sync_cancel_work;
 	struct work_struct	reenable_adv_work;
 
@@ -586,6 +587,7 @@ struct hci_dev {
 	struct device		dev;
 
 	struct rfkill		*rfkill;
+	struct work_struct	rfkill_block;
 
 	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
 	hci_conn_flags_t	conn_flags;
@@ -1822,6 +1824,8 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
 
 struct hci_dev *hci_alloc_dev_priv(int sizeof_priv);
 
+void hci_rfkill_set_hw_state(struct hci_dev *hdev, bool blocked);
+
 static inline struct hci_dev *hci_alloc_dev(void)
 {
 	return hci_alloc_dev_priv(0);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 209244fd9391..d19313452c08 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -863,11 +863,12 @@ static int hci_dev_do_poweroff(struct hci_dev *hdev)
 	return err;
 }
 
-static int hci_rfkill_set_block(void *data, bool blocked)
+static int __hci_rfkill_set_block(struct hci_dev *hdev, bool blocked)
 {
-	struct hci_dev *hdev = data;
 	int err;
 
+	lockdep_assert_held(&hdev->rfkill_lock);
+
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
@@ -894,12 +895,86 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 			}
 		}
 	} else {
+		/* Stay blocked while HW rfkill is still asserted. Do not use
+		 * rfkill_blocked() here: inside set_block it still reports
+		 * the soft block being removed.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_HW_RFKILLED))
+			return 0;
+
 		hci_dev_clear_flag(hdev, HCI_RFKILLED);
 	}
 
 	return 0;
 }
 
+static int hci_rfkill_set_block(void *data, bool blocked)
+{
+	struct hci_dev *hdev = data;
+	int err;
+
+	mutex_lock(&hdev->rfkill_lock);
+	err = __hci_rfkill_set_block(hdev, blocked);
+	mutex_unlock(&hdev->rfkill_lock);
+
+	return err;
+}
+
+/**
+ * hci_rfkill_set_hw_state - report a hardware rfkill switch change
+ * @hdev: HCI device
+ * @blocked: true if the hardware switch is asserted
+ *
+ * May sleep. Must not be called with hdev->req_lock held, as a block
+ * powers the device off under hdev->rfkill_lock.
+ */
+void hci_rfkill_set_hw_state(struct hci_dev *hdev, bool blocked)
+{
+	mutex_lock(&hdev->rfkill_lock);
+	mutex_lock(&hdev->unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		goto unlock;
+
+	if (blocked)
+		hci_dev_set_flag(hdev, HCI_HW_RFKILLED);
+	else
+		hci_dev_clear_flag(hdev, HCI_HW_RFKILLED);
+
+	if (!IS_ERR_OR_NULL(hdev->rfkill)) {
+		/* Clear HCI_RFKILLED before rfkill core notifies userspace,
+		 * so a power-on triggered by the unblock event does not see
+		 * a stale flag.
+		 */
+		if (!blocked && !rfkill_soft_blocked(hdev->rfkill))
+			hci_dev_clear_flag(hdev, HCI_RFKILLED);
+
+		rfkill_set_hw_state(hdev->rfkill, blocked);
+	}
+
+	/* Enforce the hardware state even without an rfkill device */
+	schedule_work(&hdev->rfkill_block);
+unlock:
+	mutex_unlock(&hdev->unregister_lock);
+	mutex_unlock(&hdev->rfkill_lock);
+}
+EXPORT_SYMBOL(hci_rfkill_set_hw_state);
+
+static void hci_rfkill_block_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, rfkill_block);
+	bool blocked;
+
+	/* Use only state settled under rfkill_lock. rfkill_blocked() may
+	 * still report a soft block that set_block has just removed.
+	 */
+	mutex_lock(&hdev->rfkill_lock);
+	blocked = hci_dev_test_flag(hdev, HCI_HW_RFKILLED) ||
+		  (!IS_ERR_OR_NULL(hdev->rfkill) &&
+		   rfkill_soft_blocked(hdev->rfkill));
+	__hci_rfkill_set_block(hdev, blocked);
+	mutex_unlock(&hdev->rfkill_lock);
+}
+
 static const struct rfkill_ops hci_rfkill_ops = {
 	.set_block = hci_rfkill_set_block,
 };
@@ -2495,6 +2570,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
+	mutex_init(&hdev->rfkill_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -2518,6 +2594,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_WORK(&hdev->rfkill_block, hci_rfkill_block_work);
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2683,6 +2760,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rfkill_block);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 	hci_devcd_shutdown(hdev);
-- 
2.53.0

