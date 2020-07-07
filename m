Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C6FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1922C206E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aK+Ihfct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGGOQe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGOQc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 10:16:32 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631ABC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 07:16:32 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j186so620034vsd.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcZ1dutZuBclgpEZqW6bnbWQfRovaM1ud/8ymGPFI7Y=;
        b=aK+IhfctraYMsnU/Nltw8ObMooaC22oTValrTKfAF4xzhO6KGTlIxyYASAUPE7t7LC
         DtVQknu8Hjx1BWvtJp5e5YaVKXFekKlRHF4fvanAlHVt7N1hQgiurpyKySG9+d4r9Ffr
         CiOM7RT23IiT5h5GJrood7neeAPMmVZD+NkzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcZ1dutZuBclgpEZqW6bnbWQfRovaM1ud/8ymGPFI7Y=;
        b=Wd7OhrHDuDHwmkZIrrr1VEt272sIR4YvNp+BhZApkkyPXcKj3fkJUAzGeX0hxujc0G
         vDFxYfsMXRsawp2rQkd+p/km74np+1l/32jWMTbCoBJ1LAUGxri1XJKhnWA3wmhtDrN1
         76HmE5YtIIkmhpw4xx/5tau6Y7UDkLDY6EztOuR2MrClRLpVnbMSln3HzYD23MB6d4Cy
         bHw/tDf7lxIIN1O1DhzTYww7Qzu+98nY7VFFHqPAqV4THe6i/mzECuiXzB+C+9x9kn0U
         TD6k9l3YTiVUqbVTsT3gEuYx4KcSpmxum9wm/X81IZxff88QUTqgq+EtbJKPDE0xmxtO
         vBxA==
X-Gm-Message-State: AOAM533XclUHftVv4YRaxb0BnUhVzRrI5/GPkLkdK7zaAfK/0wkBG2yg
        r9+sAqZi9bSiesrj4pvvefejonMULh0=
X-Google-Smtp-Source: ABdhPJyek+qEUiWchwWgIA89ng+r6gQDIX7p74cKG/Uf8F03okltt6BgEpM+zzPO6QZvfEeoN2UypA==
X-Received: by 2002:a67:8084:: with SMTP id b126mr14281534vsd.163.1594131391277;
        Tue, 07 Jul 2020 07:16:31 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id 140sm111811vkx.20.2020.07.07.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:16:30 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Subject: [PATCH v2] Bluetooth: create CONFIG_BT_DEBUG_FEATURE_FUNC_NAME
Date:   Tue,  7 Jul 2020 14:16:28 +0000
Message-Id: <20200707141628.368748-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Creates a CONFIG_BT_DEBUG_FEATURE_FUNC_NAME option to include function names in
debug statements.

Unlike other platforms __func__ isn't a string literal so it cannot be
automatically concatenated by the pre-processor.  As a result, the
function name is passed as a parameter to the tracing function.  Since
pr_debug is a function like macro, the normal expansion of BT_PREFIX_PARAM
does not work as it gets processed within the first parameter as well,
for this reason, BT_DBG is split into two versions.

This patch was built tested with all 4 possible combinations of
CONFIG_BT_DEBUG_FUNC_NAME and CONFIG_BT_FEATURE_DEBUG configurations.

Signed-off-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v2:
 - Making CONFIG_BT_DEBUG_FEATURE_FUNC_NAME dependent on
 CONFIG_BT_DEBUG_FEATURE

 include/net/bluetooth/bluetooth.h | 32 +++++++++++++++++++++++--------
 net/bluetooth/Kconfig             | 11 +++++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ee8041af803..8506dd268d4b 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -162,22 +162,37 @@ void bt_dbg_set(bool enable);
 bool bt_dbg_get(void);
 __printf(1, 2)
 void bt_dbg(const char *fmt, ...);
+#define BT_DBG_INT	bt_dbg
+#else
+#define BT_DBG_INT	pr_debug
 #endif
 __printf(1, 2)
 void bt_warn_ratelimited(const char *fmt, ...);
 __printf(1, 2)
 void bt_err_ratelimited(const char *fmt, ...);
 
-#define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
-#define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
-#define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
-
-#if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
-#define BT_DBG(fmt, ...)	bt_dbg(fmt "\n", ##__VA_ARGS__)
+#if IS_ENABLED(BT_FEATURE_DEBUG_FUNC_NAMES)
+#define BT_PREFIX "%s() "
+#define BT_PREFIX_PARAM ,__func__
+#define BT_DBG(fmt, ...)	\
+	BT_DBG_INT(BT_PREFIX fmt "\n", __func__, ##__VA_ARGS__)
 #else
-#define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
+#define BT_PREFIX
+#define BT_PREFIX_PARAM
+#define BT_DBG(fmt, ...)	\
+	BT_DBG_INT(fmt "\n", ##__VA_ARGS__)
 #endif
 
+#define BT_INFO(fmt, ...)	\
+	bt_info(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
+#define BT_WARN(fmt, ...)	\
+	bt_warn(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
+#define BT_ERR(fmt, ...)	\
+	bt_err(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
+
+#define BT_ERR_RATELIMITED(fmt, ...) \
+	bt_err_ratelimited(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
+
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_warn(hdev, fmt, ...)				\
@@ -188,7 +203,8 @@ void bt_err_ratelimited(const char *fmt, ...);
 	BT_DBG("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 
 #define bt_dev_warn_ratelimited(hdev, fmt, ...)			\
-	bt_warn_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	bt_warn_ratelimited("%s: " BT_PREFIX fmt, (hdev)->name	\
+			    BT_PREFIX_PARAM, ##__VA_ARGS__)
 #define bt_dev_err_ratelimited(hdev, fmt, ...)			\
 	bt_err_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 1d6d243cdde9..ccbf762053f1 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -142,4 +142,15 @@ config BT_FEATURE_DEBUG
 	  This provides an option to enable/disable debugging statements
 	  at runtime via the experimental features interface.
 
+config BT_FEATURE_DEBUG_FUNC_NAMES
+	bool "Include function names in debugging statements"
+	depends on BT_FEATURE_DEBUG
+	default n
+	help
+	  Provides an option to include function names in debugging
+	  statements.
+
+	  When enabled, trace statements will include the function name as a
+	  prefix which may help identify the source code references.
+
 source "drivers/bluetooth/Kconfig"
-- 
2.27.0.212.ge8ba1cc988-goog

