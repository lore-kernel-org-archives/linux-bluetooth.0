Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04EC3BCD3A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997228; cv=none; b=BBQxu9LKynvBNC2LyuLoxv2j6taw5LRA/yjirabtpqj8RyNYIrvmuSX/7Ufwd89tUBvoooJ1liPphTDDeoCLYD6Oazdn0vuMki1tdAIh1RobPl3eJllj9wsmgKN446CT7lGJ/2UNtHIroPA7dqTgthtM7x079vztiIiwMq1G51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997228; c=relaxed/simple;
	bh=U9ZDdqRhIsnOvirqgonX0oU00WSGtTLlERVTl1q+i9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X43oz/cQEECfYTRlehvo7XeWh6caRTRDlyL1Ds/5h5onRTjAR7M4y/hGVk8kize9sVPqro0WCUkXWD3HXV735Q/yiMlffSHquRekAJPTXGl694RAxJkUOwXRrG5KOYI0LSefMZEv1mQIpuNqgtHOI+QJhqNhon5uB82VYf1RCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWz3aJNz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWz3aJNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791997227; x=1823533227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U9ZDdqRhIsnOvirqgonX0oU00WSGtTLlERVTl1q+i9U=;
  b=LWz3aJNzCEsS4NKYqL0zPaN+tmuh65Bw7TdRN1QnNDEvUTHdW/Htf4dY
   86xgbAOLjR4JJ5vls7bZrseovegDBkpImcbU/dk0z5qZhVUY8x973Qtb2
   i9G/+RDpQ0ydMbYWgMUO0xnK630AfsAyY78dsRJ9rNjJe6zm5522dHa7e
   y4RQ8jwDQiAJN07MnxZdciLStxcRED6QQo70RPxsd9JNvyOncuVKUDR/N
   GpM325l03w27SDwI44Ya/1jE1mJ77RmN3uchAuhypS3Z73rLGuwY25dk1
   x5ohcWrT0EwRzyHGqL/cUwjcKGiJjos9MBFyBr24WsP59MKtpzj82R32F
   Q==;
X-CSE-ConnectionGUID: 0J1XoAQETLq7y39PtH4FJA==
X-CSE-MsgGUID: ofruoVBQTbiEiRLWYEQqVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="755370"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="755370"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 10:00:26 -0700
X-CSE-ConnectionGUID: VrhafEqQRymlGek5dPh19w==
X-CSE-MsgGUID: YHbgwP78Smu+BsS/M10lIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3317098"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 10:00:24 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v5 1/2] Bluetooth: Add HCI interface for HW rfkill events
Date: Wed, 14 Oct 2026 22:21:55 +0530
Message-ID: <20261014165156.1413500-2-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014165156.1413500-1-aluvala.sai.teja@intel.com>
References: <20261014165156.1413500-1-aluvala.sai.teja@intel.com>
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

A new hdev->rfkill_lock serializes hdev->rfkill_block against the
rfkill core's synchronous set_block callback, so a hardware rfkill
event and a concurrent userspace soft block/unblock cannot race on
HCI_RFKILLED and the controller's power state. A soft unblock keeps
HCI_RFKILLED set while the hardware switch is still asserted, so the
controller cannot be powered on under a hard block.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 +++
 net/bluetooth/hci_core.c         | 54 ++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

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
index 209244fd9391..d2f9a1bf0ca0 100644
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
@@ -894,12 +900,53 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 			}
 		}
 	} else {
+		/* Stay blocked while HW rfkill is still asserted */
+		if (rfkill_blocked(hdev->rfkill)) {
+			mutex_unlock(&hdev->rfkill_lock);
+			return 0;
+		}
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
+	/* Clear HCI_RFKILLED before rfkill core notifies userspace, so a
+	 * power-on triggered by the unblock event does not see a stale flag.
+	 */
+	if (!blocked && !rfkill_soft_blocked(hdev->rfkill))
+		hci_dev_clear_flag(hdev, HCI_RFKILLED);
+
+	rfkill_set_hw_state(hdev->rfkill, blocked);
+	schedule_work(&hdev->rfkill_block);
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
@@ -2495,6 +2542,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
 	mutex_init(&hdev->remote_oob_lock);
+	mutex_init(&hdev->rfkill_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -2518,6 +2566,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_WORK(&hdev->rfkill_block, hci_rfkill_block_work);
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2683,6 +2732,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rfkill_block);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 	hci_devcd_shutdown(hdev);
-- 
2.53.0

