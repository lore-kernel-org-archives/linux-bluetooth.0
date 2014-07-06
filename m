Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix updating background scan for LE connect complete
Date: Sun,  6 Jul 2014 15:44:23 +0300
Message-Id: <1404650663-4037-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we get an LE connection complete event we should restart background
scanning if there are any any devices needing it. So far the code was
only making the decision based on whether the completed connection had
any stored parameters or not. This patch ensures that we trigger
background scanning always when necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f452e44eff3c..57837cad9919 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4196,12 +4196,11 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_proto_connect_cfm(conn, ev->status);
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
+	if (params)
 		list_del_init(&params->action);
-		hci_update_background_scan(hdev);
-	}
 
 unlock:
+	hci_update_background_scan(hdev);
 	hci_dev_unlock(hdev);
 }
 
-- 
1.9.3

