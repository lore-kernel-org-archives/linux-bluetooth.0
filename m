Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Remove reason parameter from hci_amp_disconn function
Date: Fri, 27 Jun 2014 13:45:08 +0200
Message-Id: <1403869510-30820-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_amp_disconn function is a local function and there is no
need for a reason parameter. That one can be retrieved from the
hci_conn object easily.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 626160c37103..cc64fbe952fa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -136,7 +136,7 @@ void hci_disconnect(struct hci_conn *conn, __u8 reason)
 	hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
 }
 
-static void hci_amp_disconn(struct hci_conn *conn, __u8 reason)
+static void hci_amp_disconn(struct hci_conn *conn)
 {
 	struct hci_cp_disconn_phy_link cp;
 
@@ -145,7 +145,7 @@ static void hci_amp_disconn(struct hci_conn *conn, __u8 reason)
 	conn->state = BT_DISCONN;
 
 	cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
-	cp.reason = reason;
+	cp.reason = hci_proto_disconn_ind(conn);
 	hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
 		     sizeof(cp), &cp);
 }
@@ -273,13 +273,14 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 
 static void hci_conn_disconnect(struct hci_conn *conn)
 {
-	__u8 reason = hci_proto_disconn_ind(conn);
+	__u8 reason;
 
 	switch (conn->type) {
 	case AMP_LINK:
-		hci_amp_disconn(conn, reason);
+		hci_amp_disconn(conn);
 		break;
 	default:
+		reason = hci_proto_disconn_ind(conn);
 		hci_disconnect(conn, reason);
 		break;
 	}
-- 
1.9.3

