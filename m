Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix old coding style issues
Date: Tue, 16 Sep 2014 04:44:50 +0200
Message-Id: <1410835490-61265-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The btusb driver has been around for a while now and it is time to
bring its coding style in sync with what has been done for the
Bluetooth subsytem and other drivers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 114 +++++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c89b330cfa9e..cf07fef65fd5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -302,8 +302,8 @@ static void btusb_intr_complete(struct urb *urb)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
 
-	BT_DBG("%s urb %p status %d count %d", hdev->name,
-					urb, urb->status, urb->actual_length);
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return;
@@ -312,8 +312,8 @@ static void btusb_intr_complete(struct urb *urb)
 		hdev->stat.byte_rx += urb->actual_length;
 
 		if (hci_recv_fragment(hdev, HCI_EVENT_PKT,
-						urb->transfer_buffer,
-						urb->actual_length) < 0) {
+				      urb->transfer_buffer,
+				      urb->actual_length) < 0) {
 			BT_ERR("%s corrupted event packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
@@ -334,7 +334,7 @@ static void btusb_intr_complete(struct urb *urb)
 		 * -ENODEV: device got disconnected */
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p failed to resubmit (%d)",
-						hdev->name, urb, -err);
+			       hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
 }
@@ -367,8 +367,7 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	pipe = usb_rcvintpipe(data->udev, data->intr_ep->bEndpointAddress);
 
 	usb_fill_int_urb(urb, data->udev, pipe, buf, size,
-						btusb_intr_complete, hdev,
-						data->intr_ep->bInterval);
+			 btusb_intr_complete, hdev, data->intr_ep->bInterval);
 
 	urb->transfer_flags |= URB_FREE_BUFFER;
 
@@ -378,7 +377,7 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (err < 0) {
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p submission failed (%d)",
-						hdev->name, urb, -err);
+			       hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
 
@@ -393,8 +392,8 @@ static void btusb_bulk_complete(struct urb *urb)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	int err;
 
-	BT_DBG("%s urb %p status %d count %d", hdev->name,
-					urb, urb->status, urb->actual_length);
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return;
@@ -403,8 +402,8 @@ static void btusb_bulk_complete(struct urb *urb)
 		hdev->stat.byte_rx += urb->actual_length;
 
 		if (hci_recv_fragment(hdev, HCI_ACLDATA_PKT,
-						urb->transfer_buffer,
-						urb->actual_length) < 0) {
+				      urb->transfer_buffer,
+				      urb->actual_length) < 0) {
 			BT_ERR("%s corrupted ACL packet", hdev->name);
 			hdev->stat.err_rx++;
 		}
@@ -425,7 +424,7 @@ static void btusb_bulk_complete(struct urb *urb)
 		 * -ENODEV: device got disconnected */
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p failed to resubmit (%d)",
-						hdev->name, urb, -err);
+			       hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
 }
@@ -455,8 +454,8 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 
 	pipe = usb_rcvbulkpipe(data->udev, data->bulk_rx_ep->bEndpointAddress);
 
-	usb_fill_bulk_urb(urb, data->udev, pipe,
-					buf, size, btusb_bulk_complete, hdev);
+	usb_fill_bulk_urb(urb, data->udev, pipe, buf, size,
+			  btusb_bulk_complete, hdev);
 
 	urb->transfer_flags |= URB_FREE_BUFFER;
 
@@ -467,7 +466,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (err < 0) {
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p submission failed (%d)",
-						hdev->name, urb, -err);
+			       hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
 
@@ -482,8 +481,8 @@ static void btusb_isoc_complete(struct urb *urb)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	int i, err;
 
-	BT_DBG("%s urb %p status %d count %d", hdev->name,
-					urb, urb->status, urb->actual_length);
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return;
@@ -499,8 +498,8 @@ static void btusb_isoc_complete(struct urb *urb)
 			hdev->stat.byte_rx += length;
 
 			if (hci_recv_fragment(hdev, HCI_SCODATA_PKT,
-						urb->transfer_buffer + offset,
-								length) < 0) {
+					      urb->transfer_buffer + offset,
+					      length) < 0) {
 				BT_ERR("%s corrupted SCO packet", hdev->name);
 				hdev->stat.err_rx++;
 			}
@@ -521,7 +520,7 @@ static void btusb_isoc_complete(struct urb *urb)
 		 * -ENODEV: device got disconnected */
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p failed to resubmit (%d)",
-						hdev->name, urb, -err);
+			       hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
 }
@@ -576,12 +575,12 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	pipe = usb_rcvisocpipe(data->udev, data->isoc_rx_ep->bEndpointAddress);
 
 	usb_fill_int_urb(urb, data->udev, pipe, buf, size, btusb_isoc_complete,
-				hdev, data->isoc_rx_ep->bInterval);
+			 hdev, data->isoc_rx_ep->bInterval);
 
-	urb->transfer_flags  = URB_FREE_BUFFER | URB_ISO_ASAP;
+	urb->transfer_flags = URB_FREE_BUFFER | URB_ISO_ASAP;
 
 	__fill_isoc_descriptor(urb, size,
-			le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize));
+			       le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize));
 
 	usb_anchor_urb(urb, &data->isoc_anchor);
 
@@ -589,7 +588,7 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (err < 0) {
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p submission failed (%d)",
-						hdev->name, urb, -err);
+			       hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
 
@@ -601,11 +600,11 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
 static void btusb_tx_complete(struct urb *urb)
 {
 	struct sk_buff *skb = urb->context;
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
+	struct hci_dev *hdev = (struct hci_dev *)skb->dev;
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
-	BT_DBG("%s urb %p status %d count %d", hdev->name,
-					urb, urb->status, urb->actual_length);
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		goto done;
@@ -628,10 +627,10 @@ done:
 static void btusb_isoc_tx_complete(struct urb *urb)
 {
 	struct sk_buff *skb = urb->context;
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
+	struct hci_dev *hdev = (struct hci_dev *)skb->dev;
 
-	BT_DBG("%s urb %p status %d count %d", hdev->name,
-					urb, urb->status, urb->actual_length);
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		goto done;
@@ -763,10 +762,10 @@ static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
 
 	pipe = usb_sndctrlpipe(data->udev, 0x00);
 
-	usb_fill_control_urb(urb, data->udev, pipe, (void *) dr,
+	usb_fill_control_urb(urb, data->udev, pipe, (void *)dr,
 			     skb->data, skb->len, btusb_tx_complete, skb);
 
-	skb->dev = (void *) hdev;
+	skb->dev = (void *)hdev;
 
 	return urb;
 }
@@ -789,7 +788,7 @@ static struct urb *alloc_bulk_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	usb_fill_bulk_urb(urb, data->udev, pipe,
 			  skb->data, skb->len, btusb_tx_complete, skb);
 
-	skb->dev = (void *) hdev;
+	skb->dev = (void *)hdev;
 
 	return urb;
 }
@@ -818,7 +817,7 @@ static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
 	__fill_isoc_descriptor(urb, skb->len,
 			       le16_to_cpu(data->isoc_tx_ep->wMaxPacketSize));
 
-	skb->dev = (void *) hdev;
+	skb->dev = (void *)hdev;
 
 	return urb;
 }
@@ -834,7 +833,7 @@ static int submit_tx_urb(struct hci_dev *hdev, struct urb *urb)
 	if (err < 0) {
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p submission failed (%d)",
-						hdev->name, urb, -err);
+			       hdev->name, urb, -err);
 		kfree(urb->setup_packet);
 		usb_unanchor_urb(urb);
 	} else {
@@ -984,6 +983,7 @@ static void btusb_work(struct work_struct *work)
 
 		if (hdev->voice_setting & 0x0020) {
 			static const int alts[3] = { 2, 4, 5 };
+
 			new_alts = alts[data->sco_num - 1];
 		} else {
 			new_alts = data->sco_num;
@@ -1056,7 +1056,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		return -PTR_ERR(skb);
 	}
 
-	rp = (struct hci_rp_read_local_version *) skb->data;
+	rp = (struct hci_rp_read_local_version *)skb->data;
 
 	if (!rp->status) {
 		if (le16_to_cpu(rp->manufacturer) != 10) {
@@ -1094,7 +1094,7 @@ struct intel_version {
 } __packed;
 
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						struct intel_version *ver)
+						       struct intel_version *ver)
 {
 	const struct firmware *fw;
 	char fwname[64];
@@ -1270,7 +1270,7 @@ static int btusb_check_bdaddr_intel(struct hci_dev *hdev)
 		return -EIO;
 	}
 
-	rp = (struct hci_rp_read_bd_addr *) skb->data;
+	rp = (struct hci_rp_read_bd_addr *)skb->data;
 	if (rp->status) {
 		BT_ERR("%s Intel device address result failed (%02x)",
 		       hdev->name, rp->status);
@@ -1400,6 +1400,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 
 	if (skb->data[0]) {
 		u8 evt_status = skb->data[0];
+
 		BT_ERR("%s enable Intel manufacturer mode event failed (%02x)",
 		       hdev->name, evt_status);
 		kfree_skb(skb);
@@ -1509,7 +1510,7 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: changing Intel device address failed (%ld)",
-			hdev->name, ret);
+		       hdev->name, ret);
 		return ret;
 	}
 	kfree_skb(skb);
@@ -1584,19 +1585,19 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
-			hdev->name, ret);
+		       hdev->name, ret);
 		goto done;
 	}
 
 	if (skb->len != sizeof(*ver)) {
 		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
-			hdev->name);
+		       hdev->name);
 		kfree_skb(skb);
 		ret = -EIO;
 		goto done;
 	}
 
-	ver = (struct hci_rp_read_local_version *) skb->data;
+	ver = (struct hci_rp_read_local_version *)skb->data;
 	BT_INFO("%s: BCM: patching hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
 		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
 		ver->lmp_ver, ver->lmp_subver);
@@ -1607,7 +1608,7 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: BCM: Download Minidrv command failed (%ld)",
-			hdev->name, ret);
+		       hdev->name, ret);
 		goto reset_fw;
 	}
 	kfree_skb(skb);
@@ -1619,13 +1620,13 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	fw_size = fw->size;
 
 	while (fw_size >= sizeof(*cmd)) {
-		cmd = (struct hci_command_hdr *) fw_ptr;
+		cmd = (struct hci_command_hdr *)fw_ptr;
 		fw_ptr += sizeof(*cmd);
 		fw_size -= sizeof(*cmd);
 
 		if (fw_size < cmd->plen) {
 			BT_ERR("%s: BCM: patch %s is corrupted",
-				hdev->name, fw_name);
+			       hdev->name, fw_name);
 			ret = -EINVAL;
 			goto reset_fw;
 		}
@@ -1641,7 +1642,7 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 		if (IS_ERR(skb)) {
 			ret = PTR_ERR(skb);
 			BT_ERR("%s: BCM: patch command %04x failed (%ld)",
-				hdev->name, opcode, ret);
+			       hdev->name, opcode, ret);
 			goto reset_fw;
 		}
 		kfree_skb(skb);
@@ -1666,19 +1667,19 @@ reset_fw:
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
-			hdev->name, ret);
+		       hdev->name, ret);
 		goto done;
 	}
 
 	if (skb->len != sizeof(*ver)) {
 		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
-			hdev->name);
+		       hdev->name);
 		kfree_skb(skb);
 		ret = -EIO;
 		goto done;
 	}
 
-	ver = (struct hci_rp_read_local_version *) skb->data;
+	ver = (struct hci_rp_read_local_version *)skb->data;
 	BT_INFO("%s: BCM: firmware hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
 		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
 		ver->lmp_ver, ver->lmp_subver);
@@ -1690,19 +1691,19 @@ reset_fw:
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: HCI_OP_READ_BD_ADDR failed (%ld)",
-			hdev->name, ret);
+		       hdev->name, ret);
 		goto done;
 	}
 
 	if (skb->len != sizeof(*bda)) {
 		BT_ERR("%s: HCI_OP_READ_BD_ADDR event length mismatch",
-			hdev->name);
+		       hdev->name);
 		kfree_skb(skb);
 		ret = -EIO;
 		goto done;
 	}
 
-	bda = (struct hci_rp_read_bd_addr *) skb->data;
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
 	if (bda->status) {
 		BT_ERR("%s: HCI_OP_READ_BD_ADDR error status (%02x)",
 		       hdev->name, bda->status);
@@ -1737,7 +1738,7 @@ static int btusb_set_bdaddr_bcm(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: BCM: Change address command failed (%ld)",
-			hdev->name, ret);
+		       hdev->name, ret);
 		return ret;
 	}
 	kfree_skb(skb);
@@ -1746,7 +1747,7 @@ static int btusb_set_bdaddr_bcm(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 
 static int btusb_probe(struct usb_interface *intf,
-				const struct usb_device_id *id)
+		       const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *ep_desc;
 	struct btusb_data *data;
@@ -1761,6 +1762,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
+
 		match = usb_match_id(intf, blacklist_table);
 		if (match)
 			id = match;
@@ -1911,7 +1913,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
-							data->isoc, data);
+						 data->isoc, data);
 		if (err < 0) {
 			hci_free_dev(hdev);
 			return err;
-- 
1.9.3

