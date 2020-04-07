Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41378C2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 20:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1525220748
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 20:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDGUwY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:52:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39030 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDGUwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 16:52:24 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id DE962CECDB
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2020 23:01:56 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Configure controller address resolution if available
Date:   Tue,  7 Apr 2020 22:52:17 +0200
Message-Id: <20200407205217.1002534-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the LL Privacy support is available, then as part of enabling or
disabling passive background scanning, it is required to set up the
controller based address resolution as well.

Since only passive background scanning is utilizing the whitelist, the
address resolution is now bound to the whitelist and passive background
scanning. All other resolution can be easily done by the host stack.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_request.c      | 26 +++++++++++++++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5ef4547760db..58360538d42b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -459,6 +459,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_LL_PRIVACY		0x40
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 #define HCI_LE_PHY_2M			0x01
 #define HCI_LE_PHY_CODED		0x08
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f3275f1d1c4..663ffde9bd1d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -645,6 +645,7 @@ extern struct mutex hci_cb_list_lock;
 	do {							\
 		hci_dev_clear_flag(hdev, HCI_LE_SCAN);		\
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);		\
+		hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);\
 		hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);	\
 	} while (0)
 
@@ -1277,6 +1278,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
+/* Use LL Privacy based address resolution if supported */
+#define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
 			   ((dev)->commands[37] & 0x40))
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9ea40106ef17..efec2a0bb824 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -676,6 +676,12 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 		cp.enable = LE_SCAN_DISABLE;
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 	}
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		__u8 enable = 0x00;
+		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
 }
 
 static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
@@ -808,10 +814,16 @@ static bool scan_use_rpa(struct hci_dev *hdev)
 }
 
 static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
-			       u16 window, u8 own_addr_type, u8 filter_policy)
+			       u16 window, u8 own_addr_type, u8 filter_policy,
+			       bool addr_resolv)
 {
 	struct hci_dev *hdev = req->hdev;
 
+	if (use_ll_privacy(hdev) && addr_resolv) {
+		__u8 enable = 0x01;
+		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
+
 	/* Use ext scanning if set ext scan param and ext scan enable is
 	 * supported
 	 */
@@ -885,12 +897,18 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 	}
 }
 
+/* Ensure to call hci_req_add_le_scan_disable() first to disable the
+ * controller based address resolution to be able to reconfigure
+ * resolving list.
+ */
 void hci_req_add_le_passive_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
 	u8 filter_policy;
 	u8 window, interval;
+	/* Background scanning should run with address resolution */
+	bool addr_resolv = true;
 
 	if (hdev->scanning_paused) {
 		bt_dev_dbg(hdev, "Scanning is paused for suspend");
@@ -936,7 +954,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 
 	bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
 	hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
-			   own_addr_type, filter_policy);
+			   own_addr_type, filter_policy, addr_resolv);
 }
 
 static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
@@ -2725,6 +2743,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	u8 own_addr_type;
 	/* White list is not used for discovery */
 	u8 filter_policy = 0x00;
+	/* Discovery doesn't require controller address resolution */
+	bool addr_resolv = false;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2746,7 +2766,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
-			   own_addr_type, filter_policy);
+			   own_addr_type, filter_policy, addr_resolv);
 	return 0;
 }
 
-- 
2.25.2

