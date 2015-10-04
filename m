Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Move HCI_RUNNING check into hci_send_frame
Date: Sun,  4 Oct 2015 23:34:01 +0200
Message-Id: <1443994443-123453-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In all callbacks for hdev->send the status of HCI_RUNNING is checked. So
instead of repeating that code in every driver, move the check into the
hci_send_frame function before calling hdev->send.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c       | 3 ---
 drivers/bluetooth/bpa10x.c      | 3 ---
 drivers/bluetooth/btmrvl_main.c | 7 -------
 drivers/bluetooth/btsdio.c      | 3 ---
 drivers/bluetooth/btusb.c       | 6 ------
 drivers/bluetooth/btwilink.c    | 3 ---
 drivers/bluetooth/hci_ldisc.c   | 3 ---
 drivers/bluetooth/hci_vhci.c    | 3 ---
 net/bluetooth/hci_core.c        | 5 +++++
 9 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index a5c4d0584389..3ba8170d08d3 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -479,9 +479,6 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("hdev %p skb %p type %d len %d", hdev, skb, bt_cb(skb)->pkt_type, skb->len);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 8a319913c9a9..59b892464be5 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -360,9 +360,6 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	skb->dev = (void *) hdev;
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 050ad6ba1981..39552a8e9cc7 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -436,13 +436,6 @@ static int btmrvl_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("type=%d, len=%d", skb->pkt_type, skb->len);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
-		BT_ERR("Failed testing HCI_RUNING, flags=%lx", hdev->flags);
-		print_hex_dump_bytes("data: ", DUMP_PREFIX_OFFSET,
-							skb->data, skb->len);
-		return -EBUSY;
-	}
-
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 83f6437dd91d..21f99cc8c669 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -261,9 +261,6 @@ static int btsdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dfaaea2efecb..9cf3796f92aa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1156,9 +1156,6 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		urb = alloc_ctrl_urb(hdev, skb);
@@ -1843,9 +1840,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 7a722df97343..4db99a44f671 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -256,9 +256,6 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct ti_st *hst;
 	long len;
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	hst = hci_get_drvdata(hdev);
 
 	/* Prepend skb with frame type */
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ad66c690d272..443feaebe275 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -254,9 +254,6 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
 	hu->proto->enqueue(hu, skb);
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 78653db2ef2b..15c344c9a00d 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -85,9 +85,6 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -EBUSY;
-
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
 	skb_queue_tail(&data->readq, skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5af33c87cbba..b955f7192651 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3536,6 +3536,11 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Get rid of skb owner, prior to sending to the driver. */
 	skb_orphan(skb);
 
+	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	err = hdev->send(hdev, skb);
 	if (err < 0) {
 		BT_ERR("%s sending frame failed (%d)", hdev->name, err);
-- 
2.4.3

