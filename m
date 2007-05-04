Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 4 May 2007 17:36:30 +1000
References: <016001c788a0$b7b229c0$8935c70a@dlh.st.com>
	<200705031357.04459.denis.kenzior@trolltech.com>
	<1178169928.6891.39.camel@violet>
In-Reply-To: <1178169928.6891.39.camel@violet>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/JuOGj7v6qIJQuP"
Message-Id: <200705041736.31072.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Esco implementation patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_/JuOGj7v6qIJQuP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

> please make sure you use my naming of variables. Otherwise it is too
> much confusion. And please create a patch relative to this one so I can
> actually review it. And please keep hci_setup_sync(). Doing the
> separation this way it more logical than hacking up hci_add_sco(). The
> function that decides which command to use should be hci_connect().

Attached is a patch against yours.

Can you point me in the right direction with regard to adding ESCO packets to 
be transported over HCI?

Also, I noticed that SCO connections are accepted regardless of whether a SCO 
socket is open or not.  Is this intended?

-Denis

--Boundary-00=_/JuOGj7v6qIJQuP
Content-Type: text/x-diff; charset="iso-8859-1";
	name="esco-patch-marcels-changes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="esco-patch-marcels-changes.patch"

diff -p -U5 -r linux-2.6.21.1/include/net/bluetooth/hci.h linux-2.6.21.1-dkenzior/include/net/bluetooth/hci.h
--- linux-2.6.21.1/include/net/bluetooth/hci.h	2007-05-04 13:30:11.000000000 +1000
+++ linux-2.6.21.1-dkenzior/include/net/bluetooth/hci.h	2007-05-04 13:54:53.000000000 +1000
@@ -135,10 +135,15 @@ enum {
 #define ESCO_HV3	0x0004
 #define ESCO_EV3	0x0008
 #define ESCO_EV4	0x0010
 #define ESCO_EV5	0x0020
 
+/* Some devices seem to have trouble establishing EV* packet connections */
+/* with other devices.  For this reason we mask out the eSCO packets */ 
+/* for now.  Might need to address this later */
+#define ESCO_PTYPE_MASK	(ESCO_HV1 | ESCO_HV2 | ESCO_HV3)
+
 /* ACL flags */
 #define ACL_CONT		0x01
 #define ACL_START		0x02
 #define ACL_ACTIVE_BCAST	0x04
 #define ACL_PICO_BCAST		0x08
diff -p -U5 -r linux-2.6.21.1/net/bluetooth/hci_conn.c linux-2.6.21.1-dkenzior/net/bluetooth/hci_conn.c
--- linux-2.6.21.1/net/bluetooth/hci_conn.c	2007-05-04 13:33:00.000000000 +1000
+++ linux-2.6.21.1-dkenzior/net/bluetooth/hci_conn.c	2007-05-04 14:02:57.000000000 +1000
@@ -138,11 +138,11 @@ void hci_setup_sync(struct hci_conn *con
 
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 
 	cp.handle   = cpu_to_le16(handle);
-	cp.pkt_type = cpu_to_le16(hdev->esco_type);
+	cp.pkt_type = cpu_to_le16(hdev->esco_type & ESCO_PTYPE_MASK);
 
 	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.max_latency    = cpu_to_le16(0xffff);
 	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
diff -p -U5 -r linux-2.6.21.1/net/bluetooth/hci_event.c linux-2.6.21.1-dkenzior/net/bluetooth/hci_event.c
--- linux-2.6.21.1/net/bluetooth/hci_event.c	2007-05-04 13:30:11.000000000 +1000
+++ linux-2.6.21.1-dkenzior/net/bluetooth/hci_event.c	2007-05-04 15:47:15.000000000 +1000
@@ -369,10 +369,11 @@ static void hci_cc_info_param(struct hci
 		if (hdev->features[4] & LMP_EV5)
 			hdev->esco_type |= ESCO_EV5;
 
 		BT_DBG("%s: features 0x%x 0x%x 0x%x", hdev->name,
 				lf->features[0], lf->features[1], lf->features[2]);
+		BT_DBG("%s: eSco packets: 0x%x", hdev->name, hdev->esco_type);
 
 		break;
 
 	case OCF_READ_BUFFER_SIZE:
 		bs = (struct hci_rp_read_buffer_size *) skb->data;
@@ -756,11 +757,10 @@ static inline void hci_conn_request_evt(
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
 
 	if (mask & HCI_LM_ACCEPT) {
 		/* Connection accepted */
 		struct hci_conn *conn;
-		struct hci_cp_accept_conn_req cp;
 
 		hci_dev_lock(hdev);
 		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 		if (!conn) {
 			if (!(conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr))) {
@@ -771,27 +771,55 @@ static inline void hci_conn_request_evt(
 		}
 		memcpy(conn->dev_class, ev->dev_class, 3);
 		conn->state = BT_CONNECT;
 		hci_dev_unlock(hdev);
 
-		bacpy(&cp.bdaddr, &ev->bdaddr);
+		if ((ev->link_type == ACL_LINK) || (!lmp_esco_capable(hdev))) {
+			struct hci_cp_accept_conn_req cp;
+			bacpy(&cp.bdaddr, &ev->bdaddr);
 
-		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
-			cp.role = 0x00; /* Become master */
-		else
-			cp.role = 0x01; /* Remain slave */
+			if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
+				cp.role = 0x00; /* Become master */
+			else
+				cp.role = 0x01; /* Remain slave */
 
-		hci_send_cmd(hdev, OGF_LINK_CTL,
-				OCF_ACCEPT_CONN_REQ, sizeof(cp), &cp);
+			hci_send_cmd(hdev, OGF_LINK_CTL,
+					OCF_ACCEPT_CONN_REQ, sizeof(cp), &cp);
+		} else {
+			/* Send the Accept Sync Connection Command */
+			struct hci_cp_accept_sync_conn_req cp;
+			
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			cp.pkt_type = __cpu_to_le16(hdev->esco_type & ESCO_PTYPE_MASK);
+			cp.tx_bandwidth = __cpu_to_le32(0x00001f40);
+			cp.rx_bandwidth = __cpu_to_le32(0x00001f40);
+			cp.max_latency = __cpu_to_le16(0xffff);
+			cp.content_format = __cpu_to_le16(hdev->voice_setting);
+			cp.retrans_effort = 0xff;
+
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
@@ -878,10 +906,60 @@ static inline void hci_conn_complete_evt
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
@@ -1157,40 +1235,10 @@ static inline void hci_pscan_rep_mode_ev
 	}
 
 	hci_dev_unlock(hdev);
 }
 
-/* Synchronous Connection Complete Event */
-static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_sync_conn_complete *ev = (struct hci_ev_sync_conn_complete *) skb->data;
-	struct hci_conn *conn;
-
-	BT_DBG("%s status %d", hdev->name, ev->status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
-	if (!conn) {
-		hci_dev_unlock(hdev);
-		return;
-	}
-
-	if (!ev->status) {
-		conn->handle = __le16_to_cpu(ev->handle);
-		conn->type   = ev->link_type;
-		conn->state  = BT_CONNECTED;
-	} else
-		conn->state = BT_CLOSED;
-
-	hci_proto_connect_cfm(conn, ev->status);
-	if (ev->status)
-		hci_conn_del(conn);
-
-	hci_dev_unlock(hdev);
-}
-
 /* Sniff Subrate */
 static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_sniff_subrate *ev = (struct hci_ev_sniff_subrate *) skb->data;
 	struct hci_conn *conn;
diff -p -U5 -r linux-2.6.21.1/net/bluetooth/sco.c linux-2.6.21.1-dkenzior/net/bluetooth/sco.c
--- linux-2.6.21.1/net/bluetooth/sco.c	2007-05-04 13:30:11.000000000 +1000
+++ linux-2.6.21.1-dkenzior/net/bluetooth/sco.c	2007-05-04 13:33:31.000000000 +1000
@@ -838,10 +838,13 @@ done:
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

--Boundary-00=_/JuOGj7v6qIJQuP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_/JuOGj7v6qIJQuP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_/JuOGj7v6qIJQuP--
