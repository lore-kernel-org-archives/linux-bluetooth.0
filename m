Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C04DC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6580E222D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7O49/VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCJRA5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:00:57 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48906 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCJRA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 13:00:56 -0400
Received: by mail-pf1-f202.google.com with SMTP id c17so9470374pfo.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=utC88xO/3DQklGM/YS6f9zgx+KbjPZZi5VnmSXETSAc=;
        b=C7O49/VNKptjw/lBpQwmcIz0a8sArXeQ42cXcwYltCRPre0Vtqll5m97ztrXC62a7W
         QUZTB4QvdtN4Bqoiss33Thm/ckIzSGOux1JMfrkRwZr9APo6equSusZ7s6DSNDwT+4cg
         NRVEPHW9sv3KKsX6+VQjMw0yqUw5Ki51pUJg6NvKOcEvW0VFt+5TSfgi6+0FNZPB/bMN
         u9uGqCZ+kLYV4MUdExkun7mKU3qfokzowai0+M3L7hwDVps2X/TDyuTA/+pPy14PLzRY
         EPgAlrIaMlmCSVJNVsvBpU+jNp+H+/aF+RvaII931y/cYa3tr4y15JqSmybv8MMeWauH
         NE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=utC88xO/3DQklGM/YS6f9zgx+KbjPZZi5VnmSXETSAc=;
        b=krCGMkbKDBysm5D/oSgC4pBG9UUOQnbPJI3gJsfopgmjT8apXsGF4la0milV/CPe4h
         aD/DS62trob5/9G8KYyfVQwq9iMn+xQoN0R8inMcdJBSoIuAlBqlqgbnwk5QnCdov3vo
         asMy3K0dCku+GQO+lY7+S5dlFC07G1Ws7y1ur1rM6ZPSFFcCg5DWFEWDRt7nKpAJCCfU
         9zzwloKSJLlfz6poTRzvDxJ4YiijWnH4c9GM282ztNjL9taX8zbG+wH1fpyYJQl0NtgG
         1eZpj8lmBD+EYqUjwQZgVPAWPCOP952YUmghh7WpMsccc5mJ/K6vqNP5TmV7esYy7EwC
         d0Zg==
X-Gm-Message-State: ANhLgQ2voZMKYu+rVBZxazmgUDUApNBuwRiCnwuYXLXTiMvyYiCVtgXY
        KpSuG9gl4VfrJYEBda9L8y+Q1HZqQFUy1w==
X-Google-Smtp-Source: ADFU+vvxgNuaV6N0CUwbmim8in/d79uD6t3S+h+G7BS5M8JDfoSZw2XoErdStzAGhIWo2dEYhjudJLxlOBjruQ==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr2667641pjp.108.1583859655698;
 Tue, 10 Mar 2020 10:00:55 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:00:38 -0700
Message-Id: <20200310095959.1.I864ded253b57454e732ab5acb1cae5b22c67cfae@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] Bluetooth: include file and function names in logs
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org
Cc:     Joseph Hwang <josephsih@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

Include file and function names in bluetooth kernel logs to
help debugging.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 include/net/bluetooth/bluetooth.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1576353a27732..2024d9c53d687 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -150,10 +150,21 @@ void bt_warn_ratelimited(const char *fmt, ...);
 __printf(1, 2)
 void bt_err_ratelimited(const char *fmt, ...);
 
-#define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
-#define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
-#define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
-#define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
+static inline const char *basename(const char *path)
+{
+	const char *str = strrchr(path, '/');
+
+	return str ? (str + 1) : path;
+}
+
+#define BT_INFO(fmt, ...)	bt_info("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
+#define BT_WARN(fmt, ...)	bt_warn("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
+#define BT_ERR(fmt, ...)	bt_err("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
+#define BT_DBG(fmt, ...)	pr_debug("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
 
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
-- 
2.25.1.481.gfbce0eb801-goog

