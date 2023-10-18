Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE8CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 19:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjJRT5B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJRT5A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 15:57:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC99129
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 12:56:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ca816f868fso26721315ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697659016; x=1698263816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTOF47kSsP+3L+0zuOInI7X8hCS+tkOB2eS6yUUto5c=;
        b=SNua5soqel6Ia5ezBYjI4lR+SX/zz5lQAF4pn5XjxmfS9MyMgLTWB3htn4B78ZLcMA
         OF8qigXK7edQOyO/iYHzG6mj8TrxjygXGdIvzB3al+e2iaO2sXo56RopoqfDlysaQV4s
         TSt7Y1oSouSj6qVwKrZceD8W24W1M1Ivkgzf8eTv0WdCY6LFngTT6uViF03B9fLkPs4V
         AhA6PvN6V/FvTbgFQKkFkA6DqHlrNROgp1ow9yPYLufmVcj04s61aEXrc7IRnyVjGSxv
         YqR5/soCEvS6rnI+tBRb+cgFRbMXtapkTa+NNoMs8B6wo+ZJQULFORJwSWj2BTC/zhzy
         rXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659016; x=1698263816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTOF47kSsP+3L+0zuOInI7X8hCS+tkOB2eS6yUUto5c=;
        b=BxdwoXuTHFlY/cDDX22m6uLOqICqHe18Eu+wRkS57KjMUDMCBFhsgF4YWWeUGcVSYp
         QRZ9SOICi465U5+PpTa+yAZzqWNdavkjIB+KM7jPvK6n9atJXVYCngo2yOIoO7IqDB+T
         C/yZF04O8cD4CfPUD4oBS0llvQ/3aL8QpOl86EhhL+NGS0d0mTnKsSMsjvEqmGCfT7Z1
         mVwQ+hhmPqxHU+3A1i6RcRFVomJJEgSqV4qL7xzTEFLsLweEuJMIBnM42XvrpmLjgLR4
         toXEzhpuNv8kXzWAy5PqBeChBh3NwCUbvzJHf+H6kXMoUcEKqH4hbTSeDSU6NAQQG38n
         dRbQ==
X-Gm-Message-State: AOJu0YxGKIACP5aV3vcufC8v0Oy07lCvUSn+mgc4he9oKJfQeT5QHpT5
        ng5DknJPZWoowunq+bUpEPnuNYfuysbWKoe8U/w=
X-Google-Smtp-Source: AGHT+IEUuqGnk7FaqwknzBWgNd47z9aZ4/0WqHYGZyaUHTQej5dzzGeyNX7XHfviYvdvmlrs2nilOA==
X-Received: by 2002:a17:903:2803:b0:1bc:5924:2da2 with SMTP id kp3-20020a170903280300b001bc59242da2mr285024plb.56.1697659015753;
        Wed, 18 Oct 2023 12:56:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001b3bf8001a9sm329739plb.48.2023.10.18.12.56.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:56:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/util: Add util_debug_{tlv, bit} helpers
Date:   Wed, 18 Oct 2023 12:56:50 -0700
Message-ID: <20231018195653.2532882-1-luiz.dentz@gmail.com>
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

