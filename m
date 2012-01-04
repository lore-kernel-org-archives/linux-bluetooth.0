Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 3/3] Bluetooth: Use hci_conn_encrypt() instead of open coded version
Date: Wed,  4 Jan 2012 16:06:24 +0100
Message-Id: <1325689584-15121-4-git-send-email-wagi@monom.org>
In-Reply-To: <1325689584-15121-1-git-send-email-wagi@monom.org>
References: <1325689584-15121-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 net/bluetooth/hci_event.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 453e483..7a4262d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1754,11 +1754,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status && hdev->ssp_mode > 0 && conn->ssp_mode > 0) {
-			struct hci_cp_set_conn_encrypt cp;
-			cp.handle  = ev->handle;
-			cp.encrypt = 0x01;
-			hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
-									&cp);
+			hci_conn_encrypt(conn);
 		} else {
 			conn->state = BT_CONNECTED;
 			hci_proto_connect_cfm(conn, ev->status);
@@ -1774,11 +1770,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend)) {
 		if (!ev->status) {
-			struct hci_cp_set_conn_encrypt cp;
-			cp.handle  = ev->handle;
-			cp.encrypt = 0x01;
-			hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
-									&cp);
+			hci_conn_encrypt(conn);
 		} else {
 			clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
 			hci_encrypt_cfm(conn, ev->status, 0x00);
-- 
1.7.8.2.302.g17b4

