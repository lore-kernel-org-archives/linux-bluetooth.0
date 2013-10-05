Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Bluetooth: Simplify check if L2CAP connection is AMP capable
Date: Sat,  5 Oct 2013 11:47:49 -0700
Message-Id: <1380998869-64411-10-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The check if a L2CAP connection is AMP capable was a little bit
complicated. This changes the code to make it simpler and more
readable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2efdb17..a9a7df6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1012,30 +1012,30 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }
 
-/* returns true if at least one AMP active */
-static inline bool hci_amp_capable(void)
+static bool __amp_capable(struct l2cap_chan *chan)
 {
+	struct l2cap_conn *conn = chan->conn;
 	struct hci_dev *hdev;
-	bool ret = false;
+	bool amp_available = false;
+
+	if (!conn->hs_enabled)
+		return false;
+
+	if (!(conn->fixed_chan_mask & L2CAP_FC_A2MP))
+		return false;
 
 	read_lock(&hci_dev_list_lock);
-	list_for_each_entry(hdev, &hci_dev_list, list)
+	list_for_each_entry(hdev, &hci_dev_list, list) {
 		if (hdev->amp_type != AMP_TYPE_BREDR &&
-		    test_bit(HCI_UP, &hdev->flags))
-			ret = true;
+		    test_bit(HCI_UP, &hdev->flags)) {
+			amp_available = true;
+			break;
+		}
+	}
 	read_unlock(&hci_dev_list_lock);
 
-	return ret;
-}
-
-static bool __amp_capable(struct l2cap_chan *chan)
-{
-	struct l2cap_conn *conn = chan->conn;
-
-	if (conn->hs_enabled && hci_amp_capable() &&
-	    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED &&
-	    conn->fixed_chan_mask & L2CAP_FC_A2MP)
-		return true;
+	if (chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED)
+		return amp_available;
 
 	return false;
 }
-- 
1.8.3.1

