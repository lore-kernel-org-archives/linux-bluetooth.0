Return-Path: <cyrus@holtmann.org>
From: Ron Shaffer <rshaffer@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Ron Shaffer <rshaffer@codeaurora.org>
Subject: Re: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection requests to ACL state
Date: Mon, 12 Jul 2010 17:06:12 -0400
Message-Id: <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
In-Reply-To: <1278625779.10421.80.camel@localhost.localdomain>
References: <1278625779.10421.80.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Certain headsets such as the Motorola H350 will reject SCO and eSCO
connection requests while the ACL is transitioning from sniff mode
to active mode. Add synchronization so that SCO and eSCO connection
requests will wait until the ACL has fully transitioned to active mode.

Signed-off-by: Ron Shaffer <rshaffer@codeaurora.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   18 ++++++++++++++++++
 net/bluetooth/hci_event.c        |   22 +++++++++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fd53323..c4a37fc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -250,6 +250,7 @@ enum {
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
+	HCI_CONN_SCO_PEND,
 };
 
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9bf4308..ffc67ac 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -117,9 +117,18 @@ void hci_add_sco(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_add_sco cp;
+	struct hci_conn *acl = conn->link;
 
 	BT_DBG("%p", conn);
 
+	if (acl->mode == HCI_CM_SNIFF &&
+			test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
+		set_bit(HCI_CONN_SCO_PEND, &conn->pend);
+		return;
+	}
+
+	test_and_clear_bit(HCI_CONN_SCO_PEND, &conn->pend);
+
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 
@@ -135,9 +144,18 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_setup_sync_conn cp;
+	struct hci_conn *acl = conn->link;
 
 	BT_DBG("%p", conn);
 
+	if (acl->mode == HCI_CM_SNIFF &&
+			test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
+		set_bit(HCI_CONN_SCO_PEND, &conn->pend);
+		return;
+	}
+
+	test_and_clear_bit(HCI_CONN_SCO_PEND, &conn->pend);
+
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3af537a..c3a05e1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -615,6 +615,7 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
 	if (acl && (sco = acl->link)) {
 		sco->state = BT_CLOSED;
+		clear_bit(HCI_CONN_SCO_PEND, &sco->pend);
 
 		hci_proto_connect_cfm(sco, status);
 		hci_conn_del(sco);
@@ -760,6 +761,7 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
 	if (acl && (sco = acl->link)) {
 		sco->state = BT_CLOSED;
+		clear_bit(HCI_CONN_SCO_PEND, &sco->pend);
 
 		hci_proto_connect_cfm(sco, status);
 		hci_conn_del(sco);
@@ -795,6 +797,7 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_exit_sniff_mode *cp;
 	struct hci_conn *conn;
+	struct hci_conn *sco;
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
@@ -808,9 +811,16 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn)
+	if (conn) {
 		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
 
+		sco = conn->link;
+		if (sco && test_and_clear_bit(HCI_CONN_SCO_PEND, &sco->pend)) {
+				hci_proto_connect_cfm(sco, status);
+				hci_conn_del(sco);
+		}
+	}
+
 	hci_dev_unlock(hdev);
 }
 
@@ -1463,6 +1473,7 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 {
 	struct hci_ev_mode_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	struct hci_conn *sco;
 
 	BT_DBG("%s status %d", hdev->name, ev->status);
 
@@ -1478,6 +1489,15 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 				conn->power_save = 1;
 			else
 				conn->power_save = 0;
+		} else {
+			sco = conn->link;
+			if (sco && test_and_clear_bit(HCI_CONN_SCO_PEND,
+					&sco->pend)) {
+				if (lmp_esco_capable(hdev))
+					hci_setup_sync(sco, conn->handle);
+				else
+					hci_add_sco(sco, conn->handle);
+			}
 		}
 	}
 
-- 
1.7.0.2

--
Ron Shaffer
Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
