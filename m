Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C92C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 00:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiEEAKc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 20:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiEEAKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 20:10:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366ABE3A
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 17:06:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id c125so3193535iof.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=nioaqjqLdY/wp4Axj57RP1u4no4YkH7ktCK5JxBPAOl4FLeNaXUk+TVbVj6y6N7qtP
         3jfVco0a4P5gn73Bt/HM/BW0WrnH0ZNfAio2G0R/gB6zyPGpZsvWnv5G5Cb/dvjqynjY
         DuiN/86qZUxB2cqNsT+P9TxF5XKms9V25Ipv450YPEzYMLxRkNcZdXESzeWSciFcUzCs
         hXABrOLIhT9TKQXQ7mHB0WJ8uIdZSnTmAkpixuyPoGfeFb9xWNQXN+bvb/BwsLZv1WaW
         n6ZanavTHPfslDpsiODOP3jUfIuZtA4zbR8XEBaEnreXiChFXmzHvUcx2SDKhuvyCDQ+
         69lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=ulH3AqiCWvHfIJ4r3Uq+5XzGSQLOlDbnMOy7idNCa3a4z3WL97McgsnY0MrUlOR4ip
         Ye/fneBC7Qa74DsRl8zC7LjxC+ITAVPEs++tulmDfKNEQRUo++Y2W8xKRG7cmgO2nQR+
         xEtu/ePBVODfr5FzfuEWIM9NOmrYfMg1nvbw54G6xR/SVlh2Rs/NjbDgQ2YTh3Db8wzF
         whbjCwXnEXQqe123sEZSUfqugNZBLnbcnm6cgbNd9eJM0KCLojd/v7PWRrM+zLBhL0c9
         mb60RsELVLcMAKPPsLLDGOw1L2v1qXEA94+tCBJXEklywfvotaxcPerAuD5XSbt4CpB8
         UEqA==
X-Gm-Message-State: AOAM531yatv+cJtujtM6DOX6ahPty2pC3N334aTENnOF4W/anVR1bWtY
        fX5/3alzWyYLYvwv4siyJw7/gJKId58=
X-Google-Smtp-Source: ABdhPJw2iLavymU1fF8D4eUHIsuFqUS0x2//J8q4OM7f8aP+2WUw0GlxHkQDHUsDumWFtFWN8u2Ccw==
X-Received: by 2002:a05:6638:5b3:b0:323:a07d:6747 with SMTP id b19-20020a05663805b300b00323a07d6747mr9721111jar.252.1651709191154;
        Wed, 04 May 2022 17:06:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f5-20020a056e020b4500b002cde6e352d2sm57926ilu.28.2022.05.04.17.06.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 17:06:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add bt_status
Date:   Wed,  4 May 2022 17:06:27 -0700
Message-Id: <20220505000629.2903297-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_status which can be used to convert Unix errno to
Bluetooth status.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/lib.c               | 71 +++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 6b48d9e2aab9..cfe6159f26bc 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -521,6 +521,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 }
 
 int bt_to_errno(u16 code);
+__u8 bt_status(int err);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
 void hci_sock_clear_flag(struct sock *sk, int nr);
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 5326f41a58b7..469a0c95b6e8 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -135,6 +135,77 @@ int bt_to_errno(__u16 code)
 }
 EXPORT_SYMBOL(bt_to_errno);
 
+/* Unix errno to Bluetooth error codes mapping */
+__u8 bt_status(int err)
+{
+	/* Don't convert if already positive value */
+	if (err >= 0)
+		return err;
+
+	switch (err) {
+	case -EBADRQC:
+		return 0x01;
+
+	case -ENOTCONN:
+		return 0x02;
+
+	case -EIO:
+		return 0x03;
+
+	case -EHOSTDOWN:
+		return 0x04;
+
+	case -EACCES:
+		return 0x05;
+
+	case -EBADE:
+		return 0x06;
+
+	case -ENOMEM:
+		return 0x07;
+
+	case -ETIMEDOUT:
+		return 0x08;
+
+	case -EMLINK:
+		return 0x09;
+
+	case EALREADY:
+		return 0x0b;
+
+	case -EBUSY:
+		return 0x0c;
+
+	case -ECONNREFUSED:
+		return 0x0d;
+
+	case -EOPNOTSUPP:
+		return 0x11;
+
+	case -EINVAL:
+		return 0x12;
+
+	case -ECONNRESET:
+		return 0x13;
+
+	case -ECONNABORTED:
+		return 0x16;
+
+	case ELOOP:
+		return 0x17;
+
+	case -EPROTONOSUPPORT:
+		return 0x1a;
+
+	case -EPROTO:
+		return 0x19;
+
+	default:
+		return 0x1f;
+	}
+}
+EXPORT_SYMBOL(bt_status);
+
 void bt_info(const char *format, ...)
 {
 	struct va_format vaf;
-- 
2.35.1

