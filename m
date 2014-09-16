Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Split fragement receiption into separate functions
Date: Tue, 16 Sep 2014 05:33:33 +0200
Message-Id: <1410838413-16122-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The actual packet reassembly should be done inside the driver. To allow
this to happen cleany in future patches, split the fragement receiption
into its own functions.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cf07fef65fd5..df585ab064fa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -296,6 +296,21 @@ struct btusb_data {
 	int suspend_count;
 };
 
+static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
+{
+	return hci_recv_fragment(data->hdev, HCI_EVENT_PKT, buffer, count);
+}
+
+static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
+{
+	return hci_recv_fragment(data->hdev, HCI_ACLDATA_PKT, buffer, count);
+}
+
+static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
+{
+	return hci_recv_fragment(data->hdev, HCI_SCODATA_PKT, buffer, count);
+}
+
 static void btusb_intr_complete(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
@@ -311,9 +326,8 @@ static void btusb_intr_complete(struct urb *urb)
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (hci_recv_fragment(hdev, HCI_EVENT_PKT,
-				      urb->transfer_buffer,
-				      urb->actual_length) < 0) {
+		if (btusb_recv_intr(data, urb->transfer_buffer,
+				    urb->actual_length) < 0) {
 			BT_ERR("%s corrupted event packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
@@ -401,9 +415,8 @@ static void btusb_bulk_complete(struct urb *urb)
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (hci_recv_fragment(hdev, HCI_ACLDATA_PKT,
-				      urb->transfer_buffer,
-				      urb->actual_length) < 0) {
+		if (btusb_recv_bulk(data, urb->transfer_buffer,
+				    urb->actual_length) < 0) {
 			BT_ERR("%s corrupted ACL packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
@@ -497,9 +510,8 @@ static void btusb_isoc_complete(struct urb *urb)
 
 			hdev->stat.byte_rx += length;
 
-			if (hci_recv_fragment(hdev, HCI_SCODATA_PKT,
-					      urb->transfer_buffer + offset,
-					      length) < 0) {
+			if (btusb_recv_isoc(data, urb->transfer_buffer + offset,
+					    length) < 0) {
 				BT_ERR("%s corrupted SCO packet", hdev->name);
 				hdev->stat.err_rx++;
 			}
-- 
1.9.3

