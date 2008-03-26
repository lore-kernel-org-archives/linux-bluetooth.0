Return-Path: <cyrus@holtmann.org>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Wed, 26 Mar 2008 09:38:41 +0530
Message-ID: <00e801c88ef7$1381d040$832fc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00E9_01C88F25.2D3A0C40"
In-Reply-To: <BAY117-W512E12E372AF6367AFF61C0FC0@phx.gbl>
Subject: Re: [Bluez-users] How to enable eSCO in linux 2.6.18?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_00E9_01C88F25.2D3A0C40
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi=20
Please find attached the esco patch for 2.6.18

Sumeet=20

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of =11
Sent: Tuesday, March 25, 2008 11:41 AM
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] How to enable eSCO in linux 2.6.18?


Hi All:
        I want to enable eSCO function in linux 2.6.18 for a certain
reason.... I know that 2.6.23 with the bluez-2.6.23mh1 patch can enable
simple eSCO support. But since i can't upgrade my kernel to 2.6.23+ , is
there any patches that can be applied on a 2.6.18 kernel in order to =
make
eSCO connections ?



Thanks




semiyd





_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it =
now!
http://www.live.com/getstarted.aspx


------=_NextPart_000_00E9_01C88F25.2D3A0C40
Content-Type: application/octet-stream;
	name="2.6.18_esco.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.6.18_esco.patch"

diff -urN tmp/linux-2.6.18/include/net/bluetooth/bluetooth.h =
linux-2.6.18/include/net/bluetooth/bluetooth.h=0A=
--- tmp/linux-2.6.18/include/net/bluetooth/bluetooth.h	2006-09-20 =
09:12:06.000000000 +0530=0A=
+++ linux-2.6.18/include/net/bluetooth/bluetooth.h	2007-09-20 =
21:14:06.000000000 +0530=0A=
@@ -53,6 +53,23 @@=0A=
 #define SOL_SCO		17=0A=
 #define SOL_RFCOMM	18=0A=
 =0A=
+#if 0 =0A=
+/* Debugging */=0A=
+#define CONFIG_BT_BLUEZ_DEBUG=0A=
+=0A=
+#ifdef CONFIG_BT_BLUEZ_DEBUG=0A=
+#define CONFIG_BT_SOCK_DEBUG		1=0A=
+#define CONFIG_BT_HCI_CORE_DEBUG	1=0A=
+#define CONFIG_BT_HCI_SOCK_DEBUG	1=0A=
+#define CONFIG_BT_RFCOMM_DEBUG 		1=0A=
+#define CONFIG_BT_L2CAP_DEBUG		1=0A=
+#define CONFIG_BT_SCO_DEBUG		1=0A=
+=0A=
+#define CONFIG_BT_HCIUART_DEBUG		1=0A=
+#define CONFIG_BT_HCIVHCI_DEBUG		1=0A=
+#endif /* CONFIG_BT_BLUEZ_DEBUG */=0A=
+#endif =0A=
+=0A=
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , =
## arg)=0A=
 #define BT_DBG(fmt, arg...)  printk(KERN_INFO "%s: " fmt "\n" , =
__FUNCTION__ , ## arg)=0A=
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR  "%s: " fmt "\n" , =
__FUNCTION__ , ## arg)=0A=
diff -urN tmp/linux-2.6.18/include/net/bluetooth/hci_core.h =
linux-2.6.18/include/net/bluetooth/hci_core.h=0A=
--- tmp/linux-2.6.18/include/net/bluetooth/hci_core.h	2006-09-20 =
09:12:06.000000000 +0530=0A=
+++ linux-2.6.18/include/net/bluetooth/hci_core.h	2007-11-19 =
21:56:06.000000000 +0530=0A=
@@ -75,6 +75,7 @@=0A=
 	__u16		voice_setting;=0A=
 =0A=
 	__u16		pkt_type;=0A=
+	__u16		esco_pkt_type;=0A=
 	__u16		link_policy;=0A=
 	__u16		link_mode;=0A=
 =0A=
@@ -413,6 +414,8 @@=0A=
 int hci_register_sysfs(struct hci_dev *hdev);=0A=
 void hci_unregister_sysfs(struct hci_dev *hdev);=0A=
 =0A=
+=0A=
+=0A=
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->parent =3D (pdev))=0A=
 =0A=
 /* ----- LMP capabilities ----- */=0A=
@@ -420,6 +423,7 @@=0A=
 #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)=0A=
 #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)=0A=
 #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)=0A=
+#define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)=0A=
 =0A=
 /* ----- HCI protocols ----- */=0A=
 struct hci_proto {=0A=
diff -urN tmp/linux-2.6.18/include/net/bluetooth/hci.h =
linux-2.6.18/include/net/bluetooth/hci.h=0A=
--- tmp/linux-2.6.18/include/net/bluetooth/hci.h	2006-09-20 =
09:12:06.000000000 +0530=0A=
+++ linux-2.6.18/include/net/bluetooth/hci.h	2007-11-06 =
02:02:32.000000000 +0530=0A=
@@ -128,6 +128,19 @@=0A=
 #define SCO_PTYPE_MASK	(HCI_HV1 | HCI_HV2 | HCI_HV3)=0A=
 #define ACL_PTYPE_MASK	(~SCO_PTYPE_MASK)=0A=
 =0A=
+/* eSCO packet types */=0A=
+#define HCI_ESCO_HV1	0x0001=0A=
+#define HCI_ESCO_HV2	0x0002=0A=
+#define HCI_ESCO_HV3	0x0004=0A=
+#define HCI_ESCO_EV3	0x0008=0A=
+#define HCI_ESCO_EV4	0x0010=0A=
+#define HCI_ESCO_EV5	0x0020=0A=
+=0A=
+/* Some devices seem to have trouble establishing EV* packet =
connections */=0A=
+/* with other devices.  For this reason we mask out the eSCO packets */ =0A=
+/* for now.  Might need to address this later */=0A=
+#define ESCO_PTYPE_MASK	(HCI_ESCO_HV1 | HCI_ESCO_HV2 | HCI_ESCO_HV3)=0A=
+=0A=
 /* ACL flags */=0A=
 #define ACL_CONT		0x01=0A=
 #define ACL_START		0x02=0A=
@@ -137,6 +150,7 @@=0A=
 /* Baseband links */=0A=
 #define SCO_LINK	0x00=0A=
 #define ACL_LINK	0x01=0A=
+#define ESCO_LINK	0x02=0A=
 =0A=
 /* LMP features */=0A=
 #define LMP_3SLOT	0x01=0A=
@@ -157,6 +171,11 @@=0A=
 #define LMP_ULAW	0x40=0A=
 #define LMP_ALAW	0x80=0A=
 =0A=
+/* eSCO support and packets */=0A=
+#define LMP_ESCO	0x80=0A=
+#define LMP_EV4		0x01=0A=
+#define LMP_EV5		0x02=0A=
+=0A=
 #define LMP_CVSD	0x01=0A=
 #define LMP_PSCHEME	0x02=0A=
 #define LMP_PCONTROL	0x04=0A=
@@ -312,12 +331,29 @@=0A=
 	__u8     role;=0A=
 } __attribute__ ((packed));=0A=
 =0A=
+#define OCF_ACCEPT_SYNC_CONN_REQ	0x0029=0A=
+struct hci_cp_accept_sync_conn_req {=0A=
+	bdaddr_t	bdaddr;=0A=
+	__le32		tx_rate;=0A=
+	__le32		rx_rate;=0A=
+	__le16		max_latency;=0A=
+	__le16		voice_setting;=0A=
+	__u8		retrans_effort;=0A=
+	__le16		pkt_type;=0A=
+} __attribute__((packed));=0A=
+=0A=
 #define OCF_REJECT_CONN_REQ	0x000a=0A=
 struct hci_cp_reject_conn_req {=0A=
 	bdaddr_t bdaddr;=0A=
 	__u8     reason;=0A=
 } __attribute__ ((packed));=0A=
 =0A=
+#define OCF_REJECT_SYNC_CONN_REQ	0x002a=0A=
+struct hci_cp_reject_sync_conn_req {=0A=
+	bdaddr_t 	bdaddr;=0A=
+	__u8		reason;=0A=
+} __attribute__ ((packed));=0A=
+=0A=
 #define OCF_DISCONNECT	0x0006=0A=
 struct hci_cp_disconnect {=0A=
 	__le16   handle;=0A=
@@ -330,6 +366,17 @@=0A=
 	__le16   pkt_type;=0A=
 } __attribute__ ((packed));=0A=
 =0A=
+#define OCF_SETUP_SYNC_CONN	0x0028=0A=
+struct hci_cp_setup_sync_conn {=0A=
+	__le16	handle;=0A=
+	__le32 	tx_rate;=0A=
+	__le32	rx_rate;=0A=
+	__le16	latency;=0A=
+	__le16	voice_setting;=0A=
+	__u8	retrans_effort;=0A=
+	__le16	pkt_type;=0A=
+} __attribute__ ((packed));=0A=
+=0A=
 #define OCF_INQUIRY		0x0001=0A=
 struct hci_cp_inquiry {=0A=
 	__u8     lap[3];=0A=
@@ -516,6 +563,29 @@=0A=
 	__u8     encr_mode;=0A=
 } __attribute__ ((packed));=0A=
 =0A=
+#define HCI_EV_SYNC_CONN_COMPLETE	0x2C=0A=
+struct hci_ev_sync_conn_complete {=0A=
+	__u8 		status;=0A=
+	__le16		handle;=0A=
+	bdaddr_t	bdaddr;=0A=
+	__u8		link_type;=0A=
+	__u8		trans_interval;=0A=
+	__u8		retrans_window;=0A=
+	__le16		rx_pkt_len;=0A=
+	__le16		tx_pkt_len;=0A=
+	__u8		air_mode;=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+#define HCI_EV_SYNC_CONN_CHANGED       0x2D=0A=
+struct hci_ev_sync_conn_changed {=0A=
+	__u8		status;=0A=
+	__le16		handle;=0A=
+	__u8		trans_interval;=0A=
+	__u8		retrans_window;=0A=
+	__le16		rx_pkt_len;=0A=
+	__le16		tx_pkt_len;=0A=
+} __attribute__ ((packed));=0A=
+=0A=
 #define HCI_EV_CONN_REQUEST	0x04=0A=
 struct hci_ev_conn_request {=0A=
 	bdaddr_t bdaddr;=0A=
diff -urN tmp/linux-2.6.18/net/bluetooth/hci_conn.c =
linux-2.6.18/net/bluetooth/hci_conn.c=0A=
--- tmp/linux-2.6.18/net/bluetooth/hci_conn.c	2006-09-20 =
09:12:06.000000000 +0530=0A=
+++ linux-2.6.18/net/bluetooth/hci_conn.c	2007-11-19 22:00:17.000000000 =
+0530=0A=
@@ -100,17 +100,33 @@=0A=
 void hci_add_sco(struct hci_conn *conn, __u16 handle)=0A=
 {=0A=
 	struct hci_dev *hdev =3D conn->hdev;=0A=
-	struct hci_cp_add_sco cp;=0A=
 =0A=
 	BT_DBG("%p", conn);=0A=
 =0A=
 	conn->state =3D BT_CONNECT;=0A=
 	conn->out =3D 1;=0A=
 =0A=
-	cp.pkt_type =3D __cpu_to_le16(hdev->pkt_type & SCO_PTYPE_MASK);=0A=
-	cp.handle   =3D __cpu_to_le16(handle);=0A=
+	/* Devices that support 1.2 should be using the eSCO */=0A=
+	/* commands.  Add SCO commands were deprecated in 1.2 */=0A=
 =0A=
-	hci_send_cmd(hdev, OGF_LINK_CTL, OCF_ADD_SCO, sizeof(cp), &cp);=0A=
+	if (lmp_esco_capable(hdev)) {=0A=
+		struct hci_cp_setup_sync_conn cp;=0A=
+		cp.handle =3D __cpu_to_le16(handle);=0A=
+		cp.tx_rate =3D __cpu_to_le32(0x1f40);=0A=
+		cp.rx_rate =3D __cpu_to_le32(0x1f40);=0A=
+		cp.latency =3D __cpu_to_le16(0xffff);=0A=
+		cp.voice_setting =3D __cpu_to_le16(hdev->voice_setting);=0A=
+		cp.retrans_effort =3D 0xff;=0A=
+		cp.pkt_type =3D __cpu_to_le16(hdev->esco_pkt_type & ESCO_PTYPE_MASK);=0A=
+	=0A=
+		hci_send_cmd(hdev, OGF_LINK_CTL, OCF_SETUP_SYNC_CONN, sizeof(cp), =
&cp);=0A=
+	} else {=0A=
+		struct hci_cp_add_sco cp;=0A=
+		cp.pkt_type =3D __cpu_to_le16(hdev->pkt_type & SCO_PTYPE_MASK);=0A=
+		cp.handle   =3D __cpu_to_le16(handle);=0A=
+=0A=
+		hci_send_cmd(hdev, OGF_LINK_CTL, OCF_ADD_SCO, sizeof(cp), &cp);=0A=
+	}=0A=
 }=0A=
 =0A=
 static void hci_conn_timeout(unsigned long arg)=0A=
@@ -194,23 +210,25 @@=0A=
 =0A=
 	del_timer(&conn->disc_timer);=0A=
 =0A=
-	if (conn->type =3D=3D SCO_LINK) {=0A=
-		struct hci_conn *acl =3D conn->link;=0A=
-		if (acl) {=0A=
-			acl->link =3D NULL;=0A=
-			hci_conn_put(acl);=0A=
-		}=0A=
-	} else {=0A=
+	if (conn->type =3D=3D ACL_LINK) {=0A=
 		struct hci_conn *sco =3D conn->link;=0A=
 		if (sco)=0A=
 			sco->link =3D NULL;=0A=
 =0A=
 		/* Unacked frames */=0A=
 		hdev->acl_cnt +=3D conn->sent;=0A=
+	} else {=0A=
+		struct hci_conn *acl =3D conn->link;=0A=
+		if (acl) {=0A=
+			acl->link =3D NULL;=0A=
+			hci_conn_put(acl);=0A=
+		}=0A=
 	}=0A=
 =0A=
 	tasklet_disable(&hdev->tx_task);=0A=
 =0A=
+//	hci_conn_del_sysfs(conn);=0A=
+=0A=
 	hci_conn_hash_del(hdev, conn);=0A=
 	if (hdev->notify)=0A=
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);=0A=
@@ -270,6 +288,7 @@=0A=
 struct hci_conn * hci_connect(struct hci_dev *hdev, int type, bdaddr_t =
*dst)=0A=
 {=0A=
 	struct hci_conn *acl;=0A=
+	struct hci_conn *sco;=0A=
 =0A=
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));=0A=
 =0A=
@@ -283,28 +302,25 @@=0A=
 	if (acl->state =3D=3D BT_OPEN || acl->state =3D=3D BT_CLOSED)=0A=
 		hci_acl_connect(acl);=0A=
 =0A=
-	if (type =3D=3D SCO_LINK) {=0A=
-		struct hci_conn *sco;=0A=
+	if (type =3D=3D ACL_LINK)=0A=
+		return acl;=0A=
 =0A=
-		if (!(sco =3D hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst))) {=0A=
-			if (!(sco =3D hci_conn_add(hdev, SCO_LINK, dst))) {=0A=
-				hci_conn_put(acl);=0A=
-				return NULL;=0A=
-			}=0A=
+	if (!(sco =3D hci_conn_hash_lookup_ba(hdev, type, dst))) {=0A=
+		if (!(sco =3D hci_conn_add(hdev, type, dst))) {=0A=
+			hci_conn_put(acl);=0A=
+			return NULL;=0A=
 		}=0A=
-		acl->link =3D sco;=0A=
-		sco->link =3D acl;=0A=
+	}=0A=
+	acl->link =3D sco;=0A=
+	sco->link =3D acl;=0A=
 =0A=
-		hci_conn_hold(sco);=0A=
+	hci_conn_hold(sco);=0A=
 =0A=
-		if (acl->state =3D=3D BT_CONNECTED && =0A=
-				(sco->state =3D=3D BT_OPEN || sco->state =3D=3D BT_CLOSED))=0A=
-			hci_add_sco(sco, acl->handle);=0A=
+	if (acl->state =3D=3D BT_CONNECTED && =0A=
+			(sco->state =3D=3D BT_OPEN || sco->state =3D=3D BT_CLOSED))=0A=
+		hci_add_sco(sco, acl->handle);=0A=
 =0A=
-		return sco;=0A=
-	} else {=0A=
-		return acl;=0A=
-	}=0A=
+	return sco;=0A=
 }=0A=
 EXPORT_SYMBOL(hci_connect);=0A=
 =0A=
diff -urN tmp/linux-2.6.18/net/bluetooth/hci_core.c =
linux-2.6.18/net/bluetooth/hci_core.c=0A=
--- tmp/linux-2.6.18/net/bluetooth/hci_core.c	2006-09-20 =
09:12:06.000000000 +0530=0A=
+++ linux-2.6.18/net/bluetooth/hci_core.c	2008-01-29 01:01:32.000000000 =
+0530=0A=
@@ -848,6 +848,7 @@=0A=
 =0A=
 	hdev->flags =3D 0;=0A=
 	hdev->pkt_type  =3D (HCI_DM1 | HCI_DH1 | HCI_HV1);=0A=
+	hdev->esco_pkt_type =3D HCI_ESCO_HV1;=0A=
 	hdev->link_mode =3D (HCI_LM_ACCEPT);=0A=
 =0A=
 	hdev->idle_timeout =3D 0;=0A=
@@ -1390,6 +1391,7 @@=0A=
 		/* Process frame */=0A=
 		switch (bt_cb(skb)->pkt_type) {=0A=
 		case HCI_EVENT_PKT:=0A=
+			BT_DBG("%s HCI event packet", hdev->name);=0A=
 			hci_event_packet(hdev, skb);=0A=
 			break;=0A=
 =0A=
@@ -1404,6 +1406,7 @@=0A=
 			break;=0A=
 =0A=
 		default:=0A=
+			BT_DBG("%s Invalid packet", hdev->name);=0A=
 			kfree_skb(skb);=0A=
 			break;=0A=
 		}=0A=
diff -urN tmp/linux-2.6.18/net/bluetooth/hci_event.c =
linux-2.6.18/net/bluetooth/hci_event.c=0A=
--- tmp/linux-2.6.18/net/bluetooth/hci_event.c	2006-09-20 =
09:12:06.000000000 +0530=0A=
+++ linux-2.6.18/net/bluetooth/hci_event.c	2008-01-29 01:02:54.000000000 =
+0530=0A=
@@ -322,13 +322,30 @@=0A=
 		if (hdev->features[0] & LMP_5SLOT)=0A=
 			hdev->pkt_type |=3D (HCI_DM5 | HCI_DH5);=0A=
 =0A=
-		if (hdev->features[1] & LMP_HV2)=0A=
-			hdev->pkt_type |=3D (HCI_HV2);=0A=
+		if (hdev->features[1] & LMP_HV2) {=0A=
+			hdev->pkt_type  |=3D HCI_HV2;=0A=
+			hdev->esco_pkt_type |=3D HCI_ESCO_HV2;=0A=
+		}=0A=
+=0A=
+		if (hdev->features[1] & LMP_HV3) {=0A=
+			hdev->pkt_type  |=3D HCI_HV3;=0A=
+			hdev->esco_pkt_type |=3D HCI_ESCO_HV3;=0A=
+		}=0A=
+=0A=
+		if (hdev->features[3] & LMP_ESCO)=0A=
+			hdev->esco_pkt_type |=3D HCI_ESCO_EV3;=0A=
+=0A=
+		if (hdev->features[4] & LMP_EV4)=0A=
+			hdev->esco_pkt_type |=3D HCI_ESCO_EV4;=0A=
+=0A=
+		if (hdev->features[4] & LMP_EV5)=0A=
+			hdev->esco_pkt_type |=3D HCI_ESCO_EV5;=0A=
+=0A=
+		BT_DBG("%s: features 0x%x 0x%x 0x%x", hdev->name,=0A=
+				lf->features[0], lf->features[1], lf->features[2]);=0A=
 =0A=
-		if (hdev->features[1] & LMP_HV3)=0A=
-			hdev->pkt_type |=3D (HCI_HV3);=0A=
 =0A=
-		BT_DBG("%s: features 0x%x 0x%x 0x%x", hdev->name, lf->features[0], =
lf->features[1], lf->features[2]);=0A=
+		BT_DBG("%s: eSco packets: 0x%x", hdev->name, hdev->esco_pkt_type);=0A=
 =0A=
 		break;=0A=
 =0A=
@@ -412,40 +429,76 @@=0A=
 	hci_dev_unlock(hdev);=0A=
 }=0A=
 =0A=
-static void hci_cs_link_ctl(struct hci_dev *hdev, __u16 ocf, __u8 =
status)=0A=
+static inline void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)=0A=
 {=0A=
-	BT_DBG("%s ocf 0x%x", hdev->name, ocf);=0A=
+	struct hci_conn *acl, *sco;=0A=
+	struct hci_cp_add_sco *cp =3D hci_sent_cmd_data(hdev, OGF_LINK_CTL, =
OCF_ADD_SCO);=0A=
 =0A=
-	switch (ocf) {=0A=
-	case OCF_CREATE_CONN:=0A=
-		hci_cs_create_conn(hdev, status);=0A=
-		break;=0A=
+	if (!cp)=0A=
+		return;	=0A=
 =0A=
-	case OCF_ADD_SCO:=0A=
-		if (status) {=0A=
-			struct hci_conn *acl, *sco;=0A=
-			struct hci_cp_add_sco *cp =3D hci_sent_cmd_data(hdev, OGF_LINK_CTL, =
OCF_ADD_SCO);=0A=
-			__u16 handle;=0A=
+	hci_dev_lock(hdev);=0A=
 =0A=
-			if (!cp)=0A=
-				break;=0A=
+	if (status) {=0A=
+		__u16 handle =3D __le16_to_cpu(cp->handle);=0A=
 =0A=
-			handle =3D __le16_to_cpu(cp->handle);=0A=
+		BT_DBG("%s Add SCO error: handle %d status 0x%x", hdev->name, handle, =
status);=0A=
 =0A=
-			BT_DBG("%s Add SCO error: handle %d status 0x%x", hdev->name, =
handle, status);=0A=
+		acl =3D hci_conn_hash_lookup_handle(hdev, handle);=0A=
+		if (acl && (sco =3D acl->link)) {=0A=
+			sco->state =3D BT_CLOSED;=0A=
 =0A=
-			hci_dev_lock(hdev);=0A=
+			hci_proto_connect_cfm(sco, status);=0A=
+			hci_conn_del(sco);=0A=
+		}=0A=
+	}=0A=
 =0A=
-			acl =3D hci_conn_hash_lookup_handle(hdev, handle);=0A=
-			if (acl && (sco =3D acl->link)) {=0A=
-				sco->state =3D BT_CLOSED;=0A=
+	hci_dev_unlock(hdev);=0A=
+}=0A=
 =0A=
-				hci_proto_connect_cfm(sco, status);=0A=
-				hci_conn_del(sco);=0A=
-			}=0A=
+static inline void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 =
status)=0A=
+{=0A=
+	struct hci_conn *acl, *sco;=0A=
+	struct hci_cp_setup_sync_conn *cp =3D hci_sent_cmd_data(hdev, =
OGF_LINK_CTL, OCF_SETUP_SYNC_CONN);=0A=
 =0A=
-			hci_dev_unlock(hdev);=0A=
+	if (!cp)=0A=
+		return;	=0A=
+=0A=
+	hci_dev_lock(hdev);=0A=
+=0A=
+	if (status) {=0A=
+		__u16 handle =3D __le16_to_cpu(cp->handle);=0A=
+=0A=
+		BT_DBG("%s eSCO conn setup error: handle %d status 0x%x",=0A=
+			hdev->name, handle, status);=0A=
+=0A=
+		acl =3D hci_conn_hash_lookup_handle(hdev, handle);=0A=
+		if (acl && (sco =3D acl->link)) {=0A=
+			sco->state =3D BT_CLOSED;=0A=
+=0A=
+			hci_proto_connect_cfm(sco, status);=0A=
+			hci_conn_del(sco);=0A=
 		}=0A=
+	}=0A=
+=0A=
+	hci_dev_unlock(hdev);	=0A=
+}=0A=
+=0A=
+static void hci_cs_link_ctl(struct hci_dev *hdev, __u16 ocf, __u8 =
status)=0A=
+{=0A=
+	BT_DBG("%s ocf 0x%x", hdev->name, ocf);=0A=
+	=0A=
+	switch (ocf) {=0A=
+	case OCF_CREATE_CONN:=0A=
+		hci_cs_create_conn(hdev, status);=0A=
+		break;=0A=
+=0A=
+	case OCF_ADD_SCO:=0A=
+		hci_cs_add_sco(hdev, status);=0A=
+		break;=0A=
+=0A=
+	case OCF_SETUP_SYNC_CONN:=0A=
+		hci_cs_setup_sync_conn(hdev, status);=0A=
 		break;=0A=
 =0A=
 	case OCF_INQUIRY:=0A=
@@ -669,7 +722,6 @@=0A=
 	if (mask & HCI_LM_ACCEPT) {=0A=
 		/* Connection accepted */=0A=
 		struct hci_conn *conn;=0A=
-		struct hci_cp_accept_conn_req cp;=0A=
 =0A=
 		hci_dev_lock(hdev);=0A=
 		conn =3D hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);=0A=
@@ -684,23 +736,51 @@=0A=
 		conn->state =3D BT_CONNECT;=0A=
 		hci_dev_unlock(hdev);=0A=
 =0A=
-		bacpy(&cp.bdaddr, &ev->bdaddr);=0A=
+		if ((ev->link_type =3D=3D ACL_LINK) || (!lmp_esco_capable(hdev))) {=0A=
+			struct hci_cp_accept_conn_req cp;=0A=
+			bacpy(&cp.bdaddr, &ev->bdaddr);=0A=
 =0A=
-		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))=0A=
-			cp.role =3D 0x00; /* Become master */=0A=
-		else=0A=
-			cp.role =3D 0x01; /* Remain slave */=0A=
+			if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))=0A=
+				cp.role =3D 0x00; /* Become master */=0A=
+			else=0A=
+				cp.role =3D 0x01; /* Remain slave */=0A=
 =0A=
-		hci_send_cmd(hdev, OGF_LINK_CTL,=0A=
-				OCF_ACCEPT_CONN_REQ, sizeof(cp), &cp);=0A=
+			hci_send_cmd(hdev, OGF_LINK_CTL,=0A=
+					OCF_ACCEPT_CONN_REQ, sizeof(cp), &cp);=0A=
+		} else {=0A=
+			/* Send the Accept Sync Connection Command */=0A=
+			struct hci_cp_accept_sync_conn_req cp;=0A=
+			=0A=
+			bacpy(&cp.bdaddr, &ev->bdaddr);=0A=
+			cp.tx_rate =3D __cpu_to_le32(0x1f40);=0A=
+			cp.rx_rate =3D __cpu_to_le32(0x1f40);=0A=
+			cp.max_latency =3D __cpu_to_le16(0xffff);=0A=
+			cp.voice_setting =3D __cpu_to_le16(hdev->voice_setting);=0A=
+			cp.retrans_effort =3D 0xff;=0A=
+			cp.pkt_type =3D __cpu_to_le16(hdev->esco_pkt_type & ESCO_PTYPE_MASK);=0A=
+=0A=
+			hci_send_cmd(hdev, OGF_LINK_CTL,=0A=
+					OCF_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);=0A=
+		}=0A=
 	} else {=0A=
 		/* Connection rejected */=0A=
-		struct hci_cp_reject_conn_req cp;=0A=
 =0A=
-		bacpy(&cp.bdaddr, &ev->bdaddr);=0A=
-		cp.reason =3D 0x0f;=0A=
-		hci_send_cmd(hdev, OGF_LINK_CTL,=0A=
-				OCF_REJECT_CONN_REQ, sizeof(cp), &cp);=0A=
+		if ((ev->link_type =3D=3D ACL_LINK) || (!lmp_esco_capable(hdev))) {=0A=
+			struct hci_cp_reject_conn_req cp;=0A=
+=0A=
+			bacpy(&cp.bdaddr, &ev->bdaddr);=0A=
+			cp.reason =3D 0x0f;=0A=
+			hci_send_cmd(hdev, OGF_LINK_CTL,=0A=
+					OCF_REJECT_CONN_REQ, sizeof(cp), &cp);=0A=
+		} else {=0A=
+			struct hci_cp_reject_sync_conn_req cp;=0A=
+			=0A=
+			bacpy(&cp.bdaddr, &ev->bdaddr);=0A=
+			cp.reason =3D 0x0f;=0A=
+=0A=
+			hci_send_cmd(hdev, OGF_LINK_CTL,=0A=
+					OCF_REJECT_SYNC_CONN_REQ, sizeof(cp), &cp);=0A=
+		}=0A=
 	}=0A=
 }=0A=
 =0A=
@@ -780,6 +860,57 @@=0A=
 	hci_dev_unlock(hdev);=0A=
 }=0A=
 =0A=
+/* eSCO Connect Complete */=0A=
+static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, =
struct sk_buff *skb)=0A=
+{=0A=
+	struct hci_ev_sync_conn_complete *ev =3D (struct =
hci_ev_sync_conn_complete *) skb->data;=0A=
+	struct hci_conn *conn;=0A=
+=0A=
+	BT_DBG("%s", hdev->name);=0A=
+=0A=
+	hci_dev_lock(hdev);=0A=
+=0A=
+	/* There are two possibilities here.  We establish an outgoing ESCO =
link and get */=0A=
+	/* back a SCO link.  Or we got a connect request with a SCO/ESCO link =
type and */=0A=
+	/* arrived here once it was established */=0A=
+	conn =3D hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);=0A=
+	if (!conn) {=0A=
+		/* Incoming SCO case */=0A=
+		conn =3D hci_conn_hash_lookup_ba(hdev, SCO_LINK, &ev->bdaddr);=0A=
+		if (!conn) {=0A=
+			hci_dev_unlock(hdev);=0A=
+			return;=0A=
+		}=0A=
+=0A=
+		if (conn->out) {=0A=
+			BT_DBG("ended up with a SCO link");=0A=
+			hci_conn_del(conn);=0A=
+			hci_dev_unlock(hdev);=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (!ev->status) {=0A=
+		conn->handle =3D __le16_to_cpu(ev->handle);=0A=
+		conn->type =3D ev->link_type;=0A=
+		conn->state  =3D BT_CONNECTED;=0A=
+=0A=
+		if (conn->out) {=0A=
+			/* Update disconnect timer */=0A=
+			hci_conn_hold(conn);=0A=
+			hci_conn_put(conn);=0A=
+		}=0A=
+	} else=0A=
+		conn->state =3D BT_CLOSED;=0A=
+=0A=
+	hci_proto_connect_cfm(conn, ev->status);=0A=
+	if (ev->status)=0A=
+		hci_conn_del(conn);=0A=
+=0A=
+	hci_dev_unlock(hdev);=0A=
+}=0A=
+=0A=
+=0A=
 /* Disconnect Complete */=0A=
 static inline void hci_disconn_complete_evt(struct hci_dev *hdev, =
struct sk_buff *skb)=0A=
 {=0A=
@@ -832,12 +963,12 @@=0A=
 		if (conn) {=0A=
 			conn->sent -=3D count;=0A=
 =0A=
-			if (conn->type =3D=3D SCO_LINK) {=0A=
-				if ((hdev->sco_cnt +=3D count) > hdev->sco_pkts)=0A=
-					hdev->sco_cnt =3D hdev->sco_pkts;=0A=
-			} else {=0A=
+			if (conn->type =3D=3D ACL_LINK) {=0A=
 				if ((hdev->acl_cnt +=3D count) > hdev->acl_pkts)=0A=
 					hdev->acl_cnt =3D hdev->acl_pkts;=0A=
+			} else {=0A=
+				if ((hdev->sco_cnt +=3D count) > hdev->sco_pkts)=0A=
+					hdev->sco_cnt =3D hdev->sco_pkts;=0A=
 			}=0A=
 		}=0A=
 	}=0A=
@@ -1116,6 +1247,10 @@=0A=
 		hci_conn_complete_evt(hdev, skb);=0A=
 		break;=0A=
 =0A=
+	case HCI_EV_SYNC_CONN_COMPLETE:=0A=
+		hci_sync_conn_complete_evt(hdev, skb);=0A=
+		break;=0A=
+=0A=
 	case HCI_EV_DISCONN_COMPLETE:=0A=
 		hci_disconn_complete_evt(hdev, skb);=0A=
 		break;=0A=
diff -urN tmp/linux-2.6.18/net/bluetooth/sco.c =
linux-2.6.18/net/bluetooth/sco.c=0A=
--- tmp/linux-2.6.18/net/bluetooth/sco.c	2006-09-20 09:12:06.000000000 =
+0530=0A=
+++ linux-2.6.18/net/bluetooth/sco.c	2007-11-06 19:55:38.000000000 +0530=0A=
@@ -189,7 +189,7 @@=0A=
 	struct sco_conn *conn;=0A=
 	struct hci_conn *hcon;=0A=
 	struct hci_dev  *hdev;=0A=
-	int err =3D 0;=0A=
+	int err, type;=0A=
 =0A=
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));=0A=
 =0A=
@@ -200,7 +200,9 @@=0A=
 =0A=
 	err =3D -ENOMEM;=0A=
 =0A=
-	hcon =3D hci_connect(hdev, SCO_LINK, dst);=0A=
+	type =3D lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;=0A=
+=0A=
+	hcon =3D hci_connect(hdev, type, dst);=0A=
 	if (!hcon)=0A=
 		goto done;=0A=
 =0A=
@@ -837,6 +839,9 @@=0A=
 {=0A=
 	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));=0A=
 =0A=
+	if (type !=3D SCO_LINK && type !=3D ESCO_LINK)=0A=
+		return 0;=0A=
+=0A=
 	/* Always accept connection */=0A=
 	return HCI_LM_ACCEPT;=0A=
 }=0A=
@@ -845,7 +850,7 @@=0A=
 {=0A=
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), =
status);=0A=
 =0A=
-	if (hcon->type !=3D SCO_LINK)=0A=
+	if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)=0A=
 		return 0;=0A=
 =0A=
 	if (!status) {=0A=
@@ -864,7 +869,7 @@=0A=
 {=0A=
 	BT_DBG("hcon %p reason %d", hcon, reason);=0A=
 =0A=
-	if (hcon->type !=3D SCO_LINK)=0A=
+	if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)=0A=
 		return 0;=0A=
 =0A=
 	sco_conn_del(hcon, bt_err(reason));=0A=

------=_NextPart_000_00E9_01C88F25.2D3A0C40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
------=_NextPart_000_00E9_01C88F25.2D3A0C40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_NextPart_000_00E9_01C88F25.2D3A0C40--
