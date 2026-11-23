Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415724;
	b=R7RB7s/Pf8j9phLZWjBWCLPK9j9gd1FPh7uSU/XthEPivoeHP+mEak5+g15TvugTYXpD
	 8LJo0u9G4O75RAWWkHT4nqVZlqjV5/gg3mSPwbknfjp2L2ZdcYwo5KOMMh8Edu5ap98tC
	 KJs8xcZVlLasUzZKhhRf9m4hqvPCLB3FUa7FLWoQ5DcmD7ItAoG/pcCwJOAIxjbxOytHu
	 6xhaxOPz4/NDH/2PfOsUiOGNIwOUArqM3wm3EClwgZjZhrbU/1bJavW7j8T1qtwLq6J2s
	 Lc3jeowezXZBtwoOl0BsYOgxy9NpfZf/GwWN4r51EDmTYqjECRkN+icYjT+RttvF29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415724;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DPUMvnBMfymSZYzX/NzoGlsYJ3farPsLNDSOZJLNOR4=;
	b=SiwiLICpSPPwp3jHOZ+mnHq1e0neMlWzTDiak5ebVjRaojWndNCvbwuOzewVRvmvz35c
	 WPrdTSgKS8lteTXwopLwb/hBYdu3uDkEb9S/urJHXOzzWC8Pmucr2axB3pb9IO1G3lw0m
	 8xbtjYeZ1pWULZFl5H2ctC0ON+8SUF5Qs5RzLDMNXybgiPyu/pVcD5CU5MFm3RlrOeN/8
	 o0GxXCLLbFsSK2MoHH93lajSvq6Kk1v+B1pmtoT3SUbiRlXBLHEXxjD86xj8FoAYBsLZf
	 q9/aSV1FDEiK6RQL2c8f0Wbe3F3dWAIaEdSlcEdhGHEtdmdp+pNPQC1RPdVhASQWjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X49Of7Nh;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C00606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 06:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X49Of7Nh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795415725; x=1826951725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y8r4rZTyvasttV9sPzeJkC1Id14OJpexpfzXtGNjQnw=;
  b=X49Of7NhAWIwFPSH0do7ZNbW86miXnCF1OXeKMBf2L+RfS3VaOVow2kc
   dQ0MFjOT6Z4wKbrrShHG+FnRPN9lWezl2emsvcEt2a0KJeyTw97N5Lt+h
   Zna8iWVa9ZkVHfHwqycL/tEa/CQiEyyQEOUHNDyPQ+GTqHqdTZIdwn27t
   y+w6qMmS0yVtTvLF9/Sy1dmktEJTJMDeF/2px710ELxsxooSNvHKphN/3
   uOo7M2n8/ezHzjSembU3n+Gowr9xZ2FL69vZMA9dSKYMekogonOSHUT05
   6eWXrGwUjJZXnguGnlwNKWGyK8C9Dp0QRPrySOvFfelcgjZNJt3PxQ6hF
   w==;
X-CSE-ConnectionGUID: oprg/LfdRMiGA4PwZAbKOg==
X-CSE-MsgGUID: AnxWpmF9T1OrL7hRfVYEPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4316350"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4316350"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 22:35:24 -0800
X-CSE-ConnectionGUID: jWVJAoIuQ4e9rLnD9NqkMg==
X-CSE-MsgGUID: A9IqsVYfTxOr//EFAItxQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="12925790"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa012.fm.intel.com with ESMTP; 22 Nov 2026 22:35:23 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	ravindra@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Serialize MAC access requests
Date: Mon, 23 Nov 2026 12:25:23 +0530
Message-ID: <20261123065523.2769017-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123065523.2769017-1-kiran.k@intel.com>
References: <20261123065523.2769017-1-kiran.k@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MAC_ACCESS_REQ is requested and released with an unlocked
read-modify-write of FUNC_CTRL. The YoYo config set path and the dump
workqueue (device memory read and trace dump) can run it concurrently.
One path can then release MAC_ACCESS_REQ while another is still
accessing the target, or their FUNC_CTRL updates can overwrite each
other.

Hold a new mac_access_lock across the whole request, access and release
sequence in these users. Also release MAC_ACCESS_REQ when the request
fails, so a timed-out request is not left set.

Fixes: 68e0925f16c0 ("Bluetooth: btintel_pcie: Add yoyo support for config set TLV")
Assisted-by: Copilot:claude-sonnet-5.5
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 15 ++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  4 ++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 75f1724336ae..3b2c8bbb36e9 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1035,6 +1035,7 @@ btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 
 		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
 		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
+			mutex_lock(&data->mac_access_lock);
 			ret = btintel_pcie_get_mac_access(data);
 			if (ret) {
 				BT_WARN("YoYo: MAC access failed for config set (%d), skipping",
@@ -1044,6 +1045,7 @@ btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 				 * request bit is not leaked.
 				 */
 				btintel_pcie_release_mac_access(data);
+				mutex_unlock(&data->mac_access_lock);
 				continue;
 			}
 		}
@@ -1104,8 +1106,10 @@ btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 		}
 
 		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
-		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM)
+		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
 			btintel_pcie_release_mac_access(data);
+			mutex_unlock(&data->mac_access_lock);
+		}
 	}
 }
 
@@ -1752,15 +1756,19 @@ static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
 	int ret;
 
+	mutex_lock(&data->mac_access_lock);
 	ret = btintel_pcie_get_mac_access(data);
 	if (ret) {
 		bt_dev_err(hdev, "Failed to get mac access: (%d)", ret);
+		btintel_pcie_release_mac_access(data);
+		mutex_unlock(&data->mac_access_lock);
 		return;
 	}
 
 	ret = btintel_pcie_read_debug_regions(data);
 
 	btintel_pcie_release_mac_access(data);
+	mutex_unlock(&data->mac_access_lock);
 
 	if (ret)
 		bt_dev_err(hdev, "Failed to dump traces: (%d)", ret);
@@ -1884,9 +1892,12 @@ static int btintel_pcie_read_device_mem(struct btintel_pcie_data *data,
 	u32 *val = buf;
 
 	/* Get device mac access */
+	mutex_lock(&data->mac_access_lock);
 	err = btintel_pcie_get_mac_access(data);
 	if (err) {
 		bt_dev_err(data->hdev, "Failed to get mac access %d", err);
+		btintel_pcie_release_mac_access(data);
+		mutex_unlock(&data->mac_access_lock);
 		return err;
 	}
 
@@ -1899,6 +1910,7 @@ static int btintel_pcie_read_device_mem(struct btintel_pcie_data *data,
 		*val = btintel_pcie_rd_dev_mem(data, dev_addr);
 
 	btintel_pcie_release_mac_access(data);
+	mutex_unlock(&data->mac_access_lock);
 
 	return 0;
 }
@@ -4863,6 +4875,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	spin_lock_init(&data->hci_rx_lock);
 	spin_lock_init(&data->ipc_lock);
 	spin_lock_init(&data->dev_mem_lock);
+	mutex_init(&data->mac_access_lock);
 	mutex_init(&data->rfkill_doorbell_lock);
 
 	init_waitqueue_head(&data->gp0_wait_q);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 124e837da94b..97267a7e9762 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -773,6 +773,10 @@ struct btintel_pcie_data {
 	 * PRPH_DEV_RD target access register pair. Never sleep while held.
 	 */
 	spinlock_t	dev_mem_lock;
+	/* lock to serialize the MAC_ACCESS_REQ get/release sequence together
+	 * with the target accesses done under it. Held across sleeping calls.
+	 */
+	struct mutex	mac_access_lock;
 
 	void __iomem	*base_addr;
 
-- 
2.54.0

