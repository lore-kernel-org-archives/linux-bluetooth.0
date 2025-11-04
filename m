Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070FF261B70
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240221; cv=none; b=pHtp3UKfdmXPAsz/OqqaVHS5cYsVPaK9aOxjzDD6XGIxVp00fYUCmebKkudtZoppMOnnd/5zWXQaU1ZeK9PiAsARE1+xFifafKQ2ZnYiX8PeDFB/V2MalM9oH7mHizHoR+IYf2l6sPLozd1rvzYXqFGXE41faqlhPybV9kLEVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240221; c=relaxed/simple;
	bh=Mg0+h/ml5WkPgoaVJV4P3HkW3yAGxs+t3okvLY4BvrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qd8+L2zT3BClvWOlYxbhsp1klgX9ftfnWCPmfKJa4JecmhDo/tWuj2liikbWULHtLlCCBoGY8WsAc/MMdJJfSVZdzgDrB0FgNojdBBRD/TvEBYj5SC+vfWIsBU6MxuntOgqZwqjlvBH9JHhpEjBwSCGA5N6q5PC/LVIMi4lx2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fORQKFBo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fORQKFBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762240220; x=1793776220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mg0+h/ml5WkPgoaVJV4P3HkW3yAGxs+t3okvLY4BvrU=;
  b=fORQKFBopA4m5TBcAnLPWkEnmLpYmpe3CdvMu5cPptFDIA6f1kgBgQoD
   gyhdYcoEMR+wWInH1GWd3DVL1TUtPtjF5yLjMihe+nrTBolkeF2i21NQX
   UYrs3sGMOaX/AmAbqEXdI/E7fD83aRLv87Ygs83GrhVGdDyc/kqzesQii
   P+4W11EocdF/bjSG9dtUZKEk67CA0VvZAq3Bbaxr3t9DW9VHHRT3w9kdS
   HHddZMk/os7wG10Sb3dmv4tvKKEUu3BjXr8T/Bnh4LUczv1qs7vQRyulF
   rcbC3rFOCg8/Tw0A1OxxaIBjWfC/0z0AHcMYm9bk11F6AB1kitbmF2IFw
   A==;
X-CSE-ConnectionGUID: 2sIiYK8sSkWF+aA5/lgmRQ==
X-CSE-MsgGUID: uLAjatp5Q3Kq4vcKPyu20w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68165068"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68165068"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 23:10:20 -0800
X-CSE-ConnectionGUID: RIsggAvvRZygMDNwj+mNIQ==
X-CSE-MsgGUID: sKVrumSNShu7uFzaetdbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="191429764"
Received: from latitude-5491.iind.intel.com ([10.224.186.158])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2025 23:10:17 -0800
From: Chethan T N <chethan.tumkur.narayan@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	kiran.k@intel.com,
	Chethan T N <chethan.tumkur.narayan@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
Date: Tue,  4 Nov 2025 12:52:22 +0530
Message-Id: <20251104072222.195729-1-chethan.tumkur.narayan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the infrastructure that allow the user space program to
talk to intel pcie driver directly for fetching basic driver details.

The changes introduced are referred form
commit 04425292a62c15 ("Bluetooth: Introduce HCI Driver protocol")

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b0ad3c759ef5..7b47002fba75 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -19,6 +19,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_drv.h>
 
 #include "btintel.h"
 #include "btintel_pcie.h"
@@ -2360,6 +2361,63 @@ static bool btintel_pcie_wakeup(struct hci_dev *hdev)
 	return device_may_wakeup(&data->pdev->dev);
 }
 
+static const struct {
+	u16 opcode;
+	const char *desc;
+} btintel_pcie_hci_drv_supported_commands[] = {
+	/* Common commands */
+	{ HCI_DRV_OP_READ_INFO, "Read Info" },
+};
+
+static int btintel_pcie_hci_drv_read_info(struct hci_dev *hdev, void *data,
+					  u16 data_len)
+{
+	struct hci_drv_rp_read_info *rp;
+	size_t rp_size;
+	int err, i;
+	u16 opcode, num_supported_commands =
+		ARRAY_SIZE(btintel_pcie_hci_drv_supported_commands);
+
+	rp_size = sizeof(*rp) + num_supported_commands * 2;
+
+	rp = kmalloc(rp_size, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	strscpy_pad(rp->driver_name, KBUILD_MODNAME);
+
+	rp->num_supported_commands = cpu_to_le16(num_supported_commands);
+	for (i = 0; i < num_supported_commands; i++) {
+		opcode = btintel_pcie_hci_drv_supported_commands[i].opcode;
+		bt_dev_info(hdev,
+			    "Supported HCI Drv command (0x%02x|0x%04x): %s",
+			    hci_opcode_ogf(opcode),
+			    hci_opcode_ocf(opcode),
+			    btintel_pcie_hci_drv_supported_commands[i].desc);
+		rp->supported_commands[i] = cpu_to_le16(opcode);
+	}
+
+	err = hci_drv_cmd_complete(hdev, HCI_DRV_OP_READ_INFO,
+				   HCI_DRV_STATUS_SUCCESS,
+				   rp, rp_size);
+
+	kfree(rp);
+	return err;
+}
+
+static const struct hci_drv_handler btintel_pcie_hci_drv_common_handlers[] = {
+	{ btintel_pcie_hci_drv_read_info,       HCI_DRV_READ_INFO_SIZE },
+};
+
+static const struct hci_drv_handler btintel_pcie_hci_drv_specific_handlers[] = {};
+
+static struct hci_drv btintel_pcie_hci_drv = {
+	.common_handler_count   = ARRAY_SIZE(btintel_pcie_hci_drv_common_handlers),
+	.common_handlers        = btintel_pcie_hci_drv_common_handlers,
+	.specific_handler_count = ARRAY_SIZE(btintel_pcie_hci_drv_specific_handlers),
+	.specific_handlers      = btintel_pcie_hci_drv_specific_handlers,
+};
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
@@ -2386,6 +2444,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->set_bdaddr = btintel_set_bdaddr;
 	hdev->reset = btintel_pcie_reset;
 	hdev->wakeup = btintel_pcie_wakeup;
+	hdev->hci_drv = &btintel_pcie_hci_drv;
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
-- 
2.34.1

