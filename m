Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69879DA
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493293; cv=none; b=ZNrpVUImrZjimrTs9RXqTF2C21IRji9sJhKHXzjtpLE5rdBBcQ2wllCrdouWYrfUR96KYIPv5A1Sr2o0/jXctPXNEYJRL582tMYtSA1voXykIOua5HMLedsE8ogjK4J7vf3Groeuo95S8Soj4PuKhkVtPWLtQ4iDyfKf4WRqSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493293; c=relaxed/simple;
	bh=Vovt5w8HevSJ9arBdh/fJLPhgXuAnKhHM4jyci9gV2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gno+lQgOe7sBsQijSjRZhnv8ZrwjJ6rhyB+xwqZH9MT+DrEpH/ngwbgn8yXT9N55L/4NHExrpfR0+36svKoge5wzR7UrgOkf4Th3l8pZeESJ2Sfjh596liBGg8OWd1Na84v9S37ZIf0x8AdwxVRZLxXnyjLfKP2ubGBzLCOFJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzbN0G39; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzbN0G39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762493292; x=1794029292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vovt5w8HevSJ9arBdh/fJLPhgXuAnKhHM4jyci9gV2w=;
  b=JzbN0G39k5/vvFCKBikXBFndD0G7SNbQBN9yJF09pt69NpMX3xz47qLv
   N0JnmY4prdpelfkeN+rbwaQIAqEk9oDf5iQMMWf1MzCyTxrxGgW1DYfVW
   57tMq5gi4TGi6TIpB1piwe7w3fH8YSmLshReWQ1vi8/W1FcT2C0FWYJar
   tODfomZXMUWhplr7hjJF/zUtXKQJt891asYrygduBfcBix5u2hGhwuGD3
   T7grQGtR6pGWLpsn4E6J80cJMxIuPbwNysMKixW8rFgJ3Fxwln8y7hG5A
   +OrfFJkSGJksMvSYytu1DSytqMhr9smgBEbz3MYvyl50aUQUQodM7ALBW
   g==;
X-CSE-ConnectionGUID: Gx9KiZ04T7Oj9imtZsKqFA==
X-CSE-MsgGUID: 1ZCK52rNTaerq9znrn4DCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75755653"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="75755653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 21:28:10 -0800
X-CSE-ConnectionGUID: dF4Rg+55SC2ZEhsdhuvZ1Q==
X-CSE-MsgGUID: XPiRBHEeQPqPHR/lo7dKcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="218697463"
Received: from latitude-5491.iind.intel.com ([10.224.186.158])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2025 21:28:07 -0800
From: Chethan T N <chethan.tumkur.narayan@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	kiran.k@intel.com,
	Chethan T N <chethan.tumkur.narayan@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
Date: Fri,  7 Nov 2025 11:10:11 +0530
Message-Id: <20251107054011.219938-1-chethan.tumkur.narayan@intel.com>
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
index b0ad3c759ef5..2936b535479f 100644
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
+		bt_dev_dbg(hdev,
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

