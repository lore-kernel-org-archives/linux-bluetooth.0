Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Set Simultaneous LE and BR/EDR controller option to zero
Date: Thu, 24 Jul 2014 20:04:16 +0200
Message-Id: <1406225056-16491-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the Bluetooth 4.1 specification the Simultaneous LE and BR/EDR
controller option has been deprecated. It shall be set to zero and
ignored otherwise.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 net/bluetooth/mgmt.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2e2961a3cf6f..a85f2ae98393 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1567,7 +1567,7 @@ static void hci_set_le_support(struct hci_request *req)
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 		cp.le = 0x01;
-		cp.simul = lmp_le_br_capable(hdev);
+		cp.simul = 0x00;
 	}
 
 	if (cp.le != lmp_host_le_capable(hdev))
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccc4653ce658..b5027804a3ca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2264,7 +2264,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	if (val) {
 		hci_cp.le = val;
-		hci_cp.simul = lmp_le_br_capable(hdev);
+		hci_cp.simul = 0x00;
 	} else {
 		if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
 			disable_advertising(&req);
@@ -5925,8 +5925,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 	    lmp_bredr_capable(hdev)) {
 		struct hci_cp_write_le_host_supported cp;
 
-		cp.le = 1;
-		cp.simul = lmp_le_br_capable(hdev);
+		cp.le = 0x01;
+		cp.simul = 0x00;
 
 		/* Check first if we already have the right
 		 * host state (host features set)
-- 
1.9.3

