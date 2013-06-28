Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [RFC BlueZ v3 4/8] Bluetooth: Refactor hci_get_auth_req()
Date: Fri, 28 Jun 2013 10:56:30 +0200
Message-Id: <1372409794-24688-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Refactor the code without changing its behavior by handling the
no-bonding cases first followed by General Bonding.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
---
 net/bluetooth/hci_event.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 50e39f4..fe78b9c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3023,24 +3023,25 @@ unlock:
 
 static u8 hci_get_auth_req(struct hci_conn *conn)
 {
-	/* If remote requests dedicated bonding follow that lead */
-	if (conn->remote_auth == HCI_AT_DEDICATED_BONDING ||
-	    conn->remote_auth == HCI_AT_DEDICATED_BONDING_MITM) {
-		/* If both remote and local IO capabilities allow MITM
-		 * protection then require it, otherwise don't */
-		if (conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT ||
-		    conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)
-			return HCI_AT_DEDICATED_BONDING;
-		else
-			return HCI_AT_DEDICATED_BONDING_MITM;
-	}
-
 	/* If remote requests no-bonding follow that lead */
 	if (conn->remote_auth == HCI_AT_NO_BONDING ||
 	    conn->remote_auth == HCI_AT_NO_BONDING_MITM)
 		return conn->remote_auth | (conn->auth_type & 0x01);
 
-	return conn->auth_type;
+	/* For general bonding, use the given auth_type */
+	if (conn->remote_auth == HCI_AT_GENERAL_BONDING ||
+	    conn->remote_auth == HCI_AT_GENERAL_BONDING_MITM)
+		return conn->auth_type;
+
+	/* If both remote and local have enough IO capabilities, require
+	 * MITM protection
+	 */
+	if (conn->remote_cap != HCI_IO_NO_INPUT_OUTPUT &&
+	    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT)
+		return conn->remote_auth | 0x01;
+
+	/* No MITM protection possible so remove requirement */
+	return conn->remote_auth & ~0x01;
 }
 
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -3070,8 +3071,14 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		 * to DisplayYesNo as it is not supported by BT spec. */
 		cp.capability = (conn->io_capability == 0x04) ?
 				HCI_IO_DISPLAY_YESNO : conn->io_capability;
-		conn->auth_type = hci_get_auth_req(conn);
-		cp.authentication = conn->auth_type;
+
+		/* If we are initiators, there is no remote information yet */
+		if (conn->remote_auth == 0xff) {
+			cp.authentication = conn->auth_type;
+		} else {
+			conn->auth_type = hci_get_auth_req(conn);
+			cp.authentication = conn->auth_type;
+		}
 
 		if (hci_find_remote_oob_data(hdev, &conn->dst) &&
 		    (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)))
-- 
1.8.1.4

