Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Message-Id: <1059787251.22190.17.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] HCI USB driver and SCO support
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 02 Aug 2003 03:20:45 +0200
Content-Type: multipart/mixed; boundary="=-Nq4ReWR8DoaZFRT4AbWX"


--=-Nq4ReWR8DoaZFRT4AbWX
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Max,

the patch from Jonathan Paisley is working fine. I have tested it on
2.4.18 to 2.4.21 and we can safely use two ISOC TX and RX URB's by
default. But the configuration of the ISOC endpoint must be adjusted on
demand. It depends on the voice setting and number of SCO connections,
otherwise you won't hear any sound. At the moment we don't have access
to these information from within the driver, so I started to extend the
HCI core.

The first patch introduces hdev->notify and reads the voice setting on
device init and stores them in hdev->voice_setting for later use. With
these modification a driver can be notified about added or deleted
connections (ACL + SCO) and if the voice setting was changed.

The second patch is for the HCI USB driver and it shows how to use
hdev->notify. It also contains Jonathans modifications to use two ISOC
TX and RX URB's and it keeps track of the number of ACL and SCO
connections.

In the next step, we must choose the correct ISOC configuration. The
default one should be 0, because we don't use any SCO channel. It is
also a good idea to start the ISOC and BULK transfers only if they are
needed.

Comments?

Regards

Marcel


--=-Nq4ReWR8DoaZFRT4AbWX
Content-Disposition: attachment; filename=patch-2.4.22-pre10-hci-notify
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch-2.4.22-pre10-hci-notify; CHARSET=ISO-8859-15

diff -urN linux-2.4.22-pre10/include/net/bluetooth/hci.h linux-2.4.22-pre10=
-notify/include/net/bluetooth/hci.h
--- linux-2.4.22-pre10/include/net/bluetooth/hci.h	Sat Aug  2 02:33:57 2003
+++ linux-2.4.22-pre10-notify/include/net/bluetooth/hci.h	Sat Aug  2 02:34:=
37 2003
@@ -42,6 +42,11 @@
 #define HCI_DEV_SUSPEND	5
 #define HCI_DEV_RESUME	6
=20
+/* HCI notify events */
+#define HCI_CONN_ADD		1
+#define HCI_CONN_DEL		2
+#define HCI_VOICE_SETTING	3
+
 /* HCI device types */
 #define HCI_VHCI	0
 #define HCI_USB		1
@@ -269,6 +274,19 @@
 	__u8 	dev_class[3];
 } __attribute__ ((packed)) write_class_of_dev_cp;
 #define WRITE_CLASS_OF_DEV_CP_SIZE 3
+
+#define OCF_READ_VOICE_SETTING	0x0025
+typedef struct {
+	__u8	status;
+	__u16	voice_setting;
+} __attribute__ ((packed)) read_voice_setting_rp;
+#define READ_VOICE_SETTING_RP_SIZE 3
+
+#define OCF_WRITE_VOICE_SETTING	0x0026
+typedef struct {
+	__u16	voice_setting;
+} __attribute__ ((packed)) write_voice_setting_cp;
+#define WRITE_VOICE_SETTING_CP_SIZE 2
=20
 #define OCF_HOST_BUFFER_SIZE	0x0033
 typedef struct {
diff -urN linux-2.4.22-pre10/include/net/bluetooth/hci_core.h linux-2.4.22-=
pre10-notify/include/net/bluetooth/hci_core.h
--- linux-2.4.22-pre10/include/net/bluetooth/hci_core.h	Fri Jun 13 16:51:39=
 2003
+++ linux-2.4.22-pre10-notify/include/net/bluetooth/hci_core.h	Sat Aug  2 0=
2:34:37 2003
@@ -68,11 +68,12 @@
 	__u8	 	type;
 	bdaddr_t	bdaddr;
 	__u8		features[8];
+	__u16		voice_setting;
=20
 	__u16		pkt_type;
 	__u16		link_policy;
 	__u16		link_mode;
-=09
+
 	atomic_t 	cmd_cnt;
 	unsigned int 	acl_cnt;
 	unsigned int 	sco_cnt;
@@ -116,6 +117,7 @@
 	int (*flush)(struct hci_dev *hdev);
 	int (*send)(struct sk_buff *skb);
 	void (*destruct)(struct hci_dev *hdev);
+	void (*notify)(struct hci_dev *hdev, unsigned int evt, unsigned long arg)=
;
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
 };
=20
diff -urN linux-2.4.22-pre10/net/bluetooth/af_bluetooth.c linux-2.4.22-pre1=
0-notify/net/bluetooth/af_bluetooth.c
--- linux-2.4.22-pre10/net/bluetooth/af_bluetooth.c	Sat Aug  2 02:33:57 200=
3
+++ linux-2.4.22-pre10-notify/net/bluetooth/af_bluetooth.c	Sat Aug  2 02:35=
:01 2003
@@ -27,7 +27,7 @@
  *
  * $Id: af_bluetooth.c,v 1.8 2002/07/22 20:32:54 maxk Exp $
  */
-#define VERSION "2.3"
+#define VERSION "2.4"
=20
 #include <linux/config.h>
 #include <linux/module.h>
diff -urN linux-2.4.22-pre10/net/bluetooth/hci_conn.c linux-2.4.22-pre10-no=
tify/net/bluetooth/hci_conn.c
--- linux-2.4.22-pre10/net/bluetooth/hci_conn.c	Fri Jun 13 16:51:39 2003
+++ linux-2.4.22-pre10-notify/net/bluetooth/hci_conn.c	Sat Aug  2 02:34:37 =
2003
@@ -168,6 +168,9 @@
=20
 	hci_dev_hold(hdev);
=20
+	if (hdev->notify)
+		hdev->notify(hdev, HCI_CONN_ADD, (unsigned long) conn);
+
 	tasklet_disable(&hdev->tx_task);
 	conn_hash_add(hdev, conn);
 	tasklet_enable(&hdev->tx_task);
@@ -203,6 +206,9 @@
 	tasklet_enable(&hdev->tx_task);
=20
 	skb_queue_purge(&conn->data_q);
+
+	if (hdev->notify)
+		hdev->notify(hdev, HCI_CONN_DEL, (unsigned long) conn);
=20
 	hci_dev_put(hdev);
=20
diff -urN linux-2.4.22-pre10/net/bluetooth/hci_core.c linux-2.4.22-pre10-no=
tify/net/bluetooth/hci_core.c
--- linux-2.4.22-pre10/net/bluetooth/hci_core.c	Sat Aug  2 02:33:57 2003
+++ linux-2.4.22-pre10-notify/net/bluetooth/hci_core.c	Sat Aug  2 02:34:37 =
2003
@@ -240,6 +240,9 @@
 	/* Read BD Address */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BD_ADDR, 0, NULL);
=20
+        /* Read Voice Setting */
+	hci_send_cmd(hdev, OGF_HOST_CTL, OCF_READ_VOICE_SETTING, 0, NULL);
+
 	/* Optional initialization */
=20
 	/* Clear Event Filters */
diff -urN linux-2.4.22-pre10/net/bluetooth/hci_event.c linux-2.4.22-pre10-n=
otify/net/bluetooth/hci_event.c
--- linux-2.4.22-pre10/net/bluetooth/hci_event.c	Sat Aug  2 02:33:57 2003
+++ linux-2.4.22-pre10-notify/net/bluetooth/hci_event.c	Sat Aug  2 02:34:37=
 2003
@@ -123,6 +123,8 @@
 static void hci_cc_host_ctl(struct hci_dev *hdev, __u16 ocf, struct sk_buf=
f *skb)
 {
 	__u8 status, param;
+	__u16 setting;
+	read_voice_setting_rp *vs;
 	void *sent;
=20
 	BT_DBG("%s ocf 0x%x", hdev->name, ocf);
@@ -198,6 +200,7 @@
 		sent =3D hci_sent_cmd_data(hdev, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE);
 		if (!sent)
 			break;
+
 		status =3D *((__u8 *) skb->data);
 		param  =3D *((__u8 *) sent);
=20
@@ -215,6 +218,46 @@
 		hci_req_complete(hdev, status);
 		break;
=20
+	case OCF_READ_VOICE_SETTING:
+		vs =3D (read_voice_setting_rp *) skb->data;
+
+		if (vs->status) {=20
+			BT_DBG("%s READ_VOICE_SETTING failed %d", hdev->name, vc->status);
+			break;
+		}
+
+		setting =3D __le16_to_cpu(vs->voice_setting);
+
+		if (hdev->voice_setting !=3D setting ) {
+			hdev->voice_setting =3D setting;
+
+			BT_DBG("%s: voice setting 0x%04x", hdev->name, setting);
+
+			if (hdev->notify)
+				hdev->notify(hdev, HCI_VOICE_SETTING, 0);
+		}
+
+		break;
+
+	case OCF_WRITE_VOICE_SETTING:
+		sent =3D hci_sent_cmd_data(hdev, OGF_HOST_CTL, OCF_WRITE_VOICE_SETTING);
+		if (!sent)
+			break;
+
+		status =3D *((__u8 *) skb->data);
+		setting =3D __le16_to_cpu(get_unaligned((__u16 *) sent));
+
+		if (!status && hdev->voice_setting !=3D setting) {
+			hdev->voice_setting =3D setting;
+
+			BT_DBG("%s: voice setting 0x%04x", hdev->name, setting);
+
+			if (hdev->notify)
+				hdev->notify(hdev, HCI_VOICE_SETTING, 0);
+		}
+		hci_req_complete(hdev, status);
+		break;
+
 	case OCF_HOST_BUFFER_SIZE:
 		status =3D *((__u8 *) skb->data);
 		if (status) {
@@ -282,7 +325,8 @@
 		hdev->sco_pkts =3D hdev->sco_cnt =3D __le16_to_cpu(bs->sco_max_pkt);
=20
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
-		    hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
+			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
+
 		break;
=20
 	case OCF_READ_BD_ADDR:

--=-Nq4ReWR8DoaZFRT4AbWX
Content-Disposition: attachment; filename=patch-2.4.22-pre10-hci-usb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch-2.4.22-pre10-hci-usb; CHARSET=ISO-8859-15

diff -urN linux-2.4.22-pre10/drivers/bluetooth/hci_usb.c linux-2.4.22-pre10=
-usb/drivers/bluetooth/hci_usb.c
--- linux-2.4.22-pre10/drivers/bluetooth/hci_usb.c	Sat Aug  2 02:33:45 2003
+++ linux-2.4.22-pre10-usb/drivers/bluetooth/hci_usb.c	Sat Aug  2 02:54:11 =
2003
@@ -30,7 +30,7 @@
  *
  * $Id: hci_usb.c,v 1.8 2002/07/18 17:23:09 maxk Exp $   =20
  */
-#define VERSION "2.4"
+#define VERSION "2.5"
=20
 #include <linux/config.h>
 #include <linux/module.h>
@@ -302,7 +302,8 @@
=20
 #ifdef CONFIG_BLUEZ_USB_SCO
 		if (husb->isoc_iface)
-			hci_usb_isoc_rx_submit(husb);
+			for (i =3D 0; i < HCI_MAX_ISOC_RX; i++)
+				hci_usb_isoc_rx_submit(husb);
 #endif
 	} else {
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -522,7 +523,7 @@
 #ifdef CONFIG_BLUEZ_USB_SCO
 		/* Process SCO queue */
 		q =3D __transmit_q(husb, HCI_SCODATA_PKT);
-		if (!atomic_read(__pending_tx(husb, HCI_SCODATA_PKT)) &&
+		if (atomic_read(__pending_tx(husb, HCI_SCODATA_PKT)) < HCI_MAX_ISOC_TX &=
&
 				(skb =3D skb_dequeue(q))) {
 			if (hci_usb_send_isoc(husb, skb) < 0)
 				skb_queue_head(q, skb);
@@ -769,6 +770,44 @@
 	kfree(husb);
 }
=20
+static void hci_usb_notify(struct hci_dev *hdev, unsigned int evt, unsigne=
d long arg)
+{
+	struct hci_usb *husb =3D (struct hci_usb *) hdev->driver_data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s cmd %d arg %ld", hdev->name, evt, arg);
+
+	switch (evt) {
+	case HCI_CONN_ADD:
+		conn =3D (struct hci_conn *) arg;
+
+		BT_DBG("%s add conn type %d", hdev->name, conn->type);
+
+		if (conn->type =3D=3D ACL_LINK)
+			atomic_inc(&husb->acl_num_conn);
+		else
+			atomic_inc(&husb->sco_num_conn);
+
+		break;
+
+	case HCI_CONN_DEL:
+		conn =3D (struct hci_conn *) arg;
+
+		BT_DBG("%s del conn type %d", hdev->name, conn->type);
+
+		if (conn->type =3D=3D ACL_LINK)
+			atomic_dec(&husb->acl_num_conn);
+		else
+			atomic_dec(&husb->sco_num_conn);
+
+		break;
+
+	case HCI_VOICE_SETTING:
+		BT_DBG("%s voice setting 0x%04x", hdev->name, hdev->voice_setting);
+		break;
+	}
+}
+
 static void *hci_usb_probe(struct usb_device *udev, unsigned int ifnum, co=
nst struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *bulk_out_ep[HCI_MAX_IFACE_NUM];
@@ -901,11 +940,12 @@
 	hdev->type  =3D HCI_USB;
 	hdev->driver_data =3D husb;
=20
-	hdev->open  =3D hci_usb_open;
-	hdev->close =3D hci_usb_close;
-	hdev->flush =3D hci_usb_flush;
-	hdev->send  =3D hci_usb_send_frame;
+	hdev->open     =3D hci_usb_open;
+	hdev->close    =3D hci_usb_close;
+	hdev->flush    =3D hci_usb_flush;
+	hdev->send     =3D hci_usb_send_frame;
 	hdev->destruct =3D hci_usb_destruct;
+	hdev->notify   =3D hci_usb_notify;
=20
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
diff -urN linux-2.4.22-pre10/drivers/bluetooth/hci_usb.h linux-2.4.22-pre10=
-usb/drivers/bluetooth/hci_usb.h
--- linux-2.4.22-pre10/drivers/bluetooth/hci_usb.h	Fri Jun 13 16:51:32 2003
+++ linux-2.4.22-pre10-usb/drivers/bluetooth/hci_usb.h	Sat Aug  2 02:41:19 =
2003
@@ -41,6 +41,9 @@
 #define HCI_MAX_BULK_TX     	4
 #define HCI_MAX_BULK_RX     	1
=20
+#define HCI_MAX_ISOC_RX		2
+#define HCI_MAX_ISOC_TX		2
+
 #define HCI_MAX_ISOC_FRAMES     10
=20
 struct _urb_queue {
@@ -120,13 +123,16 @@
 	struct usb_endpoint_descriptor	*isoc_in_ep;
=20
 	struct sk_buff_head	transmit_q[4];
-	struct sk_buff		*reassembly[4]; // Reassembly buffers
+	struct sk_buff		*reassembly[4];	/* Reassembly buffers */
=20
 	rwlock_t		completion_lock;
=20
-	atomic_t		pending_tx[4];  // Number of pending requests=20
-	struct _urb_queue	pending_q[4];   // Pending requests
-	struct _urb_queue	completed_q[4]; // Completed requests
+	atomic_t		pending_tx[4];  /* Number of pending requests */
+	struct _urb_queue	pending_q[4];	/* Pending requests */
+	struct _urb_queue	completed_q[4];	/* Completed requests */
+
+	atomic_t		acl_num_conn;	/* Number of ACL connections */
+	atomic_t		sco_num_conn;	/* Number of SCO connections */
 };
=20
 /* States  */

--=-Nq4ReWR8DoaZFRT4AbWX--
