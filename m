Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Disallow LE local out-of-band data when LE privacy is used
Date: Thu,  2 Apr 2015 12:00:58 -0700
Message-Id: <1428001258-26629-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the LE pivacy feature is used, then pairing has to happen based
on resolvable random addresses (RPA), but currently there is no clean
way to retrieve the correct RPA. So instead of returning an outdated
RPA, just disallow this command when LE privacy is in use.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bb0c53ac4c66..20a7765680df 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6526,13 +6526,26 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 			goto complete;
 		}
 
+		/* This should return the active RPA, but since the RPA
+		 * is only programmed on demand, it is really hard to fill
+		 * this in at the moment. For now disallow retrieving
+		 * local out-of-band data when privacy is in use.
+		 *
+		 * Returning the identity address will not help here since
+		 * pairing happens before the identity resolving key is
+		 * known and thus the connection establishment happens
+		 * based on the RPA and not the identity address.
+		 */
 		if (hci_dev_test_flag(hdev, HCI_PRIVACY)) {
-			memcpy(addr, &hdev->rpa, 6);
-			addr[6] = 0x01;
-		} else if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
-			   !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
-			   (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
-			    bacmp(&hdev->static_addr, BDADDR_ANY))) {
+			hci_dev_unlock(hdev);
+			status = MGMT_STATUS_REJECTED;
+			goto complete;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
+		   !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+		   (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
+		    bacmp(&hdev->static_addr, BDADDR_ANY))) {
 			memcpy(addr, &hdev->static_addr, 6);
 			addr[6] = 0x01;
 		} else {
-- 
2.1.0

