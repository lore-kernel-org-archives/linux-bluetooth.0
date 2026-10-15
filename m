Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7604FDE41
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088835; cv=none; b=bsj+hfs+GQdnHlNmTxYdJQK8FFPDfryWvvkUO+cDRKpb63e/88S0zKyBDnkqhzERu/5ypzO2x9EJ8qYqgrtnBY0P4K2UjDHtz+BtxRod5Mf69tDz895txtbAap5nzufjxnFb3U0YrOBnzeBsmzbk5oNW67NozQRe+MYu9th9Eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088835; c=relaxed/simple;
	bh=hSGzyNLyZnAo4lw+GyNvjUrTxVQE9WDtCw4JMW6ueEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqawpPmKjgJ6VOUBVlk/fWAR2lOAWkuGAHXF/tpQw0eD/3Z6s+KGLiw9r5i9fNS4UCu9KUyCgfR5MTpknHhwyX/aicCflUy+vbKF76rVp8xJa5oOA6YV9QFYWejuU0GeYnvuQ2JaPOz+Wyy/T7cbwALGQLvAggAo5sIZJExf1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxTssNhE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxTssNhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792088826; x=1823624826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSGzyNLyZnAo4lw+GyNvjUrTxVQE9WDtCw4JMW6ueEQ=;
  b=HxTssNhEZa7OJKN/KB7NfeUT/dF8PhtlA+mCW+JLOTlMDD0F7/+uXiPV
   nmfBsvOEEnMTbl9Pj0hKhduj31fBzfnXCLkrdphoQRRrRhjIncbNcryJQ
   F9b6MOsSKlAr8kjK9obQcXchAM6e2DhrPgVQBSIdyGHEFo95vxgWUkIdu
   nQx5PkC3399DwCsc4Hjqw1yCyRjkhXVDlaoHcf7ii5/t5mQYuEmVb5w2g
   JaKpXuYj6l5b2pYHGG1sR68Cr+kH3V4HjbIccN9yskdOgAGSuxE3qFcTd
   6O26DueH6K4sTCCG1yTB+rAdL6IQwhhoxoH7OHFSR1qkszwh0fmuAIF7E
   Q==;
X-CSE-ConnectionGUID: SESDrZ/WRTqfWhAYQv7R+Q==
X-CSE-MsgGUID: mGzZDiDUTxGswbBu5d4tUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="855994"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="855994"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:26:59 -0700
X-CSE-ConnectionGUID: e3nTf2zrSTaYxZHkcBK0vQ==
X-CSE-MsgGUID: /uD287KzSyeR4LD54SqE2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2122901"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa006.fm.intel.com with ESMTP; 15 Oct 2026 11:26:57 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v9 1/2] Bluetooth: Add HCI interface for HW rfkill events
Date: Thu, 15 Oct 2026 23:48:28 +0530
Message-ID: <20261015181829.1692108-2-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015181829.1692108-1-aluvala.sai.teja@intel.com>
References: <20261015181829.1692108-1-aluvala.sai.teja@intel.com>
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

While a user channel is open, the set_block callback still refuses
soft rfkill with -EBUSY. A HW rfkill block cannot be refused, so
hdev->rfkill_block sets HCI_RFKILLED but leaves the device up for the
user channel; once it is closed, the flag blocks the next power on.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 include/net/bluetooth/hci.h      |  2 +
 include/net/bluetooth/hci_core.h |  4 ++
 net/bluetooth/hci_core.c         | 97 ++++++++++++++++++++++++++++++--
 3 files changed, 97 insertions(+), 6 deletions(-)

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
index 209244fd9391..87ea117f8d9a 100644
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
@@ -879,8 +877,12 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 	if (blocked) {
 		hci_dev_set_flag(hdev, HCI_RFKILLED);
 
+		/* Leave a user channel up; it closes the device on release
+		 * and HCI_RFKILLED then blocks the next power on.
+		 */
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
-		    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
+		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 			err = hci_dev_do_poweroff(hdev);
 			if (err) {
 				bt_dev_err(hdev, "Error when powering off device on rfkill (%d)",
@@ -894,12 +896,92 @@ static int hci_rfkill_set_block(void *data, bool blocked)
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
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
+		err = -EBUSY;
+	else
+		err = __hci_rfkill_set_block(hdev, blocked);
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
@@ -2495,6 +2577,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
+	mutex_init(&hdev->rfkill_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -2518,6 +2601,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_WORK(&hdev->rfkill_block, hci_rfkill_block_work);
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2683,6 +2767,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rfkill_block);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 	hci_devcd_shutdown(hdev);
-- 
2.53.0

