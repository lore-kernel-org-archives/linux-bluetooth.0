Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E791C4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68B460FED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbhHaLwc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:52:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:36804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241608AbhHaLwa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 07:52:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205674738"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205674738"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 04:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="498264553"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2021 04:51:33 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend when SCO use non-HCI transport
Date:   Tue, 31 Aug 2021 17:26:37 +0530
Message-Id: <20210831115637.6713-12-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210831115637.6713-1-kiran.k@intel.com>
References: <20210831115637.6713-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

Currently usb tranport is not allowed to suspend when SCO over
HCI tranport is active.

This patch shall enable the usb tranport to suspend when SCO
link use non-HCI transport

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---

Notes:
    changes in v13:
    - suspend usb in HFP offload use case

 drivers/bluetooth/btintel.c       |  2 +-
 include/net/bluetooth/bluetooth.h |  4 ++++
 net/bluetooth/hci_event.c         | 20 +++++++++++---------
 net/bluetooth/sco.c               |  2 +-
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 6091b691ddc2..2d64e289cf6e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2215,7 +2215,7 @@ static int btintel_get_codec_config_data(struct hci_dev *hdev,
 static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
 {
 	/* Intel uses 1 as data path id for all the usecases */
-	*data_path_id = 1;
+	*data_path_id = BT_SCO_PCM_PATH;
 	return 0;
 }
 
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index c1fa90fb7502..9e2745863b33 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -177,6 +177,10 @@ struct bt_codecs {
 #define CODING_FORMAT_TRANSPARENT	0x03
 #define CODING_FORMAT_MSBC		0x05
 
+/* Audio data transport path used for SCO */
+#define BT_SCO_HCI_PATH 0x00
+#define BT_SCO_PCM_PATH 0x01
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b48e24629fa4..7ff11cba89cf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4516,15 +4516,17 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_mode);
 
-	switch (ev->air_mode) {
-	case 0x02:
-		if (hdev->notify)
-			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
-		break;
-	case 0x03:
-		if (hdev->notify)
-			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
-		break;
+	if (conn->codec.data_path == BT_SCO_HCI_PATH) {
+		switch (ev->air_mode) {
+		case 0x02:
+			if (hdev->notify)
+				hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
+			break;
+		case 0x03:
+			if (hdev->notify)
+				hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
+			break;
+		}
 	}
 
 	hci_connect_cfm(conn, ev->status);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 004bce2b5eca..f35c12ca6aa5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -506,7 +506,7 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 	sco_pi(sk)->codec.id = CODING_FORMAT_CVSD;
 	sco_pi(sk)->codec.cid = 0xffff;
 	sco_pi(sk)->codec.vid = 0xffff;
-	sco_pi(sk)->codec.data_path = 0x00;
+	sco_pi(sk)->codec.data_path = BT_SCO_HCI_PATH;
 
 	bt_sock_link(&sco_sk_list, sk);
 	return sk;
-- 
2.17.1

