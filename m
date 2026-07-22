Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797E2BEC34
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679322; cv=none; b=l9so6JYxm9wxy1s7r4yVu8xugdHnjH0aD0TibbxvdVu3bt2YlNPY91HShf9KhqTOCLCv2YxPqvD72zZ0d+A14nDszdqrHT9ei83Rh4zalQJnGdmMH3VToDTTxBbuBQvfLB/+UmBopZogJ60gD/tc3D5uWeGOx/PYVBkkr26QpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679322; c=relaxed/simple;
	bh=d9g1Tc9tmYbuSOmCrSNkVN8ZsiQamlsCM3orbPFVRVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8A4Kyx+JyiVZE/Rw8cT3slBGEa/XlFTHe0U5djQzb3BMPalIYcW70NtzAZUbFNoP604WGLigS6N8FMq14T8GXM40ecH+tLMzMDGHXXWChyDA2G1Cv8mm8orMVuf11MoCTEZ6prO0LXGlQhRdFzAMbh+ni7mz6TvqxujbRjzfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2MYSK5a; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2MYSK5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784679319; x=1816215319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9g1Tc9tmYbuSOmCrSNkVN8ZsiQamlsCM3orbPFVRVY=;
  b=G2MYSK5a0JzkxsLa5lNsYpwpq/lKLEDSzgV2mMEGbxKzOLG1HxfGEvdZ
   +TFHqLK39pK+yMksVDcSC8ywm3L3MAfVnk285O5kys4Vz8K3M9fPEb/lF
   tjWhetzZJNeoovyhX6iVtqDEOUpM6UYyhYCy3IxujsI9aXiEtakC+IjW7
   7vrt2Yg+LvZSBQokuPg0DDhS0YJAhrx6U6ghwafPPLqhx3x9W1ceYydG2
   plETIXl1/irSlQFN7IDZYmV4HYAU08Pgl/x5n/O6rP/qRtO5XrUrOuUFK
   M40EV6sVEzF5RStYe3GB07sLn4TuicLQHInQ+EZ2SOLXvZqCMSMznfbIC
   Q==;
X-CSE-ConnectionGUID: 0JVTJzAZTTSoNU6OZsFuNg==
X-CSE-MsgGUID: XETLrhsFQLeSCr0zpiXyqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="89121545"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="89121545"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 17:15:18 -0700
X-CSE-ConnectionGUID: uhkWowC+SUC4ablYKEAv3A==
X-CSE-MsgGUID: tJribj75T4KScJI3JtLJYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="255270715"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa008.fm.intel.com with ESMTP; 21 Jul 2026 17:15:15 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v3] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for PLDR
Date: Wed, 22 Jul 2026 05:44:33 +0530
Message-ID: <20260722001434.804931-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_rst
to allow userspace to trigger PLDR (Product Level Device Reset).
Reading the attribute displays supported reset types. Writing
integer 0 triggers PLDR. Any other input is rejected with
-EINVAL and a warning log.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 42 +++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2e28847263ab..a412ca7ff3ad 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2781,7 +2781,10 @@ static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
 	data->reset_type = type;
 
 	pci_dev_get(data->pdev);
-	schedule_work(&data->reset_work);
+	if (!schedule_work(&data->reset_work)) {
+		pci_dev_put(data->pdev);
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
+	}
 }
 
 static void btintel_pcie_hci_reset(struct hci_dev *hdev)
@@ -2791,6 +2794,36 @@ static void btintel_pcie_hci_reset(struct hci_dev *hdev)
 	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
 }
 
+static ssize_t vendor_rst_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned int val;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
+
+	if (!data || !data->hdev)
+		return -ENODEV;
+
+	if (kstrtouint(buf, 10, &val) || val != 0) {
+		bt_dev_warn(data->hdev, "PLDR rejected: invalid input");
+		return -EINVAL;
+	}
+
+	bt_dev_info(data->hdev, "PLDR triggered via sysfs");
+	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR);
+
+	return count;
+}
+
+static ssize_t vendor_rst_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0 - PLDR\n");
+}
+
+static DEVICE_ATTR_RW(vendor_rst);
+
 static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct btintel_pcie_dev_recovery *rec;
@@ -3010,6 +3043,11 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	if (err)
 		goto exit_error;
 
+	err = device_create_file(&pdev->dev, &dev_attr_vendor_rst);
+	if (err)
+		bt_dev_warn(data->hdev, "Failed to create vendor_rst sysfs (%d)",
+			    err);
+
 	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
 		   data->cnvr);
 	return 0;
@@ -3046,6 +3084,8 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
 
+	device_remove_file(&pdev->dev, &dev_attr_vendor_rst);
+
 	/* Cancel pending reset work. Skip only when remove() is called from
 	 * within the reset work itself (PLDR device_reprobe path) to avoid
 	 * deadlock. current_work() returns the work_struct of the caller if
-- 
2.43.0

