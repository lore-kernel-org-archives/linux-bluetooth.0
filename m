Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Use lmp_le_capable where applicable
Date: Tue, 24 Jul 2012 15:03:47 -0300
Message-Id: <1343153033-898-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_LE bit checking by the helper macro
lmp_le_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 4 ++--
 net/bluetooth/mgmt.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41ff978..498d55e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -541,7 +541,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 					 * Features Notification */
 	}
 
-	if (hdev->features[4] & LMP_LE)
+	if (lmp_le_capable(hdev))
 		events[7] |= 0x20;	/* LE Meta-Event */
 
 	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
@@ -746,7 +746,7 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 		break;
 	}
 
-	if (test_bit(HCI_INIT, &hdev->flags) && hdev->features[4] & LMP_LE)
+	if (test_bit(HCI_INIT, &hdev->flags) && lmp_le_capable(hdev))
 		hci_set_le_support(hdev);
 
 done:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 990ec6a..0351bf27 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -391,7 +391,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (enable_hs)
 		settings |= MGMT_SETTING_HS;
 
-	if (hdev->features[4] & LMP_LE)
+	if (lmp_le_capable(hdev))
 		settings |= MGMT_SETTING_LE;
 
 	return settings;
@@ -1205,7 +1205,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!(hdev->features[4] & LMP_LE)) {
+	if (!lmp_le_capable(hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				 MGMT_STATUS_NOT_SUPPORTED);
 		goto unlock;
-- 
1.7.11.2

