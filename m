Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add default connection parameters before pairing
Date: Mon, 30 Jun 2014 11:50:36 +0200
Message-Id: <1404121836-48355-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When trying to pair a new Bluetooth Low Energy device, then make sure
that the default connections parameters are in place before trying to
establish the first connection to that device. With the connection
parameters structure allocated, the slave preferred values can now
easily be tracked and all future connections will use the correct
values from that start decreasing connection establishment time.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d83197f9e727..ba3c049d729a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2947,6 +2947,17 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		else
 			addr_type = ADDR_LE_DEV_RANDOM;
 
+		/* When pairing a new device, it is expected to remember
+		 * this device for future connections. Adding the connection
+		 * parameter information ahead of time allows tracking
+		 * of the slave preferred values and will speed up any
+		 * further connection establishment.
+		 */
+		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type,
+				    HCI_AUTO_CONN_DISABLED,
+				    hdev->le_conn_min_interval,
+				    hdev->le_conn_max_interval);
+
 		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
 				      sec_level, auth_type);
 	}
-- 
1.9.3

