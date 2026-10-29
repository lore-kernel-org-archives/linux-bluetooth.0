Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266416;
	b=SwrAQdCvpVXgWBTwrYYzfTt5pY9tmuJE0gwcbK/FPPB+/JUJBO8DqJAEQccYYdm4Zigr
	 kE6+oxn54QI/1uomwHgFw4CV4Ol0ud7R3Gm+FwtMlQPQvb7cYsJcvDeFuhYtOGz8yMRJi
	 y/oW/JOH11zvDD6JcOwgd6Bq8AOJVgCBULDySBSKzx2tPm3HNWqpczIaEL+A9zXXVRLSt
	 2op7n19e6QiKxh69ncI8rBt1YgzaqAmATnQkMLFE1oNktNEY7MITlnIKbjXEo4k1stETm
	 75twOWA2QC5E3CRe89PLaJpLyOQdTAs44qDeagaBuPB1lRmzg1PfbIzgRk+3bpvuHmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266416;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ozXMdSqjjZnhD2hoHH1w80FwRdKNa156iMP02v7pC7s=;
	b=jn56etPjXRqYjQQCAtGB2vUMYVgTY+STAK+BqJkGCnIjVeTltuPcXuq8wlGdX3KgZ28j
	 l/Z33Vs0ohuM+Nh3z2kifQzo+a32u3Mg/N+UNk8gjxVRC0qOVL7OKZXYMxdHrwkrNDnnP
	 krKg+F2E4pmM1T4hanOHJp+JfiyBKyyLgHSMR9Hogss1axvdAiFJqqsa6Eg/knyUu/qi4
	 s4ehR3QyCU6m+1TftXXfmVTrlZ0ASulLJn65W3lUBR+NQ6sjARCpLPXW+mgGAT85dIIpN
	 7OyAtWrTHEEMcQIz/ja1a0WLFf3XSlETDNm6LiX1GaKFLt+Pv4EhjHCut68lQY7bmtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RaJHEOeT;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E6606A31F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 889E6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RaJHEOeT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793266414; x=1824802414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PDAdJcZmSs4mB7ovLT3v4f6ugNTLNltTlxhqgimZ4OM=;
  b=RaJHEOeT6N1B0P5Eo8t89Im8PdwQOYx0TdlRfNbw1+1HZy6UsayTcy4l
   +nKSbGhWQKI4J5/xLfPDrN3IuFh+3Lzdwx+8+7yzrO3j62VxSpRQ9jKmr
   2Uj4GyWag4C3tqgEl+T9FEoExIrU4DiOl47IDiZ3aFUQVKyyHkIGvMKol
   IqUSsrCKoxTTYmkFrLLVbhiqwFYa7eE9aPG4HTYN6arZLC8FhiDADdyCU
   pH+/x58x/VQiu56Etquj2G+hvwZ1AtoZlvQs+IEcRCpHkqStKofhHjiFk
   eo7sf6HV1Gxd4QO3GoDzaiosdMMY+fEZjx7RN4WUcfv8LMnfXKreo5zK2
   Q==;
X-CSE-ConnectionGUID: eoNFZaXKTxWkwUg1YX53wQ==
X-CSE-MsgGUID: xmUDnaO/QGKZwZK7K9KTlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1887592"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1887592"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:33:34 -0700
X-CSE-ConnectionGUID: QiDFnlPkSE+lX+O0UjkI6g==
X-CSE-MsgGUID: Nbujwzq8SUmALilnEc2SdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5183748"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2026 02:33:32 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/7] Bluetooth: btintel_pcie: Add LOG_MASK parsing from debug INI
Date: Thu, 29 Oct 2026 15:23:38 +0530
Message-ID: <20261029095344.3989729-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
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

Read an optional LOG_MASK entry from ibt_bt_dbg_cfg.ini and store it in
a new log_mask field so that diagnostic logging can be selected per
device without rebuilding the driver. The mask defaults to 0 and an
invalid or missing entry leaves it unchanged. Preserve existing DBG_PATH
and ENABLE_INI handling.

Individual logging categories are introduced by follow-up patches.

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 38 +++++++++++++++++++++++++-------
 drivers/bluetooth/btintel_pcie.h |  3 +++
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 88da286750fe..a25f4d866f57 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -31,6 +31,8 @@
 
 #define VERSION "0.1"
 
+/* Runtime diagnostic logging bits loaded from LOG_MASK in the debug INI. */
+
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
 	.vendor = PCI_VENDOR_ID_INTEL,	\
 	.device = (dev),		\
@@ -206,13 +208,13 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
 }
 
 /* Name of the optional INI file used to override the default dbg_path
- * (data->dbg_path_cache) and yoyo ini settings.
+ * (data->dbg_path_cache), yoyo ini settings and runtime log_mask.
  */
 #define BTINTEL_PCIE_DBG_INI_FILE "ibt_bt_dbg_cfg.ini"
 
-/* Loads optional "DBG_PATH=<value>" and ENABLE_INI=<value>
+/* Loads optional "DBG_PATH=<value>", "ENABLE_INI=<value>" and "LOG_MASK=<value>"
  * overrides from BTINTEL_PCIE_DBG_INI_FILE
- * and applies them to data->dbg_path_cache and data->enable_ini.
+ * and applies them to data->dbg_path_cache, data->enable_ini and data->log_mask.
  *
  * DBG_PATH accepts BTINTEL_PCIE_WIFI_DBGC (0x06, default) and
  * BTINTEL_PCIE_DRAM (0x01, legacy); an invalid or missing entry leaves
@@ -220,6 +222,9 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
  *
  * ENABLE_INI accepts 1 (enabled) or 0 (disabled); an invalid or missing
  * entry leaves data->enable_ini unchanged.
+ *
+ * LOG_MASK accepts any u32 bitmask (see BTINTEL_PCIE_DUMP_TX and friends).
+ * An invalid or missing entry leaves data->log_mask unchanged.
  */
 static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
 {
@@ -227,12 +232,13 @@ static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
 	const char *ini_file = BTINTEL_PCIE_DBG_INI_FILE;
 	char *buf, *cursor, *line;
 	bool dbg_path_applied = false;
+	bool log_mask_applied = false;
 	int err;
 
 	err = request_firmware_direct(&fw, ini_file, &data->pdev->dev);
 	if (err < 0) {
-		BT_DBG("%s not found (%d), using dbg_path=0x%02x",
-		       ini_file, err, data->dbg_path_cache);
+		BT_DBG("%s not found (%d), using dbg_path=0x%02x log_mask=0x%08x",
+		       ini_file, err, data->dbg_path_cache, data->log_mask);
 		if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
 			data->enable_ini = false;
 		return;
@@ -261,9 +267,7 @@ static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
 		line = strim(line);
 		val = strim(eq + 1);
 
-		/* Accept "DBG_PATH"/"dbg_path"
-		 * case-insensitively as the key.
-		 */
+		/* Keys are case-insensitive. */
 		if (!strcasecmp(line, "DBG_PATH")) {
 			BT_INFO("Read DBG_PATH from %s: '%s'", ini_file, val);
 
@@ -279,6 +283,18 @@ static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
 				BT_WARN("Invalid DBG_PATH='%s' in %s, using dbg_path=0x%02x",
 					val, ini_file, data->dbg_path_cache);
 			}
+		} else if (!strcasecmp(line, "LOG_MASK")) {
+			BT_INFO("Read LOG_MASK from %s: '%s'", ini_file, val);
+
+			if (kstrtouint(val, 0, &parsed) == 0) {
+				data->log_mask = parsed;
+				log_mask_applied = true;
+				BT_INFO("WRT log_mask accepted: 0x%08x",
+					data->log_mask);
+			} else {
+				BT_WARN("Invalid LOG_MASK='%s' in %s, using log_mask=0x%08x",
+					val, ini_file, data->log_mask);
+			}
 		} else if (!strcasecmp(line, "ENABLE_INI")) {
 			BT_INFO("Read ENABLE_INI from %s: '%s'", ini_file, val);
 
@@ -304,6 +320,11 @@ static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
 
 	BT_DBG("ENABLE_INI effective state: %u", data->enable_ini);
 
+	if (log_mask_applied)
+		BT_DBG("Loaded log_mask=0x%08x from %s", data->log_mask, ini_file);
+	else
+		BT_DBG("No valid LOG_MASK in %s, log_mask=0x%08x", ini_file, data->log_mask);
+
 	kfree(buf);
 }
 
@@ -4530,6 +4551,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
 	data->dbg_path_cache = BTINTEL_PCIE_WIFI_DBGC;
+	data->log_mask = 0;
 	data->pcie_alloc_init = false;
 	data->enable_ini = false;
 	btintel_pcie_yoyo_init(&data->yoyo);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index fff31ac8f87a..3e662c34cd02 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -717,6 +717,8 @@ struct btintel_pcie_ini_dump_info {
  * @boot_stage_cache: cached value of boot stage register
  * @img_resp_cache: cached value of image response register
  * @dbg_path_cache: cached debug output routing mode (BT DRAM or WiFi DBGC)
+ * @log_mask: runtime diagnostic logging mask loaded from LOG_MASK in the
+ *	debug INI file
  * @cnvi: CNVi register value
  * @cnvr: CNVr register value
  * @gp0_received: condition for gp0 interrupt
@@ -771,6 +773,7 @@ struct btintel_pcie_data {
 	u32	boot_stage_cache;
 	u32	img_resp_cache;
 	u32	dbg_path_cache;
+	u32	log_mask;
 	bool	enable_ini;
 	struct btintel_pcie_yoyo_ctx yoyo;
 
-- 
2.54.0

