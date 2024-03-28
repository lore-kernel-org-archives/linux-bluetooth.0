Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F79535A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623915; cv=none; b=S05vbR10sBwNqixZ4d0oB5Y33YD4NM7UqvPonMipD6vDw6ZGXyx7pgkDBe9HwYMVk/vF0CwbnWcgq+4+EDo2+Ck/A10jonIc8QfM6cXquuC6AQgV44klwNtzpaJmgNbbV7jAj9VdrAZZDQT6lodm6/0dr60HOYeLBKZ4nxznWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623915; c=relaxed/simple;
	bh=28ChPfvhRyR6eEbB0jiEZgDBd1Aut8NmTUjXBew47Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7YXf3Ran27iaGWyfOY/IxOt3/ExbU68LEAbHFu+aDsFnkeegmnPCKHxvxOcsL3eFK9JgqWxw2lmA91rEl918Y6riC6DGYSJIRdJCHiCPnpWtZgJ/f8iMOaSIC8pLJkEKmNhvpxPMgV3ZBw6OuaJI7aZJTBcXX5nPV+9gmVhwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCm4VdTQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCm4VdTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711623913; x=1743159913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=28ChPfvhRyR6eEbB0jiEZgDBd1Aut8NmTUjXBew47Qg=;
  b=TCm4VdTQ6U8ocTJUblUfHq6KVPE9x618snB9C6Tx9kCdq5YesWGP3VXZ
   jm0WVgSX9Y0ewGSpzPKzc8JTSF1fhacVD2/sZsaQdc8n6VhnCAZvZ02LX
   YRy1yuAhqzRj1xTSnLnUdbhxWfuee+w595hPVFSAC7s6lHkQiMrwhyoZt
   h5ea5PjHlOtPZrjJ3SS6DU4zDOkvZtUGK8dFytmrcv6fCX1pn95pnZzdJ
   tXYT+UKonKbqsh2Rg9/+s5xT5yFyYzYGljJB1xSUlmSDZ5eFLl6urC7R3
   SrSoNSjH2FfnStnqfUq9Mh+zvfRE0x6493YPT7BYUAWhF0+lnSRd2ofIl
   Q==;
X-CSE-ConnectionGUID: yiVyAD9ASRegMWG3W2jEbg==
X-CSE-MsgGUID: 3ikaPseDRCqurW+M0iHE6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10551748"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="10551748"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 04:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17021573"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa007.jf.intel.com with ESMTP; 28 Mar 2024 04:05:10 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/3] Bluetooth: btintel: Export few static functions
Date: Thu, 28 Mar 2024 16:49:02 +0530
Message-Id: <20240328111904.992068-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the functions used in btintel.c is made global so that they can
be reused in other transport drivers apart from USB.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 26 +++++++++++++---------
 drivers/bluetooth/btintel.h | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd95..c687934983d1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -245,7 +245,7 @@ static int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
 	return ret;
 }
 
-static void btintel_hw_error(struct hci_dev *hdev, u8 code)
+void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct sk_buff *skb;
 	u8 type = 0x00;
@@ -277,6 +277,7 @@ static void btintel_hw_error(struct hci_dev *hdev, u8 code)
 
 	kfree_skb(skb);
 }
+EXPORT_SYMBOL_GPL(btintel_hw_error);
 
 int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 {
@@ -455,8 +456,8 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
-static int btintel_version_info_tlv(struct hci_dev *hdev,
-				    struct intel_version_tlv *version)
+int btintel_version_info_tlv(struct hci_dev *hdev,
+			     struct intel_version_tlv *version)
 {
 	const char *variant;
 
@@ -543,10 +544,11 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
-static int btintel_parse_version_tlv(struct hci_dev *hdev,
-				     struct intel_version_tlv *version,
-				     struct sk_buff *skb)
+int btintel_parse_version_tlv(struct hci_dev *hdev,
+			      struct intel_version_tlv *version,
+			      struct sk_buff *skb)
 {
 	/* Consume Command Complete Status field */
 	skb_pull(skb, 1);
@@ -648,6 +650,7 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btintel_parse_version_tlv);
 
 static int btintel_read_version_tlv(struct hci_dev *hdev,
 				    struct intel_version_tlv *version)
@@ -2596,8 +2599,8 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 	data->acpi_reset_method = btintel_acpi_reset_method;
 }
 
-static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
-					struct intel_version_tlv *ver)
+int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
+				 struct intel_version_tlv *ver)
 {
 	u32 boot_param;
 	char ddcname[64];
@@ -2681,8 +2684,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btintel_bootloader_setup_tlv);
 
-static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
+void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 {
 	switch (hw_variant) {
 	/* Legacy bootloader devices that supports MSFT Extension */
@@ -2705,6 +2709,7 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 		break;
 	}
 }
+EXPORT_SYMBOL_GPL(btintel_set_msft_opcode);
 
 static void btintel_print_fseq_info(struct hci_dev *hdev)
 {
@@ -3066,7 +3071,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	return err;
 }
 
-static int btintel_shutdown_combined(struct hci_dev *hdev)
+int btintel_shutdown_combined(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	int ret;
@@ -3100,6 +3105,7 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
 
 int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 64ab5a2860ab..1462a57420a0 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -234,6 +234,16 @@ void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
 int btintel_set_quality_report(struct hci_dev *hdev, bool enable);
+int btintel_version_info_tlv(struct hci_dev *hdev,
+			     struct intel_version_tlv *version);
+int btintel_parse_version_tlv(struct hci_dev *hdev,
+			      struct intel_version_tlv *version,
+			      struct sk_buff *skb);
+void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant);
+int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
+				 struct intel_version_tlv *ver);
+int btintel_shutdown_combined(struct hci_dev *hdev);
+void btintel_hw_error(struct hci_dev *hdev, u8 code);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -330,4 +340,37 @@ static inline int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 {
 	return -ENODEV;
 }
+
+static inline int btintel_version_info_tlv(struct hci_dev *hdev,
+					   struct intel_version_tlv *version)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btintel_parse_version_tlv(struct hci_dev *hdev,
+					    struct intel_version_tlv *version,
+					    struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
+
+{
+}
+
+static inline int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
+					       struct intel_version_tlv *ver)
+{
+	return -ENODEV;
+}
+
+static inline int btintel_shutdown_combined(struct hci_dev *hdev)
+{
+	return -ENODEV;
+}
+
+static void btintel_hw_error(struct hci_dev *hdev, u8 code)
+{
+}
 #endif
-- 
2.34.1

