Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v10 02/10] Bluetooth: Declare le_conn_failed in hci_core.h
Date: Tue, 18 Feb 2014 17:15:26 -0300
Message-Id: <1392754534-12747-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
References: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "hci_" prefix to le_conn_failed() helper and
declares it in hci_core.h so it can be reused in hci_event.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/hci_conn.c         | 4 ++--
 net/bluetooth/hci_event.c        | 6 +-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 259b876..1d14b39 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -637,6 +637,8 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
+void hci_le_conn_failed(struct hci_conn *conn, u8 status);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 40ec373..96e4cc6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -515,7 +515,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 EXPORT_SYMBOL(hci_get_route);
 
 /* This function requires the caller holds hdev->lock */
-static void le_conn_failed(struct hci_conn *conn, u8 status)
+void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -545,7 +545,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
 	if (!conn)
 		goto done;
 
-	le_conn_failed(conn, status);
+	hci_le_conn_failed(conn, status);
 
 done:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 49a2d4d..87baf21 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3609,11 +3609,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (ev->status) {
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, ev->status);
-		hci_proto_connect_cfm(conn, ev->status);
-		conn->state = BT_CLOSED;
-		hci_conn_del(conn);
+		hci_le_conn_failed(conn, ev->status);
 		goto unlock;
 	}
 
-- 
1.8.5.4

