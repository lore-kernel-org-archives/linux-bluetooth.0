Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E7C001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 19:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGLTjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGLTjC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 15:39:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F681FC7
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:39:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b895a06484so39095005ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190740; x=1691782740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/Sp+CYoanXDATUPRoonQHqBB4S+uYRSPpoZ9z/Hp1c=;
        b=jD1VwpacPc3qdKE7OIiJb0jN1d+SZ117AA6hjgITh67AsJZ9qhmEGBUVAAJXvq+0T2
         J2+FeSwjKYo5ckcF9upuNi++sQ7USmIkm+RNB6FbSRqIjKJ2q3J56Ge+hMv6eRA4ovEb
         L4NenDzPnw+W7V3eP2E++CRpnbfUObImepe86h3clvFFZFS3OOikRCJNxJ6KnbpGTHmQ
         OmwM6MRBLia12ToLpWpT+covZ1uiBAL0uEsKKMHEwetKrLWcGR/rxf87VztwIqzK10eZ
         DMpE3piRmx5tOBe6922/mRHA1lv9bn5E99CPK9AITI7gVO1pVmcSQBGmaoWhMnNd0JZx
         v1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190740; x=1691782740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/Sp+CYoanXDATUPRoonQHqBB4S+uYRSPpoZ9z/Hp1c=;
        b=RmY+lL1ciEBEqF3PjXRgkF4z4IkbWwUA69T4J2krMV34ZkrzQFDasV4K2o6KDITlp5
         gUwsL7w8nvFF7fcQbsviwfyIm5X/+erZSehEB7YYEUpdCj166IK+r+3xrexoRTcW5oZC
         2qZ2Noe3eODUg6DssKKTxzoBRM6paEGR2cUuaxlzwayLriTiOF87K1BkIPWl1HGvsd7R
         BqKIeBh4lQQKjxGaHbFDvGNwMxvH4b8IJSIfur6JSctNn1owKlX4qr0pExV3RaIFwQWL
         7wALqPKIiKAhmG1cTr2z7HJ5OtcFneff5kXh8wM7kZvkupZs42TKGSzessTXnkwv7M/d
         lo9A==
X-Gm-Message-State: ABy/qLYUv+z7CpV+vp2GEecnyyWAH02DKylDMI6pO6I65OhKGGpKz0XS
        mRcflDuUIwV9kOJ7Br/l/f0F0rLTySY=
X-Google-Smtp-Source: APBJJlFrcatOGHNFNajKMFW5F2KWZ1pUXImttgvZ07PTwwXC6OuTwR9HpmdCzuOocZ+o7BYTGN+zbg==
X-Received: by 2002:a17:902:ea0d:b0:1b6:bced:1dd6 with SMTP id s13-20020a170902ea0d00b001b6bced1dd6mr18089455plg.35.1689190740350;
        Wed, 12 Jul 2023 12:39:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id ij12-20020a170902ab4c00b001b84cd8814bsm4413264plb.65.2023.07.12.12.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:38:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/util: Introduce strisutf8
Date:   Wed, 12 Jul 2023 12:38:52 -0700
Message-Id: <20230712193854.1862996-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712193854.1862996-1-luiz.dentz@gmail.com>
References: <20230712193854.1862996-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces strisutf8 which can be used to verify if a string is
encoded using UTF-8 format.
---
 src/shared/util.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  3 +++
 2 files changed, 65 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 4d1c0d00545d..e9c1c18f5ea7 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1705,3 +1705,65 @@ int strsuffix(const char *str, const char *suffix)
 
 	return strncmp(str + len - suffix_len, suffix, suffix_len);
 }
+
+char *strstrip(char *str)
+{
+	size_t size;
+	char *end;
+
+	if (!str)
+		return NULL;
+
+	size = strlen(str);
+	if (!size)
+		return str;
+
+	end = str + size - 1;
+	while (end >= str && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	while (*str && isspace(*str))
+		str++;
+
+	return str;
+}
+
+bool strisutf8(const char *str, size_t len)
+{
+	size_t i = 0;
+
+	while (i < len) {
+		unsigned char c = str[i];
+		size_t size = 0;
+
+		/* Check the first byte to determine the number of bytes in the
+		 * UTF-8 character.
+		 */
+		if ((c & 0x80) == 0x00)
+			size = 1;
+		else if ((c & 0xE0) == 0xC0)
+			size = 2;
+		else if ((c & 0xF0) == 0xE0)
+			size = 3;
+		else if ((c & 0xF8) == 0xF0)
+			size = 4;
+		else
+			/* Invalid UTF-8 sequence */
+			return false;
+
+		/* Check the following bytes to ensure they have the correct
+		 * format.
+		 */
+		for (size_t j = 1; j < size; ++j) {
+			if (i + j > len || (str[i + j] & 0xC0) != 0x80)
+				/* Invalid UTF-8 sequence */
+				return false;
+		}
+
+		/* Move to the next character */
+		i += size;
+	}
+
+	return true;
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index ce57b53be9ef..c37b0f7296ab 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -12,6 +12,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <alloca.h>
 #include <byteswap.h>
 #include <string.h>
@@ -88,6 +89,8 @@ do {						\
 
 char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
+char *strstrip(char *str);
+bool strisutf8(const char *str, size_t length);
 
 void *util_malloc(size_t size);
 void *util_memdup(const void *src, size_t size);
-- 
2.40.1

