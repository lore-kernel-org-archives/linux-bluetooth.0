Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF1C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 10:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiKVKK4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiKVKKy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 05:10:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9C528BE
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111853; x=1700647853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCntFZ7x+FO7wKTqgYUoEacfY6pUvyin64JZfoDLcM8=;
  b=kJQgHzkUdtqJXfSr8bQvP+ZL7AbYOlO9Qq2uc2gAbGA4Y7vAdIlB3Q3z
   Iusjj86/VoXGcoCcFscPvhhAzPzZJT0Vlxmm84QJMhQsYLHRTi4nuFyXM
   xJJYII2bJYIeY8YgcPGeG3aoJbxWNbO+ZG8rz9lmgVPtMhKNJlyrsBYp6
   1rgNW01bzr9BDBq441pvyHCKjlOyIx2dviCbTjffSU9v+7XGK/AS90y4Z
   bbbgQLrAuh7PybksEJ8rXLs1p7vn8KYeux/OSbxIrZc1eMtZJJDclszXF
   8TH+eRQXNILa+WEhB5MFDMQ1j4tl8WyR8opjHGHqzbLUf6Xx0LvhVfXnR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="378039363"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="378039363"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672431912"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="672431912"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 02:10:51 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 3/7] main.conf: Add CSIP profile configurable options
Date:   Tue, 22 Nov 2022 15:42:28 +0530
Message-Id: <20221122101232.45320-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122101232.45320-1-sathish.narasimman@intel.com>
References: <20221122101232.45320-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces option to configure main.conf that can be used to
configure co-ordinated set identification profile.
---
 src/btd.h     |   9 ++++
 src/main.c    | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/main.conf |  24 +++++++++++
 3 files changed, 146 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index 42cffcde43ca..a3683a098689 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -92,6 +92,13 @@ struct btd_defaults {
 	struct btd_le_defaults le;
 };
 
+struct btd_csis {
+	uint8_t sirk_type;
+	uint8_t sirk_val[16];
+	uint8_t cs_size;
+	uint8_t cs_rank;
+};
+
 struct btd_avdtp_opts {
 	uint8_t  session_mode;
 	uint8_t  stream_mode;
@@ -142,6 +149,8 @@ struct btd_opts {
 	enum jw_repairing_t jw_repairing;
 
 	struct btd_advmon_opts	advmon;
+
+	struct btd_csis csis_defaults;
 };
 
 extern struct btd_opts btd_opts;
diff --git a/src/main.c b/src/main.c
index 99d9c508ff91..abb422961f78 100644
--- a/src/main.c
+++ b/src/main.c
@@ -60,6 +60,9 @@
 #define DEFAULT_TEMPORARY_TIMEOUT         30 /* 30 seconds */
 #define DEFAULT_NAME_REQUEST_RETRY_DELAY 300 /* 5 minutes */
 
+/*CSIP Profile - Server */
+#define DEFAULT_SIRK "761FAE703ED681F0C50B34155B6434FB"
+
 #define SHUTDOWN_GRACE_SECONDS 10
 
 struct btd_opts btd_opts;
@@ -146,6 +149,14 @@ static const char *gatt_options[] = {
 	NULL
 };
 
+static const char *csip_options[] = {
+	"CsisSirkType",
+	"CsisSirkValue",
+	"CsisSize",
+	"CsisRank",
+	NULL
+};
+
 static const char *avdtp_options[] = {
 	"SessionMode",
 	"StreamMode",
@@ -166,11 +177,55 @@ static const struct group_table {
 	{ "LE",		le_options },
 	{ "Policy",	policy_options },
 	{ "GATT",	gatt_options },
+	{ "CSIP",	csip_options },
 	{ "AVDTP",	avdtp_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
 
+#ifndef MIN
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
+
+static int8_t check_sirk_alpha_numeric(char *str)
+{
+	int8_t val = 0;
+	char *s = str;
+
+	if (strlen(s) != 32) /* 32 Bytes of Alpha numeric string */
+		return 0;
+
+	for ( ; *s; s++) {
+		if (((*s >= '0') & (*s <= '9'))
+			|| ((*s >= 'a') && (*s <= 'z'))
+			|| ((*s >= 'A') && (*s <= 'Z'))) {
+			val = 1;
+		} else {
+			val = 0;
+			break;
+		}
+	}
+
+	return val;
+}
+
+static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
+{
+	size_t i, len;
+
+	if (!hexstr)
+		return 0;
+
+	len = MIN((strlen(hexstr) / 2), buflen);
+	memset(buf, 0, len);
+
+	for (i = 0; i < len; i++) {
+		if (sscanf(hexstr + (i * 2), "%02hhX", &buf[i]) != 1)
+			continue;
+	}
+
+	return len;
+}
 
 GKeyFile *btd_get_main_conf(void)
 {
@@ -939,6 +994,58 @@ static void parse_config(GKeyFile *config)
 		btd_opts.gatt_channels = val;
 	}
 
+	val = g_key_file_get_integer(config, "CSIP", "CsisSirkType", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		val = MIN(val, 2);
+		val = MAX(val, 1);
+		DBG("Csis Type: %u", val);
+		btd_opts.csis_defaults.cs_size = val;
+	}
+
+	str = g_key_file_get_string(config, "CSIP", "CsisSirkValue", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("Csis Sirk: %s", str);
+
+		if (!check_sirk_alpha_numeric(str)) {
+			DBG("SIRK is not apha numeric Value");
+			return;
+		}
+
+		btd_opts.csis_defaults.sirk_type = 1; /* Plain Text - Type*/
+		hex2bin(str, btd_opts.csis_defaults.sirk_val,
+			sizeof(btd_opts.csis_defaults.sirk_val));
+
+		g_free(str);
+	}
+
+	val = g_key_file_get_integer(config, "CSIP", "CsisSize", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		val = MIN(val, 0xFF);
+		val = MAX(val, 0);
+		DBG("Csis Size: %u", val);
+		btd_opts.csis_defaults.cs_size = val;
+	}
+
+	val = g_key_file_get_integer(config, "CSIP", "CsisRank", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		val = MIN(val, 0xFF);
+		val = MAX(val, 0);
+		DBG("Csis Rank: %u", val);
+		btd_opts.csis_defaults.cs_rank = val;
+	}
+
 	str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -1014,6 +1121,12 @@ static void init_defaults(void)
 	btd_opts.defaults.br.scan_type = 0xFFFF;
 	btd_opts.defaults.le.enable_advmon_interleave_scan = 0xFF;
 
+	btd_opts.csis_defaults.sirk_type = 1;
+	hex2bin(DEFAULT_SIRK, btd_opts.csis_defaults.sirk_val,
+			sizeof(btd_opts.csis_defaults.sirk_val));
+	btd_opts.csis_defaults.cs_size = 1;
+	btd_opts.csis_defaults.cs_rank = 1;
+
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
 
diff --git a/src/main.conf b/src/main.conf
index f187c9aaa482..5378472ef0d4 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -258,6 +258,30 @@
 # Default to 3
 #Channels = 3
 
+[CSIP]
+# CSIP - Co-ordinated Set Identification Profile
+# SIRK Types which determines the value type for CsisSirkValue
+# Possible values:
+# 1 - Plain text
+# 2 - encrypted
+#CsisSirkType = 1
+
+# CSIP - Co-ordinated Set Identification Profile
+# SIRK - Set Identification resolution key which is common for all the
+# sets. They SIRK key is used to identify its sets. This can be any
+# 128 bit value.
+# Possible Values:
+# 16 byte hexadecimal value
+#CsisSirkValue = 861FAE703ED681F0C50B34155B6434FB
+
+#CSIP - Size
+#Total no of sets belongs to this Profile
+#CsisSize = 1
+
+#CSIP - Rank
+#Rank for the device
+#CsisRank = 1
+
 [AVDTP]
 # AVDTP L2CAP Signalling Channel Mode.
 # Possible values:
-- 
2.25.1

