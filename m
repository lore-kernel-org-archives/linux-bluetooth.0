Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/4] Bluetooth: Fix LE responder/initiator address setting
Date: Fri, 14 Mar 2014 19:22:31 +0200
Message-Id: <1394817753-7430-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1394817753-7430-1-git-send-email-johan.hedberg@gmail.com>
References: <1394817753-7430-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once directed advertising is brought into the picture simply the lack of
an hci_conn object when an le_conn_complete event occurs is no longer a
reliable indication that the responder & initiator values need to be
set based on our advertising address type.

This patch moves the code for setting these values outside of the
"if (!conn)" branch and ensures that they get set for any connection
where we are in the slave role.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7346ebd4c7d9..7f5178ccae97 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3793,23 +3793,25 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 							  &conn->init_addr,
 							  &conn->init_addr_type);
 			}
-		} else {
-			/* Set the responder (our side) address type based on
-			 * the advertising address type.
-			 */
-			conn->resp_addr_type = hdev->adv_addr_type;
-			if (hdev->adv_addr_type == ADDR_LE_DEV_RANDOM)
-				bacpy(&conn->resp_addr, &hdev->random_addr);
-			else
-				bacpy(&conn->resp_addr, &hdev->bdaddr);
-
-			conn->init_addr_type = ev->bdaddr_type;
-			bacpy(&conn->init_addr, &ev->bdaddr);
 		}
 	} else {
 		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
+	if (!conn->out) {
+		/* Set the responder (our side) address type based on
+		 * the advertising address type.
+		 */
+		conn->resp_addr_type = hdev->adv_addr_type;
+		if (hdev->adv_addr_type == ADDR_LE_DEV_RANDOM)
+			bacpy(&conn->resp_addr, &hdev->random_addr);
+		else
+			bacpy(&conn->resp_addr, &hdev->bdaddr);
+
+		conn->init_addr_type = ev->bdaddr_type;
+		bacpy(&conn->init_addr, &ev->bdaddr);
+	}
+
 	/* Lookup the identity address from the stored connection
 	 * address and address type.
 	 *
-- 
1.8.5.3

