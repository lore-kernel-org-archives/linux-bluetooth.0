Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 3 May 2007 13:57:04 +1000
References: <016001c788a0$b7b229c0$8935c70a@dlh.st.com>
	<1178018694.25217.8.camel@violet>
In-Reply-To: <1178018694.25217.8.camel@violet>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q2VOGV5UEjPWpyy"
Message-Id: <200705031357.04459.denis.kenzior@trolltech.com>
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

--Boundary-00=_Q2VOGV5UEjPWpyy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

Here's a modified patch that implements eSCO sockets, including incoming SCO 
connections.  This was a merge of my previous work for the 2.4 series of 
kernels, so some variables might be named differently than in your patch.

I've tested it on several machines here, including eSco->eSco connection, 
eSco->sco connection for both incoming and outgoing scenarios, everything 
seems fine, however I'm sure more testing is required.

> this patch is incomplete. It doesn't handle incoming eSCO connections
> and it can't handle SCO audio packets over HCI when a real eSCO
> connection has been established.

Why do you say this? What is required in order to get eSCO packets flowing?

-Denis

--Boundary-00=_Q2VOGV5UEjPWpyy
Content-Type: text/x-diff;
  charset="utf-8";
  name="esco.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="esco.patch"

diff -r -p -U5 linux-2.6.20.7/include/net/bluetooth/hci_core.h linux-2.6.20.7-dkenzior/include/net/bluetooth/hci_core.h
--- linux-2.6.20.7/include/net/bluetooth/hci_core.h	2007-04-14 06:48:14.000000000 +1000
+++ linux-2.6.20.7-dkenzior/include/net/bluetooth/hci_core.h	2007-05-02 07:45:15.000000000 +1000
@@ -76,10 +76,11 @@ struct hci_dev {
 	__u16		hci_rev;
 	__u16		manufacturer;
 	__u16		voice_setting;
 
 	__u16		pkt_type;
+	__u16		esco_pkt_type;
 	__u16		link_policy;
 	__u16		link_mode;
 
 	__u32		idle_timeout;
 	__u16		sniff_min_interval;
@@ -447,10 +448,11 @@ void hci_conn_del_sysfs(struct hci_conn 
 /* ----- LMP capabilities ----- */
 #define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
 #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
 #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
 #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
+#define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 
 /* ----- HCI protocols ----- */
 struct hci_proto {
 	char 		*name;
 	unsigned int	id;
diff -r -p -U5 linux-2.6.20.7/include/net/bluetooth/hci.h linux-2.6.20.7-dkenzior/include/net/bluetooth/hci.h
--- linux-2.6.20.7/include/net/bluetooth/hci.h	2007-04-14 06:48:14.000000000 +1000
+++ linux-2.6.20.7-dkenzior/include/net/bluetooth/hci.h	2007-05-03 13:30:27.000000000 +1000
@@ -127,19 +127,33 @@ enum {
 #define HCI_HV3		0x0080
 
 #define SCO_PTYPE_MASK	(HCI_HV1 | HCI_HV2 | HCI_HV3)
 #define ACL_PTYPE_MASK	(~SCO_PTYPE_MASK)
 
+/* eSCO packet types */
+#define HCI_ESCO_HV1	0x0001
+#define HCI_ESCO_HV2	0x0002
+#define HCI_ESCO_HV3	0x0004
+#define HCI_ESCO_EV3	0x0008
+#define HCI_ESCO_EV4	0x0010
+#define HCI_ESCO_EV5	0x0020
+
+/* Some devices seem to have trouble establishing EV* packet connections */
+/* with other devices.  For this reason we mask out the eSCO packets */ 
+/* for now.  Might need to address this later */
+#define ESCO_PTYPE_MASK	(HCI_ESCO_HV1 | HCI_ESCO_HV2 | HCI_ESCO_HV3)
+
 /* ACL flags */
 #define ACL_CONT		0x01
 #define ACL_START		0x02
 #define ACL_ACTIVE_BCAST	0x04
 #define ACL_PICO_BCAST		0x08
 
 /* Baseband links */
 #define SCO_LINK	0x00
 #define ACL_LINK	0x01
+#define ESCO_LINK	0x02
 
 /* LMP features */
 #define LMP_3SLOT	0x01
 #define LMP_5SLOT	0x02
 #define LMP_ENCRYPT	0x04
@@ -156,10 +170,15 @@ enum {
 #define LMP_HV2		0x10
 #define LMP_HV3		0x20
 #define LMP_ULAW	0x40
 #define LMP_ALAW	0x80
 
+/* eSCO support and packets */
+#define LMP_ESCO	0x80
+#define LMP_EV4		0x01
+#define LMP_EV5		0x02
+
 #define LMP_CVSD	0x01
 #define LMP_PSCHEME	0x02
 #define LMP_PCONTROL	0x04
 
 #define LMP_SNIFF_SUBR	0x02
@@ -317,16 +336,33 @@ struct hci_cp_create_conn_cancel {
 struct hci_cp_accept_conn_req {
 	bdaddr_t bdaddr;
 	__u8     role;
 } __attribute__ ((packed));
 
+#define OCF_ACCEPT_SYNC_CONN_REQ	0x0029
+struct hci_cp_accept_sync_conn_req {
+	bdaddr_t	bdaddr;
+	__le32		tx_rate;
+	__le32		rx_rate;
+	__le16		max_latency;
+	__le16		voice_setting;
+	__u8		retrans_effort;
+	__le16		pkt_type;
+} __attribute__((packed));
+
 #define OCF_REJECT_CONN_REQ	0x000a
 struct hci_cp_reject_conn_req {
 	bdaddr_t bdaddr;
 	__u8     reason;
 } __attribute__ ((packed));
 
+#define OCF_REJECT_SYNC_CONN_REQ	0x002a
+struct hci_cp_reject_sync_conn_req {
+	bdaddr_t 	bdaddr;
+	__u8		reason;
+} __attribute__ ((packed));
+
 #define OCF_DISCONNECT	0x0006
 struct hci_cp_disconnect {
 	__le16   handle;
 	__u8     reason;
 } __attribute__ ((packed));
@@ -335,10 +371,21 @@ struct hci_cp_disconnect {
 struct hci_cp_add_sco {
 	__le16   handle;
 	__le16   pkt_type;
 } __attribute__ ((packed));
 
+#define OCF_SETUP_SYNC_CONN	0x0028
+struct hci_cp_setup_sync_conn {
+	__le16	handle;
+	__le32 	tx_rate;
+	__le32	rx_rate;
+	__le16	latency;
+	__le16	voice_setting;
+	__u8	retrans_effort;
+	__le16	pkt_type;
+} __attribute__ ((packed));
+
 #define OCF_INQUIRY		0x0001
 struct hci_cp_inquiry {
 	__u8     lap[3];
 	__u8     length;
 	__u8     num_rsp;
@@ -523,10 +570,33 @@ struct hci_ev_conn_complete {
 	bdaddr_t bdaddr;
 	__u8     link_type;
 	__u8     encr_mode;
 } __attribute__ ((packed));
 
+#define HCI_EV_SYNC_CONN_COMPLETE	0x2C
+struct hci_ev_sync_conn_complete {
+	__u8 		status;
+	__le16		handle;
+	bdaddr_t	bdaddr;
+	__u8		link_type;
+	__u8		trans_interval;
+	__u8		retrans_window;
+	__le16		rx_pkt_len;
+	__le16		tx_pkt_len;
+	__u8		air_mode;
+} __attribute__ ((packed));
+
+#define HCI_EV_SYNC_CONN_CHANGED       0x2D
+struct hci_ev_sync_conn_changed {
+	__u8		status;
+	__le16		handle;
+	__u8		trans_interval;
+	__u8		retrans_window;
+	__le16		rx_pkt_len;
+	__le16		tx_pkt_len;
+} __attribute__ ((packed));
+
 #define HCI_EV_CONN_REQUEST	0x04
 struct hci_ev_conn_request {
 	bdaddr_t bdaddr;
 	__u8     dev_class[3];
 	__u8     link_type;
diff -r -p -U5 linux-2.6.20.7/net/bluetooth/hci_conn.c linux-2.6.20.7-dkenzior/net/bluetooth/hci_conn.c
--- linux-2.6.20.7/net/bluetooth/hci_conn.c	2007-04-14 06:48:14.000000000 +1000
+++ linux-2.6.20.7-dkenzior/net/bluetooth/hci_conn.c	2007-05-02 09:54:33.000000000 +1000
@@ -115,21 +115,37 @@ void hci_acl_disconn(struct hci_conn *co
 }
 
 void hci_add_sco(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_add_sco cp;
 
 	BT_DBG("%p", conn);
 
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 
-	cp.pkt_type = __cpu_to_le16(hdev->pkt_type & SCO_PTYPE_MASK);
-	cp.handle   = __cpu_to_le16(handle);
+	/* Devices that support 1.2 should be using the eSCO */
+	/* commands.  Add SCO commands were deprecated in 1.2 */
 
-	hci_send_cmd(hdev, OGF_LINK_CTL, OCF_ADD_SCO, sizeof(cp), &cp);
+	if (lmp_esco_capable(hdev)) {
+		struct hci_cp_setup_sync_conn cp;
+		cp.handle = __cpu_to_le16(handle);
+		cp.tx_rate = __cpu_to_le32(0x1f40);
+		cp.rx_rate = __cpu_to_le32(0x1f40);
+		cp.latency = __cpu_to_le16(0xffff);
+		cp.voice_setting = __cpu_to_le16(hdev->voice_setting);
+		cp.retrans_effort = 0xff;
+		cp.pkt_type = __cpu_to_le16(hdev->esco_pkt_type & ESCO_PTYPE_MASK);
+	
+		hci_send_cmd(hdev, OGF_LINK_CTL, OCF_SETUP_SYNC_CONN, sizeof(cp), &cp);
+	} else {
+		struct hci_cp_add_sco cp;
+		cp.pkt_type = __cpu_to_le16(hdev->pkt_type & SCO_PTYPE_MASK);
+		cp.handle   = __cpu_to_le16(handle);
+
+		hci_send_cmd(hdev, OGF_LINK_CTL, OCF_ADD_SCO, sizeof(cp), &cp);
+	}
 }
 
 static void hci_conn_timeout(unsigned long arg)
 {
 	struct hci_conn *conn = (void *) arg;
@@ -142,11 +158,14 @@ static void hci_conn_timeout(unsigned lo
 
 	hci_dev_lock(hdev);
 
 	switch (conn->state) {
 	case BT_CONNECT:
-		hci_acl_connect_cancel(conn);
+		if (conn->type == ACL_LINK)
+			hci_acl_connect_cancel(conn);
+		else
+			conn->state = BT_CLOSED;
 		break;
  	case BT_CONNECTED:
 		hci_acl_disconn(conn, 0x13);
 		break;
 	default:
@@ -219,23 +238,23 @@ int hci_conn_del(struct hci_conn *conn)
 
 	del_timer(&conn->idle_timer);
 
 	del_timer(&conn->disc_timer);
 
-	if (conn->type == SCO_LINK) {
-		struct hci_conn *acl = conn->link;
-		if (acl) {
-			acl->link = NULL;
-			hci_conn_put(acl);
-		}
-	} else {
+	if (conn->type == ACL_LINK) {
 		struct hci_conn *sco = conn->link;
 		if (sco)
 			sco->link = NULL;
 
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
+	} else {
+		struct hci_conn *acl = conn->link;
+		if (acl) {
+			acl->link = NULL;
+			hci_conn_put(acl);
+		}
 	}
 
 	tasklet_disable(&hdev->tx_task);
 
 	hci_conn_del_sysfs(conn);
@@ -299,10 +318,11 @@ EXPORT_SYMBOL(hci_get_route);
 /* Create SCO or ACL connection.
  * Device _must_ be locked */
 struct hci_conn * hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *acl;
+	struct hci_conn *sco;
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
 	if (!(acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst))) {
 		if (!(acl = hci_conn_add(hdev, ACL_LINK, dst)))
@@ -312,32 +332,29 @@ struct hci_conn * hci_connect(struct hci
 	hci_conn_hold(acl);
 
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED)
 		hci_acl_connect(acl);
 
-	if (type == SCO_LINK) {
-		struct hci_conn *sco;
+	if (type == ACL_LINK)
+		return acl;
 
-		if (!(sco = hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst))) {
-			if (!(sco = hci_conn_add(hdev, SCO_LINK, dst))) {
-				hci_conn_put(acl);
-				return NULL;
-			}
+	if (!(sco = hci_conn_hash_lookup_ba(hdev, type, dst))) {
+		if (!(sco = hci_conn_add(hdev, type, dst))) {
+			hci_conn_put(acl);
+			return NULL;
 		}
-		acl->link = sco;
-		sco->link = acl;
+	}
+	acl->link = sco;
+	sco->link = acl;
 
-		hci_conn_hold(sco);
+	hci_conn_hold(sco);
 
-		if (acl->state == BT_CONNECTED && 
-				(sco->state == BT_OPEN || sco->state == BT_CLOSED))
-			hci_add_sco(sco, acl->handle);
+	if (acl->state == BT_CONNECTED && 
+			(sco->state == BT_OPEN || sco->state == BT_CLOSED))
+		hci_add_sco(sco, acl->handle);
 
-		return sco;
-	} else {
-		return acl;
-	}
+	return sco;
 }
 EXPORT_SYMBOL(hci_connect);
 
 /* Authenticate remote device */
 int hci_conn_auth(struct hci_conn *conn)
diff -r -p -U5 linux-2.6.20.7/net/bluetooth/hci_core.c linux-2.6.20.7-dkenzior/net/bluetooth/hci_core.c
--- linux-2.6.20.7/net/bluetooth/hci_core.c	2007-04-14 06:48:14.000000000 +1000
+++ linux-2.6.20.7-dkenzior/net/bluetooth/hci_core.c	2007-04-26 10:50:06.000000000 +1000
@@ -849,10 +849,11 @@ int hci_register_dev(struct hci_dev *hde
 	atomic_set(&hdev->refcnt, 1);
 	spin_lock_init(&hdev->lock);
 
 	hdev->flags = 0;
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
+	hdev->esco_pkt_type = HCI_ESCO_HV1;
 	hdev->link_mode = (HCI_LM_ACCEPT);
 
 	hdev->idle_timeout = 0;
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
diff -r -p -U5 linux-2.6.20.7/net/bluetooth/hci_event.c linux-2.6.20.7-dkenzior/net/bluetooth/hci_event.c
--- linux-2.6.20.7/net/bluetooth/hci_event.c	2007-04-14 06:48:14.000000000 +1000
+++ linux-2.6.20.7-dkenzior/net/bluetooth/hci_event.c	2007-05-03 12:35:17.000000000 +1000
@@ -349,18 +349,32 @@ static void hci_cc_info_param(struct hci
 			hdev->pkt_type |= (HCI_DM3 | HCI_DH3);
 
 		if (hdev->features[0] & LMP_5SLOT)
 			hdev->pkt_type |= (HCI_DM5 | HCI_DH5);
 
-		if (hdev->features[1] & LMP_HV2)
-			hdev->pkt_type |= (HCI_HV2);
+		if (hdev->features[1] & LMP_HV2) {
+			hdev->pkt_type |= HCI_HV2;
+			hdev->esco_pkt_type |= HCI_ESCO_HV2;
+		}
+
+		if (hdev->features[1] & LMP_HV3) {
+			hdev->pkt_type |= HCI_HV3;
+			hdev->esco_pkt_type |= HCI_ESCO_HV3;
+		}
+
+		if (hdev->features[4] & LMP_ESCO)
+			hdev->esco_pkt_type |= HCI_ESCO_EV3;
 
-		if (hdev->features[1] & LMP_HV3)
-			hdev->pkt_type |= (HCI_HV3);
+		if (hdev->features[5] & LMP_EV4)
+			hdev->esco_pkt_type |= HCI_ESCO_EV4;
+
+		if (hdev->features[5] & LMP_EV5)
+			hdev->esco_pkt_type |= HCI_ESCO_EV5;
 
 		BT_DBG("%s: features 0x%x 0x%x 0x%x", hdev->name,
 				lf->features[0], lf->features[1], lf->features[2]);
+		BT_DBG("%s: eSco packets: 0x%x", hdev->name, hdev->esco_pkt_type);
 
 		break;
 
 	case OCF_READ_BUFFER_SIZE:
 		bs = (struct hci_rp_read_buffer_size *) skb->data;
@@ -443,44 +457,80 @@ static inline void hci_cs_create_conn(st
 	}
 
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cs_link_ctl(struct hci_dev *hdev, __u16 ocf, __u8 status)
+static inline void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 {
-	BT_DBG("%s ocf 0x%x", hdev->name, ocf);
+	struct hci_conn *acl, *sco;
+	struct hci_cp_add_sco *cp = hci_sent_cmd_data(hdev, OGF_LINK_CTL, OCF_ADD_SCO);
 
-	switch (ocf) {
-	case OCF_CREATE_CONN:
-		hci_cs_create_conn(hdev, status);
-		break;
+	if (!cp)
+		return;	
 
-	case OCF_ADD_SCO:
-		if (status) {
-			struct hci_conn *acl, *sco;
-			struct hci_cp_add_sco *cp = hci_sent_cmd_data(hdev, OGF_LINK_CTL, OCF_ADD_SCO);
-			__u16 handle;
+	hci_dev_lock(hdev);
 
-			if (!cp)
-				break;
+	if (status) {
+		__u16 handle = __le16_to_cpu(cp->handle);
 
-			handle = __le16_to_cpu(cp->handle);
+		BT_DBG("%s Add SCO error: handle %d status 0x%x", hdev->name, handle, status);
 
-			BT_DBG("%s Add SCO error: handle %d status 0x%x", hdev->name, handle, status);
+		acl = hci_conn_hash_lookup_handle(hdev, handle);
+		if (acl && (sco = acl->link)) {
+			sco->state = BT_CLOSED;
 
-			hci_dev_lock(hdev);
+			hci_proto_connect_cfm(sco, status);
+			hci_conn_del(sco);
+		}
+	}
 
-			acl = hci_conn_hash_lookup_handle(hdev, handle);
-			if (acl && (sco = acl->link)) {
-				sco->state = BT_CLOSED;
+	hci_dev_unlock(hdev);
+}
 
-				hci_proto_connect_cfm(sco, status);
-				hci_conn_del(sco);
-			}
+static inline void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
+{
+	struct hci_conn *acl, *sco;
+	struct hci_cp_setup_sync_conn *cp = hci_sent_cmd_data(hdev, OGF_LINK_CTL, OCF_SETUP_SYNC_CONN);
 
-			hci_dev_unlock(hdev);
+	if (!cp)
+		return;	
+
+	hci_dev_lock(hdev);
+
+	if (status) {
+		__u16 handle = __le16_to_cpu(cp->handle);
+
+		BT_DBG("%s eSCO conn setup error: handle %d status 0x%x",
+			hdev->name, handle, status);
+
+		acl = hci_conn_hash_lookup_handle(hdev, handle);
+		if (acl && (sco = acl->link)) {
+			sco->state = BT_CLOSED;
+
+			hci_proto_connect_cfm(sco, status);
+			hci_conn_del(sco);
 		}
+	}
+
+	hci_dev_unlock(hdev);	
+}
+
+static void hci_cs_link_ctl(struct hci_dev *hdev, __u16 ocf, __u8 status)
+{
+	BT_DBG("%s ocf 0x%x", hdev->name, ocf);
+	
+	switch (ocf) {
+	case OCF_CREATE_CONN:
+		hci_cs_create_conn(hdev, status);
+		break;
+
+	case OCF_ADD_SCO:
+		hci_cs_add_sco(hdev, status);
+		break;
+
+	case OCF_SETUP_SYNC_CONN:
+		hci_cs_setup_sync_conn(hdev, status);
 		break;
 
 	case OCF_INQUIRY:
 		if (status) {
 			BT_DBG("%s Inquiry error: status 0x%x", hdev->name, status);
@@ -709,11 +759,10 @@ static inline void hci_conn_request_evt(
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
 
 	if (mask & HCI_LM_ACCEPT) {
 		/* Connection accepted */
 		struct hci_conn *conn;
-		struct hci_cp_accept_conn_req cp;
 
 		hci_dev_lock(hdev);
 		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 		if (!conn) {
 			if (!(conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr))) {
@@ -724,27 +773,55 @@ static inline void hci_conn_request_evt(
 		}
 		memcpy(conn->dev_class, ev->dev_class, 3);
 		conn->state = BT_CONNECT;
 		hci_dev_unlock(hdev);
 
-		bacpy(&cp.bdaddr, &ev->bdaddr);
+		if ((ev->link_type == ACL_LINK) || (!lmp_esco_capable(hdev))) {
+			struct hci_cp_accept_conn_req cp;
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+
+			if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
+				cp.role = 0x00; /* Become master */
+			else
+				cp.role = 0x01; /* Remain slave */
 
-		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
-			cp.role = 0x00; /* Become master */
-		else
-			cp.role = 0x01; /* Remain slave */
+			hci_send_cmd(hdev, OGF_LINK_CTL,
+					OCF_ACCEPT_CONN_REQ, sizeof(cp), &cp);
+		} else {
+			/* Send the Accept Sync Connection Command */
+			struct hci_cp_accept_sync_conn_req cp;
+			
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			cp.tx_rate = __cpu_to_le32(0x1f40);
+			cp.rx_rate = __cpu_to_le32(0x1f40);
+			cp.max_latency = __cpu_to_le16(0xffff);
+			cp.voice_setting = __cpu_to_le16(hdev->voice_setting);
+			cp.retrans_effort = 0xff;
+			cp.pkt_type = __cpu_to_le16(hdev->esco_pkt_type & ESCO_PTYPE_MASK);
 
-		hci_send_cmd(hdev, OGF_LINK_CTL,
-				OCF_ACCEPT_CONN_REQ, sizeof(cp), &cp);
+			hci_send_cmd(hdev, OGF_LINK_CTL,
+					OCF_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+		}
 	} else {
 		/* Connection rejected */
-		struct hci_cp_reject_conn_req cp;
 
-		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.reason = 0x0f;
-		hci_send_cmd(hdev, OGF_LINK_CTL,
-				OCF_REJECT_CONN_REQ, sizeof(cp), &cp);
+		if ((ev->link_type == ACL_LINK) || (!lmp_esco_capable(hdev))) {
+			struct hci_cp_reject_conn_req cp;
+
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			cp.reason = 0x0f;
+			hci_send_cmd(hdev, OGF_LINK_CTL,
+					OCF_REJECT_CONN_REQ, sizeof(cp), &cp);
+		} else {
+			struct hci_cp_reject_sync_conn_req cp;
+			
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			cp.reason = 0x0f;
+
+			hci_send_cmd(hdev, OGF_LINK_CTL,
+					OCF_REJECT_SYNC_CONN_REQ, sizeof(cp), &cp);
+		}
 	}
 }
 
 /* Connect Complete */
 static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -828,10 +905,60 @@ static inline void hci_conn_complete_evt
 		hci_acl_connect(pend);
 
 	hci_dev_unlock(hdev);
 }
 
+/* eSCO Connect Complete */
+static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_sync_conn_complete *ev = (struct hci_ev_sync_conn_complete *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	/* There are two possibilities here.  We establish an outgoing ESCO link and get */
+	/* back a SCO link.  Or we got a connect request with a SCO/ESCO link type and */
+	/* arrived here once it was established */
+	conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+	if (!conn) {
+		/* Incoming SCO case */
+		conn = hci_conn_hash_lookup_ba(hdev, SCO_LINK, &ev->bdaddr);
+		if (!conn) {
+			hci_dev_unlock(hdev);
+			return;
+		}
+
+		if (conn->out) {
+			BT_DBG("ended up with a SCO link");
+			hci_conn_del(conn);
+			hci_dev_unlock(hdev);
+			return;
+		}
+	}
+
+	if (!ev->status) {
+		conn->handle = __le16_to_cpu(ev->handle);
+		conn->type = ev->link_type;
+		conn->state  = BT_CONNECTED;
+
+		if (conn->out) {
+			/* Update disconnect timer */
+			hci_conn_hold(conn);
+			hci_conn_put(conn);
+		}
+	} else
+		conn->state = BT_CLOSED;
+
+	hci_proto_connect_cfm(conn, ev->status);
+	if (ev->status)
+		hci_conn_del(conn);
+
+	hci_dev_unlock(hdev);
+}
+
 /* Disconnect Complete */
 static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (struct hci_ev_disconn_complete *) skb->data;
 	struct hci_conn *conn;
@@ -880,16 +1007,16 @@ static inline void hci_num_comp_pkts_evt
 
 		conn = hci_conn_hash_lookup_handle(hdev, handle);
 		if (conn) {
 			conn->sent -= count;
 
-			if (conn->type == SCO_LINK) {
-				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
-					hdev->sco_cnt = hdev->sco_pkts;
-			} else {
+			if (conn->type == ACL_LINK) {
 				if ((hdev->acl_cnt += count) > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
+			} else {
+				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
+					hdev->sco_cnt = hdev->sco_pkts;
 			}
 		}
 	}
 	hci_sched_tx(hdev);
 
@@ -1164,10 +1291,14 @@ void hci_event_packet(struct hci_dev *hd
 
 	case HCI_EV_CONN_COMPLETE:
 		hci_conn_complete_evt(hdev, skb);
 		break;
 
+	case HCI_EV_SYNC_CONN_COMPLETE:
+		hci_sync_conn_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_DISCONN_COMPLETE:
 		hci_disconn_complete_evt(hdev, skb);
 		break;
 
 	case HCI_EV_ROLE_CHANGE:
diff -r -p -U5 linux-2.6.20.7/net/bluetooth/sco.c linux-2.6.20.7-dkenzior/net/bluetooth/sco.c
--- linux-2.6.20.7/net/bluetooth/sco.c	2007-04-14 06:48:14.000000000 +1000
+++ linux-2.6.20.7-dkenzior/net/bluetooth/sco.c	2007-05-03 10:18:22.000000000 +1000
@@ -187,22 +187,24 @@ static int sco_connect(struct sock *sk)
 	bdaddr_t *src = &bt_sk(sk)->src;
 	bdaddr_t *dst = &bt_sk(sk)->dst;
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
-	int err = 0;
+	int err, type;
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
 	if (!(hdev = hci_get_route(dst, src)))
 		return -EHOSTUNREACH;
 
 	hci_dev_lock_bh(hdev);
 
 	err = -ENOMEM;
 
-	hcon = hci_connect(hdev, SCO_LINK, dst);
+	type = lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;
+
+	hcon = hci_connect(hdev, type, dst);
 	if (!hcon)
 		goto done;
 
 	conn = sco_conn_add(hcon, 0);
 	if (!conn) {
@@ -836,19 +838,22 @@ done:
 /* ----- SCO interface with lower layer (HCI) ----- */
 static int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
 {
 	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));
 
+	if (type != SCO_LINK && type != ESCO_LINK)
+		return 0;
+
 	/* Always accept connection */
 	return HCI_LM_ACCEPT;
 }
 
 static int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 
-	if (hcon->type != SCO_LINK)
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
 		return 0;
 
 	if (!status) {
 		struct sco_conn *conn;
 
@@ -863,11 +868,11 @@ static int sco_connect_cfm(struct hci_co
 
 static int sco_disconn_ind(struct hci_conn *hcon, __u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
-	if (hcon->type != SCO_LINK)
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
 		return 0;
 
 	sco_conn_del(hcon, bt_err(reason));
 	return 0;
 }

--Boundary-00=_Q2VOGV5UEjPWpyy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_Q2VOGV5UEjPWpyy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_Q2VOGV5UEjPWpyy--
