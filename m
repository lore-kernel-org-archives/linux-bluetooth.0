Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4AC3382F7
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905942; cv=none; b=BodEi7rkZ9mCJOSk+2O5Nr44l8Ze49Acq5dsyE5mTF5g0453v4lFo1SsIkwz7nP5a9tek3oKOv+rtrzheduakzZc0PABUgR7PsVDcIXHaac0HA3UbzwX6uae/QhjdsgHzwDiiFV22O/LKM/6+zAyGxVPOam1+SgS7KMDll17EWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905942; c=relaxed/simple;
	bh=56IUTHLINqI1S3HATMz/vUpZoIoh9g/fBCF3vZwNmQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eken4S1FWVYsaYYfmIf/GXqgUNHwKz7M8gqveeV8undRFBNWrozs3ynyRB2Ni+386xev6nEy9MY/orlN1aMa59lkmgin4x9ZHg/PXWmLV8IE96xs0aS76Imsw5j/m64h9Xnl77kujomHbstpPI0gmHfBcTEcvl5gfvlZP3qB/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rmcl2Li4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rmcl2Li4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790905941; x=1822441941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=56IUTHLINqI1S3HATMz/vUpZoIoh9g/fBCF3vZwNmQ0=;
  b=Rmcl2Li4+MBSqj4oVByyQzTxiDwq+JCFQLwVULvk4Ce8hXPCJdzBL6jP
   Wa9Qt+YSOMnZY1WIRfmWjldMUPEMY/CAysJLCWwdVrZWjBSeL9STh0H4s
   flOV1ElLpeOvKqXqLrQOSSFk0awcK6w8/iuMvNGYxzHRUECm4Qd2LpkVv
   F5+sreFglxgahlk9EAhJMUMF84qq9LkLL3z+PBXxofxqhEXahl9BXWT+O
   ZPLw2YpR8uLkHfbGVmmYUXkTrXsUMuyIohwCswAOyaAIDL8R/LGgxjbEy
   OeBg05YMcWtggTm4nfmTh0YlSNdfcJ28EOMu9Mv0uW/D0e6cLW7m1eXiG
   Q==;
X-CSE-ConnectionGUID: z6BW/CZfS0uAdAFv2K6oiQ==
X-CSE-MsgGUID: DXz/sKQ5QumJKRb+234GqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90814232"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90814232"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 18:52:21 -0700
X-CSE-ConnectionGUID: SAjZf6++S1C3WjzrzWQsiA==
X-CSE-MsgGUID: 2ro9skhWQ0m/ZcN94NYvPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="304098449"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa001.fm.intel.com with ESMTP; 01 Oct 2026 18:52:19 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: Add interface to allow stack to communicate hw rfkill events
Date: Fri,  2 Oct 2026 07:13:57 +0530
Message-ID: <cec8b1c81c62ec805bdc4c32e59515d92e62cc65.1790905146.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790905146.git.aluvala.sai.teja@intel.com>
References: <cover.1790905146.git.aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce hci_rfkill_set_hw_state() to allow drivers to notify the HCI
stack about hardware rfkill events. The helper updates the rfkill core
hardware state and schedules hdev->rfkill_block work, which applies the
resulting block state through hci_rfkill_set_block(). This lets the
stack handle hardware rfkill events through the same procedure as
software rfkill events, without blocking the calling driver context.

Serialize the helper and rfkill teardown with hdev->unregister_lock, and
reject notifications after HCI_UNREGISTER has been set. This prevents a
late driver notification from accessing the rfkill object while it is
being destroyed.

The helper is a no-op when the device has no rfkill handle registered
(rfkill_alloc() or rfkill_register() may fail and leave hdev->rfkill
NULL). The work is disabled in hci_unregister_dev() before the rfkill
handle is destroyed.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f631d9484a0b..c44c50c78088 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -586,6 +586,7 @@ struct hci_dev {
 	struct device		dev;
 
 	struct rfkill		*rfkill;
+	struct work_struct	rfkill_block;
 
 	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
 	hci_conn_flags_t	conn_flags;
@@ -1822,6 +1823,8 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
 
 struct hci_dev *hci_alloc_dev_priv(int sizeof_priv);
 
+void hci_rfkill_set_hw_state(struct hci_dev *hdev, bool blocked);
+
 static inline struct hci_dev *hci_alloc_dev(void)
 {
 	return hci_alloc_dev_priv(0);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05d1ca25f44f..ca75932acf84 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -900,6 +900,36 @@ static int hci_rfkill_set_block(void *data, bool blocked)
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
+	mutex_unlock(&hdev->unregister_lock);
+
+	/* schedule work to avoid blocking the driver context calling this api */
+	schedule_work(&hdev->rfkill_block);
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
@@ -2518,6 +2548,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_WORK(&hdev->rfkill_block, hci_rfkill_block_work);
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
@@ -2683,6 +2714,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rfkill_block);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 	hci_devcd_shutdown(hdev);
@@ -2707,10 +2739,12 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
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

