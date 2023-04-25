Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E754C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 20:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjDYUrs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjDYUrr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 16:47:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A64F16181
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517bdd9957dso4547659a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682455663; x=1685047663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAzRzgFqkl4Naoj8NS6vvPgDDNigBOrReuLftwEG1Rg=;
        b=QX8TJDU1DWTuz8RSCsQLDCuChEO2cUW7waDO23eWvb3KGlsqVKsAoMILz+nqdV04kK
         qmBkOhxD/pmIT9AXOZ4rPmHSgJqxeR1rBJKiUoNrCrP5oHp2EsV3eV2FgkchAcGrsrtC
         N40ZXaC7SXEh83Vu8IVs3zjQVWDY6wf+zzYrKrk/fRVmLH4N4SOVIzEf+0htisONP6Uf
         bxMQuwfPZCzwYMhdmg+nkZAwAbptz+hLq+ROLLGx+OJCAZkZ/Vtbyog8FfuSohXb9ict
         Ni5oLyd9JJFIpDBza485/Y45PEy/JXQnpgcAkqgcJFoDUqEuqCvOX0+ubjIf/FV88rp7
         RAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455663; x=1685047663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAzRzgFqkl4Naoj8NS6vvPgDDNigBOrReuLftwEG1Rg=;
        b=SHySLUnEIK7nbk5xRDUDsign19S3O0umItHxumQ05QNqfLxvfrJIRUHyE9x0rFQZ+k
         d4mpt65wKsNPcGp5fYCre+6ZHkjC32Dsmndfde2m+EzdLHRyGp0Sc0VBuEHJlIOj1BDk
         +6siNKmNf3tVzoC7Ccfv1GEeqEqR1frr+o5we0mlkcVgSCfyrkoE1LXR1SEcAWQEkMJh
         3th+PzGmEBagnAxJVNF9qayMywHRraewoNIOOGCU4T/ueoVfiFIOWOWEFV5/uWECYi6A
         FgMAKalSmIKzRTFyI+m1xvjG1MylozLdKDR4Zr5e5B6ijtBa9lnaYnohYYGKObY2lLGH
         +sXg==
X-Gm-Message-State: AAQBX9fG20YPqpIKsOzd6N5Gu5OOleB8e9Dk+kAi5h3o6Km45LKGlmyD
        Kq38UdylXtXupwmGkrKhhrcgmOGEwQk=
X-Google-Smtp-Source: AKy350Z9dVIQUf17+rbfiVJ2H5G9gl1TISngH2xMogefScT0UIo3PVKf8baEDVdvU5gTitrnmG08Eg==
X-Received: by 2002:a17:90a:d90e:b0:247:8b5f:59ce with SMTP id c14-20020a17090ad90e00b002478b5f59cemr18312642pjv.20.1682455662666;
        Tue, 25 Apr 2023 13:47:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm8247454pjq.43.2023.04.25.13.47.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:47:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] shared/lc3: Update configuration to use iovec
Date:   Tue, 25 Apr 2023 13:47:28 -0700
Message-Id: <20230425204729.3943583-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425204729.3943583-1-luiz.dentz@gmail.com>
References: <20230425204729.3943583-1-luiz.dentz@gmail.com>
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

