Return-Path: <SRS0=7VLe=PA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4795C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927D721783
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Dec 2018 10:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXLFi6Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeLWKk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:40:57 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53504 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeLWKk4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Dec 2018 05:40:56 -0500
Received: by mail-wm1-f51.google.com with SMTP id d15so9077802wmb.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Dec 2018 02:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=nphns7JD8OlT01RVlVjseRtfj5Q53+2Gn6dSp6ebHLE=;
        b=SXLFi6CtYLfRcI8VuYRtSLwMpV2gmMFtDvMaC0M6P8kzkXyD8llgQE1YPLUS80XKxu
         E9XYFKU7nI7e+8zRnzLHCRQsoTVNAbU+H2RA9c4zg495IWChQWDzobfP3ehUEBYPhScR
         4FS8wYsaXQmXnyTFDqEw/MADOBc1mWgFLH4urnBcRnlU3vdW7CSZOVOYMbfRWY3wEFUl
         TZlilXlwYCf116CYU+B4czf2p1DF+z/Ek97MALnIwyVGfOiGYfLchHUyDKDxKtzsS4rL
         315g/+2I0d9pjSWvbnoKDqZttTCUKRjQfs1UsPMQOkfdazov1a6FzRyVz5lAD2Y3IqOn
         hM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=nphns7JD8OlT01RVlVjseRtfj5Q53+2Gn6dSp6ebHLE=;
        b=TYmZ5vywMXS1Rck5N8srt3Fp7zU8L7K+oUEzfWWB+dNhKR/kwjX6zx4WxFCCScgjU8
         AxEk6iKJ4mklTrh8e3uNuDuE8RynXj/qNtgE782VBOYkmATUJqnD2euPYlTGI8+2de32
         eozyBKFaQ3eg0N1R42lpaaDvDSlWmRT8JQJ+BbTMKXrkLJbmL9jVCtCjw2qC38TvSEFI
         stvBg3snTbwI5Dd7j5BiRJ++9XTtdLDHXQGpMjvusTbnzu9QxncPL7CGc2miK55Zd1/Y
         l1vwiXJkJfflDmQr5LmL9YZu9tjFi3+YfWsBqqg3ytJUzD+4/2PLxLc91lAiVY13/r+x
         ARDg==
X-Gm-Message-State: AJcUukeLFjdECGEHtAs6qb1hqK9ZAmz6cyq1qkowINGtE4gE5K9yYTvI
        ID3WmGAxEtrgQbfxjgDWz/lunPi74XM=
X-Google-Smtp-Source: AFSGD/V9z9bgEcYgxIfygFojjnBstDAf8c7bYiDufcjCAgE31hlCiPVL702NtsK/mT2PAoW3kZvCnQ==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr8556304wmf.94.1545561654309;
        Sun, 23 Dec 2018 02:40:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id d4sm12168616wmb.25.2018.12.23.02.40.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 02:40:53 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] a2dp-codecs: Properly define macros and struct for LDAC codec
Date:   Sun, 23 Dec 2018 11:40:19 +0100
Message-Id: <20181223104021.18620-9-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181223104021.18620-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
 <20181223104021.18620-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/audio/a2dp-codecs.h | 27 +++++++++++++++++----------
 tools/avinfo.c               |  4 ++--
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 649e2411b..6f667d3aa 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -200,6 +200,17 @@
 #define LDAC_VENDOR_ID			0x0000012d
 #define LDAC_CODEC_ID			0x00aa
 
+#define LDAC_SAMPLING_FREQ_44100	0x20
+#define LDAC_SAMPLING_FREQ_48000	0x10
+#define LDAC_SAMPLING_FREQ_88200	0x08
+#define LDAC_SAMPLING_FREQ_96000	0x04
+#define LDAC_SAMPLING_FREQ_176400	0x02
+#define LDAC_SAMPLING_FREQ_192000	0x01
+
+#define LDAC_CHANNEL_MODE_MONO		0x04
+#define LDAC_CHANNEL_MODE_DUAL		0x02
+#define LDAC_CHANNEL_MODE_STEREO	0x01
+
 typedef struct {
 	uint8_t vendor_id4;
 	uint8_t vendor_id3;
@@ -225,6 +236,12 @@ typedef struct {
 		.codec_id1 = (((c) >> 8) & 0xff), \
 	})
 
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t frequency;
+	uint8_t channel_mode;
+} __attribute__ ((packed)) a2dp_ldac_t;
+
 #if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && \
 	__BYTE_ORDER == __LITTLE_ENDIAN
 
@@ -268,11 +285,6 @@ typedef struct {
 	uint8_t frequency:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
-typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t unknown[2];
-} __attribute__ ((packed)) a2dp_ldac_t;
-
 #elif defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && \
 	__BYTE_ORDER == __BIG_ENDIAN
 
@@ -316,11 +328,6 @@ typedef struct {
 	uint8_t channel_mode:4;
 } __attribute__ ((packed)) a2dp_aptx_t;
 
-typedef struct {
-	a2dp_vendor_codec_t info;
-	uint8_t unknown[2];
-} __attribute__ ((packed)) a2dp_ldac_t;
-
 #else
 #error "Unknown byte order"
 #endif
diff --git a/tools/avinfo.c b/tools/avinfo.c
index 9a07e675d..9d5c4e511 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -204,8 +204,8 @@ static void print_ldac(a2dp_ldac_t *ldac, uint8_t size)
 		return;
 	}
 
-	printf("\n\t\t\tUnknown: %02x %02x", ldac->unknown[0],
-							ldac->unknown[1]);
+	printf("\n\t\t\tUnknown: %02x %02x", ldac->frequency,
+							ldac->channel_mode);
 
 	printf("\n");
 }
-- 
2.11.0

