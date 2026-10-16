Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553112931CB
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120074; cv=none; b=C7u7eHDiOTEjJwpD/fc9t67cZ8Ti7cOKf6q5H2mGT9O58TNiSatIFRnMMp5Sh0Un/Udox+ZgBRLmpqw45uk2kpvct/qRVF4e9sPbxaoMG/IPqjri3Bj95cfsXYNUyFMV0F74zBC4cnf2y+UbPkbPs82jTu+nFgebH5yQm+b3Oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120074; c=relaxed/simple;
	bh=u9bqAV2zJHJjbv+5UN/bFu1D3Chppramx0lgk66ZYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leIHjox+AYcxTat9C3AHYuRgMUvmPrJhCvgQkpVIsPLgnUhYqSnGmcxH41RZm0q/ztJWvWN/94+ap0M3CsriJXYRpNeUhv1s/K5VbAkwzhv1fZcc+WxbyuCVx3u/tTvr/zM0LhM6dJc2Zgfmaq6ntor94Qlz/9Cg0HSAPN8Am4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrGLUXvW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrGLUXvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792120073; x=1823656073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u9bqAV2zJHJjbv+5UN/bFu1D3Chppramx0lgk66ZYP8=;
  b=ZrGLUXvWjEpxSDB5In6O5taziJVJqKHjW16QtuSujzH0+iFnjw91ghCN
   QA4ClwhZ7maHmFc9xv07S0aaUrLqA69vIOCZwGla0LkjZiP4c8LKaDWgc
   OAw01xJAg4IN/TDZ9Gvu5E6A+Z2kJ4vfW+AeHM7iXU9cOVup2MfMs8gMX
   FXTsA5P/3TxaCQtMOqSmHILNeW1964FaK4g6U4DbB4019XdJNucLqOWkr
   2V+Cf6YU9Q9WS7LaEVhSyyA+fJTQMA6ImQVNCW2R0sLeB+QmJM0/MfrB2
   s6SgpABKuth9rfXBFurqYnQ56SDp5Oj/Dskwwm5GXgyRDu2gr/+Vmk91M
   Q==;
X-CSE-ConnectionGUID: 6jf8YunQSs63cAJOGiKxuA==
X-CSE-MsgGUID: JXLmixJqS3CYXd6CaRchBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1004823"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1004823"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 20:07:52 -0700
X-CSE-ConnectionGUID: CyFaIO4WQBuNL4hlEJnJ1A==
X-CSE-MsgGUID: veO4C2YkQzuLe6A+G+w+LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2316664"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 15 Oct 2026 20:07:50 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v10 1/2] Bluetooth: Add HCI interface for HW rfkill events
Date: Fri, 16 Oct 2026 08:29:20 +0530
Message-ID: <20261016025921.1719986-2-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016025921.1719986-1-aluvala.sai.teja@intel.com>
References: <20261016025921.1719986-1-aluvala.sai.teja@intel.com>
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
powered on under a hard block. The soft state accepted by set_block
is tracked in a new HCI_SW_RFKILLED flag, and hdev->rfkill_block
combines the two. The rfkill core state is not read, as around
set_block it may still hold a change that is about to be reverted.

While a user channel is open, the set_block callback still refuses
soft rfkill with -EBUSY. A HW rfkill block cannot be refused, so
hdev->rfkill_block sets HCI_RFKILLED but leaves the device up for the
user channel; once it is closed, the flag blocks the next power on.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 include/net/bluetooth/hci.h      |   3 +
 include/net/bluetooth/hci_core.h |   4 ++
 net/bluetooth/hci_core.c         | 110 +++++++++++++++++++++++++++++--
 3 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9dc714d9145e..1c992e87534d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -473,6 +473,9 @@ enum {
 	HCI_MESH,
 	HCI_MESH_SENDING,
 
+	HCI_HW_RFKILLED,
+	HCI_SW_RFKILLED,
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
index 209244fd9391..4742c7634246 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -863,15 +863,13 @@ static int hci_dev_do_poweroff(struct hci_dev *hdev)
 	return err;
 }
 
-static int hci_rfkill_set_block(void *data, bool blocked)
+static int __hci_rfkill_set_block(struct hci_dev *hdev, bool blocked)
 {
-	struct hci_dev *hdev = data;
 	int err;
 
-	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
+	lockdep_assert_held(&hdev->rfkill_lock);
 
-	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
-		return -EBUSY;
+	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
 	if (blocked == hci_dev_test_flag(hdev, HCI_RFKILLED))
 		return 0;
@@ -879,8 +877,17 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 	if (blocked) {
 		hci_dev_set_flag(hdev, HCI_RFKILLED);
 
+		/* Leave a user channel up; it closes the device on release
+		 * and HCI_RFKILLED then blocks the next power on.
+		 *
+		 * During setup/config, HCI_RFKILLED is checked by the power
+		 * on path, which closes the device. A block between that
+		 * check and clearing HCI_SETUP is not enforced, as for a
+		 * soft block; changing that is left to the setup flow.
+		 */
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
-		    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
+		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 			err = hci_dev_do_poweroff(hdev);
 			if (err) {
 				bt_dev_err(hdev, "Error when powering off device on rfkill (%d)",
@@ -894,12 +901,100 @@ static int hci_rfkill_set_block(void *data, bool blocked)
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
+	/* A user channel owns the device, so refuse soft rfkill. HW rfkill
+	 * cannot be refused and is applied by hdev->rfkill_block instead.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		err = -EBUSY;
+	} else {
+		/* Track only accepted soft state; rfkill core reverts a
+		 * refused one after this callback returns.
+		 */
+		if (blocked)
+			hci_dev_set_flag(hdev, HCI_SW_RFKILLED);
+		else
+			hci_dev_clear_flag(hdev, HCI_SW_RFKILLED);
+		err = __hci_rfkill_set_block(hdev, blocked);
+	}
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
+ * powers the device off under hdev->rfkill_lock. @hdev must have been
+ * registered with hci_register_dev().
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
+		if (!blocked && !hci_dev_test_flag(hdev, HCI_SW_RFKILLED))
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
+	/* Use only state settled under rfkill_lock, not rfkill core's,
+	 * which may hold a soft change that set_block is about to revert.
+	 */
+	mutex_lock(&hdev->rfkill_lock);
+	blocked = hci_dev_test_flag(hdev, HCI_HW_RFKILLED) ||
+		  hci_dev_test_flag(hdev, HCI_SW_RFKILLED);
+	__hci_rfkill_set_block(hdev, blocked);
+	mutex_unlock(&hdev->rfkill_lock);
+}
+
 static const struct rfkill_ops hci_rfkill_ops = {
 	.set_block = hci_rfkill_set_block,
 };
@@ -2495,6 +2590,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
+	mutex_init(&hdev->rfkill_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -2518,6 +2614,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_WORK(&hdev->rfkill_block, hci_rfkill_block_work);
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2683,6 +2780,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rfkill_block);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 	hci_devcd_shutdown(hdev);
-- 
2.53.0

