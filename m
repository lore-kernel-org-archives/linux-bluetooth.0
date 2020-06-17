Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3DAC433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 14:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C76206F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 14:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFQOjc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:39:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39578 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgFQOja (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 10:39:30 -0400
Received: from localhost.localdomain (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id C6B32CECE2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 16:49:17 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/14] Bluetooth: Terminate the link if pairing is cancelled
Date:   Wed, 17 Jun 2020 16:39:19 +0200
Message-Id: <d9233675e37458675f209bd3a6b5636e6a8f752d.1592404644.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592404644.git.marcel@holtmann.org>
References: <cover.1592404644.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Manish Mandlik <mmandlik@google.com>

If user decides to cancel the ongoing pairing process (e.g. by clicking
the cancel button on pairing/passkey window), abort any ongoing pairing
and then terminate the link if it was created because of the pair
device action.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 14 ++++++++++++--
 net/bluetooth/hci_conn.c         | 11 ++++++++---
 net/bluetooth/l2cap_core.c       |  6 ++++--
 net/bluetooth/mgmt.c             | 22 ++++++++++++++++++----
 4 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 524057598ffd..77d29341b064 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -564,6 +564,12 @@ struct hci_dev {
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
 
+enum conn_reasons {
+	CONN_REASON_PAIR_DEVICE,
+	CONN_REASON_L2CAP_CHAN,
+	CONN_REASON_SCO_CONNECT,
+};
+
 struct hci_conn {
 	struct list_head list;
 
@@ -615,6 +621,8 @@ struct hci_conn {
 	__s8		max_tx_power;
 	unsigned long	flags;
 
+	enum conn_reasons conn_reason;
+
 	__u32		clock;
 	__u16		clock_accuracy;
 
@@ -1040,12 +1048,14 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     u8 dst_type, u8 sec_level,
-				     u16 conn_timeout);
+				     u16 conn_timeout,
+				     enum conn_reasons conn_reason);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
 				u8 role, bdaddr_t *direct_rpa);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
-				 u8 sec_level, u8 auth_type);
+				 u8 sec_level, u8 auth_type,
+				 enum conn_reasons conn_reason);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting);
 int hci_conn_check_link_mode(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9bdffc4e79b0..47f3a45d7dcb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1174,7 +1174,8 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 /* This function requires the caller holds hdev->lock */
 struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     u8 dst_type, u8 sec_level,
-				     u16 conn_timeout)
+				     u16 conn_timeout,
+				     enum conn_reasons conn_reason)
 {
 	struct hci_conn *conn;
 
@@ -1219,6 +1220,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
+	conn->conn_reason = conn_reason;
 
 	hci_update_background_scan(hdev);
 
@@ -1228,7 +1230,8 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
-				 u8 sec_level, u8 auth_type)
+				 u8 sec_level, u8 auth_type,
+				 enum conn_reasons conn_reason)
 {
 	struct hci_conn *acl;
 
@@ -1248,6 +1251,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 
 	hci_conn_hold(acl);
 
+	acl->conn_reason = conn_reason;
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED) {
 		acl->sec_level = BT_SECURITY_LOW;
 		acl->pending_sec_level = sec_level;
@@ -1264,7 +1268,8 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	struct hci_conn *acl;
 	struct hci_conn *sco;
 
-	acl = hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
+	acl = hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING,
+			      CONN_REASON_SCO_CONNECT);
 	if (IS_ERR(acl))
 		return acl;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fe913a5c754a..35d2bc569a2d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7893,11 +7893,13 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		else
 			hcon = hci_connect_le_scan(hdev, dst, dst_type,
 						   chan->sec_level,
-						   HCI_LE_CONN_TIMEOUT);
+						   HCI_LE_CONN_TIMEOUT,
+						   CONN_REASON_L2CAP_CHAN);
 
 	} else {
 		u8 auth_type = l2cap_get_auth_type(chan);
-		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
+		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type,
+				       CONN_REASON_L2CAP_CHAN);
 	}
 
 	if (IS_ERR(hcon)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ec66160a673c..2a732cab1dc9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2931,7 +2931,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (cp->addr.type == BDADDR_BREDR) {
 		conn = hci_connect_acl(hdev, &cp->addr.bdaddr, sec_level,
-				       auth_type);
+				       auth_type, CONN_REASON_PAIR_DEVICE);
 	} else {
 		u8 addr_type = le_addr_type(cp->addr.type);
 		struct hci_conn_params *p;
@@ -2950,9 +2950,9 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (p->auto_connect == HCI_AUTO_CONN_EXPLICIT)
 			p->auto_connect = HCI_AUTO_CONN_DISABLED;
 
-		conn = hci_connect_le_scan(hdev, &cp->addr.bdaddr,
-					   addr_type, sec_level,
-					   HCI_LE_CONN_TIMEOUT);
+		conn = hci_connect_le_scan(hdev, &cp->addr.bdaddr, addr_type,
+					   sec_level, HCI_LE_CONN_TIMEOUT,
+					   CONN_REASON_PAIR_DEVICE);
 	}
 
 	if (IS_ERR(conn)) {
@@ -3053,6 +3053,20 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
 				addr, sizeof(*addr));
+
+	/* Since user doesn't want to proceed with the connection, abort any
+	 * ongoing pairing and then terminate the link if it was created
+	 * because of the pair device action.
+	 */
+	if (addr->type == BDADDR_BREDR)
+		hci_remove_link_key(hdev, &addr->bdaddr);
+	else
+		smp_cancel_and_remove_pairing(hdev, &addr->bdaddr,
+					      le_addr_type(addr->type));
+
+	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
+		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
2.26.2

