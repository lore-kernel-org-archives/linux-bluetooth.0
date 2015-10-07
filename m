Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] Bluetoot: Fix USB endpoint selection for wideband speech
Date: Wed,  7 Oct 2015 16:05:47 +0100
Message-Id: <1444230347-1593-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For SCO connections, btusb driver sets alternate endpoint
setting to 2 by default (17 bytes per USB packet).
When connection is completed and airmode transparent has been negotiated,
alternate setting are not changed to 1 (9 bytes per USB packet).
This results in wrong packets being sent and "robotic" audio.

Notify the driver that endpoint settings must change.

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 drivers/bluetooth/btusb.c | 12 +++++++++++-
 net/bluetooth/hci_event.c |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 247b1062cb9affc67d9e7f7a0234c167f90f4b79..65ce054d0755db9078a0f0813828dbb278ea8f1c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1191,6 +1191,9 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 		data->sco_num = hci_conn_num(hdev, SCO_LINK);
 		schedule_work(&data->work);
 	}
+
+	if (evt == HCI_NOTIFY_VOICE_SETTING)
+		schedule_work(&data->work);
 }
 
 static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
@@ -1255,7 +1258,11 @@ static void btusb_work(struct work_struct *work)
 			set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
 		}
 
-		if (hdev->voice_setting & 0x0020) {
+		if (hdev->voice_setting & BT_VOICE_TRANSPARENT) {
+			static const int alts[3] = { 1, 2, 3 };
+
+			new_alts = alts[data->sco_num - 1];
+		} else if (hdev->voice_setting & 0x0020) {
 			static const int alts[3] = { 2, 4, 5 };
 
 			new_alts = alts[data->sco_num - 1];
@@ -1267,6 +1274,9 @@ static void btusb_work(struct work_struct *work)
 			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 			usb_kill_anchored_urbs(&data->isoc_anchor);
 
+			if (hdev->voice_setting & BT_VOICE_TRANSPARENT)
+				hdev->voice_setting &= ~BT_VOICE_TRANSPARENT;
+
 			/* When isochronous alternate setting needs to be
 			 * changed, because SCO connection has been added
 			 * or removed, a packet fragment may be left in the
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8acec932123ade906192ebbfd2daecee9b51f697..08e77537c6eb69c9727cb41a2ca8429f4d7a4941 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3770,6 +3770,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		break;
 	}
 
+	if (ev->air_mode == SCO_AIRMODE_TRANSP) {
+		hdev->voice_setting |= BT_VOICE_TRANSPARENT;
+		hdev->notify(hdev, HCI_NOTIFY_VOICE_SETTING);
+	}
+
 	hci_connect_cfm(conn, ev->status);
 	if (ev->status)
 		hci_conn_del(conn);
-- 
1.9.3

