Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795622;
	b=gWhxLVKXxmgGKWHY1X7x9gbsLxvTuc1hb3cWIrIuJKVpex1XViHsanBDGuPo+0nAu3N9
	 /TYQuFH0a9wv0N2HsT6dZYe6/PZpHPrgCFO55McKkkTChAIFzRWOJDESWB78KQIfrJTWj
	 k5OnZUBwqJOIO7TKCTwQhFHRVkH6kyXWh78YUwkgZbLZ9dN8KA55w8DxLltdiJZVdSWVL
	 sBN1nlT7oNJCjXg6A2UckHeU6eUYrph3bBQebdQEQIZU9WxpnynsjLNfUxpz9bMNE0ltR
	 2CPWLurmOwqj3qUqSDFtBS/RdcD1n24e4FNyFsE5uvetlm+js3yx2l18YpTtSG3sm+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795622;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yRFtpuqjCzXN7p3cahrQlJWMBxs0cUPMRAX7OmH+xpQ=;
	b=Ec+GWocE76Xo1xCzYm0++ymi02FkcHIAOKw/4QUkZdvrDHfW7vD54fyRZ1y67FdjkN0y
	 ciCPDw2bdFn9p2roRBenRLcsyQFP0vi0+UDsgBmM0W0lfqZKvOaY7JW3b8I0mVsTRkRlj
	 7l5pka18cGzXvcDxrPHbIKYF8sFlOuYBlv+n/7m39uLsxOnCYNtXhIq2FLxDn6xiW1hGV
	 2icWHNyDzUvHs2usqFc5bNjQz/qHENG1VwsTv/Jb9pe2ddxjw2YtDzVK0rm6+lo3tV+Ub
	 5JyjTH1csRwqCziCYAo4ZRntRGZYVky+bkE514XXZdrLjuXlZees+3v96Ci0ywZwucw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gM0z7kDb;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B564606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 12:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B564606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gM0z7kDb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793795621; x=1825331621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7oWVtRJuWyBj+odDpw2nZJIfSOzrwGVKbXreTwHw6WY=;
  b=gM0z7kDbwzDgvN6nIGZ69NCxsKGifxvvLC/qMdVy03+bE2NzcZlmIYdF
   nr3JyDqCHrk5/IPMmIigSo2ATxUCpnjY+zWl2bxclDLpySnfZm2fC3dBp
   yh3CldkblWcH8rBtrbB/RgqmOxwv2PHP3VQ3kl3Q1hEnzRlxU74stPGvj
   yEQjFRAfOSJTPlODomMqNkw/LxcShJLVSXGsQjXnUXYBcQxT+0viT6kRD
   dYdOcN4Qwfzwnvd/RJvT+xn0YJk8/edrLWsAPZXP9zwdWFNJI+Ql6Q/6/
   UjC0OMRyGnlPuWRmDIiT9I9y+KkfhGPQPCKH80dj+CwjoTWx3OASZN+w3
   g==;
X-CSE-ConnectionGUID: Nt/xwvBoRa6DLvfD9ndPaw==
X-CSE-MsgGUID: E5YUvtX8TQ2ZnHUmh7MWaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2422489"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2422489"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:33:40 -0800
X-CSE-ConnectionGUID: SQFZnbasS86/VakCcU2U6w==
X-CSE-MsgGUID: kzCKz0zTRuiv2aQ8froYfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7099784"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2026 04:33:39 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v5 1/2] Bluetooth: btintel_pcie: Move debug INI parsing to debug file
Date: Wed,  4 Nov 2026 17:55:07 +0530
Message-ID: <20261104122508.241477-2-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122508.241477-1-aluvala.sai.teja@intel.com>
References: <20261104122508.241477-1-aluvala.sai.teja@intel.com>
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

Move the debug INI parser from btintel_pcie.c to btintel_pcie_debug.c
so that all debug INI handling lives in one file. Split it into
btintel_pcie_read_debug_ini() and btintel_pcie_ini_next() for reuse,
export btintel_pcie_load_dbg_path_from_ini(), and update the module
description. An INI file that cannot be read, including an allocation
failure, is now logged as unavailable. DBG_PATH, ENABLE_INI and
LOG_MASK behave as before.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c       | 122 ---------------------
 drivers/bluetooth/btintel_pcie_debug.c | 142 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h |   8 +-
 3 files changed, 146 insertions(+), 126 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 7d84c8106cf1..8b991ad2a107 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -274,128 +274,6 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
 	return data->dbg_path_cache != BTINTEL_PCIE_DRAM;
 }
 
-/* Name of the optional INI file used to override the default dbg_path
- * (data->dbg_path_cache), yoyo ini settings and runtime log_mask.
- */
-#define BTINTEL_PCIE_DBG_INI_FILE "ibt_bt_dbg_cfg.ini"
-
-/* Loads optional "DBG_PATH=<value>", "ENABLE_INI=<value>" and "LOG_MASK=<value>"
- * overrides from BTINTEL_PCIE_DBG_INI_FILE
- * and applies them to data->dbg_path_cache, data->enable_ini and data->log_mask.
- *
- * DBG_PATH accepts BTINTEL_PCIE_WIFI_DBGC (0x06, default) and
- * BTINTEL_PCIE_DRAM (0x01, legacy); an invalid or missing entry leaves
- * the cached value set by the caller unchanged.
- *
- * ENABLE_INI accepts 1 (enabled) or 0 (disabled); an invalid or missing
- * entry leaves data->enable_ini unchanged.
- *
- * LOG_MASK accepts any u32 bitmask (see BTINTEL_PCIE_DUMP_TX and friends).
- * The default enables alive interrupt and Sx logging; an invalid or missing
- * entry leaves data->log_mask unchanged.
- */
-static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
-{
-	const struct firmware *fw;
-	const char *ini_file = BTINTEL_PCIE_DBG_INI_FILE;
-	char *buf, *cursor, *line;
-	bool dbg_path_applied = false;
-	bool log_mask_applied = false;
-	int err;
-
-	err = request_firmware_direct(&fw, ini_file, &data->pdev->dev);
-	if (err < 0) {
-		BT_DBG("%s not found (%d), using dbg_path=0x%02x log_mask=0x%08x",
-		       ini_file, err, data->dbg_path_cache, data->log_mask);
-		if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
-			data->enable_ini = false;
-		return;
-	}
-
-	buf = kmemdup_nul(fw->data, fw->size, GFP_KERNEL);
-	release_firmware(fw);
-	if (!buf)
-		return;
-
-	cursor = buf;
-	while ((line = strsep(&cursor, "\n"))) {
-		char *eq;
-		char *val;
-		uint parsed;
-
-		line = strim(line);
-		if (!line[0] || line[0] == '#' || line[0] == ';')
-			continue;
-
-		eq = strchr(line, '=');
-		if (!eq)
-			continue;
-
-		*eq = '\0';
-		line = strim(line);
-		val = strim(eq + 1);
-
-		/* Keys are case-insensitive. */
-		if (!strcasecmp(line, "DBG_PATH")) {
-			BT_INFO("Read DBG_PATH from %s: '%s'", ini_file, val);
-
-			/* base 0 lets kstrtouint accept "0x06", "6", etc. */
-			if (kstrtouint(val, 0, &parsed) == 0 &&
-			    (parsed == BTINTEL_PCIE_DRAM ||
-			     parsed == BTINTEL_PCIE_WIFI_DBGC)) {
-				data->dbg_path_cache = parsed;
-				dbg_path_applied = true;
-				BT_INFO("WRT dbg_path accepted: 0x%02x",
-					data->dbg_path_cache);
-			} else {
-				BT_WARN("Invalid DBG_PATH='%s' in %s, using dbg_path=0x%02x",
-					val, ini_file, data->dbg_path_cache);
-			}
-		} else if (!strcasecmp(line, "LOG_MASK")) {
-			BT_INFO("Read LOG_MASK from %s: '%s'", ini_file, val);
-
-			if (kstrtouint(val, 0, &parsed) == 0) {
-				data->log_mask = parsed;
-				log_mask_applied = true;
-				BT_INFO("WRT log_mask accepted: 0x%08x",
-					data->log_mask);
-			} else {
-				BT_WARN("Invalid LOG_MASK='%s' in %s, using log_mask=0x%08x",
-					val, ini_file, data->log_mask);
-			}
-		} else if (!strcasecmp(line, "ENABLE_INI")) {
-			BT_INFO("Read ENABLE_INI from %s: '%s'", ini_file, val);
-
-			if (kstrtouint(val, 0, &parsed) == 0 &&
-			    (parsed == 0 || parsed == 1)) {
-				data->enable_ini = !!parsed;
-				BT_INFO("WRT enable_ini accepted: %u",
-					data->enable_ini);
-			} else {
-				BT_WARN("Invalid ENABLE_INI='%s' in %s, using enable_ini=%u",
-					val, ini_file, data->enable_ini);
-			}
-		}
-	}
-
-	if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
-		data->enable_ini = false;
-
-	if (dbg_path_applied)
-		BT_DBG("Loaded dbg_path=0x%02x from %s", data->dbg_path_cache, ini_file);
-	else
-		BT_WARN("No valid DBG_PATH in %s, dbg_path=0x%02x", ini_file, data->dbg_path_cache);
-
-	BT_DBG("ENABLE_INI effective state: %u", data->enable_ini);
-
-	if (log_mask_applied)
-		BT_DBG("Loaded log_mask=0x%08x from %s", data->log_mask, ini_file);
-	else
-		BT_DBG("No valid LOG_MASK in %s, log_mask=0x%08x", ini_file, data->log_mask);
-
-	kfree(buf);
-}
-
 /* Helper function to allocate and setup a debug buffer group
  * @data: driver data structure
  * @buf: pointer to data_buf array pointer
diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/btintel_pcie_debug.c
index 9f2d3f32bd99..f3409b8d70b5 100644
--- a/drivers/bluetooth/btintel_pcie_debug.c
+++ b/drivers/bluetooth/btintel_pcie_debug.c
@@ -1,22 +1,158 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Intel Bluetooth YoYo Debug Framework
+ * Intel Bluetooth PCIe Debug Framework
  *
  * Copyright (C) 2026 Intel Corporation
  *
  * Runtime-configurable TLV-based debug collection framework for loading and
  * parsing the optional YoYo firmware configuration used to enable debug
- * regions, triggers, HCI commands, and configuration sets.
+ * regions, triggers, HCI commands, and configuration sets. Also provides
+ * debug INI configuration.
  */
 
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
 #include <net/bluetooth/bluetooth.h>
+#include "btintel_pcie.h"
 #include "btintel_pcie_debug.h"
 
+static char *btintel_pcie_read_debug_ini(struct btintel_pcie_data *data)
+{
+	const struct firmware *fw;
+	char *buf;
+	int err;
+
+	err = request_firmware_direct(&fw, BTINTEL_PCIE_DBG_INI_FILE,
+				      &data->pdev->dev);
+	if (err)
+		return ERR_PTR(err);
+
+	buf = kmemdup_nul(fw->data, fw->size, GFP_KERNEL);
+	release_firmware(fw);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	return buf;
+}
+
+static char *btintel_pcie_ini_next(char **cursor, char **key)
+{
+	char *line, *eq;
+
+	while ((line = strsep(cursor, "\n"))) {
+		line = strim(line);
+		if (!line[0] || line[0] == '#' || line[0] == ';')
+			continue;
+
+		eq = strchr(line, '=');
+		if (!eq)
+			continue;
+
+		*eq = '\0';
+		*key = strim(line);
+		return strim(eq + 1);
+	}
+
+	return NULL;
+}
+
+/* Loads optional "DBG_PATH=<value>", "ENABLE_INI=<value>" and
+ * "LOG_MASK=<value>" overrides from BTINTEL_PCIE_DBG_INI_FILE and applies
+ * them to data->dbg_path_cache, data->enable_ini and data->log_mask.
+ *
+ * DBG_PATH accepts BTINTEL_PCIE_WIFI_DBGC (0x06, default) and
+ * BTINTEL_PCIE_DRAM (0x01, legacy); an invalid or missing entry leaves
+ * the cached value set by the caller unchanged.
+ *
+ * ENABLE_INI accepts 1 (enabled) or 0 (disabled); an invalid or missing
+ * entry leaves data->enable_ini unchanged.
+ *
+ * LOG_MASK accepts any u32 bitmask (see BTINTEL_PCIE_DUMP_TX and friends).
+ * The default enables alive interrupt and Sx logging; an invalid or missing
+ * entry leaves data->log_mask unchanged.
+ */
+void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
+{
+	const char *ini_file = BTINTEL_PCIE_DBG_INI_FILE;
+	char *buf, *cursor, *key, *val;
+	bool dbg_path_applied = false;
+	bool log_mask_applied = false;
+
+	buf = btintel_pcie_read_debug_ini(data);
+	if (IS_ERR(buf)) {
+		BT_DBG("%s unavailable (%ld), using dbg_path=0x%02x log_mask=0x%08x",
+		       ini_file, PTR_ERR(buf), data->dbg_path_cache,
+		       data->log_mask);
+		if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
+			data->enable_ini = false;
+		return;
+	}
+
+	cursor = buf;
+	while ((val = btintel_pcie_ini_next(&cursor, &key))) {
+		unsigned int parsed;
+
+		if (!strcasecmp(key, "DBG_PATH")) {
+			BT_INFO("Read DBG_PATH from %s: '%s'", ini_file, val);
+			if (!kstrtouint(val, 0, &parsed) &&
+			    (parsed == BTINTEL_PCIE_DRAM ||
+			     parsed == BTINTEL_PCIE_WIFI_DBGC)) {
+				data->dbg_path_cache = parsed;
+				dbg_path_applied = true;
+				BT_INFO("WRT dbg_path accepted: 0x%02x",
+					data->dbg_path_cache);
+			} else {
+				BT_WARN("Invalid DBG_PATH='%s' in %s, using dbg_path=0x%02x",
+					val, ini_file, data->dbg_path_cache);
+			}
+		} else if (!strcasecmp(key, "LOG_MASK")) {
+			BT_INFO("Read LOG_MASK from %s: '%s'", ini_file, val);
+			if (!kstrtouint(val, 0, &parsed)) {
+				data->log_mask = parsed;
+				log_mask_applied = true;
+				BT_INFO("WRT log_mask accepted: 0x%08x",
+					data->log_mask);
+			} else {
+				BT_WARN("Invalid LOG_MASK='%s' in %s, using log_mask=0x%08x",
+					val, ini_file, data->log_mask);
+			}
+		} else if (!strcasecmp(key, "ENABLE_INI")) {
+			BT_INFO("Read ENABLE_INI from %s: '%s'", ini_file, val);
+			if (!kstrtouint(val, 0, &parsed) && parsed <= 1) {
+				data->enable_ini = !!parsed;
+				BT_INFO("WRT enable_ini accepted: %u",
+					data->enable_ini);
+			} else {
+				BT_WARN("Invalid ENABLE_INI='%s' in %s, using enable_ini=%u",
+					val, ini_file, data->enable_ini);
+			}
+		}
+	}
+
+	if (data->dbg_path_cache != BTINTEL_PCIE_DRAM)
+		data->enable_ini = false;
+
+	if (dbg_path_applied)
+		BT_DBG("Loaded dbg_path=0x%02x from %s", data->dbg_path_cache, ini_file);
+	else
+		BT_WARN("No valid DBG_PATH in %s, dbg_path=0x%02x", ini_file, data->dbg_path_cache);
+
+	BT_DBG("ENABLE_INI effective state: %u", data->enable_ini);
+
+	if (log_mask_applied)
+		BT_DBG("Loaded log_mask=0x%08x from %s", data->log_mask, ini_file);
+	else
+		BT_DBG("No valid LOG_MASK in %s, log_mask=0x%08x", ini_file, data->log_mask);
+
+	kfree(buf);
+}
+EXPORT_SYMBOL_GPL(btintel_pcie_load_dbg_path_from_ini);
+
 /* TLV-specific parser DEBUG_INFO TLV type */
 static int btintel_pcie_yoyo_parse_dbg_info(struct btintel_pcie_yoyo_ctx *ctx,
 					    const struct btintel_pcie_tlv_dbg_info *info,
@@ -327,5 +463,5 @@ btintel_pcie_yoyo_get_buf_alloc(struct btintel_pcie_yoyo_ctx *ctx, u32 alloc_id)
 }
 EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_get_buf_alloc);
 
-MODULE_DESCRIPTION("Intel Bluetooth yoyo debug framework");
+MODULE_DESCRIPTION("Intel Bluetooth PCIe Debug Framework");
 MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/btintel_pcie_debug.h
index 5ed368fb13d1..04cfcef6f65b 100644
--- a/drivers/bluetooth/btintel_pcie_debug.h
+++ b/drivers/bluetooth/btintel_pcie_debug.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Intel Bluetooth YoYo Debug Framework
+ * Intel Bluetooth PCIe Debug Framework
  *
  * Copyright (C) 2026 Intel Corporation
  *
@@ -14,6 +14,12 @@
 #include <linux/device.h>
 #include <linux/firmware.h>
 
+struct btintel_pcie_data;
+
+#define BTINTEL_PCIE_DBG_INI_FILE	"ibt_bt_dbg_cfg.ini"
+
+void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data);
+
 /* External YoYo binary file */
 #define BTINTEL_PCIE_YOYO_FW_NAME	"intel/ibt_debug_yoyo.bin"
 
-- 
2.53.0

