Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00127C7EE30
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCCB1z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCCB1w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBE311D3
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x34so1047813pjj.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsN6e8F+aFqjoJjHMcUYx32SdhoA/5p74PuCEtCl/js=;
        b=QuRL3HdnPkz/O37+QS9gJyQQj9k+F+VxICeRpNql997KQZrpG0nZ5O15NzC4SHGC7a
         C/r01CILgQkIwugqWQX69W8eh86t+BymZ7agdDpLeAn2JD2hwOtlhqF6Avi237onfxwC
         7zrk3KanN0duvbZUrzdotapLVt7i33iimnhh7s3CjyAdMHWfKhxKdIhz/2dB2cM0w0yI
         C0KCzjoc/7Tb+EwA6AySGTt69Z+IwyYikl0yvRND8O5cknGBv7v+gpLWI4wDuNiwJHxV
         am1sgsp/7grkysl7FuAeRAl66ONCJMC7wr3or76NpWxYdt7qcitXjWN29law8qxcyMG/
         YE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsN6e8F+aFqjoJjHMcUYx32SdhoA/5p74PuCEtCl/js=;
        b=nuwMbP4GTqDTQBq2XLcENlrMN1XiEKCA8IhC3wv9DW6nTvgOZboaazSQCrzhKR6XMu
         Kdj7FyNKHNtvWIpHW8wUtyA9TQnTWWKNHDAY4ZsWtUtvjmS+1fI2grp3lID2ro50qu5E
         WrRXmY+CX+04qWRD956GekGxoo8uxv0t0fo2HbGGB/mKfkGw8YqYl3BPmQo2jLexQ8qq
         FI+CO4ZBzYCfJR5nFTVhxEiwJ896urqIjym/+XPKptVmcJ8nehszHQ2N1mjKEq+bazjJ
         1Q/60b2hvOpm71zqBiKfyZnBzPAWARhMwGk3DigVze2IvIgPsL7t41iC8GDqceqQFARR
         n3ew==
X-Gm-Message-State: AO0yUKV9qdvbp9JL3K2KCGOZPiW3rQV/fyrUQr3tksrMJ3RioCWk+V2P
        QhHqbpxK1wB/VKyl5DMFTdP1d7t2z/4=
X-Google-Smtp-Source: AK7set/aiwrImqCP8RJbi9SPg8yBjtXIHFb+EVg/lvomoLgVlpmgEtWE7ISVKGRudsNR34HAm+XXyg==
X-Received: by 2002:a17:903:514:b0:19e:68e4:859c with SMTP id jn20-20020a170903051400b0019e68e4859cmr198988plb.36.1677806869585;
        Thu, 02 Mar 2023 17:27:49 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 6/9] main.conf: Add CSIP profile configurable options
Date:   Thu,  2 Mar 2023 17:27:39 -0800
Message-Id: <20230303012742.1386291-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
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
index f7ccbb49eb04..235d1a6ed397 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -258,6 +258,31 @@ KernelExperimental = 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
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

