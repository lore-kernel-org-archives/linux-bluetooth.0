Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C10BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 00:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3216B206E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 00:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwfVu7Z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGAjo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGGAjo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 20:39:44 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AD7C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 17:39:43 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a17so10713996vsq.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 17:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTKT+OgdQXytrQx567fvW+SoDkWq0qLBy6EFdrqiakI=;
        b=IwfVu7Z50Ix/dHptaW/scdYp/lsAs0w3+g+z7kjzQEcB9jG6S44YmIj8pnsC23X1xL
         fyDpWbsyw75QbEQyEQnJw0DF0WmYZa8kSbM/+hrEva4pMcLj/g5qapUN6Ut+WtCNly+7
         k2n2FmLsieBt/4bc0TT8fKNHOVCf0hiRGImeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTKT+OgdQXytrQx567fvW+SoDkWq0qLBy6EFdrqiakI=;
        b=rWSHrgXkIPgpI32WOOufYoPT+fxgli28uU70Rb01bX2pn0YLFiXjNJt6RxRwzw0eUw
         sZMDMet+lvSlYAaLhB4eI5BJc/VlFG6+e6y/WvjU1I17+Qx3SoLrAeoVzYcdK1mI9a71
         yiifRG65qnDSb1UhtRVKKKr7cylKhXyLs2YvQDpGdpR2oEyS7RJPC7I1S6Bv8zjzhlPu
         hOZSSOBdjQOHB47W2MkrwkKUn5jqNpFo+GWuayhFYfXesSsMHXgWMKn0dKm2+4u4DIeM
         +1HqGilUh7X34fsD5PS2d7VyFoCe59KhUbcoPeZiyX+HvriXmMXGR2QdSA73OKtD77Jq
         L/Pg==
X-Gm-Message-State: AOAM530N6eSXsClelcEX/karS8jEhAEpiJS8TeMg0NcGiZuTClN6XGbx
        y3pKmfDe6b2tH/KKR4qNHzvvnMXgmnI=
X-Google-Smtp-Source: ABdhPJw4Hr3Vj/GeTsZgwGGCmJQ9+pU3SOhLqoMVcoQlutObFYVOA4/9bjm10lo0OK4wMxfoYY9EDA==
X-Received: by 2002:a05:6102:3002:: with SMTP id s2mr21458975vsa.2.1594082382203;
        Mon, 06 Jul 2020 17:39:42 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id c62sm323315vkg.30.2020.07.06.17.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 17:39:41 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v1] Bluetooth: create CONFIG_BT_DEBUG_FUNC_NAME
Date:   Tue,  7 Jul 2020 00:39:37 +0000
Message-Id: <20200707003937.187125-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Creates a CONFIG_BT_DEBUG_FUNC_NAME option to include function names in
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
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 include/net/bluetooth/bluetooth.h | 32 +++++++++++++++++++++++--------
 net/bluetooth/Kconfig             | 11 +++++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ee8041af803..27ec8f2a7c28 100644
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
+#if IS_ENABLED(CONFIG_BT_DEBUG_FUNC_NAMES)
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
index 1d6d243cdde9..de31c682c7b0 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -142,4 +142,15 @@ config BT_FEATURE_DEBUG
 	  This provides an option to enable/disable debugging statements
 	  at runtime via the experimental features interface.
 
+config BT_DEBUG_FUNC_NAMES
+	bool "Include function names in debugging statements"
+	depends on BT
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

