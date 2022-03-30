Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350458AbiC3S3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351721AbiC3S3F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 14:29:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8484CD47
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:25:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso904239pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QATwaa6LxoPJw3PVOavNtamV3SVuZldI7jwI6FCNxHA=;
        b=g7a2uHMqQjJSKAEz7Oqk6/hOMd48bScaTejk64Pi5y8oXsrnUkdwC9dSzS1FIJVJLQ
         TgsraNEpYgJXuTCP8xdY1SihgtW/ZRnAZcmBjJ1UTeAiT5eOOzk2bs9VOyOoCJEspgeg
         HL6Gmsg5tGq7CyE6fWfyWQjZwGfl09S2S4+3aN8boQwix1BIai/eXL4CYqDw4N9Xx+Ax
         p111TiY8u0FO7ZLDOcgUVF3YfSa45nYjTX3ZA2OuvtjsGM5zK5jhuYXkALXDOJcpnPRw
         HEKrGyD6UcLEl6M2/JNMrEKKcqDX+4L1SyXhiXSF+TqRE9mIJan2ERZ+M07POUCqUEUU
         4vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QATwaa6LxoPJw3PVOavNtamV3SVuZldI7jwI6FCNxHA=;
        b=D5wCczv0JV/hCENkov8pDvP6hB2CYcFNcZQTbCu2EGAUZE35OOPqWxRbN4li4Nich8
         SD4bQLIajQuEF3LEDWFUKU7cGWJljYvn2z1UTgI67E8SxBwbP7skTxkoAHRwwIzW7X6r
         dSfJKYy3sienQwaZYAeKGsx440yT9tEIPJhMSNnbwZZY1LzhTvkRubqB85EdzhxbYIDV
         TxJleKV8Lrt4bTEtnb5XKdqP57GRMGwzVsW6FkOcUXVDyd62v364dc56OT6/mwq0AsIL
         rC61ZifhZLLK41tKLb/gd/1/4S/RDfJWnPpYe+CQdbSM/WVZCAhErn6fPjododFYe0s6
         5Eww==
X-Gm-Message-State: AOAM531/wa83bvd51udubPKOcuNha54yiifguiyDN/y9kZCT3czWekYw
        BVYbY3KGd45NrQr+5deMoGDf35qTiqE=
X-Google-Smtp-Source: ABdhPJxBLFkeg48UDZLvk/6gRWsDLT72N6KRGSGvYLRlMw0IXzt4SkkMC4HRLOyN9te8vrzKlLLSVg==
X-Received: by 2002:a17:90b:3886:b0:1c7:c935:4447 with SMTP id mu6-20020a17090b388600b001c7c9354447mr966427pjb.196.1648664753101;
        Wed, 30 Mar 2022 11:25:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm26758551pfl.148.2022.03.30.11.25.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:25:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Date:   Wed, 30 Mar 2022 11:25:50 -0700
Message-Id: <20220330182552.2613523-1-luiz.dentz@gmail.com>
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

