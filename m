Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: btusb: Add support for Broadcom LM_DIAG interface
Date: Thu,  8 Oct 2015 20:23:08 +0200
Message-Id: <1444328588-122301-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Broadcom Bluetooth USB devices have a third interface that is
dedicated for LM_DIAG messages. The If#= 2 describes this interface
and it consists of one bulk in and one bulk endpoint.

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#= 38 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=19ff ProdID=0239 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

For all Broadcom based devices with this interface, the driver now
claims it and schedules URBs for it. This allows to capture the
LM_DIAG messages and allows forwarding them via hci_recv_diag into
the diagnostic channel of the Bluetooth subsystem.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 228 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 247b1062cb9a..cd5e6ff161b8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -341,12 +341,14 @@ static const struct usb_device_id blacklist_table[] = {
 #define BTUSB_FIRMWARE_FAILED	8
 #define BTUSB_BOOTING		9
 #define BTUSB_RESET_RESUME	10
+#define BTUSB_DIAG_RUNNING	11
 
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
 	struct usb_interface *intf;
 	struct usb_interface *isoc;
+	struct usb_interface *diag;
 
 	unsigned long flags;
 
@@ -361,6 +363,7 @@ struct btusb_data {
 	struct usb_anchor intr_anchor;
 	struct usb_anchor bulk_anchor;
 	struct usb_anchor isoc_anchor;
+	struct usb_anchor diag_anchor;
 	spinlock_t rxlock;
 
 	struct sk_buff *evt_skb;
@@ -372,6 +375,8 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *bulk_rx_ep;
 	struct usb_endpoint_descriptor *isoc_tx_ep;
 	struct usb_endpoint_descriptor *isoc_rx_ep;
+	struct usb_endpoint_descriptor *diag_tx_ep;
+	struct usb_endpoint_descriptor *diag_rx_ep;
 
 	__u8 cmdreq_type;
 	__u8 cmdreq;
@@ -869,6 +874,92 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	return err;
 }
 
+static void btusb_diag_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (urb->status == 0) {
+		struct sk_buff *skb;
+
+		skb = bt_skb_alloc(urb->actual_length, GFP_ATOMIC);
+		if (skb) {
+			memcpy(skb_put(skb, urb->actual_length),
+			       urb->transfer_buffer, urb->actual_length);
+			hci_recv_diag(hdev, skb);
+		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
+	}
+
+	if (!test_bit(BTUSB_DIAG_RUNNING, &data->flags))
+		return;
+
+	usb_anchor_urb(urb, &data->diag_anchor);
+	usb_mark_last_busy(data->udev);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected */
+		if (err != -EPERM && err != -ENODEV)
+			BT_ERR("%s urb %p failed to resubmit (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static int btusb_submit_diag_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size = HCI_MAX_FRAME_SIZE;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!data->diag_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvbulkpipe(data->udev, data->diag_rx_ep->bEndpointAddress);
+
+	usb_fill_bulk_urb(urb, data->udev, pipe, buf, size,
+			  btusb_diag_complete, hdev);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_mark_last_busy(data->udev);
+	usb_anchor_urb(urb, &data->diag_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BT_ERR("%s urb %p submission failed (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
 static void btusb_tx_complete(struct urb *urb)
 {
 	struct sk_buff *skb = urb->context;
@@ -956,6 +1047,11 @@ static int btusb_open(struct hci_dev *hdev)
 	set_bit(BTUSB_BULK_RUNNING, &data->flags);
 	btusb_submit_bulk_urb(hdev, GFP_KERNEL);
 
+	if (data->diag) {
+		if (!btusb_submit_diag_urb(hdev, GFP_KERNEL))
+			set_bit(BTUSB_DIAG_RUNNING, &data->flags);
+	}
+
 done:
 	usb_autopm_put_interface(data->intf);
 	return 0;
@@ -971,6 +1067,7 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->intr_anchor);
 	usb_kill_anchored_urbs(&data->bulk_anchor);
 	usb_kill_anchored_urbs(&data->isoc_anchor);
+	usb_kill_anchored_urbs(&data->diag_anchor);
 }
 
 static int btusb_close(struct hci_dev *hdev)
@@ -986,6 +1083,7 @@ static int btusb_close(struct hci_dev *hdev)
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
+	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
 
 	btusb_stop_traffic(data);
 	btusb_free_frags(data);
@@ -2547,6 +2645,95 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	return 0;
 }
 
+#ifdef CONFIG_BT_HCIBTUSB_BCM
+static inline int __set_diag_interface(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct usb_interface *intf = data->diag;
+	int i;
+
+	if (!data->diag)
+		return -ENODEV;
+
+	data->diag_tx_ep = NULL;
+	data->diag_rx_ep = NULL;
+
+	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *ep_desc;
+
+		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
+
+		if (!data->diag_tx_ep && usb_endpoint_is_bulk_out(ep_desc)) {
+			data->diag_tx_ep = ep_desc;
+			continue;
+		}
+
+		if (!data->diag_rx_ep && usb_endpoint_is_bulk_in(ep_desc)) {
+			data->diag_rx_ep = ep_desc;
+			continue;
+		}
+	}
+
+	if (!data->diag_tx_ep || !data->diag_rx_ep) {
+		BT_ERR("%s invalid diagnostic descriptors", hdev->name);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct urb *alloc_diag_urb(struct hci_dev *hdev, bool enable)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct sk_buff *skb;
+	struct urb *urb;
+	unsigned int pipe;
+
+	if (!data->diag_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	skb = bt_skb_alloc(2, GFP_KERNEL);
+	if (!skb) {
+		usb_free_urb(urb);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*skb_put(skb, 1) = 0xf0;
+	*skb_put(skb, 1) = enable;
+
+	pipe = usb_sndbulkpipe(data->udev, data->diag_tx_ep->bEndpointAddress);
+
+	usb_fill_bulk_urb(urb, data->udev, pipe,
+			  skb->data, skb->len, btusb_tx_complete, skb);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static int btusb_bcm_set_diag(struct hci_dev *hdev, bool enable)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct urb *urb;
+
+	if (!data->diag)
+		return -ENODEV;
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	urb = alloc_diag_urb(hdev, enable);
+	if (IS_ERR(urb))
+		return PTR_ERR(urb);
+
+	return submit_or_queue_tx_urb(hdev, urb);
+}
+#endif
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -2627,6 +2814,7 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
+	init_usb_anchor(&data->diag_anchor);
 	spin_lock_init(&data->rxlock);
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
@@ -2666,11 +2854,20 @@ static int btusb_probe(struct usb_interface *intf,
 #ifdef CONFIG_BT_HCIBTUSB_BCM
 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
 		hdev->setup = btbcm_setup_patchram;
+		hdev->set_diag = btusb_bcm_set_diag;
 		hdev->set_bdaddr = btbcm_set_bdaddr;
+
+		/* Broadcom LM_DIAG Interface numbers are hardcoded */
+		data->diag = usb_ifnum_to_if(data->udev, 2);
 	}
 
-	if (id->driver_info & BTUSB_BCM_APPLE)
+	if (id->driver_info & BTUSB_BCM_APPLE) {
 		hdev->setup = btbcm_setup_apple;
+		hdev->set_diag = btusb_bcm_set_diag;
+
+		/* Broadcom LM_DIAG Interface numbers are hardcoded */
+		data->diag = usb_ifnum_to_if(data->udev, 2);
+	}
 #endif
 
 	if (id->driver_info & BTUSB_INTEL) {
@@ -2791,6 +2988,16 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
+#ifdef CONFIG_BT_HCIBTUSB_BCM
+	if (data->diag) {
+		if (!usb_driver_claim_interface(&btusb_driver,
+						data->diag, data))
+			__set_diag_interface(hdev);
+		else
+			data->diag = NULL;
+	}
+#endif
+
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
@@ -2818,12 +3025,25 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
 
+	if (data->diag)
+		usb_set_intfdata(data->diag, NULL);
+
 	hci_unregister_dev(hdev);
 
-	if (intf == data->isoc)
+	if (intf == data->intf) {
+		if (data->isoc)
+			usb_driver_release_interface(&btusb_driver, data->isoc);
+		if (data->diag)
+			usb_driver_release_interface(&btusb_driver, data->diag);
+	} else if (intf == data->isoc) {
+		if (data->diag)
+			usb_driver_release_interface(&btusb_driver, data->diag);
 		usb_driver_release_interface(&btusb_driver, data->intf);
-	else if (data->isoc)
-		usb_driver_release_interface(&btusb_driver, data->isoc);
+	} else if (intf == data->diag) {
+		usb_driver_release_interface(&btusb_driver, data->intf);
+		if (data->isoc)
+			usb_driver_release_interface(&btusb_driver, data->isoc);
+	}
 
 	hci_free_dev(hdev);
 }
-- 
2.4.3

