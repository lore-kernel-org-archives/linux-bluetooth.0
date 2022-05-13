Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6559BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 01:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiENBmM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 21:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiENBmJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 21:42:09 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5B36C353
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:46:23 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z12so6778540ilp.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=I0E+CHutkT2xy0OW1OZQy1kisFckLG44HV1YR7Ktc2CbB4b7FtTjUa9orvaB7FmfUw
         Cz1ElnYE1hBTLYcOynUO+qzn7QNifxStDG/thfHr9PEb9h5RSQFzFaMLvrTdK7lPG+Nl
         V0w4qme4lxwjDQLfcyQglSxzgRzHmy2VssIs46l61+t0Zpc+R6HGJlIIvcHOCTmZbAUs
         99ONHSD9LOLLw+MPUUJvs6QEwhGWbFaM840SwS5HMW6YDk22sq2DQ1orOBVJ443MgGtq
         3f5DWel+j5X39Vf8iNn6GnpADiYRyLYNJr8i2AdYGI53rq5n8gToQF4aWzOE1G0pP4ad
         zJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=nHsWdvibkXjJMguH9rrKeAWVwMSMACQP5soHtZRwOe4jt6/e/LPgp2gYyfc5XtveJD
         kbtAhBqAhgpva9rYeed9VJI2c/s+PlWKMkaB62/ZbJMdtlbHYzEIZRoJBqodqfg4Uq3D
         n7DY0JaX6/uSiaCUMy/aJMkoACRGg4wxx/dhz94LDn6ODSx2/g9XQgda/ewpsGglmVGm
         +snd1L3J85aBc7Ila7nXV82XStPvvln0BF/PHaxdduG2mQwD/yjPT2zwtlDaBvD2NCAm
         BLJBtBA1X7oAYpQbLMfsVFLfd1okMK8WL/Lc9ORA/RAcEKLeIA7KPDscIVs52NSGW/m2
         nQtw==
X-Gm-Message-State: AOAM530Y+gCeoL6/RqsbqZ+64JeunR6GhGDplcIthMTBF+KNdQ73Qp2E
        16vn98h1POptMsmSLEsIChhc3ogVL3I=
X-Google-Smtp-Source: ABdhPJwWmkUu3vUzOijN+BL3MDikgOt0IsOFuU6nHzrMbSFAMXFMwrpHSLml0clWB91KW5piZoYUow==
X-Received: by 2002:a92:7a03:0:b0:2d0:f018:ec30 with SMTP id v3-20020a927a03000000b002d0f018ec30mr3722760ilc.81.1652485574528;
        Fri, 13 May 2022 16:46:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k9-20020a02cb49000000b0032b3a78178fsm1045203jap.83.2022.05.13.16.46.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:46:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add bt_status
Date:   Fri, 13 May 2022 16:46:09 -0700
Message-Id: <20220513234611.1360704-1-luiz.dentz@gmail.com>
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

