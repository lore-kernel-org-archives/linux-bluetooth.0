Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD734C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 18:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbjJTSIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJTSIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 14:08:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A6D51
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 11:08:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so761912a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697825317; x=1698430117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTOF47kSsP+3L+0zuOInI7X8hCS+tkOB2eS6yUUto5c=;
        b=coFmFMfWudKpe3YS5SViZDyTgIGsETPft3p3QziQdlC6m2Fozu5tnHw3C2ljWfSqIt
         rZKtmwh+awE1cV2h3MoNdb1K3B+/WTtc1u12jFU6snXr5rZj9GGU5G9UwljvhquPfm3v
         3GTr8l/WbdRDl4jSFMknv9qbTHas2QQWdCqpowQNRSPqlyZrrlOI0ZjVf8GWHfCy75yy
         9OSALCF0HFTL00fF0mbMtMwqAoIlnvdnYcKgDGot/9acLnrovbBbunmNkG57/dXFkn5j
         ilSw1PhWxGJkvL+UqgIRVM4ZgMHVhzRxy+w3OZftmsTEZDk1T6EFR0m/D9E2Pu5wVuuK
         Lcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825317; x=1698430117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTOF47kSsP+3L+0zuOInI7X8hCS+tkOB2eS6yUUto5c=;
        b=SSpjXNmsgdD+KcXaYwdGYkdQFJoWVcloiAUEEnzebleSlm1x6PLbfKTC//OXUS0jgn
         TZBPHKz3LDRGCYUEbDO6Uy8Dhs50xFCh4s0eQy0E7vRhxVM3ebIpFJbZNeIU8D81heF9
         cM3ZSFfz0FKdPjuEm88w3fpPKN+/PdyWpuRqmQdWaMeCq4MOBVWrjLnHjySFCE7dBNHL
         82Y+Pj2aG6lMneA01EpAYRtDbuS2j5sg1VO6qCQXlIO+amzEjWLLSTRKYTnRoRL48DZI
         8OJKbLMKUlju2xwEJGe1BCwd2FgUF/LUlyot7hHC4KjFNFN2pwjsgXm6HZcE6rWtKqhp
         kG1w==
X-Gm-Message-State: AOJu0Yz4Ax75CliGb1dTJjvRaTqGRzaryN3dcHug9fJP/ATWSbT/S/NC
        enBA1TELB//2v+KjBxTY/jq2z26qZDrGmmp1Xqc=
X-Google-Smtp-Source: AGHT+IEpsJBygNhkYpXkGCFnQcYYEV/cUn30u14sSUJdDrMX5I0YZ9DlkyTWLICCX36Aa3HVJxTyhA==
X-Received: by 2002:a17:90a:c0f:b0:27c:fa71:4765 with SMTP id 15-20020a17090a0c0f00b0027cfa714765mr2360190pjs.33.1697825316600;
        Fri, 20 Oct 2023 11:08:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090ad34400b00263b9e75aecsm1729800pjx.41.2023.10.20.11.08.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:08:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] shared/util: Add util_debug_{tlv, bit} helpers
Date:   Fri, 20 Oct 2023 11:08:31 -0700
Message-ID: <20231020180834.3010421-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds util_debug_tlv and util_debug_bit which can help to print
debug information in their respective formats.
---
 src/shared/util.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h | 30 ++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index e9c1c18f5ea7..bf37fce364ed 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -138,6 +138,94 @@ void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 	}
 }
 
+/* Helper to print debug information of bitfields */
+uint64_t util_debug_bit(uint64_t val, const struct util_bit_debugger *table,
+				util_debug_func_t function, void *user_data)
+{
+	uint64_t mask = val;
+	int i;
+
+	for (i = 0; table[i].str; i++) {
+		if (val & (((uint64_t) 1) << table[i].bit)) {
+			util_debug(function, user_data, "%s", table[i].str);
+			mask &= ~(((uint64_t) 1) << table[i].bit);
+		}
+	}
+
+	return mask;
+}
+
+static struct util_ltv_debugger*
+ltv_debugger(struct util_ltv_debugger *debugger, size_t num, uint8_t type)
+{
+	size_t i;
+
+	if (!debugger || !num)
+		return NULL;
+
+	for (i = 0; i < num; i++) {
+		struct util_ltv_debugger *debug = &debugger[i];
+
+		if (debug->type == type)
+			return debug;
+	}
+
+	return NULL;
+}
+
+/* Helper to print debug information of LTV entries */
+bool util_debug_ltv(const uint8_t *data, uint8_t len,
+			struct util_ltv_debugger *debugger, size_t num,
+			util_debug_func_t function, void *user_data)
+{
+	struct iovec iov;
+	int i;
+
+	iov.iov_base = (void *) data;
+	iov.iov_len = len;
+
+	for (i = 0; iov.iov_len; i++) {
+		uint8_t l, t, *v;
+		struct util_ltv_debugger *debug;
+
+		if (!util_iov_pull_u8(&iov, &l)) {
+			util_debug(function, user_data,
+					"Unable to pull length");
+			return false;
+		}
+
+		if (!l) {
+			util_debug(function, user_data, "#%d: len 0x%02x",
+					i, l);
+			continue;
+		}
+
+		if (!util_iov_pull_u8(&iov, &t)) {
+			util_debug(function, user_data, "Unable to pull type");
+			return false;
+		}
+
+		util_debug(function, user_data, "#%d: len 0x%02x type 0x%02x",
+					i, l, t);
+
+		l--;
+
+		v = util_iov_pull_mem(&iov, l);
+		if (!v) {
+			util_debug(function, user_data, "Unable to pull value");
+			return false;
+		}
+
+		debug = ltv_debugger(debugger, num, t);
+		if (debug)
+			debug->func(v, l, function, user_data);
+		else
+			util_hexdump(' ', (void *)v, l, function, user_data);
+	}
+
+	return true;
+}
+
 /* Helper for getting the dirent type in case readdir returns DT_UNKNOWN */
 unsigned char util_get_dt(const char *parent, const char *name)
 {
diff --git a/src/shared/util.h b/src/shared/util.h
index c37b0f7296ab..28ae5c290071 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -107,6 +107,36 @@ void util_debug(util_debug_func_t function, void *user_data,
 void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 				util_debug_func_t function, void *user_data);
 
+#define UTIL_BIT_DEBUG(_bit, _str) \
+{ \
+	.bit = _bit, \
+	.str = _str, \
+}
+
+struct util_bit_debugger {
+	uint64_t bit;
+	const char *str;
+};
+
+uint64_t util_debug_bit(uint64_t val, const struct util_bit_debugger *table,
+				util_debug_func_t func, void *user_data);
+
+#define UTIL_LTV_DEBUG(_type, _func) \
+{ \
+	.type = _type, \
+	.func = _func, \
+}
+
+struct util_ltv_debugger {
+	uint8_t  type;
+	void (*func)(const uint8_t *data, uint8_t len,
+			util_debug_func_t func, void *user_data);
+};
+
+bool util_debug_ltv(const uint8_t *data, uint8_t len,
+			struct util_ltv_debugger *debugger, size_t num,
+			util_debug_func_t function, void *user_data);
+
 unsigned char util_get_dt(const char *parent, const char *name);
 
 ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);
-- 
2.41.0

