Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F52F1FC3
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683366; cv=none; b=ibiUHN/x15aEklpc+pEw/s/kXn3+LvQNVo0v6CdTIjdmKRyqCTUAhfF1mtKsEXUAVbCupaI4bLklPaY/FnlkhJxtAHQ/Ixm2QgKU8w3mODiqZt9gma6628g2E5DTG8u5YUcOAdbxBZhI0uItdDTcEidpzAhJeXlf29cLGdzoCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683366; c=relaxed/simple;
	bh=8GJAGRDIa2/DCWZveo4/edDTV53BXUg0DWu1QHMre8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZe09Hi/9FnDK5u7z+T553yCB6FP7Q8EFg/bUQGB+67yzPsoiF/TDCnwJQC5zqDposq3Jrm75jMAq/JDKcjEYiyLrVXMIDRYGYQgcTK10FmfTl7CMo2zLHNRQusqVimdkeOH0DNODRmpZpMcd27dR9aUc8iAtbhF9c1CK+BoOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRFD85sS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRFD85sS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784683365; x=1816219365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8GJAGRDIa2/DCWZveo4/edDTV53BXUg0DWu1QHMre8Y=;
  b=GRFD85sSBBGOk6iXP4xwU63MK4+gvbC8fbUdwxJGx1qHs2m32cxu1bbW
   kAiI7CmpxX05g9Er7FgvhMxihl6tldrvH8mmrpo/2mrvRYTqwIrRz++W9
   v7Gm8yF4g4l3J861qh8ybcatxrRvo2GdotqOiihFHyclxWhBC5frUP5P6
   1nA+xLX+ONKtj8e7Mm5dxPl0TU5FVXoVoxMPC4Twe/2UgM1xgjldBclOa
   xLOiRYeIspVeJdPCHjDPUzDSBIaWCtxzXBwA5RutNPmlVCrbPGgvoj3b9
   Wgl8GbPny5k6IYi0JchT2OB3b/IVfibFonMod4ffLXNxqSExsMn1dBLfn
   g==;
X-CSE-ConnectionGUID: o6LONi0YQCKgYnqyTRTh4w==
X-CSE-MsgGUID: Xjdbw5Z9QhujTsKtateOLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="84283055"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="84283055"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 18:22:44 -0700
X-CSE-ConnectionGUID: QWI4t9WxSFKd7pQGF960Vw==
X-CSE-MsgGUID: FUGAxBAbRFu4ioI72TrSMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="253565840"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jul 2026 18:22:42 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for PLDR
Date: Wed, 22 Jul 2026 06:51:57 +0530
Message-ID: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
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
Changes in v4:
  - Rebased on latest bluetooth-next (6f55ad8fb0ac) to fix
    CI apply failure

Changes in v3:
  - Dropped reset_type parameter approach from hdev->reset()
  - Directly call btintel_pcie_request_reset() instead of manual
    flag manipulation and schedule_work()
  - Accept only integer 0 for PLDR trigger
  - Handle schedule_work() failure: release pci_dev_get refcount
    and clear RECOVERY_IN_PROGRESS flag
  - Fix remove ordering: device_remove_file before disable_work_sync

Changes in v2:
  - Added reset_type parameter to hdev->reset() callback (1/2)
  - vendor_rst sysfs used reset_type to select PLDR (2/2)

Changes in v1:
  - Initial vendor_rst PCI sysfs implementation
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

