Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D81C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 20:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbiESUXC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244683AbiESUXB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 16:23:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1847FA2046
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:23:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m1so5734862plx.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=iRZDT+44Vk10DYjyMpUfbZrisL0WeLbZU0HIqTNIGw3vMoc/E9Q6LMqLYD4dGrf/9p
         wLSYPRG9OIMUGKzFXVHTjFLnVJ9b7IlDBkN/bv7jfdEJTLKzimDek6452v9v7t+V3biS
         NIyS+kkI1b7C6AD0nf4keSfwdXPxXisbigfxmp1A/GjJ/J51WCw9QJh5mZhWJ/LcYTST
         XUDtUYwe3lDVJwT7M4+aKpZhA91auKFCW2a76J12xrcRYZh+0WFCYCntCAwWuiUP8Rli
         2svCiSqWx3eVQC1kAhgUFXNEPnoPtVM1VA+psMSjEoQSRF2B7aFG6MI0Hw2UWKGo1gy8
         2FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=0i9tWFzRee8TQMvSgVJK3PYvnWhctcAuY1KsoquoSzm+tdvC9PDjWRnycK4vmyYigX
         kW+sZKD0nBGg/nDMPK3e7VqbPZttP2eZ3RULC52uH7r+4Ev7J3rkv4fPDGRbTldQ9Mpa
         QCXchl5h9NGYpE2LwcGhkHdvybZC1A68ibQtSVEyqZ6aabXDDezllcI5gBnrbPTSPD1O
         1apUePtHt6ADURUooWYALv4+hxkGGbX8wnVioYUkD/T7bSSXUI9tmonZ3XU4GhFIZCth
         KlPUsCz1hO8RH/3ULLOTIrZta7br9SnCt9x3r3+kR3hSf28IRTZ+h2325ICnMyKcrdhZ
         4FGw==
X-Gm-Message-State: AOAM530f5vHkDN6zVniNe3aJgCTR94iSsD0Qjk6EhaCnqy2gR4I1zmJ5
        2Uwfn8U/Iqq2A61ineggnuHKPLAcSyI=
X-Google-Smtp-Source: ABdhPJziBXRA9miUItpmA2o1G2f1w/IiqlFqHCeJyCPVaOFIh6BvMaVeoFG2tR3P1g9bdlwnbm8AVQ==
X-Received: by 2002:a17:903:d1:b0:15f:3277:fae with SMTP id x17-20020a17090300d100b0015f32770faemr6497110plc.69.1652991780253;
        Thu, 19 May 2022 13:23:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i6-20020a62c106000000b0050dc762816csm98003pfg.70.2022.05.19.13.22.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:22:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Add bt_status
Date:   Thu, 19 May 2022 13:22:57 -0700
Message-Id: <20220519202258.2459530-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220519202258.2459530-1-luiz.dentz@gmail.com>
References: <20220519202258.2459530-1-luiz.dentz@gmail.com>
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

