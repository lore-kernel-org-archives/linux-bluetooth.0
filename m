Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 8/9] Bluetooth: Handle incoming connection to an adv set
Date: Mon,  4 Dec 2017 13:37:52 +0530
Message-Id: <1512374873-1956-9-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch basically set responder address to the hci conn from
the adv instance to which connection is established.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_event.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 67081ab..92b8308 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4737,8 +4737,11 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 	/* All controllers implicitly stop advertising in the event of a
 	 * connection, so ensure that the state bit is cleared.
+	 * If ext adv is supported then it would be handled in adv terminated
+	 * event.
 	 */
-	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+	if (!ext_adv_capable(hdev))
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
 	conn = hci_lookup_le_connect(hdev);
 	if (!conn) {
@@ -4775,14 +4778,17 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	}
 
 	if (!conn->out) {
-		/* Set the responder (our side) address type based on
-		 * the advertising address type.
-		 */
-		conn->resp_addr_type = hdev->adv_addr_type;
-		if (hdev->adv_addr_type == ADDR_LE_DEV_RANDOM)
-			bacpy(&conn->resp_addr, &hdev->random_addr);
-		else
-			bacpy(&conn->resp_addr, &hdev->bdaddr);
+		/* In ext adv, resp addr will be set in adv terminated event */
+		if (!ext_adv_capable(hdev)) {
+			/* Set the responder (our side) address type based on
+			 * the advertising address type.
+			 */
+			conn->resp_addr_type = hdev->adv_addr_type;
+			if (hdev->adv_addr_type == ADDR_LE_DEV_RANDOM)
+				bacpy(&conn->resp_addr, &hdev->random_addr);
+			else
+				bacpy(&conn->resp_addr, &hdev->bdaddr);
+		}
 
 		conn->init_addr_type = bdaddr_type;
 		bacpy(&conn->init_addr, bdaddr);
@@ -4929,10 +4935,33 @@ static void hci_le_adv_set_terminated_evt(struct hci_dev *hdev,
 
 	/* If this is because of connection */
 	if (!ev->status) {
+		struct hci_conn *conn;
+
 		if (!ev->handle)
 			hci_dev_clear_flag(hdev, HCI_LE_ADV);
 		else
 			clear_bit(ADV_INST_ENABLED, &adv_instance->state);
+
+		conn = hci_conn_hash_lookup_handle(hdev,
+						   le16_to_cpu(ev->conn_handle));
+		if (conn) {
+			/* Set the responder (our side) address type based on
+			 * the advertising address type.
+			 */
+			if (!ev->handle) {
+				conn->resp_addr_type = hdev->adv_addr_type;
+				if (hdev->adv_addr_type == ADDR_LE_DEV_RANDOM)
+					bacpy(&conn->resp_addr, &hdev->random_addr);
+				else
+					bacpy(&conn->resp_addr, &hdev->bdaddr);
+			} else {
+				conn->resp_addr_type = adv_instance->addr_type;
+				if (adv_instance->addr_type == ADDR_LE_DEV_RANDOM)
+					bacpy(&conn->resp_addr, &adv_instance->random_addr);
+				else
+					bacpy(&conn->resp_addr, &hdev->bdaddr);
+			}
+		}
 	} else if (ev->handle) {
 		/* Remove the instance in all other cases */
 		err = hci_remove_adv_instance(hdev, ev->handle);
-- 
2.7.4

