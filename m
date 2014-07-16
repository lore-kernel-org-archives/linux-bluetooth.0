Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix always checking the blacklist for incoming connections
Date: Wed, 16 Jul 2014 16:19:21 +0300
Message-Id: <1405516761-20590-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should check the blacklist no matter what, meaning also when we're
not connectable. This patch fixes the respective logic in the function
making the decision whether to accept a connection or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ceaffd681f8b..8339f729921b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2129,18 +2129,17 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags)) {
-		if (hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
-					   BDADDR_BREDR)) {
-			hci_reject_conn(hdev, &ev->bdaddr);
-			return;
-		}
-	} else {
-		if (!hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
-					    BDADDR_BREDR)) {
-			hci_reject_conn(hdev, &ev->bdaddr);
-			return;
-		}
+	if (hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
+				   BDADDR_BREDR)) {
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
+	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
+	    !hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
+				    BDADDR_BREDR)) {
+		    hci_reject_conn(hdev, &ev->bdaddr);
+		    return;
 	}
 
 	/* Connection accepted */
-- 
1.9.3

