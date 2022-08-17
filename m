Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B2C32772
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 23:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbiHQXmD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242473AbiHQXmC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 19:42:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9698A41
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:59 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h4so46182qtj.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=HcZbzWIaS3ZBAoKQ8WtTSxdAa3N97Uesw92CvXSMVJ0=;
        b=liC/Tp4UwLqbQvPlhJqPR/7zqVEx+a9OVI74XDcG9DCyzCFbOa/F4bpN+b9tOyQLNq
         d48Qk9NqS/XsKIc9bY1EG4WzSHL5I1Og8k4zKCKgbUBP/wV2D9dWEc/ngwAlKnqFRhny
         h2aTLadUhIRmp8LULLMEx4OQ0/ucHQhwFdXIbN5JMVF55k/pH6I4YQG2hAhT3jXhC0L0
         VnHq8+J/B1QkwmCXoDzktG839sxJ6GVzqgI1CLtpna3eGy6EUUToLbS0AInfrno7n38g
         VowLpWleLpd3Cdw+9YaJ5Jep1hwjREKgHvnfsa/W8QZLO27i93Icgd0AXRyW/HMDLP0J
         rBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=HcZbzWIaS3ZBAoKQ8WtTSxdAa3N97Uesw92CvXSMVJ0=;
        b=R2HTI89zAaIXG6cCXr3k2lS5wDxgslU6hf7jxWVkbNlGXdzesJniTVoyRODSMmKc+U
         gROnF5bZeuA+JMf8YViL9xgLJABHcIFk4RTYBsDob15wHm+aweG7+hnR9yBox5fumTBd
         qrRdM39kmDi6msS+dGQQdIP2qcIVBkhr524qN3z337AxUETI9Fv3WDfOGT4c/+52Uo6V
         iNFRXMeZySkVAKv5ONy84IivCKd20UkyWDp0zBiLfj+9q25uQr1drXwS6YVU8XDRdZNA
         K+yll6dXLoJAX5bd34COIGLsMoRZn1Y7APymmVfwHxJJGyEaqlxldxCHi4Ab7CIbjATB
         ULTA==
X-Gm-Message-State: ACgBeo1meHPEM57SlId3n6pA2wfZMma5emZLUAxLLi8rd7ucMbBAZawV
        5oJxr8SUdRa5qlDEMeekZQs6NPsZUEzAd5kX
X-Google-Smtp-Source: AA6agR5UyT7QJ8qdb82pypGRgrRyNz5kiooSqJixtRW8hVVtgDPI8AsMn6bUhRskpRVgQm2oWxkhng==
X-Received: by 2002:a05:622a:1aa3:b0:344:60fc:6686 with SMTP id s35-20020a05622a1aa300b0034460fc6686mr592028qtc.116.1660779717788;
        Wed, 17 Aug 2022 16:41:57 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm189637qkk.41.2022.08.17.16.41.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:41:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/9] shared: Add definition for LC3 codec
Date:   Wed, 17 Aug 2022 16:41:42 -0700
Message-Id: <20220817234146.224081-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817234146.224081-1-luiz.dentz@gmail.com>
References: <20220817234146.224081-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definition for LC3 codec capabilities and configuration.
---
 Makefile.am      |   2 +-
 src/shared/lc3.h | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/lc3.h

diff --git a/Makefile.am b/Makefile.am
index 92758ca55816..960bf21bc726 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -231,7 +231,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gap.h src/shared/gap.c \
 			src/shared/log.h src/shared/log.c \
 			src/shared/bap.h src/shared/bap.c src/shared/ascs.h \
-			src/shared/tty.h
+			src/shared/lc3.h src/shared/tty.h
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/src/shared/lc3.h b/src/shared/lc3.h
new file mode 100644
index 000000000000..33e8107e39e6
--- /dev/null
+++ b/src/shared/lc3.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ */
+
+#define LTV(_type, _bytes...) \
+	{ \
+		.len = 1 + sizeof((uint8_t []) { _bytes }), \
+		.type = _type, \
+		.data = { _bytes }, \
+	}
+
+#define LC3_ID			0x06
+
+#define LC3_BASE		0x01
+
+#define LC3_FREQ		(LC3_BASE)
+#define LC3_FREQ_8KHZ		BIT(0)
+#define LC3_FREQ_11KHZ		BIT(1)
+#define LC3_FREQ_16KHZ		BIT(2)
+#define LC3_FREQ_22KHZ		BIT(3)
+#define LC3_FREQ_24KHZ		BIT(4)
+#define LC3_FREQ_32KHZ		BIT(5)
+#define LC3_FREQ_44KHZ		BIT(6)
+#define LC3_FREQ_48KHZ		BIT(7)
+#define LC3_FREQ_ANY		(LC3_FREQ_8KHZ | \
+					LC3_FREQ_11KHZ | \
+					LC3_FREQ_16KHZ | \
+					LC3_FREQ_22KHZ | \
+					LC3_FREQ_24KHZ | \
+					LC3_FREQ_32KHZ | \
+					LC3_FREQ_44KHZ | \
+					LC3_FREQ_48KHZ)
+
+#define LC3_DURATION		(LC3_BASE + 1)
+#define LC3_DURATION_7_5	BIT(0)
+#define LC3_DURATION_10		BIT(1)
+#define LC3_DURATION_ANY	(LC3_DURATION_7_5 | LC3_DURATION_10)
+#define LC3_DURATION_PREFER_7_5	BIT(4)
+#define LC3_DURATION_PREFER_10	BIT(5)
+
+
+#define LC3_CHAN_COUNT		(LC3_BASE + 2)
+#define LC3_CHAN_COUNT_SUPPORT	BIT(0)
+
+#define LC3_FRAME_LEN		(LC3_BASE + 3)
+
+#define LC3_FRAME_COUNT		(LC3_BASE + 4)
+
+#define LC3_CAPABILITIES(_freq, _duration, _chan_count, _len_min, _len_max) \
+	{ \
+		LTV(LC3_FREQ, _freq), \
+		LTV(LC3_DURATION, _duration), \
+		LTV(LC3_CHAN_COUNT, _chan_count), \
+		LTV(LC3_FRAME_LEN, _len_min, _len_min >> 8, \
+				_len_max, _len_max >> 8), \
+	}
+
+#define LC3_CONFIG_BASE		0x01
+
+#define LC3_CONFIG_FREQ		(LC3_CONFIG_BASE)
+#define LC3_CONFIG_FREQ_8KHZ	0x01
+#define LC3_CONFIG_FREQ_11KHZ	0x02
+#define LC3_CONFIG_FREQ_16KHZ	0x03
+#define LC3_CONFIG_FREQ_22KHZ	0x04
+#define LC3_CONFIG_FREQ_24KHZ	0x05
+#define LC3_CONFIG_FREQ_32KHZ	0x06
+#define LC3_CONFIG_FREQ_44KHZ	0x07
+#define LC3_CONFIG_FREQ_48KHZ	0x08
+
+#define LC3_CONFIG_DURATION	(LC3_CONFIG_BASE + 1)
+#define LC3_CONFIG_DURATION_7_5	0x00
+#define LC3_CONFIG_DURATION_10	0x01
+
+#define LC3_CONFIG_CHAN_ALLOC	(LC3_CONFIG_BASE + 2)
+
+#define LC3_CONFIG_FRAME_LEN	(LC3_CONFIG_BASE + 3)
+
+#define LC3_CONFIG(_freq, _duration, _len) \
+	{ \
+		LTV(LC3_CONFIG_FREQ, _freq), \
+		LTV(LC3_CONFIG_DURATION, _duration), \
+		LTV(LC3_CONFIG_FRAME_LEN, _len, _len >> 8), \
+	}
+
+#define LC3_CONFIG_8KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
+
+#define LC3_CONFIG_11KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_11KHZ, _duration, _len)
+
+#define LC3_CONFIG_16KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_16KHZ, _duration, _len)
+
+#define LC3_CONFIG_22KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_22KHZ, _duration, _len)
+
+#define LC3_CONFIG_24KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_24KHZ, _duration, _len)
+
+#define LC3_CONFIG_32KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_32KHZ, _duration, _len)
+
+#define LC3_CONFIG_44KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_44KHZ, _duration, _len)
+
+#define LC3_CONFIG_48KHZ(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_48KHZ, _duration, _len)
-- 
2.37.2

