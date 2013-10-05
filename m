Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add public mgmt function to send New Settings event
Date: Sat,  5 Oct 2013 12:01:05 +0200
Message-Id: <1380967266-28782-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
References: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

A function is needed so that the HCI event processing can ask the mgmt
code to emit a new settings event. This is necessary e.g. when the event
processing does updates to mgmt related states without any dependency of
actual mgmt commands.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/mgmt.c             | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e09c305..079c5c5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1123,6 +1123,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(struct hci_dev *hdev);
 int mgmt_index_removed(struct hci_dev *hdev);
+int mgmt_new_settings(struct hci_dev *hdev);
 int mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7e43d37..6e808d1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -890,6 +890,11 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
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
1.8.3.1

