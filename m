Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0485DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7C120809
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgG3JOb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:14:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47057 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgG3JOa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 05:14:30 -0400
Received: from localhost.localdomain (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id D1CB3CECF7
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2020 11:24:28 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Enable/Disable address resolution during le create conn
Date:   Thu, 30 Jul 2020 11:14:19 +0200
Message-Id: <20200730091421.48847-6-marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <nsathish41@gmail.com>

In this patch if le_create_conn process is started restrict to
disable address resolution and same is disabled during
le_enh_connection_complete

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c    |  7 +++++-
 net/bluetooth/hci_event.c   |  4 ++++
 net/bluetooth/hci_request.c | 45 ++++++++++++++++++++++++++++---------
 net/bluetooth/hci_request.h |  3 ++-
 net/bluetooth/mgmt.c        |  2 +-
 5 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index be67361ff2f0..9832f8445d43 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1003,6 +1003,11 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_request req;
 	int err;
 
+	/* This ensures that during disable le_scan address resolution
+	 * will not be disabled if it is followed by le_create_conn
+	 */
+	bool rpa_le_conn = true;
+
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		if (lmp_le_capable(hdev))
@@ -1103,7 +1108,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * state.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, rpa_le_conn);
 		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6388fb55b4d2..628831b15c0a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5228,6 +5228,10 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->interval),
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+		hci_req_disable_address_resolution(hdev);
 }
 
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e48f0945a417..70e077cc7dfa 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -428,7 +428,7 @@ static void __hci_update_background_scan(struct hci_request *req)
 		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			return;
 
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 		BT_DBG("%s stopping background scanning", hdev->name);
 	} else {
@@ -447,7 +447,7 @@ static void __hci_update_background_scan(struct hci_request *req)
 		 * don't miss any advertising (due to duplicates filter).
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(req);
+			hci_req_add_le_scan_disable(req, false);
 
 		hci_req_add_le_passive_scan(req);
 
@@ -652,7 +652,7 @@ void __hci_req_update_eir(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
-void hci_req_add_le_scan_disable(struct hci_request *req)
+void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -676,8 +676,9 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 	}
 
+	/* Disable address resolution */
 	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
 		__u8 enable = 0x00;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
@@ -1072,7 +1073,7 @@ static void hci_req_config_le_suspend_scan(struct hci_request *req)
 {
 	/* Before changing params disable scan if enabled */
 	if (hci_dev_test_flag(req->hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* Configure params and enable scanning */
 	hci_req_add_le_passive_scan(req);
@@ -1140,7 +1141,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 
 		/* Disable LE passive scan if enabled */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(&req);
+			hci_req_add_le_scan_disable(&req, false);
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
@@ -1696,6 +1697,28 @@ int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_req_run(&req, NULL);
 }
 
+static void enable_addr_resolution_complete(struct hci_dev *hdev, u8 status,
+					    u16 opcode)
+{
+	BT_DBG("%s status %u", hdev->name, status);
+}
+
+void hci_req_disable_address_resolution(struct hci_dev *hdev)
+{
+	struct hci_request req;
+	__u8 enable = 0x00;
+
+	if (!use_ll_privacy(hdev) &&
+	    !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+		return;
+
+	hci_req_init(&req, hdev);
+
+	hci_req_add(&req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+
+	hci_req_run(&req, enable_addr_resolution_complete);
+}
+
 static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	BT_DBG("%s status %u", hdev->name, status);
@@ -2667,7 +2690,7 @@ static void bg_scan_update(struct work_struct *work)
 
 static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 	return 0;
 }
 
@@ -2770,7 +2793,7 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 		return 0;
 	}
 
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 
 	if (use_ext_scan(hdev)) {
 		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
@@ -2861,7 +2884,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * discovery scanning parameters.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
@@ -2976,14 +2999,14 @@ bool hci_req_stop_discovery(struct hci_request *req)
 
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
-			hci_req_add_le_scan_disable(req);
+			hci_req_add_le_scan_disable(req, false);
 		}
 
 		ret = true;
 	} else {
 		/* Passive scanning */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-			hci_req_add_le_scan_disable(req);
+			hci_req_add_le_scan_disable(req, false);
 			ret = true;
 		}
 	}
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index bbe892ab078a..6a12e84c66c4 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -65,11 +65,12 @@ void __hci_req_write_fast_connectable(struct hci_request *req, bool enable);
 void __hci_req_update_name(struct hci_request *req);
 void __hci_req_update_eir(struct hci_request *req);
 
-void hci_req_add_le_scan_disable(struct hci_request *req);
+void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
 void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
 
+void hci_req_disable_address_resolution(struct hci_dev *hdev);
 void hci_req_reenable_advertising(struct hci_dev *hdev);
 void __hci_req_enable_advertising(struct hci_request *req);
 void __hci_req_disable_advertising(struct hci_request *req);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f45105d2de77..47bcfe2fb14c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5226,7 +5226,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 		hci_req_init(&req, hdev);
 
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, false);
 		hci_req_add_le_passive_scan(&req);
 
 		hci_req_run(&req, NULL);
-- 
2.26.2

