Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B922F173
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563054; cv=none; b=dzP6COSJV6Zp0tJyZU2QmBx3GcFzIXFzDDcweiMXYoxmAYtI/GKCZ7LtfvupsjEVaA7KddZijVQXBHXN/sa3OajEchXO6i2cHTDz2aY06O80IEqaJ/8/VIaSyCKyC07Vy57VMomnxSmjP9wYPeNp6XQljcVUtdTO3JK1og2myTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563054; c=relaxed/simple;
	bh=jp8BlmSza5qSgypfoYJZb4TqJB+HyiNivf7yT0rsQ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIExQkdf0GUPpcJd8o1aK88SOrjSUVpJc/EL9rF6HQOXZgAmjhMGWhMIdFIIN16qEdcXL+JXlVVcYQoAH4tkTX/lFaBJy2YAJ7rRVhxlydGijzBYRJqSYwm1GvzoemYcmU/+ZOSEE7/yAzBUM+7NNd9/8CZrBrxrVN725pxNTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFvFQ0CX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFvFQ0CX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749563053; x=1781099053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jp8BlmSza5qSgypfoYJZb4TqJB+HyiNivf7yT0rsQ4k=;
  b=BFvFQ0CXbMplaGO1LJ3U3Ugj+7vB5eTeqcaamwrBMAv1NY4B/vzNcwV0
   KIzjXaB4KbAO/meG2vglpCMjSJZkviKoVcLCeFImcq8fP2nhjpdiQdkCD
   wbwNZQ9SKp/NqIIGWwMBBawZ1sqhoCxOs59Wz+v4odzXuPmOZr+YhM1DU
   LBoM9rihZRfPtsUpjEoock1X0YeZPn8Iq6m8blrd016mfaaFeR2uqIH5x
   jMwKrgSXBjA4qCnl7ElXCYfTmdhBNvWKk6F1uf6Qk55luBSuv33ywqZ/p
   TfXTRX5M4bi8QCPHU+shqitglUKs1mpP5iwAxhkzd1sfgEYyeuJcRRAY/
   w==;
X-CSE-ConnectionGUID: OKe/y37tQ/S8BDPOP8Ngcg==
X-CSE-MsgGUID: HLDUYsVIRaK7ZKyQK8qLKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62328971"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="62328971"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:44:13 -0700
X-CSE-ConnectionGUID: 2CblDOx2S5apXC5CzAeLlA==
X-CSE-MsgGUID: bqrtcrxxQW2Ps22gnYUGCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="146748890"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 10 Jun 2025 06:44:10 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 2/2] Bluetooth: btintel_pcie: Support Function level reset
Date: Tue, 10 Jun 2025 19:30:38 +0530
Message-ID: <20250610140038.696091-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610140038.696091-1-kiran.k@intel.com>
References: <20250610140038.696091-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

The driver supports Function Level Reset (FLR) to recover the controller
upon hardware exceptions or hci command timeouts. FLR is triggered only
when no prior reset has occurred within the retry window, with a maximum
of one FLR allowed within this window.

This patch is tested by,
echo 1 >  /sys/class/bluetooth/hciX/reset

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
- Fix typos, indentation issues
- Update commit message to include test command
- Keep the flr max retry to 1

 drivers/bluetooth/btintel_pcie.c | 226 ++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |   4 +-
 2 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e1c688dd2d45..87e4b3546c7a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -41,6 +41,13 @@ static const struct pci_device_id btintel_pcie_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 
+struct btintel_pcie_dev_restart_data {
+	struct list_head list;
+	u8 restart_count;
+	time64_t last_error;
+	char name[];
+};
+
 /* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI type */
 #define BTINTEL_PCIE_HCI_TYPE_LEN	4
 #define BTINTEL_PCIE_HCI_CMD_PKT	0x00000001
@@ -62,6 +69,9 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
 #define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
 
+#define BTINTEL_PCIE_RESET_WINDOW_SECS		5
+#define BTINTEL_PCIE_FLR_MAX_RETRY	1
+
 /* Alive interrupt context */
 enum {
 	BTINTEL_PCIE_ROM,
@@ -99,6 +109,14 @@ struct btintel_pcie_dbgc_ctxt {
 	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
 };
 
+struct btintel_pcie_removal {
+	struct pci_dev *pdev;
+	struct work_struct work;
+};
+
+static LIST_HEAD(btintel_pcie_restart_data_list);
+static DEFINE_SPINLOCK(btintel_pcie_restart_data_lock);
+
 /* This function initializes the memory for DBGC buffers and formats the
  * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
  * size as the payload
@@ -1932,6 +1950,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	u32 type;
 	u32 old_ctxt;
 
+	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
+		return -ENODEV;
+
 	/* Due to the fw limitation, the type header of the packet should be
 	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
 	 * the first byte to get the packet type and redirect the rest of data
@@ -2192,9 +2213,196 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		}
 		btintel_pcie_start_rx(data);
 	}
+
+	if (!err)
+		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
 	return err;
 }
 
+static struct btintel_pcie_dev_restart_data *btintel_pcie_get_restart_data(struct pci_dev *pdev,
+									   struct device *dev)
+{
+	struct btintel_pcie_dev_restart_data *tmp, *data = NULL;
+	const char *name = pci_name(pdev);
+	struct hci_dev *hdev = to_hci_dev(dev);
+
+	spin_lock(&btintel_pcie_restart_data_lock);
+	list_for_each_entry(tmp, &btintel_pcie_restart_data_list, list) {
+		if (strcmp(tmp->name, name))
+			continue;
+		data = tmp;
+		break;
+	}
+	spin_unlock(&btintel_pcie_restart_data_lock);
+
+	if (data) {
+		bt_dev_dbg(hdev, "Found restart data for BDF: %s", data->name);
+		return data;
+	}
+
+	data = kzalloc(struct_size(data, name, strlen(name) + 1), GFP_ATOMIC);
+	if (!data)
+		return NULL;
+
+	strscpy_pad(data->name, name, strlen(name) + 1);
+	spin_lock(&btintel_pcie_restart_data_lock);
+	list_add_tail(&data->list, &btintel_pcie_restart_data_list);
+	spin_unlock(&btintel_pcie_restart_data_lock);
+
+	return data;
+}
+
+static void btintel_pcie_free_restart_list(void)
+{
+	struct btintel_pcie_dev_restart_data *tmp;
+
+	while ((tmp = list_first_entry_or_null(&btintel_pcie_restart_data_list,
+					       typeof(*tmp), list))) {
+		list_del(&tmp->list);
+		kfree(tmp);
+	}
+}
+
+static void btintel_pcie_inc_restart_count(struct pci_dev *pdev,
+					   struct device *dev)
+{
+	struct btintel_pcie_dev_restart_data *data;
+	struct hci_dev *hdev = to_hci_dev(dev);
+	time64_t retry_window;
+
+	data = btintel_pcie_get_restart_data(pdev, dev);
+	if (!data)
+		return;
+
+	retry_window = ktime_get_boottime_seconds() - data->last_error;
+	if (data->restart_count == 0) {
+		data->last_error = ktime_get_boottime_seconds();
+		data->restart_count++;
+		bt_dev_dbg(hdev, "First iteration initialise. last_error: %lld seconds restart_count: %d",
+			   data->last_error, data->restart_count);
+	} else if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
+		   data->restart_count <= BTINTEL_PCIE_FLR_MAX_RETRY) {
+		data->restart_count++;
+		bt_dev_dbg(hdev, "Flr triggered within the max retry time so increment the restart_count: %d",
+			   data->restart_count);
+	} else if (retry_window > BTINTEL_PCIE_RESET_WINDOW_SECS) {
+		data->last_error = 0;
+		data->restart_count = 0;
+		bt_dev_dbg(hdev, "Flr triggered out of the retry window, so reset counters");
+	}
+}
+
+static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
+
+static void btintel_pcie_removal_work(struct work_struct *wk)
+{
+	struct btintel_pcie_removal *removal =
+		container_of(wk, struct btintel_pcie_removal, work);
+	struct pci_dev *pdev = removal->pdev;
+	struct btintel_pcie_data *data;
+	int err;
+
+	pci_lock_rescan_remove();
+
+	if (!pdev->bus)
+		goto error;
+
+	data = pci_get_drvdata(pdev);
+
+	btintel_pcie_disable_interrupts(data);
+	btintel_pcie_synchronize_irqs(data);
+
+	flush_work(&data->rx_work);
+	flush_work(&data->hdev->dump.dump_rx);
+
+	bt_dev_dbg(data->hdev, "Release bluetooth interface");
+	btintel_pcie_release_hdev(data);
+
+	err = pci_reset_function(pdev);
+	if (err) {
+		BT_ERR("Failed resetting the pcie device (%d)", err);
+		goto error;
+	}
+
+	btintel_pcie_enable_interrupts(data);
+	btintel_pcie_config_msix(data);
+
+	err = btintel_pcie_enable_bt(data);
+	if (err) {
+		BT_ERR("Failed to enable bluetooth hardware after reset (%d)",
+		       err);
+		goto error;
+	}
+
+	btintel_pcie_reset_ia(data);
+	btintel_pcie_start_rx(data);
+	data->flags = 0;
+
+	err = btintel_pcie_setup_hdev(data);
+	if (err) {
+		BT_ERR("Failed registering hdev (%d)", err);
+		goto error;
+	}
+error:
+	pci_dev_put(pdev);
+	pci_unlock_rescan_remove();
+	kfree(removal);
+}
+
+static void btintel_pcie_reset(struct hci_dev *hdev)
+{
+	struct btintel_pcie_removal *removal;
+	struct btintel_pcie_data *data;
+
+	data = hci_get_drvdata(hdev);
+
+	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
+		return;
+
+	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
+		return;
+
+	removal = kzalloc(sizeof(*removal), GFP_ATOMIC);
+	if (!removal)
+		return;
+
+	removal->pdev = data->pdev;
+	INIT_WORK(&removal->work, btintel_pcie_removal_work);
+	pci_dev_get(removal->pdev);
+	schedule_work(&removal->work);
+}
+
+static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
+{
+	struct  btintel_pcie_dev_restart_data *data;
+	struct btintel_pcie_data *dev_data = hci_get_drvdata(hdev);
+	struct pci_dev *pdev = dev_data->pdev;
+	time64_t retry_window;
+
+	if (code == 0x13) {
+		bt_dev_err(hdev, "Encountered top exception");
+		return;
+	}
+
+	data = btintel_pcie_get_restart_data(pdev, &hdev->dev);
+	if (!data)
+		return;
+
+	retry_window = ktime_get_boottime_seconds() - data->last_error;
+
+	if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
+	    data->restart_count >= BTINTEL_PCIE_FLR_MAX_RETRY) {
+		bt_dev_err(hdev, "Exhausted maximum: %d recovery attempts: %d",
+			   BTINTEL_PCIE_FLR_MAX_RETRY, data->restart_count);
+		bt_dev_dbg(hdev, "Boot time: %lld seconds first_flr at: %lld seconds restart_count: %d",
+			   ktime_get_boottime_seconds(), data->last_error,
+			   data->restart_count);
+		return;
+	}
+	btintel_pcie_inc_restart_count(pdev, &hdev->dev);
+	btintel_pcie_reset(hdev);
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
@@ -2216,9 +2424,10 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->send = btintel_pcie_send_frame;
 	hdev->setup = btintel_pcie_setup;
 	hdev->shutdown = btintel_shutdown_combined;
-	hdev->hw_error = btintel_hw_error;
+	hdev->hw_error = btintel_pcie_hw_error;
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
+	hdev->reset = btintel_pcie_reset;
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
@@ -2366,7 +2575,20 @@ static struct pci_driver btintel_pcie_driver = {
 	.driver.coredump = btintel_pcie_coredump
 #endif
 };
-module_pci_driver(btintel_pcie_driver);
+
+static int __init btintel_pcie_init(void)
+{
+	return pci_register_driver(&btintel_pcie_driver);
+}
+
+static void __exit btintel_pcie_exit(void)
+{
+	pci_unregister_driver(&btintel_pcie_driver);
+	btintel_pcie_free_restart_list();
+}
+
+module_init(btintel_pcie_init);
+module_exit(btintel_pcie_exit);
 
 MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
 MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver " VERSION);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 7dad4523236c..0fa876c5b954 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -117,7 +117,9 @@ enum {
 enum {
 	BTINTEL_PCIE_CORE_HALTED,
 	BTINTEL_PCIE_HWEXP_INPROGRESS,
-	BTINTEL_PCIE_COREDUMP_INPROGRESS
+	BTINTEL_PCIE_COREDUMP_INPROGRESS,
+	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
+	BTINTEL_PCIE_SETUP_DONE
 };
 
 enum btintel_pcie_tlv_type {
-- 
2.43.0

