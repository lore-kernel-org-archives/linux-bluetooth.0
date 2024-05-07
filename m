Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF881161331
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096561; cv=none; b=QUd0YkVVU22UqKRbvc+zO8o6RrY257O9yS455vQZprb7Zc4ekw4a5O8Jvj9ELJvuLTUhUMKGdMWc8QpeZd5ZG3XkqUlPoX/YafTAYEBsKaC4ngYdwqMt67mY5ilgWA9PIQjC2ZULB6IP1hua4ADqDUAhF9CLaY5SEqE7FiNvBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096561; c=relaxed/simple;
	bh=Rffl3XV8DDDFTCcf7BQZxXbkVeC011+bls3yflO8WSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dn0cKMy2tsXgAc8CGhTx47hYY0JjoTf/bPeE+s/Paujq8yJUSVd3NMrfsZnP6T8PIuP4sq+uXaFz2cKs2b3WM0poozR4mmem5dhgyRJAZC2jrtjpnErPgqfgTZuqRvJuN8fJ8bon/CakDw1/FJxReGUry5Lgk2mULrrfn7N+DWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjZgrgdL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjZgrgdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715096560; x=1746632560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rffl3XV8DDDFTCcf7BQZxXbkVeC011+bls3yflO8WSg=;
  b=TjZgrgdLrggPT+KiBMhhIiA2RBwzUQrRRXkv86+0ZISKpzgOfuzA/s9x
   FYHaxtpHyAPmHuhEkR1XkEUJm4bPS862DeH2OglSs0IKaIGeDjGZZIsOM
   wvbYXMJmLWvhg/jSXFISEeUj/3hCuTn5RAVTzr/JytOybAjHLUMGENXI0
   wt6Fj+2wHZzH98PW09PGE2Q09sJoIaQZhckxKyYVYEyr74yM26LJEqYPh
   S1jPL4Ml8+tE9cTZLQWKDqCHP6hr1FNQH8tuJx1Hef8AM8QhYdtJjnBMy
   bHZrY3NQH5U1q8wEgaRznU3SkMaGBW+l9S7ywhJr7L8e4ejY+hBbv9BT4
   g==;
X-CSE-ConnectionGUID: gXxF6bRiSxOejylnxG2FLg==
X-CSE-MsgGUID: 5uOmCbzPQFaLIcisV30ZTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11026636"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="11026636"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:42:39 -0700
X-CSE-ConnectionGUID: Hu09qzZNQbGBzFovn3SLmA==
X-CSE-MsgGUID: 2vK8dCoETIeITKywAPF+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="28647362"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2024 08:42:37 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	helgaas@kernel.org,
	pmenzel@molgen.mpg.de,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/3] Bluetooth: btintel: Export few static functions
Date: Tue,  7 May 2024 21:26:56 +0530
Message-Id: <20240507155658.294676-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
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
index 4f4bd5538b6e..0c855c3ee1c1 100644
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
 
@@ -544,10 +545,11 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 
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
@@ -649,6 +651,7 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btintel_parse_version_tlv);
 
 static int btintel_read_version_tlv(struct hci_dev *hdev,
 				    struct intel_version_tlv *version)
@@ -2597,8 +2600,8 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 	data->acpi_reset_method = btintel_acpi_reset_method;
 }
 
-static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
-					struct intel_version_tlv *ver)
+int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
+				 struct intel_version_tlv *ver)
 {
 	u32 boot_param;
 	char ddcname[64];
@@ -2682,8 +2685,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btintel_bootloader_setup_tlv);
 
-static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
+void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 {
 	switch (hw_variant) {
 	/* Legacy bootloader devices that supports MSFT Extension */
@@ -2707,6 +2711,7 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 		break;
 	}
 }
+EXPORT_SYMBOL_GPL(btintel_set_msft_opcode);
 
 static void btintel_print_fseq_info(struct hci_dev *hdev)
 {
@@ -3078,7 +3083,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	return err;
 }
 
-static int btintel_shutdown_combined(struct hci_dev *hdev)
+int btintel_shutdown_combined(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	int ret;
@@ -3112,6 +3117,7 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 
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
2.40.1

