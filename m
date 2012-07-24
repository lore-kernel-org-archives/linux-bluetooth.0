Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Make connect / disconnect cfm functions return void
Date: Tue, 24 Jul 2012 16:06:15 +0300
Message-Id: <1343135175-21617-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Return values are never used because callers hci_proto_connect_cfm
and hci_proto_disconn_cfm return void.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    8 ++++----
 net/bluetooth/l2cap_core.c       |    6 ++----
 net/bluetooth/sco.c              |    7 ++-----
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 03b8b65..41d9439 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -350,16 +350,16 @@ extern rwlock_t hci_cb_list_lock;
 
 /* ----- HCI interface to upper protocols ----- */
 extern int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
-extern int l2cap_connect_cfm(struct hci_conn *hcon, u8 status);
+extern void l2cap_connect_cfm(struct hci_conn *hcon, u8 status);
 extern int l2cap_disconn_ind(struct hci_conn *hcon);
-extern int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
+extern void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
 extern int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt);
 extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
 			      u16 flags);
 
 extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
-extern int sco_connect_cfm(struct hci_conn *hcon, __u8 status);
-extern int sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
+extern void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
+extern void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
 extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
 /* ----- Inquiry cache ----- */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 64d88a6..8391e05 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5329,7 +5329,7 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return exact ? lm1 : lm2;
 }
 
-int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
+void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
 
@@ -5342,7 +5342,6 @@ int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	} else
 		l2cap_conn_del(hcon, bt_to_errno(status));
 
-	return 0;
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
@@ -5356,12 +5355,11 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 	return conn->disc_reason;
 }
 
-int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
+void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	l2cap_conn_del(hcon, bt_to_errno(reason));
-	return 0;
 }
 
 static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 40bbe25..0ef5a78 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -913,7 +913,7 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return lm;
 }
 
-int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 	if (!status) {
@@ -924,16 +924,13 @@ int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 			sco_conn_ready(conn);
 	} else
 		sco_conn_del(hcon, bt_to_errno(status));
-
-	return 0;
 }
 
-int sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
+void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	sco_conn_del(hcon, bt_to_errno(reason));
-	return 0;
 }
 
 int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
-- 
1.7.9.5

