Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7DFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 20:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiC2USd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiC2USc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 16:18:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA4122200
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:16:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s11so16857503pfu.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GpwDi9PZUVzO1ydcNv4650eH+9QV674kt6hS/SC3Xc=;
        b=Q0PbOCY7kEC9g4X3A8/jpgCLEQ22X0kj5NP6RrmvIpZuqsBy7XuL0T1hwJLkthQgt5
         W6CRJ9UQdfO2HSp8aUnplDdQkP+DsltqNl/Q7AhadFVlktjD41Hsi2yWQSei4XEiryzT
         lyOmjwCi1XGXxNM88UBhpBwNvtoexcoJNazKJ/GLk0Sim1dJOIn1xB33Wxo3le8JbJgW
         wU7hrOMsgYD5VP/aEPp/O6CqVTjDytzlpaVl9VtMTfBuY8H3Zrwri2Ly3kpsBOO/5A4l
         q3KAEwC+XOEXtxPUiiKkOrfbejYOsKhjEA9kvdKlIs0OXxoU99FIZYMBSwpmenOMZnVV
         xE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GpwDi9PZUVzO1ydcNv4650eH+9QV674kt6hS/SC3Xc=;
        b=ybKC2JC/CQnX2h0TqAIxMEFF0YtY/gKJ3I5k02YzWLLBLf3YP6exJ1N6eQYYLYanbV
         UinA/oExE9DItG1uRZKCigrbBF4/i5G6SDeJwmnBpLXzJk4NsJL79YRsLXE8hOKtmP01
         TR9BB+f6LcGtkfpxdJBW2PdBJuj4+2yyVjzpTkhMf2o5pn5AZBUao2Gny/G3N2AiuNDv
         2KBalYSC2mN9Qyb7diSAmhltET5lCU1NJX8pZfLZ7f+Y5ZAC5O7M2sX/MiHaUeu7Rqzc
         uCxaOf/BTCLGFp+BpWDBubltkTmFaSMa/JJ/ongxbo4Qd0+dzSy+v/Fs2Y2C0rQdG6Dt
         B/Hg==
X-Gm-Message-State: AOAM530tioTetilTXeIuuhPAEKhYtQ+eetKvc4+9xUiCymHPyUhPbSKr
        dkS8y9dAWFrksE/QW1/EgrFv4EHNJt4=
X-Google-Smtp-Source: ABdhPJyn8DO7UYtMSQaf90oeP322Lt7DLOUQfm5esEztCJZziCfIMLLJ06LszkN1Y08nymrCoDlBrA==
X-Received: by 2002:a65:6753:0:b0:385:fa8a:188f with SMTP id c19-20020a656753000000b00385fa8a188fmr3242346pgu.499.1648585007447;
        Tue, 29 Mar 2022 13:16:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm20816270pfh.83.2022.03.29.13.16.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:16:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Date:   Tue, 29 Mar 2022 13:16:44 -0700
Message-Id: <20220329201646.2296314-1-luiz.dentz@gmail.com>
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

