Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Stop advertising always before initiating a connection
Date: Tue,  8 Jul 2014 15:07:52 +0300
Message-Id: <1404821273-28005-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Most controllers do not support advertising while initiating an LE
connection. We also have to first disable current advertising if the
initiation is going to happen through direct advertising. Therefore,
simply stop advertising as the first thing when starting to issue
commands to establish an LE connection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0db2579ea6c6..1517f1549f85 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -668,9 +668,6 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	u8 own_addr_type;
 	u8 enable;
 
-	enable = 0x00;
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-
 	/* Clear the HCI_LE_ADV bit temporarily so that the
 	 * hci_update_random_address knows that it's safe to go ahead
 	 * and write a new random address. The flag will be set back on
@@ -761,6 +758,18 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 	hci_req_init(&req, hdev);
 
+	/* Disable advertising if we're active. For master role
+	 * connections most controllers will refuse to connect if
+	 * advertising is enabled, and for slave role connections we
+	 * anyway have to disable it in order to start directed
+	 * advertising.
+	 */
+	if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
+		u8 enable = 0x00;
+		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
+			    &enable);
+	}
+
 	/* If requested to connect as slave use directed advertising */
 	if (!master) {
 		hci_req_directed_advertising(&req, conn);
-- 
1.9.3

