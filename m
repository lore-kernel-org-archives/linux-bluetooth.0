Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB2C77B61
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbjD1Sq4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbjD1Sqx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D562D51
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a92513abebso2901365ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707611; x=1685299611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDu9ngCUhq7egRGnT1zXnnBvaz72CpY739h6yjYjBd8=;
        b=ZrRiCwRv9zdoj4XsSp/YN2RL5PwejGcZP3roehm2lJeBI1ZjJjsvQ0Iq7pFFJhhsQT
         7Lcys2brORlb4tovzfeXfioWqOme2XswjdlydZC9JKZbdq/NZh0QUQ1gN7kU9tvCevue
         hSgoSPMKvj3B8rZBNh14816pnU90mm/+qn5+XkTH/qw8s8Hq12VlydhuVojxBHcRWUp2
         E7aShf7KW0yOjQKricUH0GsjFry3e72hkqWR2WvkO2ddW03iy41U6Wj0VFgR0GvNjVeX
         M8lSP/089Mu5yVoN/eAGHUiQnbcIe9aXsBomY6+jn7Za041R57EgjNyB/jvVqUA15K+U
         gpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707611; x=1685299611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDu9ngCUhq7egRGnT1zXnnBvaz72CpY739h6yjYjBd8=;
        b=JFMiz9su5nlASs3NlmOTBZfO+DBZMxajwyBbOAMFqlcFrGyRT8oqDmwM8nO5qLB3al
         0/IzNcPEDcVNQnC6zCdKNWaych2z3mlLB2kr+2DCGi8TpmF2+Om1z2eBtW6QTe3ozjEK
         576EalEImCglIFPiJxtqJEHlNCBTfKiLPg8ck4kv85F9dV4a2w5reV4ef/K/2kJpYzi4
         Q9NW0WS7JDKIe+bTfSn8wH7UCDGGV0AoFJQiub7ord8j07Cq0flIvO/aWWJW7kLDQQdQ
         Gbi/TUPoflIfVg3eyx3tS+8URgTpbSiC/kNXLujWdjWiQcR1WAuE/EdE35iks5xqHE5U
         4Qxw==
X-Gm-Message-State: AC+VfDyXEuB9bScfor6tUL32rGoRBhWtMuZA0bIfOFpdHx3LXfReWzIL
        x/dy+rEd/3hsuHCCkFppg82AL0KfRls=
X-Google-Smtp-Source: ACHHUZ5rW0PnoiQ2Hf7/SFDzOJJ5i6Y96mIMax5xZPn+nfH4XWa0giwnLrXXKKJ0XWonKUT6xqtmFw==
X-Received: by 2002:a17:902:c745:b0:1a9:9a18:345c with SMTP id q5-20020a170902c74500b001a99a18345cmr5430391plq.44.1682707611029;
        Fri, 28 Apr 2023 11:46:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 6/9] shared/lc3: Update configuration to use iovec
Date:   Fri, 28 Apr 2023 11:46:37 -0700
Message-Id: <20230428184640.849066-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
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

