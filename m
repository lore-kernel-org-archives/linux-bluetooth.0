Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328DDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 01:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiENBu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 21:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiENBu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 21:50:27 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EEB3D6280
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:53:21 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i22so6806847ila.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=BMYBZERquXYiAkw6aMfA1dxT6mDjsRqF0rpmedTSOQeQkrIZlJREHvfwM8+b8Y9vfn
         139k8G0iBlgAGYI3XgV2UpON6txUVMX/yOu2YEdkjLrDHRD/mYDkgGtcaHV2S1VhokY4
         uRGIik7/3+PNOS1BCQCq93peQ0A3SubgL6YdYXeJK7QkNYCAIiy9AopwcaJCOCfAZx4S
         ADnIpaaDfK2svwBCEqwQAp5ejim30vAk6XDhnKRpGb6CgqI6XE+mAFuxm3zw3T5ojVBJ
         K4QQLIziRbe1FJUJOPoA/oXSX7Mp6EzTK5BAUMlYwYcsTUaowewzlAp8hPooz2sN/FTP
         g3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5E9/QWTff8XTUl3YMv8DsMWpigkqx7PC7kzC5bE9vX8=;
        b=UCTH0EpX7cPSE/UjeiPkKfE25gS22smI2D4DMVq8+5CgxGjwGsOj3Kh5k9IwpjYFTM
         M1sX8fnxlE/lo/EQk2TdPQtY+UP8k64xctxc6kBPyh8WPKna76k5Q3CKlQ+oX8CzW/5E
         X4sKA3u1FhikuRPV9KlhMgO2Vh9NwKQANhPIi2f8A1lR9da5bD+P3UGUMf48tboiVBAE
         /eE8FfM6LpuUvzf2yQ8Vs3+l076hv4r2Wf0+Sdpgw0AlY4lkcSKSC/1PttK/gYN11SzP
         ViAuoEdLIqdy76u1mL1fV7f/8BkcyI3PM8fjSg2ZG8gIVqpBAbC/7ggEbY8Mtr4mGfpb
         gfAA==
X-Gm-Message-State: AOAM532cD3biYpKQ1ge9wPEd0/RGmAPdwLUcLZrIU4sPkrMjL4WxKiGw
        v6lJ2DKvbWMVDTrUx3SDIP8PeqtavFo=
X-Google-Smtp-Source: ABdhPJwhBSDuwpfnuOn0HrsrPDqsvctHqYvCas4grtUfyBgMpYiORqE5voo283s34E3S5yz720PUuw==
X-Received: by 2002:a92:d708:0:b0:2d0:ecd5:894c with SMTP id m8-20020a92d708000000b002d0ecd5894cmr3559857iln.201.1652485886931;
        Fri, 13 May 2022 16:51:26 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e020d9000b002d0e8a52ab6sm937628ilj.27.2022.05.13.16.51.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:51:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Add bt_status
Date:   Fri, 13 May 2022 16:51:23 -0700
Message-Id: <20220513235125.1364692-1-luiz.dentz@gmail.com>
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

