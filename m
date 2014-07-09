Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix setting HCI_CONNECTABLE from ioctl code
Date: Wed,  9 Jul 2014 13:28:26 +0300
Message-Id: <1404901706-19308-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the white list is in use the code would not update the
HCI_CONNECTABLE flag if it gets changed through the ioctl code (e.g.
hciconfig hci0 pscan). Since the flag is important for properly
accepting incoming connections add code to fix it up if necessary and
emit a New Settings mgmt event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 17 +++++++++++++++++
 net/bluetooth/mgmt.c             |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cba4837dcaa5..e69c2b08c0c6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1281,6 +1281,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
+int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 728a6ee471ea..84431b86af96 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2715,6 +2715,23 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	case HCISETSCAN:
 		err = hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
 				   HCI_INIT_TIMEOUT);
+
+		/* Ensure that the connectable state gets correctly
+		 * notified if the whitelist is in use.
+		 */
+		if (!err && !list_empty(&hdev->whitelist)) {
+			bool changed;
+
+			if ((dr.dev_opt & SCAN_PAGE))
+				changed = !test_and_set_bit(HCI_CONNECTABLE,
+							    &hdev->dev_flags);
+			else
+				changed = test_and_set_bit(HCI_CONNECTABLE,
+							   &hdev->dev_flags);
+
+			if (changed)
+				mgmt_new_settings(hdev);
+		}
 		break;
 
 	case HCISETLINKPOL:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 98392d61b78f..91b1f92c681e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1427,6 +1427,11 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
 	return mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), skip);
 }
 
+int mgmt_new_settings(struct hci_dev *hdev)
+{
+	return new_settings(hdev, NULL);
+}
+
 struct cmd_lookup {
 	struct sock *sk;
 	struct hci_dev *hdev;
-- 
1.9.3

