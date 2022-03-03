Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C2FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 21:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiCCVMp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiCCVMo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 16:12:44 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013431FCF1
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 13:11:58 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 132so5766202pga.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Mar 2022 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GReboN0kbPnNthr1mFeuHLlhdmTsb9/atQ1C9EQW7M=;
        b=T3aOy8P4lUPw7zdBMR5+eUSp8kpClMQnIpy54LK//XywLb2yq5YpiT/LypLwFEbUr4
         8+4giN5n6NnWVdvc3iCKtH0NwEBSZAn2AvNlhUeTRusQCNZcqSoW+/dBrYXVnQnHtnP7
         HZ2wdv8xZbH3cyw7Sth2qaI0x72RIB+VW0E9KDp+dvWPJUSknUumED0EdU6dIc8Mj71f
         v8wuJ5+FiWULfgwwAn2EmSfWj1yQAT0jS+dknnw0uCzFtrwZ051wg+Vcqe7SJZ5jJ6i9
         vZLLLis4Ga9VEQdb7rYeh876zTccEYH+Bl8EwlAo33tVWD1BK96r0ptWI6s4sQt3HSgs
         /lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GReboN0kbPnNthr1mFeuHLlhdmTsb9/atQ1C9EQW7M=;
        b=qMe8ENeidKIF9FU8y9YGxnjlZ28qmzRQxJSel5prpJnadiTA4n6DKygRBopIZTVQ80
         zR2orn+EdDXeCIuYBZGXVHxvDDc62WOZDES/PUu8bCbmiTH5LKMHU8s+lPRQAYckeSBU
         dSOFqah3EcIc0PwQ+KWsoqKqkhNwW/iPRFPQpWkj5QyQ/K7X9Elm0L0fxADVxS9VJH4O
         dCyaYGwGEQm9XP/E4SMZvpR0viN1UEkiFP54tvgS0ewf6wUULgzgkHmk99uOQ3kNG8C1
         F2lw9J6GAzFZyv27QNQr+9I4p9kdY8BZTkFaXTNT/sCFjTD9qTB8jGI2qz81MdUnIMlj
         +Vgg==
X-Gm-Message-State: AOAM530orQqhLRD8A3Zs4mw4S5HlRrwVFR1YT0njj5tLO0/mQ5KX0aMU
        v2XzgM3tUVHSVUHcti36SUu4ljBOmmg=
X-Google-Smtp-Source: ABdhPJz+ogHS5r+OTFEucJ1+02LyaAaA8yEjY55Wamax5CP++mofrcLI/dDZZ/plTuh+ZEI21ZM19Q==
X-Received: by 2002:a63:d754:0:b0:374:35db:1a8f with SMTP id w20-20020a63d754000000b0037435db1a8fmr31093522pgi.489.1646341918184;
        Thu, 03 Mar 2022 13:11:58 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q8-20020a056a00088800b004bca31c8e56sm3582523pfj.115.2022.03.03.13.11.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 13:11:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix not checking for valid hdev on bt_dev_{info,warn,err,dbg}
Date:   Thu,  3 Mar 2022 13:11:57 -0800
Message-Id: <20220303211157.334337-1-luiz.dentz@gmail.com>
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
index a647e5fabdbd..2aa5e95808a5 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -204,19 +204,21 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 #endif
 
+#define bt_dev_name(hdev) ((hdev) ? (hdev)->name : "null")
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

