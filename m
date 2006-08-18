Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Fri, 18 Aug 2006 17:56:25 +0530
Message-ID: <000801c6c2c1$85dcbaf0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0009_01C6C2EF.9F94F6F0"
In-Reply-To: <1155909848.4075.185.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
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

------=_NextPart_000_0009_01C6C2EF.9F94F6F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > Sending Host No of Completed Packets:
> > hci_cmd_task: hci0 command tx timeout
> > Sending Host No of Completed Packets:
> >=20
> >=20
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Note that "Sending Host No of Completed Packets:" has been=20
> added by me. Can
> > you tell me the reason for "hci_cmd_task: hci0 command tx timeout"
>=20
> I have to see the source code. Otherwise it would be only a=20
> wild guess.

Here you go. Though, it is not the latest version of files that I am =
working
on.
It's a quick and dirty approach right now. Sending Host Number of =
Completed
Packets as soon as we receive ACL Data Packet on any connection handle.
Once this works, I'll try to send Host Number of completed packets after
reception of 8 packets.

Regards,
Mayank

------=_NextPart_000_0009_01C6C2EF.9F94F6F0
Content-Type: application/octet-stream;
	name="hci.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hci.h.diff"

--- C:\Copy of hci.h	2006-05-31 21:12:40.000000000 +-0530
+++ C:\hci.h	2006-08-18 17:43:09.000000000 +-0530
@@ -817,20 +817,38 @@
 	uint8_t		status;
 	uint16_t	handle;
 	int8_t		level;
 } __attribute__ ((packed)) read_transmit_power_level_rp;
 #define READ_TRANSMIT_POWER_LEVEL_RP_SIZE 4
 
+#define OCF_SET_CONTROLLER_TO_HOST_FC	0x0031
+typedef struct {
+	uint8_t		flow_control_enable;
+} __attribute__ ((packed)) set_controller_to_host_fc_cp;
+#define SET_CONTROLLER_TO_HOST_FC_CP_SIZE	1
+typedef struct {
+	uint8_t		status;
+} __attribute__ ((packed)) set_controller_to_host_fc_rp;
+#define SET_CONTROLLER_TO_HOST_FC_RP_SIZE	1
+
 #define OCF_HOST_BUFFER_SIZE		0x0033
 typedef struct {
 	uint16_t	acl_mtu;
 	uint8_t		sco_mtu;
 	uint16_t	acl_max_pkt;
 	uint16_t	sco_max_pkt;
 } __attribute__ ((packed)) host_buffer_size_cp;
 #define HOST_BUFFER_SIZE_CP_SIZE 7
+
+#define OCF_HOST_NUM_OF_COMPLETED_PACKETS	0x0035
+typedef struct {
+	uint8_t		num_of_handles;
+	uint16_t	handle;
+	uint16_t	host_num_of_completed_packets;
+} __attribute__ ((packed)) host_num_of_completed_packets_cp;
+#define OCF_HOST_NUM_OF_COMPLETED_PACKETS_CP_SIZE 5
 
 #define OCF_READ_LINK_SUPERVISION_TIMEOUT	0x0036
 typedef struct {
 	uint8_t		status;
 	uint16_t	handle;
 	uint16_t	link_sup_to;

------=_NextPart_000_0009_01C6C2EF.9F94F6F0
Content-Type: application/octet-stream;
	name="hci_core.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hci_core.diff"

--- C:\Copy of hci_core.c	2003-03-14 03:53:16.000000000 +-0530
+++ C:\hci_core.c	2006-08-18 17:50:19.000000000 +-0530
@@ -73,12 +73,13 @@
 #define HCI_MAX_PROTO	2
 struct hci_proto *hci_proto[HCI_MAX_PROTO];
=20
 /* HCI notifiers list */
 static struct notifier_block *hci_notifier;
=20
+extern int __controller_to_host_fc;
=20
 /* ---- HCI notifications ---- */
=20
 int hci_register_notifier(struct notifier_block *nb)
 {
 	return notifier_chain_register(&hci_notifier, nb);
@@ -221,24 +222,22 @@
 	/* Read Local Supported Features */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_LOCAL_FEATURES, 0, NULL);
=20
 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BUFFER_SIZE, 0, NULL);
=20
-#if 0
 	/* Host buffer size */
 	{
 		host_buffer_size_cp bs;
 		bs.acl_mtu =3D __cpu_to_le16(HCI_MAX_ACL_SIZE);
 		bs.sco_mtu =3D HCI_MAX_SCO_SIZE;
 		bs.acl_max_pkt =3D __cpu_to_le16(0xffff);
 		bs.sco_max_pkt =3D __cpu_to_le16(0xffff);
 		hci_send_cmd(hdev, OGF_HOST_CTL, OCF_HOST_BUFFER_SIZE,
 				HOST_BUFFER_SIZE_CP_SIZE, &bs);
 	}
-#endif
=20
 	/* Read BD Address */
 	hci_send_cmd(hdev, OGF_INFO_PARAM, OCF_READ_BD_ADDR, 0, NULL);
=20
 	/* Optional initialization */
=20
@@ -1273,12 +1272,13 @@
 /* ACL data packet */
 static inline void hci_acldata_packet(struct hci_dev *hdev, struct =
sk_buff *skb)
 {
 	hci_acl_hdr *ah =3D (void *) skb->data;
 	struct hci_conn *conn;
 	__u16 handle, flags;
+	host_num_of_completed_packets_cp cp;
=20
 	skb_pull(skb, HCI_ACL_HDR_SIZE);
=20
 	handle =3D __le16_to_cpu(ah->handle);
 	flags  =3D acl_flags(handle);
 	handle =3D acl_handle(handle);
@@ -1287,12 +1287,24 @@
=20
 	hdev->stat.acl_rx++;
=20
 	hci_dev_lock(hdev);
 	conn =3D conn_hash_lookup_handle(hdev, handle);
 	hci_dev_unlock(hdev);
+	/* If flow control has been enabled from Controller to Host
+	 * send Host Number of Completed Packets Command
+	 * Note that there is no event generated for this command
+	 */
+
+	if(__controller_to_host_fc) {
+		cp.num_of_handles =3D 0x01;
+		cp.handle =3D handle;
+		cp.host_num_of_completed_packets =3D 0x01;
+		hci_send_cmd(hdev, OGF_HOST_CTL, OCF_HOST_NUM_OF_COMPLETED_PACKETS,=20
+				OCF_HOST_NUM_OF_COMPLETED_PACKETS_CP_SIZE, &cp);
+	}
 =09
 	if (conn) {
 		register struct hci_proto *hp;
=20
 		/* Send to upper protocol */
 		if ((hp =3D hci_proto[HCI_PROTO_L2CAP]) && hp->recv_acldata) {

------=_NextPart_000_0009_01C6C2EF.9F94F6F0
Content-Type: application/octet-stream;
	name="hci_event.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hci_event.diff"

--- C:\Copy of hci_event.c	2006-08-17 17:37:06.000000000 +-0530
+++ C:\hci_event.c	2006-08-18 17:51:37.000000000 +-0530
@@ -54,12 +54,14 @@
=20
 #ifndef HCI_CORE_DEBUG
 #undef  BT_DBG
 #define BT_DBG( A... )
 #endif
=20
+int __controller_to_host_fc =3D 0;
+
 /* Handle HCI Event packets */
=20
 /* Command Complete OGF LINK_CTL  */
 static void hci_cc_link_ctl(struct hci_dev *hdev, __u16 ocf, struct =
sk_buff *skb)
 {
 	BT_DBG("%s ocf 0x%x", hdev->name, ocf);
@@ -108,12 +110,13 @@
=20
 /* Command Complete OGF HOST_CTL  */
 static void hci_cc_host_ctl(struct hci_dev *hdev, __u16 ocf, struct =
sk_buff *skb)
 {
 	__u8 status, param;
 	void *sent;
+	set_controller_to_host_fc_cp cp;
=20
 	BT_DBG("%s ocf 0x%x", hdev->name, ocf);
=20
 	switch (ocf) {
 	case OCF_RESET:
 		status =3D *((__u8 *) skb->data);
@@ -205,12 +208,33 @@
 	case OCF_HOST_BUFFER_SIZE:
 		status =3D *((__u8 *) skb->data);
 		if (status) {
 			BT_DBG("%s OCF_BUFFER_SIZE failed %d", hdev->name, status);
 			hci_req_complete(hdev, status);
 		}
+		else {
+			memset(&cp, 0, sizeof(cp));
+			/* Set Flow Control on for HCI ACL Data Packets
+			 * and off for HCI Synchronous Data Packets
+			 */
+			cp.flow_control_enable =3D 0x01;
+			=09
+			hci_send_cmd(hdev, OGF_HOST_CTL, OCF_SET_CONTROLLER_TO_HOST_FC,
+				SET_CONTROLLER_TO_HOST_FC_CP_SIZE, &cp);
+		}
+		break;
+
+	case OCF_SET_CONTROLLER_TO_HOST_FC:
+		status =3D *((__u8 *) skb->data);
+		if (status) {
+			BT_DBG("%s OCF_SET_CONTROLLER_TO_HOST_FC failed %d", hdev->name, =
status);
+			hci_req_complete(hdev, status);
+		}
+		else {
+			__controller_to_host_fc =3D 1; /* Start using Controller to Host =
Flow Control */
+		}
 		break;
=20
 	default:
 		BT_DBG("%s Command complete: ogf HOST_CTL ocf %x", hdev->name, ocf);
 		break;
 	};

------=_NextPart_000_0009_01C6C2EF.9F94F6F0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_NextPart_000_0009_01C6C2EF.9F94F6F0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0009_01C6C2EF.9F94F6F0--
