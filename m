Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF79BC0502A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 23:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbiHZXUs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbiHZXUp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 19:20:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01222BA17C
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e19so2916310pju.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=HcZbzWIaS3ZBAoKQ8WtTSxdAa3N97Uesw92CvXSMVJ0=;
        b=aA6wgMg2QBqx//S3yt67zc7W17Us7+GgsXuoEcL3gfA8ejLy4zJSxWh0WHYVmJZ4Ty
         LCajq8N8Bpqn9mpkfDOYahLVMJTvRCBJsxVze9fDTeyZq56R1EcQhMGqUzNlKXlmYYVk
         GfHy6lC1il3WCYT0KxVL4qsDlgw95aZmeRCrx/4FdWFT+wg0osL1RuvA7BXXFbZ1PEIN
         E6ogICaby7LVdOqYDh/K70O6EUzQ8bAEOSse3WW4tAkyt7jwSCaXt+wqXNxGZmY9DHF/
         sQR1+Odq8qp/PZFR/GeHPaY6dRdQCtxja7h+PiLTD8fk4u1AR5yJGn2X3b7ODYOq2AXz
         jnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=HcZbzWIaS3ZBAoKQ8WtTSxdAa3N97Uesw92CvXSMVJ0=;
        b=Yq5cqTDUXWLqcd3vElT9SuDW65GP5geuPgbxfY2rNYOomnln1nf3gaQ+wMWu7R57Nj
         IZEBr2lY1dVeCFvM2Jn3/K6e4rQIyP0bN60V/LMsqaHxxWPhqiQGUHn4687PJyvOlnye
         Xjgd7WEdSI5DjTF3MTkkRaA7+yPswVbr16boXpQAZAjwE8zaKtu88Hm/3tACNpQNzEez
         /fAP5bsqq5hjON6VpLFiW/uPszF0lRHIJ4NMi947lxR+/v2A5e4UfrlE4XguhKOeOAw2
         z+UrNlYkV/0s8X0faQRi9eJje7725NeGG2BuUXyNudNwfjQAbi+140ChSDnALQtzBwjA
         vKuQ==
X-Gm-Message-State: ACgBeo1PUbsqz5DNeAbFtoy+rfh5ClCm9QVGNKUJIRaP1s6C/xWBU27k
        YnfM2qZ+g9+oB2aohqfRXt+K/TvlXeA=
X-Google-Smtp-Source: AA6agR4oiJEM7TZfNGA5Hgb+e4GFBtfLDZ+5Lq0mY+qcy+6e2r/eOdryNXfOkblky4qQqR4pQrcAGQ==
X-Received: by 2002:a17:903:1c8:b0:173:c58:dc6d with SMTP id e8-20020a17090301c800b001730c58dc6dmr5722380plh.105.1661556040938;
        Fri, 26 Aug 2022 16:20:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm2312338pfq.66.2022.08.26.16.20.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:20:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/9] shared: Add definition for LC3 codec
Date:   Fri, 26 Aug 2022 16:20:27 -0700
Message-Id: <20220826232031.20391-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826232031.20391-1-luiz.dentz@gmail.com>
References: <20220826232031.20391-1-luiz.dentz@gmail.com>
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

