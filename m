Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D9C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiFUTKe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiFUTKe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:10:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B620F43
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:10:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l6so5195037plg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ai4G4UB57+HKsGwyeNmVm3s1TC46XAAomFY8+BT6rnU=;
        b=RhHTs/GE+6Ha97196UnE4XlXxQkQbAVw/i+zaLYG36xlxSYxIEwh9oPd4CU6CjmEMq
         zdlWCFxbtOl9DE3ir+gPOpFcbovltkDF/uXu/pkZGE9JNwstc0TqhF4Z6cGYMWxSbb4+
         FxS54C17BL6CHUTF/bqMyh+VbsNNWCrNDBMQwSrQYnLyVbvoCv7OWSxm5uJISg7B9JMU
         akyECoWUJnZbvRB5lT/+ojpTDLMdpVLXUzZa+TQEp9PV+ebRnrcaVHSxZRWxvzCQNNx1
         kajtYTjoTZU4LU3fopxsJAVwfrV2OPk4tbKcRKOgktAn/m/mvDzrnZPrmpevaw7hNnU3
         QqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ai4G4UB57+HKsGwyeNmVm3s1TC46XAAomFY8+BT6rnU=;
        b=2oc+StaiyoeIDFp5xPzVe9NkzUXFv3+BQcJL9fQB2PJvQVMJISxDfHv/9Lz0ivFqbR
         raLdvbxklJ7p0BdaEffHi/tGagkSMDs9PoFYF8fPt85rAAnRqgEAxm5aq77+pYPzsOH5
         FwybqbZz8hQsmQYMLbZf+UYRJZhEEjQygoMF7mAaV1jgZxHtUAaUocpVfCeEhpNqrmYc
         HfHmSqbPXgp9h3e6gxmlrlJ/2LiJURw+a/X9fWJB181PtOwetWwxkOgH9a5dNPPdm0Yd
         0qpP5MMC/q1SKD7EtHvziHjclyBbCtSJwvF1AzRE8Oigso9smUMKWI5et6Xj+z57jCwu
         dyow==
X-Gm-Message-State: AJIora/ZMSDJWLo+4lzxaqHO2pEBugyjmh8jXE7OdqVxGJrsjLfdCFBF
        fxwPjWRV+YdceLgX88bLWVfP/Z5SKhLvAQ==
X-Google-Smtp-Source: AGRyM1td+DUOk2qMz84lMsfMl1V5nbeoh/yzf3No/UQTl+4P2BGi3w+pmae/f7CW/qfw1TZ5KsVR8w==
X-Received: by 2002:a17:903:230a:b0:16a:4372:359 with SMTP id d10-20020a170903230a00b0016a43720359mr1268630plh.46.1655838632519;
        Tue, 21 Jun 2022 12:10:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y188-20020a62cec5000000b00525286c7847sm4183546pfg.216.2022.06.21.12.10.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:10:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND 1/2] Bluetooth: Add bt_status
Date:   Tue, 21 Jun 2022 12:10:30 -0700
Message-Id: <20220621191031.2160381-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
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
2.35.3

