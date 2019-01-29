Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F43C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CF82147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsJK42ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfA2N0k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:40 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:42925 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfA2N0j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:39 -0500
Received: by mail-ed1-f44.google.com with SMTP id y20so15940736edw.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=lkAak8YkVJhMqmBbCroxFOGLIBlfK/xui5S8VQTp+Bw=;
        b=XsJK42eiwbirM4N2BMpweZZjVOJzWH2IQxkGm9GS0bjEGf9OKNHGyuZyBN7wc3+hmM
         CaQH8sQc823b6z8IodAIo4LGuGhDy/umotQwO7Vl/N8apovf196jPy+cNvFIqLR3Ar3I
         c2CUI3WD6EBEFdi13GM1vM5s1uoqnMaFCaWllKNM7GZ98N6qkRUmLuEBnm4+kfiCx11Q
         D2kAQNYBmimX5p3l5OVpF+MBVkbrd3zNezwM5/jd7fRRqrsiqyOkUsJmoxElxFuOq8WQ
         Bx0wikBoCGBLbEE7zzM4Wv8K1Ah3H1hs39HXQtHCWbQiykms3ls4pLIHoI7Kb3t6GVNl
         3IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=lkAak8YkVJhMqmBbCroxFOGLIBlfK/xui5S8VQTp+Bw=;
        b=PxqvqGfByFoin8Hz1BohgL9rXb9Tj8Os9BroaTyM47YDNCvFAECyD8fKXIves3NPB2
         iGWyHfQvMcU6qmyabbxPZ0b2TWTMWU5WLqnoDx15ZEykUMKs9giQ9iEbeFHVoOAmFUzt
         RwSOP6HlmM4e51Kr8LrytL9b9MhThYEOYZ/29pgqU6EmcSSuloHTr4HgyNMp0coS0ckj
         RkF+BmJfEblO5ez7xlkyMfNTw5WNOtXaxa2dKpiMmqUu6VactECLxIl5IAWxKCV37wpg
         SDnoh15PxGDpHzS1Z41XzdAX34SNQMo1lQxSSknE9YM5vhZF9mVa7SqFkJDtVHGIjtV1
         S04w==
X-Gm-Message-State: AJcUukeW95Qf0iWqQ3pr9JZLD1DuK3bvhyUwpTwtMvg5sjk+A+YTOmpE
        c5kfZFzBNApOu1eZMw5kV0+ARxx2
X-Google-Smtp-Source: ALg8bN4oSbuClcGiDx9mxgXUpAf/8eQNHNLdGQuvAI3WL92fiUUGR7fIgAb1zn7KQU/dyaJNWjuMVw==
X-Received: by 2002:a17:906:78c6:: with SMTP id r6mr22818417ejn.123.1548768397454;
        Tue, 29 Jan 2019 05:26:37 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/15] shared/crypto: Add bt_crypto_gatt_hash
Date:   Tue, 29 Jan 2019 15:26:20 +0200
Message-Id: <20190129132634.28786-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The bt_crypto_gatt_hash uses AES-CCM to create a hash with the contents
stored in the iovec.

Note: The spec disregards the byte order so both the key, msg and res
are not swapped.
---
 src/shared/crypto.c | 31 +++++++++++++++++++++++++++++++
 src/shared/crypto.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index ce0dcd638..5c5e1217d 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -688,3 +688,34 @@ bool bt_crypto_h6(struct bt_crypto *crypto, const uint8_t w[16],
 
 	return true;
 }
+
+bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
+				size_t iov_len, uint8_t res[16])
+{
+	const uint8_t key[16] = {};
+	ssize_t len;
+	int fd;
+
+	if (!crypto)
+		return false;
+
+	fd = alg_new(crypto->cmac_aes, key, 16);
+	if (fd < 0)
+		return false;
+
+	len = writev(fd, iov, iov_len);
+	if (len < 0) {
+		close(fd);
+		return false;
+	}
+
+	len = read(fd, res, 16);
+	if (len < 0) {
+		close(fd);
+		return false;
+	}
+
+	close(fd);
+
+	return true;
+}
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index 1e1b4836d..c58d2e104 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -23,6 +23,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <sys/uio.h>
 
 struct bt_crypto;
 
@@ -61,3 +62,5 @@ bool bt_crypto_h6(struct bt_crypto *crypto, const uint8_t w[16],
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 				const uint8_t *m, uint16_t m_len,
 				uint32_t sign_cnt, uint8_t signature[12]);
+bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
+				size_t iov_len, uint8_t res[16]);
-- 
2.17.2

