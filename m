Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C7C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3E92073B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 15:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwIAnfRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbgDBPZw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:25:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41922 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389241AbgDBPZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 11:25:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id d24so1455013pll.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2020 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qPYVyEVEKQp6IataHlhhjaavOzrXrgAm5jitVxivhYY=;
        b=bwIAnfRwOzjrR2LcYsn1znVWhWBJvEjbeZhrE8pRBP+Q4dHnhI4JNA81pZAXOyatQh
         hD2e4oOdxiEDkD/By5zFXTojQhtpVwBaq8889maDgD6e6CGYx95Bh1oQdYg8H6cQ7lnC
         /lCitZyIUQNJXmP/EJFjhWQJmy3tMQHPzKDzT9ayIrxcIELbOZBrSOCbiYkgkCu+Pv01
         gzooFZKxCl0Li0DWKemfTS8aUr06fGaki4QrjTJzlqyXTTBNV2cYnRLtNXlzTT1Y4PoE
         e1Ekx6h6O7zGmBdQZ2/+Zr0bc9Pm3weadJQFGkLq4vkHefxMrjy+kLCvoLhcqvEQE8Ri
         swCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qPYVyEVEKQp6IataHlhhjaavOzrXrgAm5jitVxivhYY=;
        b=i7TgMPIf+7hFQOnh1XvEQ3ilxR1L9d9Tt3ThfE+7+0Aaiw0W2byHTjA6TnJgDxh8Kt
         KqD1lX40mj46Ds1bkwXf/h9Ou85G0I9XwYgxtwqLGEHTTiqplSPK+x373ozQO6X44OeO
         1P2yvNl3mo/R7oc7jp9EkU2dL9VjXooge96jqiF3gkicyrABwrxLQiytefvxmOH+LP/W
         UoHV7Ti8IUInUkS6jisihdcve3Gk0qu4KuLcVakaGe7tRq3ySoyL5SXqYCQIhOHwAa+s
         ppM/grYnv3I2LWWn88E6+7O54LcNHifWOKvORjZWd6T1GrAQG2B9TooHdSKmSc0OWEC/
         7XiQ==
X-Gm-Message-State: AGi0PubN8z9tn6qm9zd5w5GZkWdeQfMMSxPAy3Tcs4KH2eHUiRCnT+7d
        vjgUrtNBuoJYeUcbaWSc6hneXhVigEW5AA==
X-Google-Smtp-Source: APiQypJ8/QWtfP6csMICcomAus/u2v7G5+afJ1qVL14p0fbIPeYB9KLZxllWuX3byg6ICZySOiiq/g==
X-Received: by 2002:a17:90a:b003:: with SMTP id x3mr4374287pjq.140.1585841148435;
        Thu, 02 Apr 2020 08:25:48 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id h95sm3911816pjb.46.2020.04.02.08.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:25:46 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narsimman <nsathish41@gmail.com>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v6 1/2] bluetooth: add support to notify using SCO air_mode
Date:   Thu,  2 Apr 2020 20:57:57 +0530
Message-Id: <20200402152758.10363-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narsimman <nsathish41@gmail.com>

notifying using HCI_NOTIFY_CONN_ADD for SCO connection is generic in
case of msbc audio. To differnetiate SCO air mode introducing
HCI_NOTIFY_ENABLE_SCO_CVSD and HCI_NOTIFY_ENABLE_SCO_TRANSP.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h      |  3 +++
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_conn.c         | 19 +++++++++++++++----
 net/bluetooth/hci_event.c        | 15 ++++++++++++++-
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f60e135aeb6..9ff2f7a9e131 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -53,6 +53,9 @@
 #define HCI_NOTIFY_CONN_ADD		1
 #define HCI_NOTIFY_CONN_DEL		2
 #define HCI_NOTIFY_VOICE_SETTING	3
+#define HCI_NOTIFY_ENABLE_SCO_CVSD	4
+#define HCI_NOTIFY_ENABLE_SCO_TRANSP	5
+#define HCI_NOTIFY_DISABLE_SCO		6
 
 /* HCI bus types */
 #define HCI_VIRTUAL	0
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e28773d378..1d1eb802f720 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1662,4 +1662,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+#define SCO_CODED_CVSD         0x02
+#define SCO_CODED_TRANSP       0x03
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e245bc155cc2..613b6b86f170 100644
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
 
@@ -577,8 +582,14 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
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
index 0a591be8b0ae..d6fd99029ca6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2607,8 +2607,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->status) {
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_del(conn);
-	} else if (ev->link_type != ACL_LINK)
+	} else if (ev->link_type == SCO_LINK) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
+
 		hci_connect_cfm(conn, ev->status);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -4307,6 +4311,15 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
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

