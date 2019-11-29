Return-Path: <SRS0=sIa/=ZV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBAFC432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 12:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0B32086A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 12:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R64HjNLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfK2MKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:10:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36417 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2MKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Nov 2019 07:10:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id k20so405045pls.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2019 04:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gO9llKC2KXPue9JeAEtEbIyNliFR5hHEKY5y9mKMpIc=;
        b=R64HjNLDijenQt2l1xkEtFxL7jFqYkkdlzX2uLbmTv4HZXWmDR9E8xJV/kSD1jvdHB
         Gm6TX9OiaHPwhZATnu7vyg5+WVw+fVCdU9AqJBTx34u4zdj7a3bINa5ujwTynC21k1J9
         MDoNKg3ZRwsTTX5QCGT4AwtCTrMTXkIG1vnWIMqLU9E419scWb+as1ACV3HRHRN0LRwV
         pCwH5jCKr4mgSaHwSxj6HJi0pcD5C3sM7XMZ7gcRyrCnLudHDnBQf5HMz8HmkHc9pozv
         wfRwUBDDgLoEQz+dYpbAnkzmfwVDiD9WQzkYcy4egZigzF0FcLs8JqFjCQDr2C7hsvkv
         2lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gO9llKC2KXPue9JeAEtEbIyNliFR5hHEKY5y9mKMpIc=;
        b=lgU9Fl6yJdRbwe6/wfcB+Xs30zkxgvVMtxL6itB0L3iSZGChbePL1rtCFBHm0QI7c/
         fPKX5XPnPFhrqExJMCs/pBwvP3Ia/RyRGp0UCcQo9ea17ny1trsi3GiQLRKiKTWgZJ3x
         Zgd4pVwN1+Uiq6XFFg0rBIsuHGov3TyAjahhIFugUCg7WYSY5+oX+zLJ53bohZyYVAll
         FTRwE7n+pjDXSUsQYCSrxj0g2uyZa1NgD5vu2giDQp2xalnsZu6vT/QYSxcz1EjdgXRw
         8mTWAnaX5bw0WvW+beENPN8M99c4wIZF6dhp5fIPVxjV2uES2cjOfcSDB4DXm89bNfUZ
         5Hfw==
X-Gm-Message-State: APjAAAU2utm4iuShXBqB83wWorXePOi5717tIsA1qimZnsfJWOLBu/eQ
        iovsmtB0oQA79Xju0inkvoF9kIROzZw=
X-Google-Smtp-Source: APXvYqyQkY0lB4lVhccT1hWaQ+WG9oy4av0658FhvUf9RFC3LsBUCbAk/LIEfw/etDmwvoKs+yxLhA==
X-Received: by 2002:a17:90a:2a44:: with SMTP id d4mr18201632pjg.91.1575029429349;
        Fri, 29 Nov 2019 04:10:29 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id g26sm12137556pfo.128.2019.11.29.04.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 04:10:28 -0800 (PST)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 1/2] bluetooth: add support to notify SCO air mode
Date:   Fri, 29 Nov 2019 17:40:41 +0530
Message-Id: <20191129121042.3311-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

notifying HCI_NOTIFY_CONN_ADD for SCO connection is generic in
case of msbc audio. To differnetiate SCO air mode audio introducing
HCI_NOTIFY_SCO_CVSD and HCI_NOTIFY_SCO_TRASP.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h      |  3 +++
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_conn.c         | 19 +++++++++++++++----
 net/bluetooth/hci_event.c        |  9 +++++++++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bc1e30dedde..bfaaef1aa4d6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -52,6 +52,9 @@
 #define HCI_NOTIFY_CONN_ADD		1
 #define HCI_NOTIFY_CONN_DEL		2
 #define HCI_NOTIFY_VOICE_SETTING	3
+#define HCI_NOTIFY_ENABLE_SCO_CVSD	4
+#define HCI_NOTIFY_ENABLE_SCO_TRANSP	5
+#define HCI_NOTIFY_DISABLE_SCO		6
 
 /* HCI bus types */
 #define HCI_VIRTUAL	0
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..9258e19f8cc5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1604,4 +1604,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+#define SCO_CODED_CVSD         0x02
+#define SCO_CODED_TRANSP       0x03
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 87691404d0c6..097a179418d6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -122,8 +122,13 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 	hci_conn_hash_del(hdev, conn);
 
-	if (hdev->notify)
-		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
+	if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_DISABLE_SCO);
+	} else {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
+	}
 
 	hci_conn_del_sysfs(conn);
 
@@ -561,8 +566,14 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	hci_dev_hold(hdev);
 
 	hci_conn_hash_add(hdev, conn);
-	if (hdev->notify)
-		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
+
+	/* As HCI_NOTIFY_ENABLE_SCO_CVSD & HCI_NOTIFY_ENABLE_SCO_TRANSP is
+	 * used to notify SCO connections during sync_conn_complete event
+	 */
+	if (conn->type != SCO_LINK && conn->type != ESCO_LINK) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
+	}
 
 	hci_conn_init_sysfs(conn);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c1d3a303d97f..ecad696db139 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4231,6 +4231,15 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		break;
 	}
 
+	BT_DBG("sco connected with air mode: %02x", ev->air_mode);
+	if (ev->air_mode == SCO_CODED_CVSD) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
+	} else if (ev->air_mode == SCO_CODED_TRANSP) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
+	}
+
 	hci_connect_cfm(conn, ev->status);
 	if (ev->status)
 		hci_conn_del(conn);
-- 
2.17.1

