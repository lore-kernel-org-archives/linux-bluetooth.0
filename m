Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sathish Narasimman <nsathish41@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: btusb: hci_event: handle msbc audio over USB Endpoints
Date: Mon, 20 Aug 2018 19:02:00 +0530
Message-Id: <1534771920-4437-2-git-send-email-sathish.narasimman@intel.com>
In-Reply-To: <1534771920-4437-1-git-send-email-sathish.narasimman@intel.com>
References: <1534771920-4437-1-git-send-email-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For msbc encoded audio stream over usb transport, btusb driver
to be set to alternate settings 6 as per BT core spec 5.0. This
done from  hci_sync_conn_complete_evt. The type of air mode is known
during this event. For this reason the btusb is to be notifed
about the TRANSPARENT air mode and the ALT setting 6 is selected.
The changes are made considering some discussion over the similar
patch submitted earlier from Kuba Pawlak(link below)
https://www.spinics.net/lists/linux-bluetooth/msg64577.html

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 drivers/bluetooth/btusb.c   | 95 +++++++++++++++++++++++++--------------------
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   |  5 +++
 3 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cd2e5cf..ae924b6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1390,18 +1390,6 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-
-	BT_DBG("%s evt %d", hdev->name, evt);
-
-	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
-		data->sco_num = hci_conn_num(hdev, SCO_LINK);
-		schedule_work(&data->work);
-	}
-}
-
 static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -1445,6 +1433,58 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 	return 0;
 }
 
+static void bt_switch_alt_setting(struct hci_dev *hdev, int new_alts)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (data->isoc_altsetting != new_alts) {
+		unsigned long flags;
+
+		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+		usb_kill_anchored_urbs(&data->isoc_anchor);
+
+		/* When isochronous alternate setting needs to be
+		 * changed, because SCO connection has been added
+		 * or removed, a packet fragment may be left in the
+		 * reassembling state. This could lead to wrongly
+		 * assembled fragments.
+		 *
+		 * Clear outstanding fragment when selecting a new
+		 * alternate setting.
+		 */
+		spin_lock_irqsave(&data->rxlock, flags);
+		kfree_skb(data->sco_skb);
+		data->sco_skb = NULL;
+		spin_unlock_irqrestore(&data->rxlock, flags);
+
+		if (__set_isoc_interface(hdev, new_alts) < 0)
+			return;
+	}
+	if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
+		if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
+			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+		else
+			btusb_submit_isoc_urb(hdev, GFP_KERNEL);
+	}
+}
+
+static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	BT_DBG("%s evt %d", hdev->name, evt);
+
+	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
+		data->sco_num = hci_conn_num(hdev, SCO_LINK);
+		schedule_work(&data->work);
+	}
+
+	if (evt == HCI_NOTIFY_AIR_MODE_TRANSP) {
+		/* Alt setting 6 is for msbc encoded audio channel */
+		bt_switch_alt_setting(hdev, 6);
+	}
+}
+
 static void btusb_work(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
@@ -1472,36 +1512,7 @@ static void btusb_work(struct work_struct *work)
 			new_alts = data->sco_num;
 		}
 
-		if (data->isoc_altsetting != new_alts) {
-			unsigned long flags;
-
-			clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-			usb_kill_anchored_urbs(&data->isoc_anchor);
-
-			/* When isochronous alternate setting needs to be
-			 * changed, because SCO connection has been added
-			 * or removed, a packet fragment may be left in the
-			 * reassembling state. This could lead to wrongly
-			 * assembled fragments.
-			 *
-			 * Clear outstanding fragment when selecting a new
-			 * alternate setting.
-			 */
-			spin_lock_irqsave(&data->rxlock, flags);
-			kfree_skb(data->sco_skb);
-			data->sco_skb = NULL;
-			spin_unlock_irqrestore(&data->rxlock, flags);
-
-			if (__set_isoc_interface(hdev, new_alts) < 0)
-				return;
-		}
-
-		if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
-			if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
-				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-			else
-				btusb_submit_isoc_urb(hdev, GFP_KERNEL);
-		}
+		bt_switch_alt_setting(hdev, new_alts);
 	} else {
 		clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 		usb_kill_anchored_urbs(&data->isoc_anchor);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cdd9f1f..3498c6b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -52,6 +52,7 @@
 #define HCI_NOTIFY_CONN_ADD		1
 #define HCI_NOTIFY_CONN_DEL		2
 #define HCI_NOTIFY_VOICE_SETTING	3
+#define HCI_NOTIFY_AIR_MODE_TRANSP	4
 
 /* HCI bus types */
 #define HCI_VIRTUAL	0
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f12555f..8ef5220 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4100,6 +4100,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		break;
 	}
 
+	if (ev->air_mode == SCO_AIRMODE_TRANSP) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_AIR_MODE_TRANSP);
+	}
+
 	hci_connect_cfm(conn, ev->status);
 	if (ev->status)
 		hci_conn_del(conn);
-- 
2.7.4
