Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C833C9
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558919; cv=none; b=q03BrMDZf4c4kFXurog+zj3cnHHga8hDQQJfmJ/BvHbzwCdIfSClUocrWhIf7FRsY9pRFlMDE7LEqybHiRB52b4AB8812jYwjrDf08ofQYg0mp44vM5+eUc6/1CTv/nuRS7hAOj4pdUrkrPSdltuLmLpnG6sI+OeTZmVRyiP5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558919; c=relaxed/simple;
	bh=ihBKF4O/TSiiMmceUe+PvXcfv3afwZL4YmZ8dYPQwZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSwoMjamxrg66+X7SdFpkyKkMPcsXMFnBIzzje/9W2G4O2J5wqKfCzb6iRvxK5Nq+04lUIhbWNtmDfLLXJ1rx3Jod6VDtAoF3tPTEhKto+9/2g+bzI6ux9WBNtByg1qaujmxn5yneRUTDn/sZCijwHKbIYiE04tOgwf2Df1Pmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqIB5TU9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqIB5TU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743558918; x=1775094918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ihBKF4O/TSiiMmceUe+PvXcfv3afwZL4YmZ8dYPQwZU=;
  b=SqIB5TU9fph+0LEjx/E46ei81RLt2QfQ7GxI7PGB8fdJJ2sKn6SVcM+z
   p4IFCMSy+5XA6kOwXAbRWGLZnGOXfFRzHYtLG56tI/pNGA5a0VVGBJg/1
   UUijpMkT03MrKYyQ3BObLtB7oILutosd8HqKUkM72Xyxu9XUrXDTrtKvO
   ijVoQDhxEpGwMH0YVt4ofQnqVWTSnbrgwhwRf6lXEphtWb3yak6nY40qL
   joG9gXiljnWpFjjFogwakmQiXnXtDMkHBV7b17grQ2oCui6eZFW9vfsv9
   TksvSS/J56kFNK0cep3vp2aooSYzCyS7yw9RQSWg43ffe41uvS6qhjYPd
   Q==;
X-CSE-ConnectionGUID: 2BBixBWbTqaICeoRLnwapg==
X-CSE-MsgGUID: RshEU1IZQZSEdvP9WaHoKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="48695339"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="48695339"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 18:55:17 -0700
X-CSE-ConnectionGUID: bUGfkdcFS9a/G43VnbupJw==
X-CSE-MsgGUID: v8HcTBq2QSyG5lA1KKGuGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="130665370"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 01 Apr 2025 18:55:14 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Do not generate coredump for diagnostic events
Date: Wed,  2 Apr 2025 07:41:48 +0530
Message-ID: <20250402021148.63748-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Intel diagnostic events are part of HCI traces and there is no need
to generate coredump for the same.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      |  3 +--
 drivers/bluetooth/btintel.h      |  6 ------
 drivers/bluetooth/btintel_pcie.c | 10 ----------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 48e2f400957b..ae92490d0c78 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3688,7 +3688,7 @@ int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name)
 }
 EXPORT_SYMBOL_GPL(btintel_configure_setup);
 
-int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
+static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct intel_tlv *tlv = (void *)&skb->data[5];
 
@@ -3716,7 +3716,6 @@ int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 recv_frame:
 	return hci_recv_frame(hdev, skb);
 }
-EXPORT_SYMBOL_GPL(btintel_diagnostics);
 
 int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 2aece3effa4e..1d12c4113c66 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -277,7 +277,6 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 void btintel_print_fseq_info(struct hci_dev *hdev);
-int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -411,9 +410,4 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 static inline void btintel_print_fseq_info(struct hci_dev *hdev)
 {
 }
-
-static inline int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	return -EOPNOTSUPP;
-}
 #endif
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index c1e69fcc9c4f..e0b50513403f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -889,7 +889,6 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *)skb->data;
-	const char diagnostics_hdr[] = { 0x87, 0x80, 0x03 };
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
 
 	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
@@ -945,15 +944,6 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 			}
 		}
 
-		/* Handle all diagnostics events separately. May still call
-		 * hci_recv_frame.
-		 */
-		if (len >= sizeof(diagnostics_hdr) &&
-		    memcmp(&skb->data[2], diagnostics_hdr,
-			   sizeof(diagnostics_hdr)) == 0) {
-			return btintel_diagnostics(hdev, skb);
-		}
-
 		/* This is a debug event that comes from IML and OP image when it
 		 * starts execution. There is no need pass this event to stack.
 		 */
-- 
2.43.0

