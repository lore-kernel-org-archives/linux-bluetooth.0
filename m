Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC8C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 23:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjD0XOJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344325AbjD0XOI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 19:14:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE4272E
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:14:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so7545170b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682637244; x=1685229244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDu9ngCUhq7egRGnT1zXnnBvaz72CpY739h6yjYjBd8=;
        b=h9A6PKxIWocRFW9Z9McsKB1Uoq+EN2gdoys77TpuWL5JIzSs6+tbwYPOJ+DPpgXfGC
         lM7yNcYStjYGBfs4rZnSviwU/QT4Do9lu2thujAHlfnFr7T4mOXQ/qi9pgn9TQkJFqmC
         Zdp2VR0rpMFsKIjyMN+fJKAoIh+9bg7jYQBds1CEbAf8Krlb1ZfOOXg13WT0SPNbvx9c
         eITf06WGxf8yswKJj5dDHwRjnIe2S/ywSOScGWBkMjV8usQWzx1c3rvN9bpzT9xyTZj2
         kSyCYsgLxzyzj45GDGjg4ld/N0ynO20Lt2uhIpD8172ml9h+NnwI5JvDrk1WZ1oZpd/U
         VvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682637244; x=1685229244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDu9ngCUhq7egRGnT1zXnnBvaz72CpY739h6yjYjBd8=;
        b=XeNAxDLjHbwHWOIS/IQZOlHT4tL4Uoqe5wEnjB/60daqPSC/M8qXJYtzCRNhjRrecF
         14vyO3PfyfYVQ0CdB1vmsX4KHoxn1H4/i2V/JlXY/WfR6Sln4DOM/y0qfksD+1la3uto
         NWQzXV/0775IRkC+/s2JOWL+Us/3N0Qp/XbQClhAngx2ERA2czmDGsb7/Gjqp6ubICz3
         zxLxnOtOnWatUVBvMPuKc7HJpymM10UvIt1NsIpRuqhUK944lP9XnOL2hcN0PW9yqUfB
         +5erQYYcO+44hoCfRq5LCkqZGInwR3wx1zYpuNOU3KeTfMCcFf6u5Ff+JPfEb74zj5XJ
         CrAQ==
X-Gm-Message-State: AC+VfDwK8nCj5IUZIlEokbU/0WflAtz10YuJw+tdWPRyRZHJX9zMfyFq
        Lm0UQfQYzXtZ86vskGn5iBrJ4LYiA6A=
X-Google-Smtp-Source: ACHHUZ7itMpNLtKLG0xG4rpimFPJO8wtNvGbtaDbUQKBNalrLz2JeefTrx5jG7ZQvK/zVuGrj54CYw==
X-Received: by 2002:a17:902:e884:b0:1a1:f0cb:1055 with SMTP id w4-20020a170902e88400b001a1f0cb1055mr3995429plg.28.1682637243814;
        Thu, 27 Apr 2023 16:14:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902aa4500b001a24cded097sm12112369plr.236.2023.04.27.16.14.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:14:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 6/9] shared/lc3: Update configuration to use iovec
Date:   Thu, 27 Apr 2023 16:13:49 -0700
Message-Id: <20230427231352.576337-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427231352.576337-1-luiz.dentz@gmail.com>
References: <20230427231352.576337-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This use iovec as expected storage for capabilities and configuration
so it is inline with what bluetoothctl has been using making it simpler
to reuse these definitions.
---
 src/shared/lc3.h | 93 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 24 deletions(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index fd9eb15a73ea..ae193f9e2fa7 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -7,11 +7,12 @@
  *
  */
 
-#define LTV(_type, _bytes...) \
+#define data(args...) ((const unsigned char[]) { args })
+
+#define LC3_IOV(args...) \
 	{ \
-		.len = 1 + sizeof((uint8_t []) { _bytes }), \
-		.type = _type, \
-		.data = { _bytes }, \
+		.iov_base = (void *)data(args), \
+		.iov_len = sizeof(data(args)), \
 	}
 
 #define LC3_ID			0x06
@@ -52,13 +53,11 @@
 #define LC3_FRAME_COUNT		(LC3_BASE + 4)
 
 #define LC3_CAPABILITIES(_freq, _duration, _chan_count, _len_min, _len_max) \
-	{ \
-		LTV(LC3_FREQ, _freq), \
-		LTV(LC3_DURATION, _duration), \
-		LTV(LC3_CHAN_COUNT, _chan_count), \
-		LTV(LC3_FRAME_LEN, _len_min, _len_min >> 8, \
-				_len_max, _len_max >> 8), \
-	}
+	LC3_IOV(0x02, LC3_FREQ, _freq, _freq >> 8, \
+		0x02, LC3_DURATION, _duration, \
+		0x02, LC3_CHAN_COUNT, _chan_count, \
+		0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, \
+		_len_max, _len_max >> 8)
 
 #define LC3_CONFIG_BASE		0x01
 
@@ -81,32 +80,78 @@
 #define LC3_CONFIG_FRAME_LEN	(LC3_CONFIG_BASE + 3)
 
 #define LC3_CONFIG(_freq, _duration, _len) \
-	{ \
-		LTV(LC3_CONFIG_FREQ, _freq), \
-		LTV(LC3_CONFIG_DURATION, _duration), \
-		LTV(LC3_CONFIG_FRAME_LEN, _len, _len >> 8), \
-	}
+	LC3_IOV(0x02, LC3_CONFIG_FREQ, _freq, \
+		0x02, LC3_CONFIG_DURATION, _duration, \
+		0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
 
-#define LC3_CONFIG_8KHZ(_duration, _len) \
+#define LC3_CONFIG_8(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
 
-#define LC3_CONFIG_11KHZ(_duration, _len) \
+#define LC3_CONFIG_11(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_11KHZ, _duration, _len)
 
-#define LC3_CONFIG_16KHZ(_duration, _len) \
+#define LC3_CONFIG_16(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_16KHZ, _duration, _len)
 
-#define LC3_CONFIG_22KHZ(_duration, _len) \
+#define LC3_CONFIG_22(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_22KHZ, _duration, _len)
 
-#define LC3_CONFIG_24KHZ(_duration, _len) \
+#define LC3_CONFIG_24(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_24KHZ, _duration, _len)
 
-#define LC3_CONFIG_32KHZ(_duration, _len) \
+#define LC3_CONFIG_32(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_32KHZ, _duration, _len)
 
-#define LC3_CONFIG_44KHZ(_duration, _len) \
+#define LC3_CONFIG_44(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_44KHZ, _duration, _len)
 
-#define LC3_CONFIG_48KHZ(_duration, _len) \
+#define LC3_CONFIG_48(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_48KHZ, _duration, _len)
+
+#define LC3_CONFIG_8_1 \
+	LC3_CONFIG_8(LC3_CONFIG_DURATION_7_5, 26u)
+
+#define LC3_CONFIG_8_2 \
+	LC3_CONFIG_8(LC3_CONFIG_DURATION_10, 30u)
+
+#define LC3_CONFIG_16_1 \
+	LC3_CONFIG_16(LC3_CONFIG_DURATION_7_5, 30u)
+
+#define LC3_CONFIG_16_2 \
+	LC3_CONFIG_16(LC3_CONFIG_DURATION_10, 40u)
+
+#define LC3_CONFIG_24_1 \
+	LC3_CONFIG_24(LC3_CONFIG_DURATION_7_5, 45u)
+
+#define LC3_CONFIG_24_2 \
+	LC3_CONFIG_24(LC3_CONFIG_DURATION_10, 60u)
+
+#define LC3_CONFIG_32_1 \
+	LC3_CONFIG_32(LC3_CONFIG_DURATION_7_5, 60u)
+
+#define LC3_CONFIG_32_2 \
+	LC3_CONFIG_32(LC3_CONFIG_DURATION_10, 80u)
+
+#define LC3_CONFIG_44_1 \
+	LC3_CONFIG_44(LC3_CONFIG_DURATION_7_5, 98u)
+
+#define LC3_CONFIG_44_2 \
+	LC3_CONFIG_44(LC3_CONFIG_DURATION_10, 130u)
+
+#define LC3_CONFIG_48_1 \
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, 75u)
+
+#define LC3_CONFIG_48_2 \
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, 100u)
+
+#define LC3_CONFIG_48_3 \
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, 90u)
+
+#define LC3_CONFIG_48_4 \
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, 120u)
+
+#define LC3_CONFIG_48_5 \
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, 117u)
+
+#define LC3_CONFIG_48_6 \
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, 155u)
-- 
2.40.0

