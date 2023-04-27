Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24CC7EE24
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 19:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbjD0TdL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbjD0TdB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 15:33:01 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA010CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:59 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3293e4b2cb5so70750035ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623978; x=1685215978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAzRzgFqkl4Naoj8NS6vvPgDDNigBOrReuLftwEG1Rg=;
        b=i03oSb8n101w6ecDZjPt+YPXd/SijX7d6Mgatatz0TFf6R4GQRKDS4i5F4VB6jtAVb
         L+P1c0rCCWj3l6J/MdM5bUrKx5B2VddQaP+oUZeaol9DQU/225UCFaSIheAKK0I/qnKR
         y3N1zMMprHdymoVmALljFdPbPbwEnT8Ev4hvvOBwdntYREwIU+y15Xhh/9JKXKt0CpyY
         DlKKH5N79FsphBlQgNfZi2bqLCHFW0KPXWXi0ezTKEVgnHIuDspY1NunVbymu2W7xoAw
         gAZEC5uyWyFOSEgyNSI4CUMq25JpdHp1Bg3xl5YMQZklAp4X6C590btBFOxYyxC7u9VC
         PXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623978; x=1685215978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAzRzgFqkl4Naoj8NS6vvPgDDNigBOrReuLftwEG1Rg=;
        b=GEC06KBg3igP7XwEv2UTzFHEFe/r18zl+4TJUkrF+31kUsxvELgtTHiUUrwfw9m1hp
         IEY68Vet7nsTcStbleWTV3DESbPjrcYo/f72k9qdmxa2poR98whdAbN3tD7QVMOJG3P1
         VFEoppU1nZkDJdT4C+kBAow8nDddNCRJkcWzARxkwq8qI/xE9KKqx/UXF5HQaRr8/fyG
         MhvOSClioTQcKc6IegMvJGXstegnYgSHpU9zU5py9B9EouYdd0J3JuyaVGOqfE6113pR
         HnfQh4f4nt3JgcfPRTk48J7Tq2QiADcTn88VvV7qg4aIEgO0NvPYaYj8Y9kw4W8cKpAN
         Cr6Q==
X-Gm-Message-State: AC+VfDxtHQbRswDkZQ6fF9IbwtcOS1vDjJ71U+oeUxULIhLDMs3scrLZ
        M0a4kSh6JxCdXi2VmvMV9mTH75hXHlM=
X-Google-Smtp-Source: ACHHUZ4pQsqq9g5FS1HUr7k+BPYQOvyc5PGdX5Xxku0iFDr44/guFVvK8CcWbWS2RVP8GprymXw4EQ==
X-Received: by 2002:a92:ccc4:0:b0:32f:2614:cda9 with SMTP id u4-20020a92ccc4000000b0032f2614cda9mr1927199ilq.3.1682623978430;
        Thu, 27 Apr 2023 12:32:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638264c00b00411baa5ec5asm3349898jat.154.2023.04.27.12.32.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:32:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 6/9] shared/lc3: Update configuration to use iovec
Date:   Thu, 27 Apr 2023 12:32:42 -0700
Message-Id: <20230427193245.323502-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427193245.323502-1-luiz.dentz@gmail.com>
References: <20230427193245.323502-1-luiz.dentz@gmail.com>
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
index fd9eb15a73ea..c702a951f50c 100644
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
+	LC3_IOV(0x02, LC3_FREQ, _freq, _freq >>8, \
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

