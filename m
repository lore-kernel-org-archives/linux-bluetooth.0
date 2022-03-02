Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42768C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiCCAIW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiCCAIW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 19:08:22 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB586FA32
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 16:07:37 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u16so3312593pfg.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVA4k4dXNYbQ6zZb1JQo4288As5qtJVLtt6xD6t1o7E=;
        b=L/HcEuVPlJwv6Yb5s4gmSZF2U7n0bBgyOFoMQTwWxDsKLiX23P5UesXQlaabhhJOEM
         gSyPPsLb4cl4eZJAZbCyTwd7d7Lsi6rSdW3qMKd2XtmDcffPh46lHMq8u6xYpRURYdSC
         17xuZ8asqMCQBkhU3XKQsyWNvY26GOyYJcb8MFOqms/KFfYJYc2OH4y+3luEm6IxzmQw
         ngx8M8yJz1R2IrqvkwrdB6bQ5W1W1v0wNtADEyx2sPlsFQVBPX4hs0OOgKJ1HvPkseTd
         gdYhwUDeKyVo/98++GoyP93m29oBo0aZ52MczGmHfJvB6TXNhdcs9rKU5dmfXf6mf6tC
         0JGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVA4k4dXNYbQ6zZb1JQo4288As5qtJVLtt6xD6t1o7E=;
        b=tknKpb/uKd3pXJASjIbkKDV68E9EIYXBVZH57Z3S4vUzwHaqB1qdpWPZ0Dq7PlYf0k
         jEkW2Th0DFFyRVCDqVoM3/le7zlYv0MYdRwSwc7dMe8C77zxAcFE6Bu0OFzYBMiBfZf1
         /pAmlxxiINYML7BNiwq1vkkoF4HhxjdTCKT0b5n5hBBJHti4Cu5l51YlkdiX/J8j41vk
         ZR/Q7Xb9U4EIhzXpalzgbuBlkeRze8FJnKpEbp0PmoekOdnE2s+LuginfYf9jI1Gwucc
         574qaTectQGyLaiWoDeHuUOLC7J5hxLhHd7QBqBvl0qfBSLClYlPcroI9+JiKqfh2gvl
         4Zig==
X-Gm-Message-State: AOAM530zmzK50h1L6ra3NHekAguZ2Hidgr1mWrjIODtr9xS32osAwJv+
        IeGnHeteaFnceL9NVUbPeCY9H3szGU8=
X-Google-Smtp-Source: ABdhPJwji09vYfCzcc+BBpJkuJyXKUMsfYP3xamefM6nMludlvXyem83cyve7E/islV3vAK1ZNfY/w==
X-Received: by 2002:a92:c5c1:0:b0:2c2:8aeb:6570 with SMTP id s1-20020a92c5c1000000b002c28aeb6570mr28653482ilt.162.1646262540470;
        Wed, 02 Mar 2022 15:09:00 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d15-20020a056e02214f00b002bc80da7cc6sm270745ilv.72.2022.03.02.15.08.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:08:59 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix not checking for valid hdev on bt_dev_{info,warn,err,dbg}
Date:   Wed,  2 Mar 2022 15:08:58 -0800
Message-Id: <20220302230858.444141-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes attemting to print hdev->name directly which causes them to
print an error:

kernel: read_version:367: (efault): sock 000000006a3008f2

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index a647e5fabdbd..d82736e58d45 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -204,19 +204,21 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 #endif
 
+#define bt_dev_name(hdev) (hdev ? (hdev)->name : NULL)
+
 #define bt_dev_info(hdev, fmt, ...)				\
-	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	BT_INFO("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 #define bt_dev_warn(hdev, fmt, ...)				\
-	BT_WARN("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	BT_WARN("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 #define bt_dev_err(hdev, fmt, ...)				\
-	BT_ERR("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 #define bt_dev_dbg(hdev, fmt, ...)				\
-	BT_DBG("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 
 #define bt_dev_warn_ratelimited(hdev, fmt, ...)			\
-	bt_warn_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	bt_warn_ratelimited("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 #define bt_dev_err_ratelimited(hdev, fmt, ...)			\
-	bt_err_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+	bt_err_ratelimited("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
 
 /* Connection and socket states */
 enum {
-- 
2.35.1

