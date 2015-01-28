Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Use helper function to determine BR/EDR OOB data present
Date: Tue, 27 Jan 2015 16:04:32 -0800
Message-Id: <1422403473-3542-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When replying to the IO capability request for Secure Simple Pairing and
Secure Connections, the OOB data present fields needs to set. Instead of
making the calculation inline, split this into a separate helper
function.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0850cad8c368..8ed8516b18c7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3855,6 +3855,21 @@ static u8 hci_get_auth_req(struct hci_conn *conn)
 	return (conn->remote_auth & ~0x01) | (conn->auth_type & 0x01);
 }
 
+static u8 bredr_oob_data_present(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct oob_data *data;
+
+	data = hci_find_remote_oob_data(hdev, &conn->dst, BDADDR_BREDR);
+	if (!data)
+		return 0x00;
+
+	if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags))
+		return 0x01;
+
+	return 0x00;
+}
+
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_io_capa_request *ev = (void *) skb->data;
@@ -3906,12 +3921,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			conn->auth_type &= HCI_AT_NO_BONDING_MITM;
 
 		cp.authentication = conn->auth_type;
-
-		if (hci_find_remote_oob_data(hdev, &conn->dst, BDADDR_BREDR) &&
-		    (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)))
-			cp.oob_data = 0x01;
-		else
-			cp.oob_data = 0x00;
+		cp.oob_data = bredr_oob_data_present(conn);
 
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_REPLY,
 			     sizeof(cp), &cp);
-- 
2.1.0

