Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4353F6A7
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998990; cv=none; b=tstnLhy8TiMcY6fcnScvNE3Vz9/qwDv0KCfFfL/sGlv4WRvt9vplacPKudNM91ouVEe6AX3dmVbG8vwnAuJgC9QRBcjxb5oVM846pik83oMORb1u+b243gl7H9qFhp0wq2stL5VMFI0G9WqRLqtwE4l6I+HKoh/hpgqcuRTa6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998990; c=relaxed/simple;
	bh=nyZ3JH8em72KF/ONC14zIcwz1A7uN9MI6cNLGx9JP0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWbHI8qTiAfnFgmduPruqFFBTaA62lnBueZlkHuKv3R05OAXSPEcpxwtoODpODy7/uX+7mdhNv0tStUR5HtFGRGxkgUAT3MQduXT9w5QRMoivdK1n5pLrC1T0FI/loiVHHapmirGDCDm1eZjbxl4Zxzpg1ijFtnZ/IUKtQBXD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFEv6aId; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFEv6aId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791998985; x=1823534985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyZ3JH8em72KF/ONC14zIcwz1A7uN9MI6cNLGx9JP0E=;
  b=bFEv6aIdDv7gWsVU+QPR3KI2n+yrBprzkKV8LSOrYKSR/5UjrYUItYx5
   Us44R7TrLrC93Vwaya2CINUPnrhHofEXWjrz2iw+dg/5fLau3UBOucA7l
   zDAjc+dIycDUCFkysJMpVsO/imr19QYotXQctlJ6W+c13scemHDCnLmYv
   Fkyiw0z0Kwhj76hpvOH5mOdUTkZmJWb62otrL+IxuJQsjPmr3vpbps5mp
   E749rzJY84pOiADFFbuuyhwEX8HUG2PuyNCzZ/OJllsAxBGAzQCtpnM6w
   j3JxgAiWk7ciVVHumAkTe3mMX2/gGuuOzIq90Uyn8MpM2MddbRBCpSWFe
   g==;
X-CSE-ConnectionGUID: IpL/UeynQHGGna4KLHys8w==
X-CSE-MsgGUID: 6X3gB3pdROyzyfIyFUQAxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="747423"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="747423"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 10:29:44 -0700
X-CSE-ConnectionGUID: jsix75DdT6eWN5UC0o81Jg==
X-CSE-MsgGUID: fkG5tNF5Suey2CDQsG20vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1569767"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa003.fm.intel.com with ESMTP; 14 Oct 2026 10:29:41 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v6 1/2] Bluetooth: Add HCI interface for HW rfkill events
Date: Wed, 14 Oct 2026 22:51:13 +0530
Message-ID: <20261014172114.1426239-2-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014172114.1426239-1-aluvala.sai.teja@intel.com>
References: <20261014172114.1426239-1-aluvala.sai.teja@intel.com>
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
under hdev->unregister_lock and schedules a new hdev->rfkill_block
work item while still holding that lock, so hci_unregister_dev()
cannot destroy hdev->rfkill before the work runs. On release, if
not soft blocked, HCI_RFKILLED is cleared before rfkill core sends
its async event, so a userspace power-on triggered by that event
does not observe a stale flag.

A new hdev->rfkill_lock serializes hci_rfkill_set_hw_state(),
hdev->rfkill_block and the rfkill core's set_block callback. The
rfkill state is read and HCI_RFKILLED updated under that lock, so a
hardware rfkill event and a concurrent userspace soft block/unblock
cannot leave a stale state applied. A soft unblock keeps
HCI_RFKILLED set while the hardware switch is still asserted, so the
controller cannot be powered on under a hard block.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++
 net/bluetooth/hci_core.c         | 69 +++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

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
index 209244fd9391..9432d8dcceb2 100644
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
@@ -894,12 +895,73 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 			}
 		}
 	} else {
+		/* Stay blocked while HW rfkill is still asserted */
+		if (rfkill_blocked(hdev->rfkill))
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
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER) ||
+	    IS_ERR_OR_NULL(hdev->rfkill))
+		goto unlock;
+
+	/* Clear HCI_RFKILLED before rfkill core notifies userspace, so a
+	 * power-on triggered by the unblock event does not see a stale flag.
+	 */
+	if (!blocked && !rfkill_soft_blocked(hdev->rfkill))
+		hci_dev_clear_flag(hdev, HCI_RFKILLED);
+
+	rfkill_set_hw_state(hdev->rfkill, blocked);
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
+
+	if (!hdev->rfkill)
+		return;
+
+	/* Read the rfkill state under rfkill_lock so a concurrent soft
+	 * block/unblock cannot leave a stale state applied.
+	 */
+	mutex_lock(&hdev->rfkill_lock);
+	__hci_rfkill_set_block(hdev, rfkill_blocked(hdev->rfkill));
+	mutex_unlock(&hdev->rfkill_lock);
+}
+
 static const struct rfkill_ops hci_rfkill_ops = {
 	.set_block = hci_rfkill_set_block,
 };
@@ -2495,6 +2557,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
+	mutex_init(&hdev->rfkill_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -2518,6 +2581,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_WORK(&hdev->rfkill_block, hci_rfkill_block_work);
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2683,6 +2747,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rfkill_block);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 	hci_devcd_shutdown(hdev);
-- 
2.53.0

