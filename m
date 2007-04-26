Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 26 Apr 2007 10:26:41 +0530
Message-ID: <00b401c787bf$48300b80$8935c70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B5_01C787ED.61E84780"
In-Reply-To: <1177487043.14980.17.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Esco implementation patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_00B5_01C787ED.61E84780
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marcel
Sorry for the mistake. Please find a single diff attached. 

Regards,
Sumeet 
-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Wednesday, April 25, 2007 1:14 PM
To: BlueZ development
Subject: Re: [Bluez-devel] Esco implementation patch

Hi Sumeet,

> I have done an implementation of esco in bluez kernel. I have hardcoded
the settings of eSCO connection at the moment (packet type EV3).
> Please review it and feel free to make modifications. This is working fine
on my side. I changed the 2.6.20 kernel code.

your patch is reverse and please don't send separate patches for each file.
Create a big diff that includes all changes.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express Download DB2 Express C - the
FREE version of DB2 express and take control of your XML. No limits. Just
data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_00B5_01C787ED.61E84780
Content-Type: application/octet-stream;
	name="esco.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="esco.patch"

diff -ur ../orig/include/hci_core.h ../escopatch/include/hci_core.h=0A=
--- ../orig/include/hci_core.h	2007-04-18 11:18:02.000000000 +0530=0A=
+++ ../escopatch/include/hci_core.h	2007-04-25 07:47:27.000000000 +0530=0A=
@@ -308,6 +308,7 @@=0A=
 void hci_acl_connect(struct hci_conn *conn);=0A=
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);=0A=
 void hci_add_sco(struct hci_conn *conn, __u16 handle);=0A=
+void hci_add_esco(struct hci_conn *conn, __u16 handle);=0A=
 =0A=
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t =
*dst);=0A=
 int    hci_conn_del(struct hci_conn *conn);=0A=
diff -ur ../orig/include/hci.h ../escopatch/include/hci.h=0A=
--- ../orig/include/hci.h	2007-04-18 11:18:02.000000000 +0530=0A=
+++ ../escopatch/include/hci.h	2007-04-25 07:48:03.000000000 +0530=0A=
@@ -138,6 +138,7 @@=0A=
 /* Baseband links */=0A=
 #define SCO_LINK	0x00=0A=
 #define ACL_LINK	0x01=0A=
+#define ESCO_LINK	0x02=0A=
 =0A=
 /* LMP features */=0A=
 #define LMP_3SLOT	0x01=0A=
@@ -337,6 +338,28 @@=0A=
 	__le16   pkt_type;=0A=
 } __attribute__ ((packed));=0A=
 =0A=
+#define OCF_SETUP_SYNC_CONN	0x0028=0A=
+struct hci_cp_setup_sync_conn {=0A=
+	__le16	handle;=0A=
+	__u32	tx_bw;=0A=
+	__u32	rx_bw;=0A=
+	__le16	max_latency;=0A=
+	__le16	voice_setting;=0A=
+	__u8 	retx_effort;=0A=
+	__le16	pkt_type;	=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+#define OCF_ACCEPT_SYNC_CONN	0x0029=0A=
+struct hci_cp_accept_sync_conn {=0A=
+	bdaddr_t bdaddr;=0A=
+	__u32	tx_bw;=0A=
+	__u32	rx_bw;=0A=
+	__le16	max_latency;=0A=
+	__le16	content_format;=0A=
+	__u8	retx_effort;=0A=
+	__le16	pkt_type;	=0A=
+} __attribute__ ((packed));=0A=
+=0A=
 #define OCF_INQUIRY		0x0001=0A=
 struct hci_cp_inquiry {=0A=
 	__u8     lap[3];=0A=
@@ -662,6 +685,19 @@=0A=
 	__le16   max_local_timeout;=0A=
 } __attribute__ ((packed));=0A=
 =0A=
+#define HCI_EV_SYNC_CONN_COMPLETE  0x2C=0A=
+struct hci_ev_sync_conn_complete {=0A=
+	__u8	status;=0A=
+	__le16	handle;=0A=
+	bdaddr_t bdaddr;=0A=
+	__u8	link_type;=0A=
+	__u8	tx_interval;=0A=
+	__u8	retx_window;=0A=
+	__le16	rx_pkt_len;=0A=
+	__le16	tx_pkt_len;=0A=
+	__u8	air_mode;=0A=
+} __attribute__ ((packed));=0A=
+=0A=
 /* Internal events generated by Bluetooth stack */=0A=
 #define HCI_EV_STACK_INTERNAL	0xFD=0A=
 struct hci_ev_stack_internal {=0A=
diff -ur ../orig/src/bluetooth.mod.c ../escopatch/src/bluetooth.mod.c=0A=
--- ../orig/src/bluetooth.mod.c	2007-04-18 11:16:52.000000000 +0530=0A=
+++ ../escopatch/src/bluetooth.mod.c	2007-04-25 07:21:07.000000000 +0530=0A=
@@ -125,4 +125,4 @@=0A=
 "depends=3D";=0A=
 =0A=
 =0A=
-MODULE_INFO(srcversion, "0DEF4A4EF3FAE1E27E3D437");=0A=
+MODULE_INFO(srcversion, "72AB206AE1E9B57B1430323");=0A=
diff -ur ../orig/src/hci_conn.c ../escopatch/src/hci_conn.c=0A=
--- ../orig/src/hci_conn.c	2007-04-18 11:16:53.000000000 +0530=0A=
+++ ../escopatch/src/hci_conn.c	2007-04-25 07:45:44.000000000 +0530=0A=
@@ -130,6 +130,27 @@=0A=
 	hci_send_cmd(hdev, OGF_LINK_CTL, OCF_ADD_SCO, sizeof(cp), &cp);=0A=
 }=0A=
 =0A=
+void hci_add_esco(struct hci_conn *conn, __u16 handle)=0A=
+{=0A=
+	struct hci_dev *hdev =3D conn->hdev;=0A=
+	struct hci_cp_setup_sync_conn cp;=0A=
+=0A=
+	BT_DBG("%p", conn);=0A=
+=0A=
+	conn->state =3D BT_CONNECT;=0A=
+	conn->out =3D 1;=0A=
+=0A=
+	cp.handle =3D __cpu_to_le16(handle);=0A=
+	cp.tx_bw =3D __cpu_to_le32(0x00001f40);=0A=
+	cp.rx_bw =3D __cpu_to_le32(0x00001f40);=0A=
+	cp.max_latency =3D __cpu_to_le16(0xffff);=0A=
+	cp.voice_setting =3D __cpu_to_le16(hdev->voice_setting);=0A=
+	cp.retx_effort =3D 0x00;=0A=
+	cp.pkt_type =3D __cpu_to_le16(0x03c8); //EV3 as per spec Corev2.0+EDR=0A=
+=0A=
+	hci_send_cmd(hdev, OGF_LINK_CTL, OCF_SETUP_SYNC_CONN, sizeof(cp), &cp);=0A=
+}=0A=
+=0A=
 static void hci_conn_timeout(unsigned long arg)=0A=
 {=0A=
 	struct hci_conn *conn =3D (void *) arg;=0A=
@@ -221,7 +242,7 @@=0A=
 =0A=
 	del_timer(&conn->disc_timer);=0A=
 =0A=
-	if (conn->type =3D=3D SCO_LINK) {=0A=
+	if ((conn->type =3D=3D SCO_LINK) || (conn->type =3D=3D ESCO_LINK))  { =0A=
 		struct hci_conn *acl =3D conn->link;=0A=
 		if (acl) {=0A=
 			acl->link =3D NULL;=0A=
@@ -314,13 +335,22 @@=0A=
 	if (acl->state =3D=3D BT_OPEN || acl->state =3D=3D BT_CLOSED)=0A=
 		hci_acl_connect(acl);=0A=
 =0A=
-	if (type =3D=3D SCO_LINK) {=0A=
+	if ((type =3D=3D SCO_LINK) || (type =3D=3D ESCO_LINK)) { =0A=
 		struct hci_conn *sco;=0A=
 =0A=
-		if (!(sco =3D hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst))) {=0A=
-			if (!(sco =3D hci_conn_add(hdev, SCO_LINK, dst))) {=0A=
-				hci_conn_put(acl);=0A=
-				return NULL;=0A=
+		if(type =3D=3D SCO_LINK) { =0A=
+			if (!(sco =3D hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst))) {=0A=
+				if (!(sco =3D hci_conn_add(hdev, SCO_LINK, dst))) { =0A=
+					hci_conn_put(acl);=0A=
+					return NULL;=0A=
+				}=0A=
+			}=0A=
+		} else {=0A=
+			if (!(sco =3D hci_conn_hash_lookup_ba(hdev, ESCO_LINK, dst))) {=0A=
+				if (!(sco =3D hci_conn_add(hdev, ESCO_LINK, dst))) {=0A=
+					hci_conn_put(acl);=0A=
+					return NULL;=0A=
+				}=0A=
 			}=0A=
 		}=0A=
 		acl->link =3D sco;=0A=
@@ -329,8 +359,12 @@=0A=
 		hci_conn_hold(sco);=0A=
 =0A=
 		if (acl->state =3D=3D BT_CONNECTED && =0A=
-				(sco->state =3D=3D BT_OPEN || sco->state =3D=3D BT_CLOSED))=0A=
-			hci_add_sco(sco, acl->handle);=0A=
+				(sco->state =3D=3D BT_OPEN || sco->state =3D=3D BT_CLOSED)) {=0A=
+			if(type =3D=3D SCO_LINK) =0A=
+				hci_add_sco(sco, acl->handle); =0A=
+			else =0A=
+				hci_add_esco(sco, acl->handle); =0A=
+		}=0A=
 =0A=
 		return sco;=0A=
 	} else {=0A=
diff -ur ../orig/src/hci_event.c ../escopatch/src/hci_event.c=0A=
--- ../orig/src/hci_event.c	2007-04-18 11:16:53.000000000 +0530=0A=
+++ ../escopatch/src/hci_event.c	2007-04-25 07:40:07.000000000 +0530=0A=
@@ -82,7 +82,37 @@=0A=
 		hci_dev_unlock(hdev);=0A=
 =0A=
 		break;=0A=
+	=0A=
+	case OCF_ADD_SCO:=0A=
+		status =3D *((__u8 *) skb->data);=0A=
+		=0A=
+		/* If ADD_SCO_CONNECTION is not supported, try establishing an eSCO =
link */=0A=
+		if (status =3D=3D 0x01) {=0A=
+			struct hci_cp_add_sco *cp =3D hci_sent_cmd_data(hdev, OGF_LINK_CTL, =
OCF_ADD_SCO);=0A=
+			__u16 handle;=0A=
+			struct hci_conn *acl,*sco;=0A=
+			bdaddr_t *dst;=0A=
+			=0A=
+			if(!cp)=0A=
+				break;=0A=
+			=0A=
+			handle =3D __le16_to_cpu(cp->handle);=0A=
+=0A=
+			BT_DBG("%s Add SCO error: Command not supported. handle %d status =
0x%x. ", hdev->name, handle, status);				     =0A=
+=0A=
+			hci_dev_lock(hdev);=0A=
+			acl=3D hci_conn_hash_lookup_handle(hdev, handle);=0A=
+			if(acl && (sco=3Dacl->link)) {=0A=
+				dst =3D &(sco->dst);=0A=
+				/* Clear SCO */=0A=
+				sco->state =3D BT_CLOSED;=0A=
 =0A=
+				hci_proto_connect_cfm(sco, status);=0A=
+				hci_conn_del(sco);=0A=
+			}=0A=
+			hci_dev_unlock(hdev);=0A=
+		}=0A=
+	=0A=
 	default:=0A=
 		BT_DBG("%s Command complete: ogf LINK_CTL ocf %x", hdev->name, ocf);=0A=
 		break;=0A=
@@ -453,6 +483,33 @@=0A=
 	case OCF_CREATE_CONN:=0A=
 		hci_cs_create_conn(hdev, status);=0A=
 		break;=0A=
+	=0A=
+	case OCF_SETUP_SYNC_CONN:=0A=
+                if (status) {=0A=
+                        struct hci_conn *acl, *sco;=0A=
+                        struct hci_cp_setup_sync_conn *cp =3D =
hci_sent_cmd_data(hdev, OGF_LINK_CTL, OCF_SETUP_SYNC_CONN);=0A=
+                        __u16 handle;=0A=
+=0A=
+                        if (!cp)=0A=
+                                break;=0A=
+=0A=
+                        handle =3D __le16_to_cpu(cp->handle);=0A=
+=0A=
+                        BT_DBG("%s SETUP Sync Conn error: handle %d =
status 0x%x", hdev->name, handle, status);=0A=
+=0A=
+                        hci_dev_lock(hdev);=0A=
+=0A=
+                        acl =3D hci_conn_hash_lookup_handle(hdev, =
handle);=0A=
+                        if (acl && (sco =3D acl->link)) {=0A=
+                                sco->state =3D BT_CLOSED;=0A=
+=0A=
+                                hci_proto_connect_cfm(sco, status);=0A=
+                                hci_conn_del(sco);=0A=
+                        }=0A=
+=0A=
+                        hci_dev_unlock(hdev);=0A=
+                }=0A=
+                break;=0A=
 =0A=
 	case OCF_ADD_SCO:=0A=
 		if (status) {=0A=
@@ -1126,6 +1183,70 @@=0A=
 	hci_dev_unlock(hdev);=0A=
 }=0A=
 =0A=
+/* Synchronous Connection Complete Event */=0A=
+static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, =
struct sk_buff *skb)=0A=
+{=0A=
+	struct hci_ev_sync_conn_complete *ev =3D (struct =
hci_ev_sync_conn_complete *) skb->data;=0A=
+	struct hci_conn *conn;=0A=
+=0A=
+	BT_DBG("%s status %d", hdev->name, ev->status);=0A=
+=0A=
+	hci_dev_lock(hdev);=0A=
+	conn =3D hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);=0A=
+	if (!conn) {=0A=
+                hci_dev_unlock(hdev);=0A=
+                return;=0A=
+        }=0A=
+=0A=
+        if (!ev->status) {=0A=
+                conn->handle =3D __le16_to_cpu(ev->handle);=0A=
+                conn->state  =3D BT_CONNECTED;=0A=
+=0A=
+=0A=
+                if (test_bit(HCI_AUTH, &hdev->flags))=0A=
+                        conn->link_mode |=3D HCI_LM_AUTH;=0A=
+=0A=
+                if (test_bit(HCI_ENCRYPT, &hdev->flags))=0A=
+                        conn->link_mode |=3D HCI_LM_ENCRYPT;=0A=
+=0A=
+                /* Set packet type for incoming connection */=0A=
+                if (!conn->out) {=0A=
+                        struct hci_cp_change_conn_ptype cp;=0A=
+                        cp.handle =3D ev->handle;=0A=
+                        cp.pkt_type =3D (conn->type =3D=3D ACL_LINK) ?=0A=
+                                __cpu_to_le16(hdev->pkt_type & =
ACL_PTYPE_MASK):=0A=
+                                __cpu_to_le16(hdev->pkt_type & =
SCO_PTYPE_MASK);=0A=
+			=0A=
+                        hci_send_cmd(hdev, OGF_LINK_CTL,=0A=
+                                OCF_CHANGE_CONN_PTYPE, sizeof(cp), &cp);=0A=
+                } else {=0A=
+	                /* Update disconnect timer */=0A=
+                        hci_conn_hold(conn);=0A=
+                        hci_conn_put(conn);=0A=
+                }=0A=
+        } else=0A=
+                conn->state =3D BT_CLOSED;=0A=
+=0A=
+	if (conn->type =3D=3D ACL_LINK) {=0A=
+                struct hci_conn *sco =3D conn->link;=0A=
+                if (sco) {=0A=
+                        if (!ev->status) {=0A=
+                                hci_add_sco(sco, conn->handle);=0A=
+			}=0A=
+                        else {=0A=
+                                hci_proto_connect_cfm(sco, ev->status);=0A=
+                                hci_conn_del(sco);=0A=
+                        }=0A=
+                }=0A=
+        }=0A=
+=0A=
+        hci_proto_connect_cfm(conn, ev->status);=0A=
+        if (ev->status)=0A=
+                hci_conn_del(conn);=0A=
+=0A=
+        hci_dev_unlock(hdev);=0A=
+}=0A=
+=0A=
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)=0A=
 {=0A=
 	struct hci_event_hdr *hdr =3D (struct hci_event_hdr *) skb->data;=0A=
@@ -1161,7 +1282,7 @@=0A=
 	case HCI_EV_CONN_REQUEST:=0A=
 		hci_conn_request_evt(hdev, skb);=0A=
 		break;=0A=
-=0A=
+	=0A=
 	case HCI_EV_CONN_COMPLETE:=0A=
 		hci_conn_complete_evt(hdev, skb);=0A=
 		break;=0A=
@@ -1217,6 +1338,10 @@=0A=
 	case HCI_EV_SNIFF_SUBRATE:=0A=
 		hci_sniff_subrate_evt(hdev, skb);=0A=
 		break;=0A=
+	=0A=
+	case HCI_EV_SYNC_CONN_COMPLETE:=0A=
+		hci_sync_conn_complete_evt(hdev, skb);=0A=
+		break;=0A=
 =0A=
 	case HCI_EV_CMD_STATUS:=0A=
 		cs =3D (struct hci_ev_cmd_status *) skb->data;=0A=
diff -ur ../orig/src/l2cap.mod.c ../escopatch/src/l2cap.mod.c=0A=
--- ../orig/src/l2cap.mod.c	2007-04-18 11:16:53.000000000 +0530=0A=
+++ ../escopatch/src/l2cap.mod.c	2007-04-25 07:21:20.000000000 +0530=0A=
@@ -101,4 +101,4 @@=0A=
 "depends=3Dbluetooth";=0A=
 =0A=
 =0A=
-MODULE_INFO(srcversion, "75EF27EE0CCFFB206FCB9E2");=0A=
+MODULE_INFO(srcversion, "E07DDD764CA7D15B51CEB74");=0A=
diff -ur ../orig/src/sco.c ../escopatch/src/sco.c=0A=
--- ../orig/src/sco.c	2007-04-18 11:16:53.000000000 +0530=0A=
+++ ../escopatch/src/sco.c	2007-04-25 07:42:11.000000000 +0530=0A=
@@ -200,7 +200,8 @@=0A=
 =0A=
 	err =3D -ENOMEM;=0A=
 =0A=
-	hcon =3D hci_connect(hdev, SCO_LINK, dst);=0A=
+	//hcon =3D hci_connect(hdev, SCO_LINK, dst);=0A=
+	hcon =3D hci_connect(hdev, ESCO_LINK, dst); =0A=
 	if (!hcon)=0A=
 		goto done;=0A=
 =0A=
@@ -846,8 +847,9 @@=0A=
 {=0A=
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), =
status);=0A=
 =0A=
-	if (hcon->type !=3D SCO_LINK)=0A=
+	if ((hcon->type !=3D SCO_LINK) && (hcon->type !=3D ESCO_LINK)) { =0A=
 		return 0;=0A=
+	}=0A=
 =0A=
 	if (!status) {=0A=
 		struct sco_conn *conn;=0A=
@@ -865,8 +867,9 @@=0A=
 {=0A=
 	BT_DBG("hcon %p reason %d", hcon, reason);=0A=
 =0A=
-	if (hcon->type !=3D SCO_LINK)=0A=
+	if ((hcon->type !=3D SCO_LINK) && (hcon->type !=3D ESCO_LINK)) { =0A=
 		return 0;=0A=
+	}=0A=
 =0A=
 	sco_conn_del(hcon, bt_err(reason));=0A=
 	return 0;=0A=
diff -ur ../orig/src/sco.mod.c ../escopatch/src/sco.mod.c=0A=
--- ../orig/src/sco.mod.c	2007-04-18 11:16:52.000000000 +0530=0A=
+++ ../escopatch/src/sco.mod.c	2007-04-25 07:21:23.000000000 +0530=0A=
@@ -92,4 +92,4 @@=0A=
 "depends=3Dbluetooth";=0A=
 =0A=
 =0A=
-MODULE_INFO(srcversion, "792016A3CBF462DCE34EE81");=0A=
+MODULE_INFO(srcversion, "6E48E206EFFDE97AC6DEF28");=0A=
Only in ../escopatch/src: state=0A=

------=_NextPart_000_00B5_01C787ED.61E84780
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------=_NextPart_000_00B5_01C787ED.61E84780
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_00B5_01C787ED.61E84780--
