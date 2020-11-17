Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD80FC56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DAD2465E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 15:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="AsneKCkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKQP5K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgKQP5J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 10:57:09 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B667C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 07:57:09 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s30so30802596lfc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZr1CDpsxkc0EtTeIWjg8oXT7/DV+Tesw82XN3N59Y8=;
        b=AsneKCkCgXXof2+1Y2aqdvEv2nocv7idshizTTw2WXElrue5y0ceQexxsJWsJjyNeA
         VCCdY3KUps5jiHSDcQqzIGR7EJ8q5QTOZlyw2sJmUQagL6cHzfDX+Gwfdil/JBNSZZz6
         feJ1tfiSqjBnmA1gCV9ZWO2m74cFMQ8LEW5cO4fM2iftIBvqy0j4rp8VQu8fpQAIs5oc
         McmmIK3mKjTeacGuCKunSdORtiqQmiD5/fy0UNPpuNyj6RmvwZali87NDk4CdDNcQfxx
         iUYUogddQ+ZggyxVa3ZGtK0K4LJg5Wp0WaN4BAednanPFyy0x/yCA7ekakKQlQFU71s4
         jq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZr1CDpsxkc0EtTeIWjg8oXT7/DV+Tesw82XN3N59Y8=;
        b=c6LphzJ5CBY4Sc/k1yDcE1iw24DMlMRi8FrX1cGkNGPDr4eaz9XFbmS9BuloQCgkWL
         1VcBNlK0MqnqkB1rDnoqNbJi5NgwtSn57+BrnJKXci3foaS9okD13arcDW2nXK7IMUb8
         qGdD4vCgfFLV6+ryIUaIiLdKRB9wAM0uBmJakmDPcpQH3hneMyYNp/TQlX+EHzyWPWm4
         hH5+bMZHRk+7VuzFaKwBpFS28HNr1XeduI1JwlwMkwAsqzy3IdDsMwWph24PlCP0DFUV
         GWMOZR+9SyNXvUlFIj/CM78cWRfACMkiJ7b9Tu1j6htYfyoQQiRj4hf5b/8zWVbSnxWo
         f1gg==
X-Gm-Message-State: AOAM530q2wNlYTuw4kAsRx8Y8IOH45lrn/zKkMgEl7uMNUkuskzq88+R
        UJsOUxkrr0NimdoF/dlAB/cSOTiAaZkmYA==
X-Google-Smtp-Source: ABdhPJxWMXKGrnPqEwW8nI25WrNoh3iI2yzFDEacapO88yDKr4Alk7rut62OvJzARQdlvsSLwAxFhA==
X-Received: by 2002:ac2:44ac:: with SMTP id c12mr2169378lfm.602.1605628626998;
        Tue, 17 Nov 2020 07:57:06 -0800 (PST)
Received: from ix.codecoup.local ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id v9sm3192366lfd.287.2020.11.17.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 07:57:05 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] device: Update cache only if content changed
Date:   Tue, 17 Nov 2020 16:57:03 +0100
Message-Id: <20201117155703.30268-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fix hammering storage device (eg sdcard) when doing scanning
and LE devices are around.
---
 src/device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 2800b276a..cf4226f42 100644
--- a/src/device.c
+++ b/src/device.c
@@ -509,7 +509,9 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	char d_addr[18];
 	GKeyFile *key_file;
 	char *data;
+	char *data_old;
 	gsize length = 0;
+	gsize length_old = 0;
 
 	if (device_address_is_private(dev)) {
 		DBG("Can't store name for private addressed device %s",
@@ -524,11 +526,17 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	data_old = g_key_file_to_data(key_file, &length_old, NULL);
+
 	g_key_file_set_string(key_file, "General", "Name", name);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
+
+	if ((length != length_old) || (memcmp(data, data_old, length)))
+		g_file_set_contents(filename, data, length, NULL);
+
 	g_free(data);
+	g_free(data_old);
 
 	g_key_file_free(key_file);
 }
-- 
2.28.0

