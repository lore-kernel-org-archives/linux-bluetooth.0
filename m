Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Rename HCI_BREDR into HCI_PRIMARY
Date: Tue,  5 Jul 2016 14:30:14 +0200
Message-Id: <1467721814-117020-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI_BREDR naming is confusing since it actually stands for Primary
Bluetooth Controller. Which is a term that has been used in the latest
standard. However from a legacy point of view there only really have
been Basic Rate (BR) and Enhanced Data Rate (EDR). Recent versions of
Bluetooth introduced Low Energy (LE) and made this terminology a little
bit confused since Dual Mode Controllers include BR/EDR and LE. To
simplify this the name HCI_PRIMARY stands for the Primary Controller
which can be a single mode or dual mode controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btmrvl_main.c |  2 +-
 drivers/bluetooth/btsdio.c      |  2 +-
 drivers/bluetooth/btusb.c       |  2 +-
 drivers/bluetooth/hci_ldisc.c   |  2 +-
 drivers/bluetooth/hci_vhci.c    |  6 +++---
 include/net/bluetooth/hci.h     |  2 +-
 net/bluetooth/hci_conn.c        |  2 +-
 net/bluetooth/hci_core.c        | 28 +++++++++++++---------------
 net/bluetooth/hci_event.c       |  2 +-
 net/bluetooth/hci_sock.c        |  2 +-
 net/bluetooth/l2cap_core.c      |  2 +-
 net/bluetooth/mgmt.c            | 16 ++++++++--------
 12 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 7ad8d61c0c61..e6a85f0e6309 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -138,7 +138,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 			if (event->length > 3 && event->data[3])
 				priv->btmrvl_dev.dev_type = HCI_AMP;
 			else
-				priv->btmrvl_dev.dev_type = HCI_BREDR;
+				priv->btmrvl_dev.dev_type = HCI_PRIMARY;
 
 			BT_DBG("dev_type: %d", priv->btmrvl_dev.dev_type);
 		} else if (priv->btmrvl_dev.sendcmdflag &&
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 2b05661e3818..1cb958e199eb 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -311,7 +311,7 @@ static int btsdio_probe(struct sdio_func *func,
 	if (id->class == SDIO_CLASS_BT_AMP)
 		hdev->dev_type = HCI_AMP;
 	else
-		hdev->dev_type = HCI_BREDR;
+		hdev->dev_type = HCI_PRIMARY;
 
 	data->hdev = hdev;
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 880bb5546b25..f2e8fd701bf6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2832,7 +2832,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_AMP)
 		hdev->dev_type = HCI_AMP;
 	else
-		hdev->dev_type = HCI_BREDR;
+		hdev->dev_type = HCI_PRIMARY;
 
 	data->hdev = hdev;
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 49b3e1e2d236..dda97398c59a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -609,7 +609,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
 		hdev->dev_type = HCI_AMP;
 	else
-		hdev->dev_type = HCI_BREDR;
+		hdev->dev_type = HCI_PRIMARY;
 
 	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return 0;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index aba31210c802..3ff229b2e7f3 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -97,10 +97,10 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (data->hdev)
 		return -EBADFD;
 
-	/* bits 0-1 are dev_type (BR/EDR or AMP) */
+	/* bits 0-1 are dev_type (Primary or AMP) */
 	dev_type = opcode & 0x03;
 
-	if (dev_type != HCI_BREDR && dev_type != HCI_AMP)
+	if (dev_type != HCI_PRIMARY && dev_type != HCI_AMP)
 		return -EINVAL;
 
 	/* bits 2-5 are reserved (must be zero) */
@@ -316,7 +316,7 @@ static void vhci_open_timeout(struct work_struct *work)
 	struct vhci_data *data = container_of(work, struct vhci_data,
 					      open_timeout.work);
 
-	vhci_create_device(data, amp ? HCI_AMP : HCI_BREDR);
+	vhci_create_device(data, amp ? HCI_AMP : HCI_PRIMARY);
 }
 
 static int vhci_open(struct inode *inode, struct file *file)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index eefcf3e96421..a3f86de6f100 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -65,7 +65,7 @@
 #define HCI_I2C		8
 
 /* HCI controller types */
-#define HCI_BREDR	0x00
+#define HCI_PRIMARY	0x00
 #define HCI_AMP		0x01
 
 /* First BR/EDR Controller shall have ID = 0 */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bf9f8a801a2e..3809617aa98d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -625,7 +625,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
 		    hci_dev_test_flag(d, HCI_USER_CHANNEL) ||
-		    d->dev_type != HCI_BREDR)
+		    d->dev_type != HCI_PRIMARY)
 			continue;
 
 		/* Simple routing:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 45a9fc68c677..98f6c3770736 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -260,14 +260,12 @@ static int hci_init1_req(struct hci_request *req, unsigned long opt)
 		hci_reset_req(req, 0);
 
 	switch (hdev->dev_type) {
-	case HCI_BREDR:
+	case HCI_PRIMARY:
 		bredr_init(req);
 		break;
-
 	case HCI_AMP:
 		amp_init1(req);
 		break;
-
 	default:
 		BT_ERR("Unknown device type %d", hdev->dev_type);
 		break;
@@ -791,11 +789,11 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	/* HCI_BREDR covers both single-mode LE, BR/EDR and dual-mode
+	/* HCI_PRIMARY covers both single-mode LE, BR/EDR and dual-mode
 	 * BR/EDR/LE type controllers. AMP controllers only need the
 	 * first two stages of init.
 	 */
-	if (hdev->dev_type != HCI_BREDR)
+	if (hdev->dev_type != HCI_PRIMARY)
 		return 0;
 
 	err = __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT, NULL);
@@ -1202,7 +1200,7 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
-	if (hdev->dev_type != HCI_BREDR) {
+	if (hdev->dev_type != HCI_PRIMARY) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -1307,7 +1305,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		 * since AMP controllers do not have an address.
 		 */
 		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-		    hdev->dev_type == HCI_BREDR &&
+		    hdev->dev_type == HCI_PRIMARY &&
 		    !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 		    !bacmp(&hdev->static_addr, BDADDR_ANY)) {
 			ret = -EADDRNOTAVAIL;
@@ -1402,7 +1400,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
 		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 		    hci_dev_test_flag(hdev, HCI_MGMT) &&
-		    hdev->dev_type == HCI_BREDR) {
+		    hdev->dev_type == HCI_PRIMARY) {
 			ret = __hci_req_hci_power_on(hdev);
 			mgmt_power_on(hdev, ret);
 		}
@@ -1563,7 +1561,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
-	if (!auto_off && hdev->dev_type == HCI_BREDR &&
+	if (!auto_off && hdev->dev_type == HCI_PRIMARY &&
 	    hci_dev_test_flag(hdev, HCI_MGMT))
 		__mgmt_power_off(hdev);
 
@@ -1802,7 +1800,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		goto done;
 	}
 
-	if (hdev->dev_type != HCI_BREDR) {
+	if (hdev->dev_type != HCI_PRIMARY) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -2043,7 +2041,7 @@ static void hci_power_on(struct work_struct *work)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_RFKILLED) ||
 	    hci_dev_test_flag(hdev, HCI_UNCONFIGURED) ||
-	    (hdev->dev_type == HCI_BREDR &&
+	    (hdev->dev_type == HCI_PRIMARY &&
 	     !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 	     !bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		hci_dev_clear_flag(hdev, HCI_AUTO_OFF);
@@ -3030,7 +3028,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	 * so the index can be used as the AMP controller ID.
 	 */
 	switch (hdev->dev_type) {
-	case HCI_BREDR:
+	case HCI_PRIMARY:
 		id = ida_simple_get(&hci_index_ida, 0, 0, GFP_KERNEL);
 		break;
 	case HCI_AMP:
@@ -3090,7 +3088,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_dev_set_flag(hdev, HCI_SETUP);
 	hci_dev_set_flag(hdev, HCI_AUTO_OFF);
 
-	if (hdev->dev_type == HCI_BREDR) {
+	if (hdev->dev_type == HCI_PRIMARY) {
 		/* Assume BR/EDR support until proven otherwise (such as
 		 * through reading supported features during init.
 		 */
@@ -3415,7 +3413,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 	hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
 
 	switch (hdev->dev_type) {
-	case HCI_BREDR:
+	case HCI_PRIMARY:
 		hci_add_acl_hdr(skb, conn->handle, flags);
 		break;
 	case HCI_AMP:
@@ -3826,7 +3824,7 @@ static void hci_sched_acl(struct hci_dev *hdev)
 	BT_DBG("%s", hdev->name);
 
 	/* No ACL link over BR/EDR controller */
-	if (!hci_conn_num(hdev, ACL_LINK) && hdev->dev_type == HCI_BREDR)
+	if (!hci_conn_num(hdev, ACL_LINK) && hdev->dev_type == HCI_PRIMARY)
 		return;
 
 	/* No AMP link over AMP controller */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4b3dd5413be..3fb95c47243c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3249,7 +3249,7 @@ static struct hci_conn *__hci_conn_lookup_handle(struct hci_dev *hdev,
 	struct hci_chan *chan;
 
 	switch (hdev->dev_type) {
-	case HCI_BREDR:
+	case HCI_PRIMARY:
 		return hci_conn_hash_lookup_handle(hdev, handle);
 	case HCI_AMP:
 		chan = hci_chan_lookup_handle(hdev, handle);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 12e9294b02e0..6ef8a01a9ad4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -676,7 +676,7 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
 		return -EOPNOTSUPP;
 
-	if (hdev->dev_type != HCI_BREDR)
+	if (hdev->dev_type != HCI_PRIMARY)
 		return -EOPNOTSUPP;
 
 	switch (cmd) {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eb4f5f24cbe3..54ceb1f2cc9a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7468,7 +7468,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 	int len;
 
 	/* For AMP controller do not create l2cap conn */
-	if (!conn && hcon->hdev->dev_type != HCI_BREDR)
+	if (!conn && hcon->hdev->dev_type != HCI_PRIMARY)
 		goto drop;
 
 	if (!conn)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9e4b931588cf..7983ec8d4c60 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -359,7 +359,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_BREDR &&
+		if (d->dev_type == HCI_PRIMARY &&
 		    !hci_dev_test_flag(d, HCI_UNCONFIGURED))
 			count++;
 	}
@@ -384,7 +384,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
 			continue;
 
-		if (d->dev_type == HCI_BREDR &&
+		if (d->dev_type == HCI_PRIMARY &&
 		    !hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			BT_DBG("Added hci%u", d->id);
@@ -419,7 +419,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_BREDR &&
+		if (d->dev_type == HCI_PRIMARY &&
 		    hci_dev_test_flag(d, HCI_UNCONFIGURED))
 			count++;
 	}
@@ -444,7 +444,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
 			continue;
 
-		if (d->dev_type == HCI_BREDR &&
+		if (d->dev_type == HCI_PRIMARY &&
 		    hci_dev_test_flag(d, HCI_UNCONFIGURED)) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			BT_DBG("Added hci%u", d->id);
@@ -479,7 +479,7 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_BREDR || d->dev_type == HCI_AMP)
+		if (d->dev_type == HCI_PRIMARY || d->dev_type == HCI_AMP)
 			count++;
 	}
 
@@ -503,7 +503,7 @@ static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
 			continue;
 
-		if (d->dev_type == HCI_BREDR) {
+		if (d->dev_type == HCI_PRIMARY) {
 			if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
 				rp->entry[count].type = 0x01;
 			else
@@ -6366,7 +6366,7 @@ void mgmt_index_added(struct hci_dev *hdev)
 		return;
 
 	switch (hdev->dev_type) {
-	case HCI_BREDR:
+	case HCI_PRIMARY:
 		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 			mgmt_index_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev,
 					 NULL, 0, HCI_MGMT_UNCONF_INDEX_EVENTS);
@@ -6399,7 +6399,7 @@ void mgmt_index_removed(struct hci_dev *hdev)
 		return;
 
 	switch (hdev->dev_type) {
-	case HCI_BREDR:
+	case HCI_PRIMARY:
 		mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
 		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-- 
2.7.4

