Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Add support for Unconfigured Index Added events
Date: Wed,  2 Jul 2014 21:30:54 +0200
Message-Id: <1404329455-32929-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a controller is in unconfigured state it is currently hidden
from the management interface. This change now announces the new
controller with an Unconfigured Index Added event and allows clients
to easily detect the controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  2 ++
 net/bluetooth/hci_core.c     | 17 ++++++++++-------
 net/bluetooth/hci_sock.c     |  9 +++------
 net/bluetooth/mgmt.c         | 12 +++++++++++-
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5b3e8009eddd..7da29fd748d8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -640,3 +640,5 @@ struct mgmt_ev_new_conn_param {
 	__le16 latency;
 	__le16 timeout;
 } __packed;
+
+#define MGMT_EV_UNCONF_INDEX_ADDED	0x001d
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 395b014ad0e8..df25a8329ecc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2806,14 +2806,18 @@ static void hci_power_on(struct work_struct *work)
 	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags)) {
 		/* For unconfigured devices, set the HCI_RAW flag
 		 * so that userspace can easily identify them.
-		 *
-		 * If the device is fully configured and ready for
-		 * operation, announce it via management interface.
 		 */
 		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
 			set_bit(HCI_RAW, &hdev->flags);
-		else
-			mgmt_index_added(hdev);
+
+		/* For fully configured devices, this will send
+		 * the Index Added event. For unconfigured devices,
+		 * it will send Unconfigued Index Added event.
+		 *
+		 * Devices with HCI_QUIRK_RAW_DEVICE are ignored
+		 * and no event will be send.
+		 */
+		mgmt_index_added(hdev);
 	}
 }
 
@@ -4032,8 +4036,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->power_on);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
-	    !test_bit(HCI_SETUP, &hdev->dev_flags) &&
-	    !test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+	    !test_bit(HCI_SETUP, &hdev->dev_flags)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index db9610323d4d..ba13ad8e25c6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -453,8 +453,7 @@ static int hci_sock_release(struct socket *sock)
 
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-			if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
-				mgmt_index_added(hdev);
+			mgmt_index_added(hdev);
 			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
 			hci_dev_close(hdev->id);
 		}
@@ -706,14 +705,12 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
-		if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
-			mgmt_index_removed(hdev);
+		mgmt_index_removed(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
 			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
-			if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
-				mgmt_index_added(hdev);
+			mgmt_index_added(hdev);
 			hci_dev_put(hdev);
 			goto done;
 		}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1ab98980054c..ab70d5858db9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -118,6 +118,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_DEVICE_ADDED,
 	MGMT_EV_DEVICE_REMOVED,
 	MGMT_EV_NEW_CONN_PARAM,
+	MGMT_EV_UNCONF_INDEX_ADDED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -5373,7 +5374,13 @@ void mgmt_index_added(struct hci_dev *hdev)
 	if (hdev->dev_type != HCI_BREDR)
 		return;
 
-	mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+		return;
+
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+		mgmt_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev, NULL, 0, NULL);
+	else
+		mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
 }
 
 void mgmt_index_removed(struct hci_dev *hdev)
@@ -5383,6 +5390,9 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	if (hdev->dev_type != HCI_BREDR)
 		return;
 
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+		return;
+
 	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 
 	mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
-- 
1.9.3

