Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC97CC32771
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 00:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C47E206F0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 00:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bK0FbfvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgAGAnb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:43:31 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46222 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgAGAnb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 19:43:31 -0500
Received: by mail-vk1-f196.google.com with SMTP id u6so12983910vkn.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 16:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BlBBdlGTuLlXDSlD9fRaOwY7xbSqzXQ+9DZfMQk/VE=;
        b=bK0FbfvPnuViNAOc9L966TjIfcadOxZIquOI0AhDIPyRawCwORXbislHd33sdNaLEQ
         kP8pRCH4TZp7OBO1taA+pdjiZSPHfWwv4tq6qmu5wl3WODX+clubBjmCyctsgLICOdk6
         99+EyJv43P+rvxrN7Ba70UiCJQ/BFBr6yy6+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BlBBdlGTuLlXDSlD9fRaOwY7xbSqzXQ+9DZfMQk/VE=;
        b=MGNaJ9wgRVAmHV4lP+c4G1JNY15WayUi7sSlS+ccdvJjR4c/i9irubow25PGux3Wt1
         sKDly/kRVgGa2yxf2Phos9+ZtbXa2bsv4oKiuSsC9mM4fXYD55y7buoa4ANfKVHARnaT
         faY6AcMiQMcZAd1/qoiYALZKkKDZyplYjRgRpCamsyCVZyEAU9G2JbnAVzMbwBQ42RUk
         qAyjTyW3fG9lEh8Xlz5lQwiCzGrkm+dTF5PL87j3UxSqGB5X5mRLA27i2D6ZGbFFCwHW
         wDy1R5J7vCIkmV+BKQ26DkeQFe95FLLlLvYW/oGn3ihUugNaSJdYj1RzhdqWpVPEx6mF
         X1NA==
X-Gm-Message-State: APjAAAWEYc2c9rEvIBudHK9eqBxnXKMaAgWAzeHkqVbKnVkh3oe3KxkI
        BZUwRYPAVA5dWK37IucNEC/fFAvyyok=
X-Google-Smtp-Source: APXvYqwHA6zh3nFXascuypV+5eG721XtDEaytcOrIFHzRlhHAToWzrUzbWtgTbPud+Eq5i9UvFu8+g==
X-Received: by 2002:a1f:3fcd:: with SMTP id m196mr61566983vka.28.1578357810037;
        Mon, 06 Jan 2020 16:43:30 -0800 (PST)
Received: from alain.c.googlers.com.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id k1sm6305244ual.2.2020.01.06.16.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 16:43:29 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH v5 1/2] Adding a bt_dev_warn_ratelimited macro.
Date:   Tue,  7 Jan 2020 00:43:16 +0000
Message-Id: <20200107004317.152792-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
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
2.24.1.735.g03f4e72817-goog

