Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69662145B24
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862315; cv=none; b=bbs2CwP92hGzbAj9klrsF6YBIwX3Jdp7uBLOaACvl13i/vlVSzx/oc/XfZ13qacEXvpA/kH+mw8TbK7MMqfM6JGB5/RpYT5NuzKAw5aD3eOB8NYWcuZy0OvNWedp8TUnaZEsIhXAME0pSkFFMOjzSLP8OTnT6xSouLg4vnHSdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862315; c=relaxed/simple;
	bh=U/lMzK8NoedWxpOGN/VlDqOMEqiFNoK+o4ZS9OkJOMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MOkaxP1NRmy2Rd5+APk+Wnli4XXjGnozKCrXC8+KLNMKG0AYntspYUzxDTXq1nd7VkC9uQ5bE0DNlm1Ao6U3Wa4zKxYjHMAZaMo1IV+GHkH6CNje4zkZJA/eqDpajK8RQAfO07iCbOVcAMyy9BQxYyrzemw+/2Qd3IVnKJTxtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H158PHbZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H158PHbZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715862313; x=1747398313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/lMzK8NoedWxpOGN/VlDqOMEqiFNoK+o4ZS9OkJOMU=;
  b=H158PHbZcNgtkYoRIVXBruMMQgozCg4hbNxBMCnJ66aiBrmOskJjPSvF
   yKLqOrch9BH2PtyNhqgZdkMaJ5Q7FQPhwz4n8vyS78vFLv0dm1kohpLqz
   +/iRQBEr1qIyZeqF0PUgjHFA6LvIi/BHnxPgVsIkUz/PxicMSqHp8iWOT
   8nwW6LDsvtibzUYzs7DsJ1cMz14qV956VFGT59D/ZB6XjBH4ibxP9HVN5
   v0ykMWI/UxDORroHEfiJ7wlsj2U1j2Cf3QA+ctLy/w5apPi43KpQ93FAf
   b2PMnC02sLsWqIF8lt3Z9d8NxwOvko8N3kWXEwf/q75w27xkL+9Gh6Mne
   A==;
X-CSE-ConnectionGUID: ldcDyEGGRXq/RbVPKJEcBA==
X-CSE-MsgGUID: ghjgpovDR3CrJq/sEegFTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15790874"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="15790874"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 05:25:12 -0700
X-CSE-ConnectionGUID: ka5ffwMtSxCjfJJ/G6QWWg==
X-CSE-MsgGUID: u6AfX0leTzaZVbBb8G7bog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="62246350"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 16 May 2024 05:25:10 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	vijay.satija@intel.com,
	Kiran <kiran.k@intel.com>
Subject: [PATCH v1 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
Date: Thu, 16 May 2024 18:09:36 +0530
Message-Id: <20240516123938.891523-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiran <kiran.k@intel.com>

Firmware sequencer (FSEQ) is a common code shared across Bluetooth
and Wifi. Printing FSEQ will help to debug if there is any mismatch
between Bluetooth and Wifi FSEQ.

Signed-off-by: Kiran <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 ++-
 drivers/bluetooth/btintel.h      | 5 +++++
 drivers/bluetooth/btintel_pcie.c | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0c855c3ee1c1..2c434ff9c47c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2713,7 +2713,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 }
 EXPORT_SYMBOL_GPL(btintel_set_msft_opcode);
 
-static void btintel_print_fseq_info(struct hci_dev *hdev)
+void btintel_print_fseq_info(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	u8 *p;
@@ -2825,6 +2825,7 @@ static void btintel_print_fseq_info(struct hci_dev *hdev)
 
 	kfree_skb(skb);
 }
+EXPORT_SYMBOL_GPL(btintel_print_fseq_info);
 
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b5fea735e260..796953547932 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -244,6 +244,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver);
 int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
+void btintel_print_fseq_info(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -373,4 +374,8 @@ static inline int btintel_shutdown_combined(struct hci_dev *hdev)
 static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
+
+static void btintel_print_fseq_info(struct hci_dev *hdev)
+{
+}
 #endif
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5b6805d87fcf..8d282ee2322c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1197,9 +1197,11 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
 			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 		err = -EINVAL;
+		goto exit_error;
 		break;
 	}
 
+	btintel_print_fseq_info(hdev);
 exit_error:
 	kfree_skb(skb);
 
-- 
2.40.1

