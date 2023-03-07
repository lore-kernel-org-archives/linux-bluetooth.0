Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C42C678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCGWZ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjCGWZc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F3B04AD
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:25:02 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u5so15729351plq.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgTfiZrjPFHYXsaM8eCTZSSY0mCirVfYD1ClAxwO8NA=;
        b=Gl87ZwJ9XS5+si/96yj3+eZ9gXzNbehbdA4nydHqBaqdCltlGL6h9sfQeMi1GOCctt
         FfKfFAP+ilr+RvENNefel+Pv1h172/C61AEaenmaiulGxn7uFG6Jh6lP50pxzBeUeLiQ
         qB8SiDd8eA/0BIUPgAXvL/tO13nxMhzRmvoi9joLOAuFm0CqpaKe9GyHpSh9bGgjyxPN
         bor77uYcY5QIZ/eDd1GQrsIoDdx7/ocBEIKGf1z4/+QH4lXRyC9p1IRFI0oTBAS25Zw+
         R2aCpFqoVKE/mzf1t7kMUdEFZmPPqBVQ5PGhWbv9jOAcrPO9Na0/CCNS6BRy6gjmlVul
         39ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgTfiZrjPFHYXsaM8eCTZSSY0mCirVfYD1ClAxwO8NA=;
        b=jqKymkTDHrhi2ddu1xGkxiXq2K612rGrmkLfoApkYXgvrwHefVg/Z/JI/cYguO7qny
         lg/OOeIwDdQDXIiFBXpry3BRcB0CCGHe/Cxkb9U5rybkyfIdjfNaKfevGntQ78p+ho55
         qMpBI4H5mNlYcpnj9P58hTdLvgU3Uwm8JbZfJs4cqGsz6f/TdmUCP7C/draUc36dO90C
         v1Hbu5B/Ro9BhaimOX+ZLZc8aO817trjN/0nv67gcIAZo/AYjJiMKUXIPcdt3xdKEtYw
         rz/kjqfzy7JavwTwietl9Q5NYyFGclKvTGkFXDFebVow9O8a7rf9P2Yy73/OV33kEzey
         V6dA==
X-Gm-Message-State: AO0yUKUw4yb6MH6tro2joEfmIvFvknf7IE7J1Ddf+XdFXnOpUukg7NFf
        NL9bYsg6yDtvIjdV04Z7n7ZwYQ6jiEk=
X-Google-Smtp-Source: AK7set8/baXS7W1SVnd/AKGFpA8XAy7B5Tfc638eMwJFI9uYI5cwX9QkcTnKgOWqqV5PsONyxU7aVw==
X-Received: by 2002:a17:903:2446:b0:19c:d78b:cdc with SMTP id l6-20020a170903244600b0019cd78b0cdcmr21881565pls.5.1678227872521;
        Tue, 07 Mar 2023 14:24:32 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 07/12] main.conf: Add CSIP profile configurable options
Date:   Tue,  7 Mar 2023 14:24:17 -0800
Message-Id: <20230307222422.2608483-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <sathish.narasimman@intel.com>

This introduces option to configure main.conf that can be used to
configure co-ordinated set identification profile.
---
 src/btd.h     |   9 ++++
 src/main.c    | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/main.conf |  25 ++++++++++
 3 files changed, 158 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index 42cffcde43ca..70051c71c7c1 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -92,6 +92,13 @@ struct btd_defaults {
 	struct btd_le_defaults le;
 };
 
+struct btd_csis {
+	bool    encrypt;
+	uint8_t sirk[16];
+	uint8_t size;
+	uint8_t rank;
+};
+
 struct btd_avdtp_opts {
 	uint8_t  session_mode;
 	uint8_t  stream_mode;
@@ -142,6 +149,8 @@ struct btd_opts {
 	enum jw_repairing_t jw_repairing;
 
 	struct btd_advmon_opts	advmon;
+
+	struct btd_csis csis;
 };
 
 extern struct btd_opts btd_opts;
diff --git a/src/main.c b/src/main.c
index 99d9c508ff91..2a4d9be05d7a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -43,6 +43,7 @@
 #include "shared/mainloop.h"
 #include "shared/timeout.h"
 #include "shared/queue.h"
+#include "shared/crypto.h"
 #include "lib/uuid.h"
 #include "shared/util.h"
 #include "btd.h"
@@ -60,6 +61,9 @@
 #define DEFAULT_TEMPORARY_TIMEOUT         30 /* 30 seconds */
 #define DEFAULT_NAME_REQUEST_RETRY_DELAY 300 /* 5 minutes */
 
+/*CSIP Profile - Server */
+#define DEFAULT_SIRK "761FAE703ED681F0C50B34155B6434FB"
+
 #define SHUTDOWN_GRACE_SECONDS 10
 
 struct btd_opts btd_opts;
@@ -146,6 +150,13 @@ static const char *gatt_options[] = {
 	NULL
 };
 
+static const char *csip_options[] = {
+	"SIRK",
+	"Size",
+	"Rank",
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
@@ -652,6 +707,27 @@ static void btd_parse_kernel_experimental(char **list)
 	}
 }
 
+static bool gen_sirk(const char *str)
+{
+	struct bt_crypto *crypto;
+	int ret;
+
+	crypto = bt_crypto_new();
+	if (!crypto) {
+		error("Failed to open crypto");
+		return false;
+	}
+
+	ret = bt_crypto_sirk(crypto, str, btd_opts.did_vendor,
+			   btd_opts.did_product, btd_opts.did_version,
+			   btd_opts.did_source, btd_opts.csis.sirk);
+	if (!ret)
+		error("Failed to generate SIRK");
+
+	bt_crypto_unref(crypto);
+	return ret;
+}
+
 static void parse_config(GKeyFile *config)
 {
 	GError *err = NULL;
@@ -939,6 +1015,54 @@ static void parse_config(GKeyFile *config)
 		btd_opts.gatt_channels = val;
 	}
 
+	str = g_key_file_get_string(config, "CSIP", "SIRK", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("CSIS SIRK: %s", str);
+
+		if (strlen(str) == 32 && check_sirk_alpha_numeric(str)) {
+			hex2bin(str, btd_opts.csis.sirk,
+					sizeof(btd_opts.csis.sirk));
+		} else if (!gen_sirk(str))
+			DBG("Unable to generate SIRK from string");
+
+		g_free(str);
+	}
+
+	boolean = g_key_file_get_boolean(config, "CSIP", "SIRK", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("CSIS Encryption: %s", boolean ? "true" : "false");
+
+		btd_opts.csis.encrypt = boolean;
+	}
+
+	val = g_key_file_get_integer(config, "CSIP", "Size", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		val = MIN(val, 0xFF);
+		val = MAX(val, 0);
+		DBG("CSIS Size: %u", val);
+		btd_opts.csis.size = val;
+	}
+
+	val = g_key_file_get_integer(config, "CSIP", "Rank", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		val = MIN(val, 0xFF);
+		val = MAX(val, 0);
+		DBG("CSIS Rank: %u", val);
+		btd_opts.csis.rank = val;
+	}
+
 	str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
 	if (err) {
 		DBG("%s", err->message);
diff --git a/src/main.conf b/src/main.conf
index f187c9aaa482..11172c9dd7c6 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -258,6 +258,31 @@
 # Default to 3
 #Channels = 3
 
+[CSIS]
+# SIRK - Set Identification Resolution Key which is common for all the
+# sets. They SIRK key is used to identify its sets. This can be any
+# 128 bit value or a string value (e.g. product name) which is then hashed.
+# Possible Values:
+# 16 byte hexadecimal value: 861FAE703ED681F0C50B34155B6434FB
+# String value: "My Product Name"
+# Defaults to none
+#SIRK =
+
+# SIRK Encryption
+# Possible values:
+# yes: Encrypt SIRK when read
+# no: Do not encrypt SIRK when read. (plaintext)
+# Defaults to yes
+#Encryption = yes
+
+# Total no of sets belongs to this Profile
+# Defaults to 0
+#Size = 0
+
+# Rank for the device
+# Defaults to 0
+#Rank = 0
+
 [AVDTP]
 # AVDTP L2CAP Signalling Channel Mode.
 # Possible values:
-- 
2.39.2

