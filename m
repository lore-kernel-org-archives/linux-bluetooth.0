Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A9C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 04:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97378218FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 04:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeL1ELg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Dec 2018 23:11:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:6298 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbeL1ELg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Dec 2018 23:11:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 20:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="110453787"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2018 20:11:34 -0800
From:   SpoorthiX K <spoorthix.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] LE Ping: Changes implement LE Ping feature
Date:   Fri, 28 Dec 2018 09:45:54 +0530
Message-Id: <1545970554-2316-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: SpoorthiX <spoorthix.k@intel.com>

As per the Core Specification 5.0, Volume 2, Part E, Section 7.3.94
the following code changes implements HCI Write Authenticated Payload Timeout
command for LE Ping feature.

Signed-off-by: SpoorthiX <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci.h  |  6 +++
 include/net/bluetooth/mgmt.h |  9 +++++
 net/bluetooth/hci_event.c    | 28 ++++++++++++++
 net/bluetooth/mgmt.c         | 92 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e..c2a8080 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1130,6 +1130,12 @@ struct hci_cp_write_sc_support {
 	__u8	support;
 } __packed;
 
+#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
+struct hci_cp_write_auth_payload_to {
+        __u16	conn_handle;
+        __u16   timeout;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
 struct hci_rp_read_local_oob_ext_data {
 	__u8     status;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9cee7dd..22c3052 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -654,6 +654,15 @@ struct mgmt_cp_set_phy_confguration {
 } __packed;
 #define MGMT_SET_PHY_CONFIGURATION_SIZE	4
 
+
+#define MGMT_OP_WRITE_AUTH_PAYLOAD_TO   0x0046
+struct mgmt_cp_write_auth_payload_to {
+       __le16  conn_handle;
+       __le16  auth_to;
+} __packed;
+#define MGMT_OP_WRITE_AUTH_PAYLOAD_TO_SIZE  4
+
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef9928d..eef7025 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1183,6 +1183,29 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+
+static void hci_cc_write_auth_payload_to (struct hci_dev *hdev, struct sk_buff *skb)
+{
+        __u8 status = *((__u8 *) skb->data);
+        struct hci_cp_write_auth_payload_to *cp;
+        struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+        if (status)
+                return;
+
+        cp = hci_sent_cmd_data(hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO);
+        if (!cp)
+                return;
+
+        hci_dev_lock(hdev);
+
+        conn->handle = cp->conn_handle;
+
+        hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_ext_scan_param(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
@@ -5913,6 +5936,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
+
 #if IS_ENABLED(CONFIG_BT_HS)
 	case HCI_EV_CHANNEL_SELECTED:
 		hci_chan_selected_evt(hdev, skb);
@@ -5939,6 +5963,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
 
+        case HCI_OP_WRITE_AUTH_PAYLOAD_TO:
+                hci_cc_write_auth_payload_to(hdev, skb);
+                break;
+
 	default:
 		BT_DBG("%s event 0x%2.2x", hdev->name, event);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccce954..ae6480e9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_WRITE_AUTH_PAYLOAD_TO,
 };
 
 static const u16 mgmt_events[] = {
@@ -3595,6 +3596,96 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 	mgmt_pending_remove(cmd);
 }
 
+static void write_auth_payload_to_complete(struct hci_dev *hdev, u8 status,
+                                     u16 opcode, struct sk_buff *skb)
+{
+        struct mgmt_cp_write_auth_payload_to *cp;
+        struct mgmt_pending_cmd *cmd;
+        BT_DBG("");
+        BT_INFO("status 0x%02x\n", status);
+
+        hci_dev_lock(hdev);
+
+        cmd = pending_find(MGMT_OP_WRITE_AUTH_PAYLOAD_TO, hdev);
+        if (!cmd)
+                goto unlock;
+        cp = cmd->param;
+
+        if (status) {
+                mgmt_cmd_status(cmd->sk, hdev->id,
+                                MGMT_OP_WRITE_AUTH_PAYLOAD_TO,
+                                mgmt_status(status));
+        } else {
+                mgmt_cmd_complete(cmd->sk, hdev->id,
+                                  MGMT_OP_WRITE_AUTH_PAYLOAD_TO, 0,
+                                  NULL, 0);
+        }
+
+        mgmt_pending_remove(cmd);
+
+unlock:
+        hci_dev_unlock(hdev);
+}
+
+
+static int write_auth_payload_to(struct sock *sk, struct hci_dev *hdev, void *data,
+                      u16 len)
+{
+	struct mgmt_cp_write_auth_payload_to *cp = data;
+	struct hci_cp_write_auth_payload_to cp_payload;
+	struct mgmt_pending_cmd *cmd;
+	struct hci_request req;
+	u16 handle;
+	u16 timeout;
+	int err;
+
+	hci_dev_lock(hdev);
+	if (!hdev_is_powered(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+                                     MGMT_OP_WRITE_AUTH_PAYLOAD_TO,
+                                     MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	if (pending_find(MGMT_OP_WRITE_AUTH_PAYLOAD_TO, hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+                                     MGMT_OP_WRITE_AUTH_PAYLOAD_TO,
+                                     MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	err = mgmt_cmd_complete(sk, hdev->id,
+                                       MGMT_OP_WRITE_AUTH_PAYLOAD_TO,
+                                       0, NULL, 0);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_WRITE_AUTH_PAYLOAD_TO, hdev, data,
+                              len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+	hci_req_init(&req, hdev);
+
+	handle = cp->conn_handle;
+	timeout = cp->auth_to;
+
+	memset(&cp_payload, 0, sizeof(cp_payload));
+
+	cp_payload.conn_handle = handle;
+	cp_payload.timeout = timeout;
+
+	hci_req_add(&req, HCI_OP_WRITE_AUTH_PAYLOAD_TO, sizeof(cp_payload), &cp_payload);
+
+	err = hci_req_run_skb(&req, write_auth_payload_to_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+
 static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 			       void *data, u16 data_len)
 {
@@ -6921,6 +7012,7 @@ static int get_adv_size_info(struct sock *sk, struct hci_dev *hdev,
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
+	{ write_auth_payload_to,   MGMT_OP_WRITE_AUTH_PAYLOAD_TO_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
1.9.1

