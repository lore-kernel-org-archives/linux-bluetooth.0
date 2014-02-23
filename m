Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: Ensure hci_conn always contains the local identity address
Date: Sun, 23 Feb 2014 22:07:00 +0200
Message-Id: <1393186020-6383-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To be consistent with the remote address info in hci_conn we want it to
also contain the local identity address information. The struct will
contain the actual address used for the connection while a connection
process is in place but as soon as we have a successful connection the
identity address should be tracked instead.

This patch updates the code to set the src and src_type values to point
at the identity address in the hci_le_conn_complete_evt function. The
identity address can either be a public address or a static random
address.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v4: Fix commit message not to refer to non-existent functions

 net/bluetooth/hci_event.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4327b129d38e..84a475ac2e7f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3625,6 +3625,26 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
+	/* Ensure that the hci_conn contains the identity address type
+	 * regardless of which address the connection was made with.
+	 *
+	 * If the controller has a public BD_ADDR, then by default
+	 * use that one. If this is a LE only controller without
+	 * a public address, default to the random address.
+	 *
+	 * For debugging purposes it is possible to force
+	 * controllers with a public address to use the
+	 * random address instead.
+	 */
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+		bacpy(&conn->src, &hdev->static_addr);
+		conn->src_type = ADDR_LE_DEV_RANDOM;
+	} else {
+		bacpy(&conn->src, &hdev->bdaddr);
+		conn->src_type = ADDR_LE_DEV_PUBLIC;
+	}
+
 	/* Lookup the identity address from the stored connection
 	 * address and address type.
 	 *
-- 
1.8.5.3

