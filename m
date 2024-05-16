Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190714658E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864454; cv=none; b=Yi6vWdCfYeRl6HSojVgFEkAZAOvI5kHnNs5erC0W9LvjCShrh6hBtT1KQunRSgETr9HZTtAcGNzxH6BBrFsVf58iVIFC5tZvr935LksXTvafnqwol3ah75DOkMmgK5CpO1hyOM6tvKfoXGtzfl4wKDfqeemvQu7HX3pDEcRJjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864454; c=relaxed/simple;
	bh=U/lMzK8NoedWxpOGN/VlDqOMEqiFNoK+o4ZS9OkJOMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAq47IFz+rMw49ItLNSbA2FGiMJ5hWqEywzRyu3XBLuqlNkJVIobkEjSSAgM90Y8aCcV/JCFED4vNEFooO7KJ7WFvO1IHomikXTPQ3/b3Oi2PR0n3Sl+7cjEuSxAeKep8PRUnc66tyCo5iMVyFlErLAm8pkTNfdZ9fqTLFuVops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVPR439U; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVPR439U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715864453; x=1747400453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/lMzK8NoedWxpOGN/VlDqOMEqiFNoK+o4ZS9OkJOMU=;
  b=eVPR439UWzSjq4jUJfVXWKk0ZzejE4iXxz9cjr12LmsiNYm7GSstQOXh
   q+iLay35DwkNchdddCnxwr/4TR73gRl9MP/ioprNUD6tO0QAoQOhjfQH1
   neMbT3BYUXF7zpZbz6x0I0WWl6Z6DYMYVPoW9QtoW8SFPa0calyVwhK7z
   MHtrKAxTLJrcR9eWJPlFKWJyZBfmukedux8HzR8Zd87KF9Mv7xeI9JzWa
   nSzRANyDVfm3lPFbg91LSjlVnoESaWuaj9CMwX+gtCHaO+nY2dqw2z16m
   rbt0qQpTonhZAv9Lw7Y90TqoHPeFoyDaorBUBPyD+2TyJVCxyDAv1m74G
   Q==;
X-CSE-ConnectionGUID: pffcZDMXThijHV0Tij4HpQ==
X-CSE-MsgGUID: GeVmGFD/T6Oi0V5gvj0pmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23108528"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23108528"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:00:52 -0700
X-CSE-ConnectionGUID: giRgRybtRkOUInuYIqJtuA==
X-CSE-MsgGUID: 3AdWsTqbS62NaSTJpp8XXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="54623611"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa002.fm.intel.com with ESMTP; 16 May 2024 06:00:50 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	vijay.satija@intel.com,
	Kiran <kiran.k@intel.com>
Subject: [PATCH v2 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
Date: Thu, 16 May 2024 18:45:08 +0530
Message-Id: <20240516131510.904787-1-kiran.k@intel.com>
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

