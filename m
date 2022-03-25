Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiCYVOz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiCYVOx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 17:14:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C93E2E09B
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 14:13:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b8so8600573pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdXk1pyPsVBhnrHyt5mX9r0DgwLVIPD7/AuNwdpQKgg=;
        b=khwhl53D7t6PjllQXRrNbDUkfAINVjf84MzGsUFRnEbxnn/Fr9ItyRXfZUuiQnuxh9
         Je9Q3dSaeEKdpC6hOVOoEoMEYWt+BKMQETudpV//Q8GqjvMqRWwghYIe7v0Il2erdQFm
         AEShi0sqY1Oh2fne7Q8Y7mPI2+KfUj9QwSw1UIagt5tL9FUIPhiwuGiy703BXsZtNnqT
         zGoGMOA1Jz0rGSITm7h6t/Ec+q1ZZMl/JT1wIe7y4oY6TdIeQWRq0Sj50SGH36oAx4mi
         RCpPTOFu7xtFGHsMg8UJldRnvY4rORGvphNlxN1FDUofmXW7DzgaUXUeyUnFoveA1wpJ
         0nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdXk1pyPsVBhnrHyt5mX9r0DgwLVIPD7/AuNwdpQKgg=;
        b=c7CmoWXqmJtlmKdzQGR6sqFI4eBPGfM1UU5s9KgbGkU7gkJkDYJVSEvu0pCDKEyZGS
         v2GEVptklwiC97rDsRn8zf3DazjRgSQgf5ZhJcL63PJ92FcGn+y0heUq9GQTPZJVFDLc
         dNj/p/4eAlBmsRwvE7W+7dbgpQL5CfTQCDg/pgnE0fqxqYKwWWcMmCIGhPFnnmRCYa++
         2oL+SAaKKqBL40uuFQEsjrLImVpabmXYYkuco5/byJMkHIRcmgnc5L5k4g2NN6u4whw6
         M72UFlRiFmMBMRcrWISa2Fe0e1/M0GXeMun5NkwQ2iTRn+WBfJuqfKR+h1E6m5EGNdQD
         p+KA==
X-Gm-Message-State: AOAM531timUQ12OQJqJH6CgY6ad7nsqqL5lsap/WUuhAKUZDecW3j/Qn
        qNnc2BEhpqqEl3I9BHzI1oAls+ONJ4Y=
X-Google-Smtp-Source: ABdhPJy1vEGa1YpeSYIWHejteU7PZ+ua7MAjVsGUHVuV5+w+9dsy5tn4fe5ML5nSloqPFR5rAk5oEA==
X-Received: by 2002:a17:90a:8e85:b0:1bc:429b:513d with SMTP id f5-20020a17090a8e8500b001bc429b513dmr26963018pjo.11.1648242795560;
        Fri, 25 Mar 2022 14:13:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a588600b001c699d77503sm6582009pji.2.2022.03.25.14.13.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 14:13:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Date:   Fri, 25 Mar 2022 14:13:13 -0700
Message-Id: <20220325211314.425364-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk which can be
used to mark HCI_Enhanced_Setup_Synchronous_Connection as broken even
if its support command bit are set since some controller report it as
supported but the command don't work properly with some configurations
(e.g. BT_VOICE_TRANSPARENT/mSBC).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      | 9 +++++++++
 include/net/bluetooth/hci_core.h | 8 ++++++--
 net/bluetooth/hci_conn.c         | 2 +-
 net/bluetooth/sco.c              | 2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5cb095b09a94..8bb81ea4d286 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -265,6 +265,15 @@ enum {
 	 * runtime suspend, because event filtering takes place there.
 	 */
 	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
+
+	/*
+	 * When this quirk is set, disables the use of
+	 * HCI_OP_ENHANCED_SETUP_SYNC_CONN command to setup SCO connections.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d5377740e99c..59815df1272a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1492,8 +1492,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
 				   (hdev->commands[39] & 0x04))
 
-/* Use enhanced synchronous connection if command is supported */
-#define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
+/* Use enhanced synchronous connection if command is supported and its quirk
+ * has not been set.
+ */
+#define enhanced_sync_conn_capable(dev) \
+	(((dev)->commands[29] & 0x08) && \
+	 !test_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &(dev)->quirks))
 
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 84312c836549..cd51bf2a709b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -481,7 +481,7 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
-	if (enhanced_sco_capable(conn->hdev))
+	if (enhanced_sync_conn_capable(conn->hdev))
 		return hci_enhanced_setup_sync_conn(conn, handle);
 
 	return hci_setup_sync_conn(conn, handle);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..2a58c7d88433 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -885,7 +885,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			err = -EBADFD;
 			break;
 		}
-		if (enhanced_sco_capable(hdev) &&
+		if (enhanced_sync_conn_capable(hdev) &&
 		    voice.setting == BT_VOICE_TRANSPARENT)
 			sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
 		hci_dev_put(hdev);
-- 
2.35.1

