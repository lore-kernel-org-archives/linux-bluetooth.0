Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Remove unneeded hci_conn_disconnect abstraction
Date: Fri, 27 Jun 2014 13:45:09 +0200
Message-Id: <1403869510-30820-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The abstraction of disconnect operation via hci_conn_disconnect is not
needed and it does not add any readability. Handle the difference of
AMP physical channels and BR/EDR/LE connection in the timeout callback.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cc64fbe952fa..6d0fe3df2fa5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -271,21 +271,6 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	}
 }
 
-static void hci_conn_disconnect(struct hci_conn *conn)
-{
-	__u8 reason;
-
-	switch (conn->type) {
-	case AMP_LINK:
-		hci_amp_disconn(conn);
-		break;
-	default:
-		reason = hci_proto_disconn_ind(conn);
-		hci_disconnect(conn, reason);
-		break;
-	}
-}
-
 static void hci_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
@@ -320,7 +305,12 @@ static void hci_conn_timeout(struct work_struct *work)
 		break;
 	case BT_CONFIG:
 	case BT_CONNECTED:
-		hci_conn_disconnect(conn);
+		if (conn->type == AMP_LINK) {
+			hci_amp_disconn(conn);
+		} else {
+			__u8 reason = hci_proto_disconn_ind(conn);
+			hci_disconnect(conn, reason);
+		}
 		break;
 	default:
 		conn->state = BT_CLOSED;
-- 
1.9.3

