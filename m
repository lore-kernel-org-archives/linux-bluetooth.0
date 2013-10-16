Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 09/15] Bluetooth: Add support for BT_AUTO_CONN_LINK_LOSS option
Date: Wed, 16 Oct 2013 20:17:59 -0300
Message-Id: <1381965485-9159-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the BT_AUTO_CONN_LINK_LOSS option which
configures the kernel to autonomously reconnect to a certainn device
in case the connection is terminated by link loss (which maps to HCI
Connection Timeout error.

This feature is required by the majority of LE profiles such as
Proximity, Find Me, Cycling Speed and Cadence and Time.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b34ff1d..570f27d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1820,15 +1820,25 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * device.
 	 */
 	param = hci_find_conn_param(hdev, &conn->dst, conn->dst_type);
-	if (param && param->auto_connect == BT_AUTO_CONN_ALWAYS) {
+	if (param) {
 		int err;
 
-		err = hci_trigger_background_scan(hdev);
-		if (err)
-			BT_ERR("Failed to trigger background "
-					"scanning: %d", err);
+		switch (param->auto_connect){
+		case BT_AUTO_CONN_LINK_LOSS:
+			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+				break;
+			/* Fall through */
+
+		case BT_AUTO_CONN_ALWAYS:
+			err = hci_trigger_background_scan(hdev);
+			if (err)
+				BT_ERR("Failed to trigger background "
+						"scanning: %d", err);
+
+			param->bg_scan_triggered = true;
+			break;
+		}
 
-		param->bg_scan_triggered = true;
 		hci_conn_param_put(param);
 	}
 
-- 
1.8.4

