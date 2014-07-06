Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Run controller setup after external configuration
Date: Sun,  6 Jul 2014 12:11:14 +0200
Message-Id: <1404641476-24971-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the external configuration triggers the switch to a configured
controller, it means the setup needs to be run. Controllers that start
out unconfigured have only run limited set of HCI commands. This is
not enough for complete operation and thus run the setup procedure
before announcing the new controller index.

This introduces HCI_CONFIG flag as companion to HCI_SETUP flag. The
HCI_SETUP flag is only used once for the initial setup procedure. And
during that procedure hdev->setup driver callback is called. With the
new HCI_CONFIG the switch from unconfigured to configured state is
triggering the same setup procedure just without hdev->setup. This
is required since bringing a controller back to unconfigured state
from configured state is possible.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 17 ++++++++++++++---
 net/bluetooth/hci_sock.c    |  3 ++-
 net/bluetooth/mgmt.c        | 14 ++++++++++++--
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 80c5fc947fbc..46f2458e4bc9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -163,6 +163,7 @@ enum {
  */
 enum {
 	HCI_SETUP,
+	HCI_CONFIG,
 	HCI_AUTO_OFF,
 	HCI_RFKILLED,
 	HCI_MGMT,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f996e2c4815c..538716587a29 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2232,7 +2232,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		goto done;
 	}
 
-	if (!test_bit(HCI_SETUP, &hdev->dev_flags)) {
+	if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+	    !test_bit(HCI_CONFIG, &hdev->dev_flags)) {
 		/* Check for rfkill but allow the HCI setup stage to
 		 * proceed (which in itself doesn't cause any RF activity).
 		 */
@@ -2326,6 +2327,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+		    !test_bit(HCI_CONFIG, &hdev->dev_flags) &&
 		    !test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
 		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
 		    hdev->dev_type == HCI_BREDR) {
@@ -2824,7 +2826,8 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 
 	if (blocked) {
 		set_bit(HCI_RFKILLED, &hdev->dev_flags);
-		if (!test_bit(HCI_SETUP, &hdev->dev_flags))
+		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+		    !test_bit(HCI_CONFIG, &hdev->dev_flags))
 			hci_dev_do_close(hdev);
 	} else {
 		clear_bit(HCI_RFKILLED, &hdev->dev_flags);
@@ -2881,6 +2884,12 @@ static void hci_power_on(struct work_struct *work)
 		 * and no event will be send.
 		 */
 		mgmt_index_added(hdev);
+	} else if (test_and_clear_bit(HCI_CONFIG, &hdev->dev_flags)) {
+		/* Powering on the controller with HCI_CONFIG set only
+		 * happens with the transition from unconfigured to
+		 * configured. This will send the Index Added event.
+		 */
+		mgmt_index_added(hdev);
 	}
 }
 
@@ -4063,7 +4072,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->power_on);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
-	    !test_bit(HCI_SETUP, &hdev->dev_flags)) {
+	    !test_bit(HCI_SETUP, &hdev->dev_flags) &&
+	    !test_bit(HCI_CONFIG, &hdev->dev_flags)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
@@ -5388,6 +5398,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	if (!test_bit(HCI_UP, &hdev->flags) ||
 	    test_bit(HCI_INIT, &hdev->flags) ||
 	    test_bit(HCI_SETUP, &hdev->dev_flags) ||
+	    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
 	    test_bit(HCI_AUTO_OFF, &hdev->dev_flags) ||
 	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
 		return;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ba13ad8e25c6..802665751cc4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -693,7 +693,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 		if (test_bit(HCI_UP, &hdev->flags) ||
 		    test_bit(HCI_INIT, &hdev->flags) ||
-		    test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		    test_bit(HCI_SETUP, &hdev->dev_flags) ||
+		    test_bit(HCI_CONFIG, &hdev->dev_flags)) {
 			err = -EBUSY;
 			hci_dev_put(hdev);
 			goto done;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f514eb15e0fb..9721f428640e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -385,6 +385,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (test_bit(HCI_SETUP, &d->dev_flags) ||
+		    test_bit(HCI_CONFIG, &d->dev_flags) ||
 		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
 			continue;
 
@@ -444,6 +445,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (test_bit(HCI_SETUP, &d->dev_flags) ||
+		    test_bit(HCI_CONFIG, &d->dev_flags) ||
 		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
 			continue;
 
@@ -5428,8 +5430,15 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 
 	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) == is_configured(hdev)) {
 		mgmt_index_removed(hdev);
-		change_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
-		mgmt_index_added(hdev);
+
+		if (test_and_change_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+			set_bit(HCI_CONFIG, &hdev->dev_flags);
+			set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+
+			queue_work(hdev->req_workqueue, &hdev->power_on);
+		} else {
+			mgmt_index_added(hdev);
+		}
 	}
 
 unlock:
@@ -5545,6 +5554,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		}
 
 		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
+		    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
 		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
-- 
1.9.3

