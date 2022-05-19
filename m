Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 20:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbiESUXB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244553AbiESUXA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 16:23:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871E9419B
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:23:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so6203895pjq.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5KE7dwc120qeok1CZgQ5szINl5mYleYsk/m0GI/AVY=;
        b=SqOqcjCkbdqtsRjpAbUZjmpsaRD81ksU2rLh+A31lOwjWwjFSumDNMVrVa5O9rzjo3
         pZ/+4KwX/o95zVyWWctrc0+ppCTOffjoXP39jBW60BFv8pmezWMmElVMyeCkKEN0K/XZ
         ps+OOW9whxRNFObK9OovrAfm1waogTBZJPbnEEE4k3R7ofa9ZGI/5VedFaqkZTroRnJf
         B6j7f8L6IClN7AR4d7yN4iSv+AwgsVDPFAnZ5PuyCcDA6NIqkiVsLV5jpQ119gK9rK/0
         R5XA9z6D7f0wsDzI9BicSMYncJ3Qi5+ILoonWnAoYAm+m3f0T4CbaZYbh/0SSMSquLb9
         h3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5KE7dwc120qeok1CZgQ5szINl5mYleYsk/m0GI/AVY=;
        b=iAZ08DWJWSm+BBBs05H4xvVJga8vr/yFfZlVR27D/4E+RwjL73pFEGQcGguz+zZOw0
         UUjFUq4W8Xwa4VOVKyaZw71rGhxq425Xgde0dN/M65uXCWnlpY69pJ+CJkiCzVZjA6I6
         QTuIvupuxED2Cxz7H6fEVfWqsn/HkUfQq7JMscGDrwuRxTlOEBj5pdoX4Ci+nFGXAVdw
         2AnyIPk11k8ukH1JrCSrGpdfV8KTV2hu/4EuxQg9US1dUstjGJdzjWOX9UQ1qADmTzk+
         +8FfrDP7O2FNoUPZnB9gnlTKNuFKDUpKB/y05wVPPUWxaY6LvtTL6hkJwzhpCi5zIKSP
         ISPA==
X-Gm-Message-State: AOAM531fr9eOKERIWOsPXKt/hIdLyEZFN6JUhCFpBpM/cWXS3UhVdXPk
        h/qTYnRX93cjZ2qrbgNo5H1adDqM1qo=
X-Google-Smtp-Source: ABdhPJwkfvcYgOku0JGnvJAm0rf4GXpyACsJ0M3H6dl0XvOS4gn5oTtcf7jgdwKobUttKswB9gT+wg==
X-Received: by 2002:a17:90b:164a:b0:1dc:981d:f197 with SMTP id il10-20020a17090b164a00b001dc981df197mr7498591pjb.228.1652991779209;
        Thu, 19 May 2022 13:22:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i6-20020a62c106000000b0050dc762816csm98003pfg.70.2022.05.19.13.22.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:22:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: hci_conn: Fix hci_connect_le_sync
Date:   Thu, 19 May 2022 13:22:56 -0700
Message-Id: <20220519202258.2459530-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The handling of connection failures shall be handled by the request
completion callback as already done by hci_cs_le_create_conn, also make
sure to use hci_conn_failed instead of hci_le_conn_failed as the later
don't actually call hci_conn_del to cleanup.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 5 +++--
 net/bluetooth/hci_event.c | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 882a7df13005..ac06c9724c7f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -943,10 +943,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
 
-	if (!conn)
+	/* Check if connection is still pending */
+	if (conn != hci_lookup_le_connect(hdev))
 		goto done;
 
-	hci_le_conn_failed(conn, err);
+	hci_conn_failed(conn, err);
 
 done:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0270e597c285..af17dfb20e01 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		status = HCI_ERROR_INVALID_PARAMETERS;
 	}
 
-	if (status) {
-		hci_conn_failed(conn, status);
+	/* All connection failure handling is taken care of by the
+	 * hci_conn_failed function which is triggered by the HCI
+	 * request completion callbacks used for connecting.
+	 */
+	if (status)
 		goto unlock;
-	}
 
 	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
 		addr_type = BDADDR_LE_PUBLIC;
-- 
2.35.1

