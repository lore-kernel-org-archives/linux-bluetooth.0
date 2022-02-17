Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82383C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 21:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiBQVLH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:11:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245572AbiBQVK7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 16:10:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB61EAD5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 13:10:40 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x4so5542948plb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 13:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66M16CBRPYrlao7BmByLPHnxUcjLypCxTCLl2w8IVS4=;
        b=n1fa0+u6w2SsdDImrsT5JKvRJjWhAyl6l7nNH7hl7bXeWF1IPYIPDd2LFtBqFqIRxB
         A9vAcwpdeTNiVb6Y+pAzZcwFEZwxk9Nfc03kDEPh5HTuuOvqMgr3nJL9ChwpA9EKwhCR
         Zmeb43/TFBxqUlF/f3nNA231ogX5fhCYQwQ0a+i0g1xJmkPBGqOuvWO4s8fJpKk7OoST
         QVjtlSG72FpYAjFWPsA/rEx18BghnCOhTXZC/XzGYvcxJDZcHtLG7r7IJa3DxaekjkzZ
         /+2mUF6+YJazgy+Vv1o/UP1TUxsOIg1tNL7vxxavyhBIdveAwhpP/srKLRIKUfydd+iz
         3NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66M16CBRPYrlao7BmByLPHnxUcjLypCxTCLl2w8IVS4=;
        b=uevfu5rpkq7OZV531yw94QI+cskHqqNaFGNpAFvfpWrQXbnCRdVMxRtPMXPWlFmZeg
         EZEP+VSXS1ZTQMFq6KpNT8+7meR3pXsyoosiaRi3O9MMwEAs1hqqC0HsiCbzlX7tDtXD
         n7TsVxEsjDkUPZg6aqluCPqVRMxsZEDlWl6veqUH8FxsgCjVzs9ypKPEAZS4Gl1gRB/c
         dI03wLbwm2Dfd0VIAjE5RRp2N5v2bwjM9Psdj+sWlUEgtn7owjgd84IED4pVDTrnFokb
         dKTP3QtB/6nZSWro+uEdqP30WKvFaZ6GxnoqHQZ57ku9BbKWAFJ9FQYbKEtBRA1hBzLS
         zmYw==
X-Gm-Message-State: AOAM531pMe9mYE7x0aaTAv/0MxkUjh8MiNKW97xiJgv0W7xfv42ethZ6
        yPFpcjoocB1ExRlz0cch7vY6dwYSam8jwA==
X-Google-Smtp-Source: ABdhPJyxvRck21LRzlWrJffXaHisJLjGXXQJaW6I+YIB8dVuKFBvlkRMZciu4MqtKxqjEQmeE39F1g==
X-Received: by 2002:a17:90b:23c1:b0:1b9:4d25:ead6 with SMTP id md1-20020a17090b23c100b001b94d25ead6mr4912430pjb.238.1645132239943;
        Thu, 17 Feb 2022 13:10:39 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p10sm473674pfo.209.2022.02.17.13.10.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 13:10:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix not using conn_timeout
Date:   Thu, 17 Feb 2022 13:10:38 -0800
Message-Id: <20220217211038.3064096-1-luiz.dentz@gmail.com>
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

