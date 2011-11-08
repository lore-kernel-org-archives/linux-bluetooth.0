Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix cancel_delayed_work_sync usage with locks
Date: Wed,  9 Nov 2011 01:44:22 +0200
Message-Id: <1320795862-18741-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The cancel_delayed_work_sync function should not be used if we hold any
locks. Luckily all places where this is the case it is also safe to use
the non-sync version.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    6 +++---
 net/bluetooth/mgmt.c     |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f87bf24..fb3feeb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -599,12 +599,12 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	tasklet_kill(&hdev->tx_task);
 
 	if (hdev->discov_timeout > 0) {
-		cancel_delayed_work_sync(&hdev->discov_off);
+		cancel_delayed_work(&hdev->discov_off);
 		hdev->discov_timeout = 0;
 	}
 
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
-		cancel_delayed_work_sync(&hdev->power_off);
+		cancel_delayed_work(&hdev->power_off);
 
 	hci_dev_lock_bh(hdev);
 	inquiry_cache_flush(hdev);
@@ -828,7 +828,7 @@ int hci_get_dev_list(void __user *arg)
 	read_lock_bh(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
 		if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
-			cancel_delayed_work_sync(&hdev->power_off);
+			cancel_delayed_work(&hdev->power_off);
 
 		if (!test_bit(HCI_MGMT, &hdev->flags))
 			set_bit(HCI_PAIRABLE, &hdev->flags);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index be4c3d0..263fa27 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -149,7 +149,7 @@ static int read_index_list(struct sock *sk)
 	i = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (test_and_clear_bit(HCI_AUTO_OFF, &d->flags))
-			cancel_delayed_work_sync(&d->power_off);
+			cancel_delayed_work(&d->power_off);
 
 		if (test_bit(HCI_SETUP, &d->flags))
 			continue;
@@ -398,7 +398,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 	if (cp->val)
 		scan |= SCAN_INQUIRY;
 	else
-		cancel_delayed_work_sync(&hdev->discov_off);
+		cancel_delayed_work(&hdev->discov_off);
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	if (err < 0)
-- 
1.7.7.1

