Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F8C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22292073B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxRau3YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLKBzL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:55:11 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36803 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLKBzL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 20:55:11 -0500
Received: by mail-vs1-f66.google.com with SMTP id m5so14662722vsj.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2019 17:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUUAOp2xQU5ivYj1+FhbPk/qPij8WnC3TQIPxtYGybw=;
        b=WxRau3YNY82OUBG/tdIM2+vCDJQuFrw2pz+hy6RqVz0natFxAyxucu6bjQ05qiLxLR
         zxZRB+Zg+ImufgZKlBCfZb2eIq7chBCPVWglIu/TXckn6FcE+oIDX7vnJCNF1RDN0Nif
         CuiscsV8OH12xDzQ20qGpW1s/W72RpcBTNUFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUUAOp2xQU5ivYj1+FhbPk/qPij8WnC3TQIPxtYGybw=;
        b=NUTRxUkB0ky1RJALwgEYIqzFEibwjHOMHIIYU1xvjequkXaYnCZ0rSnTr24Hlew1u+
         CsdHEelXxi0Qi+WgtCjgfoypCmAQocS+8EAYdpTswt2V63l6MnCwonowjt+QZL3mZKlO
         C4qGK/pNyOP3ISm5sdyttGpJQrWwiGobAnkXtT1jYVt6yZUQdSDens188XV8rQFOD1vm
         OTyunyXKJ8H0uImalOZIMy/REM9qYrFL1PiZFAnI35rKMbP0rRYra8ChNR6M6ePXUBb+
         FtP5xG5rhuGgyZdtxd6x5xwFjyLzsjoaWYHPiqLpRx+akACL4SGS1W7/djrNzlOX23ox
         6SfQ==
X-Gm-Message-State: APjAAAV0cqwnuZ18a0AlzAvzpXUNbcnxz+0OYiLQkF6R7jzxpMgYcVqL
        uELucWtRHbkMjF6RI2wKUf0x1LfsPAs=
X-Google-Smtp-Source: APXvYqx+lujTRjVqP2x3oGgsi/p1iSPhXzI769PEVWBE3i4MZl5AUCJO9Q16bHizZoRS/XE1zlbRxg==
X-Received: by 2002:a67:f8d9:: with SMTP id c25mr568300vsp.203.1576029309538;
        Tue, 10 Dec 2019 17:55:09 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id k45sm380511uae.9.2019.12.10.17.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 17:55:09 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 1/2] Adding a bt_dev_warn_ratelimited macro.
Date:   Wed, 11 Dec 2019 01:54:43 +0000
Message-Id: <20191211015444.143341-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The macro will be used to display rate limited warning messages in the
log.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/bluetooth.h |  4 ++++
 net/bluetooth/lib.c               | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fabee6db0abb..bd2675266859 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -129,6 +129,8 @@ void bt_warn(const char *fmt, ...);
 __printf(1, 2)
 void bt_err(const char *fmt, ...);
 __printf(1, 2)
+void bt_warn_ratelimited(const char *fmt, ...);
+__printf(1, 2)
 void bt_err_ratelimited(const char *fmt, ...);
 
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
@@ -147,6 +149,8 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define bt_dev_dbg(hdev, fmt, ...)				\
 	BT_DBG("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 
+#define bt_dev_warn_ratelimited(hdev, fmt, ...)			\
+	bt_warn_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_err_ratelimited(hdev, fmt, ...)			\
 	BT_ERR_RATELIMITED("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 63e65d9b4b24..755bc7c12e2d 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -167,6 +167,22 @@ void bt_warn(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_warn);
 
+void bt_warn_ratelimited(const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	pr_warn_ratelimited("%pV", &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(bt_warn_ratelimited);
+
 void bt_err(const char *format, ...)
 {
 	struct va_format vaf;
-- 
2.24.0.525.g8f36a354ae-goog

