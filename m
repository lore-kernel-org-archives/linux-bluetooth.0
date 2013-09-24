Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Test for HCI_SETUP and HCI_USER_CHANNEL in mgmt_valid_hdev()
Date: Tue, 24 Sep 2013 17:02:38 +0300
Message-Id: <1380031363-1266-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If either one of the HCI_SETUP or HCI_USER_CHANNEL flags is set the
device is not considered valid for mgmt. By having these checks inside
the mgmt_valid_hdev function the a couple of places using it can be
simplified.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |  4 +---
 net/bluetooth/mgmt.c     | 12 ++++++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3d9f02b..1940147 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1238,9 +1238,7 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
-		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
-		    mgmt_valid_hdev(hdev)) {
+		if (mgmt_valid_hdev(hdev)) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
 			hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3070e77..5319a94 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -183,6 +183,12 @@ static u8 mgmt_status_table[] = {
 
 bool mgmt_valid_hdev(struct hci_dev *hdev)
 {
+	if (test_bit(HCI_SETUP, &hdev->dev_flags))
+		return false;
+
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
+		return false;
+
 	return hdev->dev_type == HCI_BREDR;
 }
 
@@ -336,12 +342,6 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_bit(HCI_SETUP, &d->dev_flags))
-			continue;
-
-		if (test_bit(HCI_USER_CHANNEL, &d->dev_flags))
-			continue;
-
 		if (!mgmt_valid_hdev(d))
 			continue;
 
-- 
1.8.4.rc3

