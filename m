Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611F483811
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966922; cv=none; b=PqxYmcprFKNb3f1iQcOhERHh+TlNJEJssaCfY4vfWS6OJqBaZyjLVi1A9802Ys3kvNI2Z4CFKndLmSoHGLEma26Itya3jfgKT0MJrsnSsWwmZEXQTSgI/1/zYNset5MPh4L5mqs9NcgeXqgjTOb5b2UNqZP/QB6Z6pADBiJ7sBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966922; c=relaxed/simple;
	bh=162MjQgso2Ll9CS+cY5eemnQfrBFU15dG/RubbtzwDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwQjWLXqdvSIjqhVBYDaFpymHw06Fhi+RPuRxIdcngHPTzfonGu+9qD/YOXyB22jIm+1t3w2re6xpiWXvv4mtwMyRtfxnN1JevV0/onj87WP70CKYIwAuibkrBjgIVaYsg2sdVnnIGg2/V63ogtB4G25+v5mVkRYa+eW32ZF5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFghuxfY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFghuxfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791966919; x=1823502919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=162MjQgso2Ll9CS+cY5eemnQfrBFU15dG/RubbtzwDE=;
  b=XFghuxfY0EDZwIWfJwYwp0x4nNuJdGsSjxOOEr7HvG5Ap3gF4vYSF0W4
   01CtTciRHHYEVJO5k4LnU3q+Es08qCcCROQEcBGvByafufYy1sZiM6Ir+
   15dUJlXggDanBkKEgXoVrx/p12c7SQ4b8N+ZGR8ypXwVM4X57LzRSH5SB
   +fnM6XZsT+7t5bzgqrX6KLivjf3bqzS0JLXW1Vs+tlg3FSe3KjuaS9U9/
   7jz7EC/neoZWwZCbzWfnEO1hyxEZU+QqeSd0Now/iXdS3RxgY4+ZZzRHM
   Vx5D6fT1b5pkOInNopXM3RbIijQk3IWuKzu6UyKPA3yxCYrOWaZuPnAOK
   w==;
X-CSE-ConnectionGUID: CxnI+dVvTIa/x7aRSvl6pw==
X-CSE-MsgGUID: 51PYeg5QRWeBkxQcCh1+JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="593396"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="593396"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 01:35:19 -0700
X-CSE-ConnectionGUID: H8d8cfEHSqCCNWzH7+uDew==
X-CSE-MsgGUID: f+wmjcreS4aKt5O93alt5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1704426"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 01:35:18 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v4 1/2] Bluetooth: Add HCI interface for HW rfkill events
Date: Wed, 14 Oct 2026 13:56:49 +0530
Message-ID: <20261014082650.1270679-2-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014082650.1270679-1-aluvala.sai.teja@intel.com>
References: <20261014082650.1270679-1-aluvala.sai.teja@intel.com>
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

hci_rfkill_set_hw_state() validates HCI_UNREGISTER and hdev->rfkill
under hdev->unregister_lock, applies the new state via a new
hdev->rfkill_block work item while still holding that lock, and
flushes it before returning. This avoids hci_unregister_dev()
destroying hdev->rfkill before the work runs, and avoids a racing
userspace power-on (triggered by rfkill core's own async uevent)
observing a stale HCI_RFKILLED flag before the work applies the new
state.

A new hdev->rfkill_lock serializes hdev->rfkill_block against the
rfkill core's synchronous set_block callback, so a hardware rfkill
event and a concurrent userspace soft block/unblock cannot race on
HCI_RFKILLED and the controller's power state.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 +++
 net/bluetooth/hci_core.c         | 51 ++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

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
index 209244fd9391..7598a1044c5c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -868,13 +868,19 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 	struct hci_dev *hdev = data;
 	int err;
 
+	mutex_lock(&hdev->rfkill_lock);
+
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
-	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		mutex_unlock(&hdev->rfkill_lock);
 		return -EBUSY;
+	}
 
-	if (blocked == hci_dev_test_flag(hdev, HCI_RFKILLED))
+	if (blocked == hci_dev_test_flag(hdev, HCI_RFKILLED)) {
+		mutex_unlock(&hdev->rfkill_lock);
 		return 0;
+	}
 
 	if (blocked) {
 		hci_dev_set_flag(hdev, HCI_RFKILLED);
@@ -897,9 +903,45 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 		hci_dev_clear_flag(hdev, HCI_RFKILLED);
 	}
 
+	mutex_unlock(&hdev->rfkill_lock);
+
 	return 0;
 }
 
+void hci_rfkill_set_hw_state(struct hci_dev *hdev, bool blocked)
+{
+	mutex_lock(&hdev->unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER) ||
+	    IS_ERR_OR_NULL(hdev->rfkill)) {
+		mutex_unlock(&hdev->unregister_lock);
+		return;
+	}
+
+	rfkill_set_hw_state(hdev->rfkill, blocked);
+
+	/* Flush so HCI_RFKILLED is updated before rfkill core's async
+	 * uevent reaches userspace, otherwise a racing power-on could see
+	 * a stale flag and immediately close the device again.
+	 */
+	schedule_work(&hdev->rfkill_block);
+	flush_work(&hdev->rfkill_block);
+	mutex_unlock(&hdev->unregister_lock);
+}
+EXPORT_SYMBOL(hci_rfkill_set_hw_state);
+
+static void hci_rfkill_block_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, rfkill_block);
+
+	if (!hdev->rfkill)
+		return;
+
+	if (rfkill_blocked(hdev->rfkill))
+		hci_rfkill_set_block(hdev, true);
+	else
+		hci_rfkill_set_block(hdev, false);
+}
+
 static const struct rfkill_ops hci_rfkill_ops = {
 	.set_block = hci_rfkill_set_block,
 };
@@ -2495,6 +2537,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
+	mutex_init(&hdev->rfkill_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -2518,6 +2561,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_WORK(&hdev->rfkill_block, hci_rfkill_block_work);
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2683,6 +2727,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rfkill_block);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 	hci_devcd_shutdown(hdev);
@@ -2707,10 +2752,12 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_sock_dev_event(hdev, HCI_DEV_UNREG);
 
+	mutex_lock(&hdev->unregister_lock);
 	if (hdev->rfkill) {
 		rfkill_unregister(hdev->rfkill);
 		rfkill_destroy(hdev->rfkill);
 	}
+	mutex_unlock(&hdev->unregister_lock);
 
 	device_del(&hdev->dev);
 	/* Actual cleanup is deferred until hci_release_dev(). */
-- 
2.53.0

