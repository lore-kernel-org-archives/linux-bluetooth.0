Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] Bluetooth: Fix initializing hci_conn RSSI to invalid value
Date: Fri,  5 Dec 2014 13:36:08 +0200
Message-Id: <1417779369-6428-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we create the hci_conn object we should properly initialize the
RSSI to HCI_RSSI_INVALID.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 96887ae8375b..79d84b88b8f0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -449,6 +449,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	conn->io_capability = hdev->io_capability;
 	conn->remote_auth = 0xff;
 	conn->key_type = 0xff;
+	conn->rssi = HCI_RSSI_INVALID;
 	conn->tx_power = HCI_TX_POWER_INVALID;
 	conn->max_tx_power = HCI_TX_POWER_INVALID;
 
-- 
2.1.0

