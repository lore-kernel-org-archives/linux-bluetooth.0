Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A142DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 23:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353439AbiDAXkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353427AbiDAXkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 19:40:20 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C602739
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:38:29 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d3so3019872ilr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Gp6F9qkkhPrndSWliPIV0M7p0aUKRwWzBTpGmpEAxc=;
        b=KbXd10LnWEwnrAW2bcQU+pB9XukOXlhNUPnuwHF1BjFr2kJvm6xD8Rs7l2m4hjcVDW
         5M4qJJKu4rTf5oLnmiLBG9c28Zva7mMP0UyyceiTPSPze8X9N79MhazW3QbEhcFqujtx
         DZ47x4aMzIYo4mxMLrTwksDUgNsT8gvG2GZTC2659N74UmdupGK35s7xF/ey4JZZGI2G
         mxaIu7SeW5AaaZ7i3Zl93ypZP2pEG75ASyRcB4UcK4IOvlN+otAHu8kxegdM0HZAWBDH
         CfZZ/u/7+ZG/Zl9cyeSoyFOKFwnQ6i8uNGcK6EQOGpuTYMUq6s090YNJXTimXZumTw+a
         J6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Gp6F9qkkhPrndSWliPIV0M7p0aUKRwWzBTpGmpEAxc=;
        b=uTbb6NS38xFWt9wz3sbGXMtpmtaKxGlnuBrhEK9ZZwqPjtZ+jGOsGv/I8lVRuK58gr
         PRINPKMqo/4mlN5ROqCltcW+woCzdU8KEWewUuhMWsOSeLyfITFxOKrkgoaKzPZAn0RD
         9kkYZXF2RTnImNtCBV2Vex1iGZl1BvEb4wxXYchcZ8rbowgWox666V2zZys1iB6iwLaW
         nHa6GtaB6nn3HTJ3P/O0LcLEbuQ+M9vgJLsd83m24lZa4wKq1SDBr+t1Nc0oWf5Ws1oj
         Drrpd3UBWzkvf7mdFvhDDsHqSkaUUZ+AdtJ38H+1TrF+TnvyJaYsvjLOfJ6BO6vQJYXC
         nH0g==
X-Gm-Message-State: AOAM530iYL2CI6kZYTA54sp+4gs0V8yLbD6Nl/E5Wa6cg+2fYU+0MoCP
        u0AjsLiH2tj/rl3qAewT7lBSmDngsYk=
X-Google-Smtp-Source: ABdhPJwpYBGD0C6mwcU4Y34BJ4rO9CNhorBSLShjWQmP9JiRSmr2f+Xkasbm8My597a8Qji12Awg+A==
X-Received: by 2002:a05:6e02:19c9:b0:2ca:57a:9f62 with SMTP id r9-20020a056e0219c900b002ca057a9f62mr934071ill.63.1648856308522;
        Fri, 01 Apr 2022 16:38:28 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8553000000b00649f02b1b0csm2217062ios.39.2022.04.01.16.38.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:38:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Date:   Fri,  1 Apr 2022 16:38:23 -0700
Message-Id: <20220401233826.122544-1-luiz.dentz@gmail.com>
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
v4: Address latest comments, add patch 4/4 spliting hci_dev_open_sync so each
stage can be handled by its own function.
v3: Make HCI_QUIRK_BROKEN macro expand quirk name and address other comments
from v2.
v2: Change hci_broken/hci_quirk_broken and HCI_BROKEN/HCI_QUIRK_BROKEN and add
patch 3/3 setting HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA
controllers.

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

