Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D50CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 23:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKUXqn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiKUXqS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 18:46:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBFE06B3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 15:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669074282; x=1700610282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTbX2pdiwm9GeCnodnhOGxJF7EuZf5wKjMS0lB961mc=;
  b=Rut3uECkZpV02SGuyQZDXC8VjMuvz20Ynm027EEz9VAPFpkiEGM2iPL7
   PswZH3J2rEc21OosHaeSkkOJYG2ctZRHYuPK+hWEhJYGHSnCeV7SR2Df2
   HKBvmkAJXBxSCbwhXdpzGO1hepZE/QFlvA176sra+xJusQT6P3CA/Y1Ny
   HmxdENPbhOn+d14sxNmewyX8bUirv1XLmJHeq1AAKS/jJ4jcs4RXk9BKv
   /WXxh8RE7BdTcKkD9xrsw0qSIna2zktFLWuZruMcKuazwsJeE7yqgPzXq
   CtCGA5iTSd5SIvasY7JhZfqlXZRKkSdAxWX0v44wMASBnYsMEZOK2mTgF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377946601"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="377946601"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 15:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="783633441"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="783633441"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2022 15:44:40 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 2/6] main.conf: Add CSIP profile configurable options
Date:   Tue, 22 Nov 2022 05:16:20 +0530
Message-Id: <20221121234624.2961-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121234624.2961-1-sathish.narasimman@intel.com>
References: <20221121234624.2961-1-sathish.narasimman@intel.com>
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
index 63be6d8d4b3f..7c40492e5a1b 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -86,6 +86,13 @@ struct btd_defaults {
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
@@ -135,6 +142,8 @@ struct btd_opts {
 	enum jw_repairing_t jw_repairing;
 
 	struct btd_advmon_opts	advmon;
+
+	struct btd_csis csis_defaults;
 };
 
 extern struct btd_opts btd_opts;
diff --git a/src/main.c b/src/main.c
index 1d357161feec..d05036a3380a 100644
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
@@ -145,6 +148,14 @@ static const char *gatt_options[] = {
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
@@ -165,11 +176,55 @@ static const struct group_table {
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
+	int8_t val;
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
@@ -925,6 +980,58 @@ static void parse_config(GKeyFile *config)
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
@@ -999,6 +1106,12 @@ static void init_defaults(void)
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
index 2796f155ebaa..0cc0812f8587 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -247,6 +247,30 @@
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

