Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Use hci_conn_num() instead of direct connection hash access
Date: Thu, 10 Oct 2013 09:47:55 -0700
Message-Id: <1381423675-2207-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When changing the alternate setting for the ISOC endpoints, use the
hci_conn_num() helper function to count currently established SCO
and eSCO connections and store the the value. This avoids direct
access to the connection hash.

In addition use the stored value instead accessing the connection
hash over and over again.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f3dfc0a..faa429f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -774,7 +774,7 @@ static int btusb_send_frame(struct sk_buff *skb)
 		break;
 
 	case HCI_SCODATA_PKT:
-		if (!data->isoc_tx_ep || hdev->conn_hash.sco_num < 1)
+		if (!data->isoc_tx_ep || hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_ATOMIC);
@@ -833,8 +833,8 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 	BT_DBG("%s evt %d", hdev->name, evt);
 
-	if (hdev->conn_hash.sco_num != data->sco_num) {
-		data->sco_num = hdev->conn_hash.sco_num;
+	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
+		data->sco_num = hci_conn_num(hdev, SCO_LINK);
 		schedule_work(&data->work);
 	}
 }
@@ -889,7 +889,7 @@ static void btusb_work(struct work_struct *work)
 	int new_alts;
 	int err;
 
-	if (hdev->conn_hash.sco_num > 0) {
+	if (data->sco_num > 0) {
 		if (!test_bit(BTUSB_DID_ISO_RESUME, &data->flags)) {
 			err = usb_autopm_get_interface(data->isoc ? data->isoc : data->intf);
 			if (err < 0) {
@@ -903,9 +903,9 @@ static void btusb_work(struct work_struct *work)
 
 		if (hdev->voice_setting & 0x0020) {
 			static const int alts[3] = { 2, 4, 5 };
-			new_alts = alts[hdev->conn_hash.sco_num - 1];
+			new_alts = alts[data->sco_num - 1];
 		} else {
-			new_alts = hdev->conn_hash.sco_num;
+			new_alts = data->sco_num;
 		}
 
 		if (data->isoc_altsetting != new_alts) {
-- 
1.8.3.1

