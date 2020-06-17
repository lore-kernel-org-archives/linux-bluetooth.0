Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80084C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C442082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgFQKmO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:42:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36294 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgFQKmN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 06:42:13 -0400
Received: from localhost.localdomain (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id B5F14CECDB
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 12:52:02 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/14] Bluetooth: Add handler of MGMT_OP_REMOVE_ADV_MONITOR
Date:   Wed, 17 Jun 2020 12:42:00 +0200
Message-Id: <211ca797e01a6ccab70d6432bf33ff73ab37d994.1592390407.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592390407.git.marcel@holtmann.org>
References: <cover.1592390407.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This adds the request handler of MGMT_OP_REMOVE_ADV_MONITOR command.
Note that the controller-based monitoring is not yet in place. This
removes the internal monitor(s) without sending HCI traffic, so the
request returns immediately.

The following test was performed.
- Issue btmgmt advmon-remove with valid and invalid handles.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 31 ++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 13fad419ae7d..c54f9295892e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1283,6 +1283,7 @@ void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 void hci_adv_monitors_clear(struct hci_dev *hdev);
 void hci_free_adv_monitor(struct adv_monitor *monitor);
 int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor);
+int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ce481fab349d..59132b3e2cde 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3041,6 +3041,37 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	return 0;
 }
 
+static int free_adv_monitor(int id, void *ptr, void *data)
+{
+	struct hci_dev *hdev = data;
+	struct adv_monitor *monitor = ptr;
+
+	idr_remove(&hdev->adv_monitors_idr, monitor->handle);
+	hci_free_adv_monitor(monitor);
+
+	return 0;
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle)
+{
+	struct adv_monitor *monitor;
+
+	if (handle) {
+		monitor = idr_find(&hdev->adv_monitors_idr, handle);
+		if (!monitor)
+			return -ENOENT;
+
+		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
+		hci_free_adv_monitor(monitor);
+	} else {
+		/* Remove all monitors if handle is 0. */
+		idr_for_each(&hdev->adv_monitors_idr, &free_adv_monitor, hdev);
+	}
+
+	return 0;
+}
+
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
 					 bdaddr_t *bdaddr, u8 type)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1eca36e51706..cff24fde72d2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -121,6 +121,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_DEVICE_FLAGS,
 	MGMT_OP_READ_ADV_MONITOR_FEATURES,
 	MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+	MGMT_OP_REMOVE_ADV_MONITOR,
 };
 
 static const u16 mgmt_events[] = {
@@ -4118,6 +4119,39 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+	struct mgmt_cp_remove_adv_monitor *cp = data;
+	struct mgmt_rp_remove_adv_monitor rp;
+	u16 handle;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	handle = __le16_to_cpu(cp->monitor_handle);
+
+	err = hci_remove_adv_monitor(hdev, handle);
+	if (err == -ENOENT) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADV_MONITOR,
+				      MGMT_STATUS_INVALID_INDEX);
+		goto unlock;
+	}
+
+	hci_dev_unlock(hdev);
+
+	rp.monitor_handle = cp->monitor_handle;
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_ADV_MONITOR,
+				 MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -7589,6 +7623,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_adv_mon_features,   MGMT_READ_ADV_MONITOR_FEATURES_SIZE },
 	{ add_adv_patterns_monitor,MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ remove_adv_monitor,      MGMT_REMOVE_ADV_MONITOR_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.26.2

