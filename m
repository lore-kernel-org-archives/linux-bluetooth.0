Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EC360698
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349178AbhICKy0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:54:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:42875 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348334AbhICKyY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 06:54:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="304953083"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="304953083"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692090481"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 03:53:22 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com
Subject: [PATCH v14 12/12] Bluetooth: Allow usb to auto-suspend when SCO use non-HCI transport
Date:   Fri,  3 Sep 2021 16:28:13 +0530
Message-Id: <20210903105813.2440-12-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210903105813.2440-1-kiran.k@intel.com>
References: <20210903105813.2440-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

Currently usb tranport is not allowed to suspend when SCO over
HCI tranport is active.

This patch shall enable the usb tranport to suspend when SCO
link use non-HCI transport.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---

Notes:
    * changes in v14:
     - Address review comments
    
    * changes in v13:
     - suspend usb in HFP offload use case

 net/bluetooth/hci_event.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b48e24629fa4..fdf51f89754a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4444,6 +4444,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 {
 	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	unsigned int notify_evt;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -4518,15 +4519,21 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 
 	switch (ev->air_mode) {
 	case 0x02:
-		if (hdev->notify)
-			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
+		notify_evt = HCI_NOTIFY_ENABLE_SCO_CVSD;
 		break;
 	case 0x03:
-		if (hdev->notify)
-			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
+		notify_evt = HCI_NOTIFY_ENABLE_SCO_TRANSP;
 		break;
 	}
 
+	/* Notify only in case of SCO over HCI transport data path which
+	 * is zero and non-zero value shall be non-HCI transport data path
+	 */
+	if (conn->codec.data_path == 0) {
+		if (hdev->notify)
+			hdev->notify(hdev, notify_evt);
+	}
+
 	hci_connect_cfm(conn, ev->status);
 	if (ev->status)
 		hci_conn_del(conn);
-- 
2.17.1

