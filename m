Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0401AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 21:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbiBQVZJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:25:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbiBQVZI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 16:25:08 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BE80234
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 13:24:53 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q132so6082228pgq.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 13:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66M16CBRPYrlao7BmByLPHnxUcjLypCxTCLl2w8IVS4=;
        b=eTj8gy9SABYXFyLxQMvQukiaI4vKeyPJNbak3c5dJqhTl7AkOe2flM1jD1GjqiFfxB
         Vmv1/R4NKQDFb2FFn9o3pqaYe2zhaXWcoOUffihFSbcgOMShbe/368ppm65aaHVUaFck
         spjy5HuojZoeOfd01JonYLtJtNU/J1gUMjovZlmloeu7NUDd8hHVoxXE3n4LtxIEvuit
         WYuiBqoLL7qhARGmgVz+HmqnOGEJvUXGdnOOHj5aehvmomhBJpPxYrk4sDLqhojIxArI
         1JW3Bn7+oTtzuWI15qnE3vnHty3orbhKglvbdKc9T+H0Wga+8Eoi0xfuMIDwQvVy3SGK
         JLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66M16CBRPYrlao7BmByLPHnxUcjLypCxTCLl2w8IVS4=;
        b=q1qKv1uXtYC2AZPYI06IHGoUYofHB30iS3/2Mm9dP/KTmL8YkGYSXgJhkk15qeFian
         45Xw8DLL1uzaKZOCiXbyK5pBWinAN6CulgtN6mWfHHROFhVoGVyDnxglXx3yRxx+58oz
         Lco74Fa+gqMkwvGS/xohr9xpsiIkqh7xdq37JYZQ4NPkXdIVuB213TW8p7fwVHbpgfnp
         QzfWW8qzlUYj+WdpietVYryBpkC4FHBm3FIPRGFGz3jSwPfprnLMZE3X6c2AY9uLXqZ3
         +6dtGyzPb7XIRKQ97LeL7ICJ2KRjxPJpsSvS8ovU1FAOhTSMRNUoESKDMA18MZYFzppg
         x/Og==
X-Gm-Message-State: AOAM532E3TWRL1PfXDaAl9HD85DexydEEPSLffd8WRIVLfLUxV0yWiiC
        pw9nnO6f05A5hH+lseKAuWv7poAdBEVwQA==
X-Google-Smtp-Source: ABdhPJyfFqR/x2BqbSkb6gBO3sXN/KfgTwzXXm9PR63MNRS8YILzRUUmv6b0Pvn1YfBhKsImVo8X4g==
X-Received: by 2002:a63:a545:0:b0:34c:9ba5:6125 with SMTP id r5-20020a63a545000000b0034c9ba56125mr3833184pgu.392.1645133092961;
        Thu, 17 Feb 2022 13:24:52 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z25sm7290562pgu.39.2022.02.17.13.24.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 13:24:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix not using conn_timeout
Date:   Thu, 17 Feb 2022 13:24:52 -0800
Message-Id: <20220217212452.3067244-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using hci_le_create_conn_sync it shall wait for the conn_timeout
since the connection complete may take longer than just 2 seconds.

Also fix the masking of HCI_EV_LE_ENHANCED_CONN_COMPLETE and
HCI_EV_LE_CONN_COMPLETE so they are never both set so we can predict
which one the controller will use in case of HCI_OP_LE_CREATE_CONN.

Fixes: 6cd29ec6ae5e3 ("Bluetooth: hci_sync: Wait for proper events when connecting LE")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Add use_enhanced_conn_complete and include comments regarding when the use
of HCI_EV_LE_ENHANCED_CONN_COMPLETE.

 include/net/bluetooth/hci_core.h |  8 ++++++++
 net/bluetooth/hci_sync.c         | 21 +++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c454913794bf..a5ee8a00d52a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1505,6 +1505,14 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 1789:
+ *
+ * C24: Mandatory if the LE Controller supports Connection State and either
+ * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supported
+ */
+#define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
+					 ext_adv_capable(dev))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9dbf007e3dc7..b66a2271c433 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3265,10 +3265,10 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
 		events[0] |= 0x40;	/* LE Data Length Change */
 
-	/* If the controller supports LL Privacy feature, enable
-	 * the corresponding event.
+	/* If the controller supports LL Privacy feature or LE Extended Adv,
+	 * enable the corresponding event.
 	 */
-	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+	if (use_enhanced_conn_complete(hdev))
 		events[1] |= 0x02;	/* LE Enhanced Connection Complete */
 
 	/* If the controller supports Extended Scanner Filter
@@ -5188,7 +5188,7 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
 					plen, data,
 					HCI_EV_LE_ENHANCED_CONN_COMPLETE,
-					HCI_CMD_TIMEOUT, NULL);
+					conn->conn_timeout, NULL);
 }
 
 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -5273,9 +5273,18 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	cp.min_ce_len = cpu_to_le16(0x0000);
 	cp.max_ce_len = cpu_to_le16(0x0000);
 
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2261:
+	 *
+	 * If this event is unmasked and the HCI_LE_Connection_Complete event
+	 * is unmasked, only the HCI_LE_Enhanced_Connection_Complete event is
+	 * sent when a new connection has been created.
+	 */
 	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
-				       sizeof(cp), &cp, HCI_EV_LE_CONN_COMPLETE,
-				       HCI_CMD_TIMEOUT, NULL);
+				       sizeof(cp), &cp,
+				       use_enhanced_conn_complete(hdev) ?
+				       HCI_EV_LE_ENHANCED_CONN_COMPLETE :
+				       HCI_EV_LE_CONN_COMPLETE,
+				       conn->conn_timeout, NULL);
 
 done:
 	/* Re-enable advertising after the connection attempt is finished. */
-- 
2.35.1

