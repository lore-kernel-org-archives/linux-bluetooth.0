Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BF448B9B
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754651; cv=none; b=RWmlOOqRN0IeI1WitdyGC77JwA0WMCR1USy1sEfDSt0poReHniDsRiMMmJd0Z1nRpedsk7rSnG+Jt8jS5oZZjZVbyJWEB3Usv0+5jb2VtqQcZwP2empjKiQIfLlhBEbowCMojN3MTmj4Yq/iuVbxJucAUHhVYWNTg/f/N0FlW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754651; c=relaxed/simple;
	bh=K0qowe4MuzOWdt7HK1amLRxItfaW7nSsO4vUvRkmfg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNM7kce9r19OBQ1q4/LyuN0vOAVLT5COpk2TwIlF0goBsnnoq3TuGZ2B/oeeomCTwNtJsFAQqj7gMSfQ94anpos1d9N16FPzp5Sx/YEwYhgxZg2YoifJ5L3jVvRFTiOml5m3vGwchjePS7h88F5MetTMgY7YB1QDJMbCNJmbIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDXNDYBO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDXNDYBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754649; x=1822290649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0qowe4MuzOWdt7HK1amLRxItfaW7nSsO4vUvRkmfg4=;
  b=MDXNDYBOzCCAliyM4qNn2Row56RKZMlVMvNVYQ30DMnC7VGQXSDuj49I
   c/eIM7vYiDEjNaHOKQjeAlReF8JE27Hsn2sriix40/eNGEcTdhfj3ubPX
   +9q3ggMVOs5iKFMQVuZxWcUOKWJCBFqBjlXMP26AB4cjGR2vRIqR3c30F
   xZeaa92Zm/jqfezzi+vnZHyYaZL1AK17jeAwAvKy4F73C43+U+6x4yrpD
   4Vl1rX//qxYm+S93jTnfuG0/bBom5QfZYuz5S+75ltXGHGDd6IS+DcMC3
   pBFCaY8R+Kr2YqnS8yUSfuDVmCCPqVZOAJQf2QDOERwna3UtO47iyQDEn
   Q==;
X-CSE-ConnectionGUID: IzK6dEOpQGC4N3RkH9T4kQ==
X-CSE-MsgGUID: irUssu3LTEqmYGnUCphAcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90386158"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90386158"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:50:48 -0700
X-CSE-ConnectionGUID: CHPYADSDQeyAh6uFptcPIQ==
X-CSE-MsgGUID: Eegl+w3dSF+2dkr5wZd8lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274816287"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2026 00:50:46 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 4/4] Bluetooth: hci_debugfs: add force_hw_rfkill test hook
Date: Wed, 30 Sep 2026 13:12:20 +0530
Message-ID: <af7525184b7c910d8f5bc313805ac31293711c19.1790752799.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790752799.git.aluvala.sai.teja@intel.com>
References: <cover.1790752799.git.aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a force_hw_rfkill entry under /sys/kernel/debug/bluetooth/hciN/ for
HCI devices with a registered rfkill handle. Writing Y/N sets the
hardware block state through hci_rfkill_set_hw_state(), which exercises
the generic Bluetooth HW rfkill handling without requiring a transport
driver to assert its physical rfkill line. Reading returns the hardware
block state from rfkill_hard_blocked(), independently of any software
block. Writing the current state returns -EALREADY.

The read and write handlers check HCI_UNREGISTER and hdev->rfkill under
hdev->unregister_lock, so they fail with -ENODEV rather than use an
rfkill handle that is being destroyed. The entry uses custom open and
release operations that pin the debugfs file with debugfs_file_get() and
debugfs_file_put(), so hdev cannot be released while a descriptor is
open. After a successful write, the handler drops unregister_lock and
flushes hdev->rfkill_block, so the caller observes the settled
HCI_RFKILLED state without blocking the work, which may itself need that
lock.

The hook does not exercise driver-specific interrupt, doorbell or
register logic that detects the hardware event; that still requires
real hardware or transport-level emulation.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 net/bluetooth/hci_debugfs.c | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 2559fb6324d6..a14d2ae8cab5 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -20,6 +20,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/kstrtox.h>
+#include <linux/rfkill.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -306,6 +307,108 @@ static const struct file_operations sc_only_mode_fops = {
 	.llseek		= default_llseek,
 };
 
+static int force_hw_rfkill_open(struct inode *inode, struct file *file)
+{
+	int err;
+
+	err = debugfs_file_get(file->f_path.dentry);
+	if (err)
+		return err;
+
+	err = simple_open(inode, file);
+	if (err)
+		debugfs_file_put(file->f_path.dentry);
+
+	return err;
+}
+
+static int force_hw_rfkill_release(struct inode *inode, struct file *file)
+{
+	debugfs_file_put(file->f_path.dentry);
+
+	return 0;
+}
+
+/* Test-only hook to simulate a HW rfkill event without needing the
+ * underlying transport driver to assert its real rfkill line. It drives
+ * hci_rfkill_set_hw_state() directly, exercising the same rfkill core
+ * notification (hci_rfkill_set_block()) and power on/off handling that a
+ * genuine HW rfkill interrupt from any driver would trigger.
+ */
+static ssize_t force_hw_rfkill_read(struct file *file, char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+	bool blocked;
+
+	mutex_lock(&hdev->unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER) ||
+	    IS_ERR_OR_NULL(hdev->rfkill)) {
+		mutex_unlock(&hdev->unregister_lock);
+		return -ENODEV;
+	}
+	blocked = rfkill_hard_blocked(hdev->rfkill);
+	mutex_unlock(&hdev->unregister_lock);
+
+	buf[0] = blocked ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_hw_rfkill_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	mutex_lock(&hdev->unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER) ||
+	    IS_ERR_OR_NULL(hdev->rfkill)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (enable == rfkill_hard_blocked(hdev->rfkill)) {
+		err = -EALREADY;
+		goto unlock_flush;
+	}
+
+	hci_rfkill_set_hw_state(hdev, enable);
+	err = count;
+
+unlock_flush:
+	mutex_unlock(&hdev->unregister_lock);
+
+	/* hci_rfkill_set_hw_state() updates the rfkill core state
+	 * synchronously, but applies the HCI_RFKILLED flag and resulting
+	 * power handling asynchronously via hdev->rfkill_block. Flush after
+	 * dropping unregister_lock because the work may submit a sync command
+	 * that also takes this lock.
+	 */
+	flush_work(&hdev->rfkill_block);
+	return err;
+
+unlock:
+	mutex_unlock(&hdev->unregister_lock);
+	return err;
+}
+
+static const struct file_operations force_hw_rfkill_fops = {
+	.open		= force_hw_rfkill_open,
+	.read		= force_hw_rfkill_read,
+	.write		= force_hw_rfkill_write,
+	.llseek		= default_llseek,
+	.release	= force_hw_rfkill_release,
+};
+
 DEFINE_INFO_ATTRIBUTE(hardware_info, hw_info);
 DEFINE_INFO_ATTRIBUTE(firmware_info, fw_info);
 
@@ -352,6 +455,10 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	if (hdev->fw_info)
 		debugfs_create_file("firmware_info", 0444, hdev->debugfs,
 				    hdev, &firmware_info_fops);
+
+	if (!IS_ERR_OR_NULL(hdev->rfkill))
+		debugfs_create_file("force_hw_rfkill", 0644, hdev->debugfs,
+				    hdev, &force_hw_rfkill_fops);
 }
 
 static int inquiry_cache_show(struct seq_file *f, void *p)
-- 
2.53.0

