Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <016001c788a0$b7b229c0$8935c70a@dlh.st.com>
References: <016001c788a0$b7b229c0$8935c70a@dlh.st.com>
Content-Type: multipart/mixed; boundary="=-USfcwYptFT7LVV21o176"
Date: Tue, 01 May 2007 13:24:54 +0200
Message-Id: <1178018694.25217.8.camel@violet>
Mime-Version: 1.0
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


--=-USfcwYptFT7LVV21o176
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Sumeet,

> I have corrected the mistakes. Please review the attached patch and let me
> know if this is fine. 

this patch is incomplete. It doesn't handle incoming eSCO connections
and it can't handle SCO audio packets over HCI when a real eSCO
connection has been established.

However it shows a more clean way to actually address eSCO support.

Regards

Marcel


--=-USfcwYptFT7LVV21o176
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 93ce272..7a001e5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -114,7 +114,7 @@ enum {
 #define HCI_EVENT_PKT		0x04
 #define HCI_VENDOR_PKT		0xff
 
-/* HCI Packet types */
+/* HCI packet types */
 #define HCI_DM1		0x0008
 #define HCI_DM3		0x0400
 #define HCI_DM5		0x4000
@@ -129,6 +129,14 @@ enum {
 #define SCO_PTYPE_MASK	(HCI_HV1 | HCI_HV2 | HCI_HV3)
 #define ACL_PTYPE_MASK	(~SCO_PTYPE_MASK)
 
+/* eSCO packet types */
+#define ESCO_HV1	0x0001
+#define ESCO_HV2	0x0002
+#define ESCO_HV3	0x0004
+#define ESCO_EV3	0x0008
+#define ESCO_EV4	0x0010
+#define ESCO_EV5	0x0020
+
 /* ACL flags */
 #define ACL_CONT		0x01
 #define ACL_START		0x02
@@ -138,6 +146,7 @@ enum {
 /* Baseband links */
 #define SCO_LINK	0x00
 #define ACL_LINK	0x01
+#define ESCO_LINK	0x02
 
 /* LMP features */
 #define LMP_3SLOT	0x01
@@ -162,6 +171,11 @@ enum {
 #define LMP_PSCHEME	0x02
 #define LMP_PCONTROL	0x04
 
+#define LMP_ESCO	0x80
+
+#define LMP_EV4		0x01
+#define LMP_EV5		0x02
+
 #define LMP_SNIFF_SUBR	0x02
 
 /* Connection modes */
@@ -296,7 +310,18 @@ struct hci_cp_host_buffer_size {
 } __attribute__ ((packed));
 
 /* Link Control */
-#define OGF_LINK_CTL	0x01 
+#define OGF_LINK_CTL	0x01
+
+#define OCF_INQUIRY		0x0001
+struct hci_cp_inquiry {
+	__u8     lap[3];
+	__u8     length;
+	__u8     num_rsp;
+} __attribute__ ((packed));
+
+#define OCF_INQUIRY_CANCEL	0x0002
+
+#define OCF_EXIT_PERIODIC_INQ	0x0004
 
 #define OCF_CREATE_CONN		0x0005
 struct hci_cp_create_conn {
@@ -319,35 +344,24 @@ struct hci_cp_accept_conn_req {
 	__u8     role;
 } __attribute__ ((packed));
 
-#define OCF_REJECT_CONN_REQ	0x000a
+#define OCF_REJECT_CONN_REQ	0x000A
 struct hci_cp_reject_conn_req {
 	bdaddr_t bdaddr;
 	__u8     reason;
 } __attribute__ ((packed));
 
-#define OCF_DISCONNECT	0x0006
+#define OCF_DISCONNECT		0x0006
 struct hci_cp_disconnect {
 	__le16   handle;
 	__u8     reason;
 } __attribute__ ((packed));
 
-#define OCF_ADD_SCO	0x0007
+#define OCF_ADD_SCO		0x0007
 struct hci_cp_add_sco {
 	__le16   handle;
 	__le16   pkt_type;
 } __attribute__ ((packed));
 
-#define OCF_INQUIRY		0x0001
-struct hci_cp_inquiry {
-	__u8     lap[3];
-	__u8     length;
-	__u8     num_rsp;
-} __attribute__ ((packed));
-
-#define OCF_INQUIRY_CANCEL	0x0002
-
-#define OCF_EXIT_PERIODIC_INQ	0x0004
-
 #define OCF_LINK_KEY_REPLY	0x000B
 struct hci_cp_link_key_reply {
 	bdaddr_t bdaddr;
@@ -398,13 +412,41 @@ struct hci_cp_read_remote_features {
 	__le16   handle;
 } __attribute__ ((packed));
 
-#define OCF_READ_REMOTE_VERSION 0x001D
+#define OCF_READ_REMOTE_VERSION	0x001D
 struct hci_cp_read_remote_version {
 	__le16   handle;
 } __attribute__ ((packed));
 
+#define OCF_SETUP_SYNC_CONN	0x0028
+struct hci_cp_setup_sync_conn {
+	__le16   handle;
+	__le32   tx_bandwidth;
+	__le32   rx_bandwidth;
+	__le16   max_latency;
+	__le16   voice_setting;
+	__u8     retrans_effort;
+	__le16   pkt_type;
+} __attribute__ ((packed));
+
+#define OCF_ACCEPT_SYNC_CONN_REQ 0x0029
+struct hci_cp_accept_sync_conn_req {
+	bdaddr_t bdaddr;
+	__le32   tx_bandwidth;
+	__le32   rx_bandwidth;
+	__le16   max_latency;
+	__le16   content_format;
+	__u8     retrans_effort;
+	__le16   pkt_type;
+} __attribute__ ((packed));
+
+#define OCF_REJECT_SYNC_CONN_REQ 0x002A
+struct hci_cp_reject_sync_conn_req {
+	bdaddr_t bdaddr;
+	__u8     reason;
+} __attribute__ ((packed));
+
 /* Link Policy */
-#define OGF_LINK_POLICY	0x02   
+#define OGF_LINK_POLICY	0x02
 
 #define OCF_SNIFF_MODE		0x0003
 struct hci_cp_sniff_mode {
@@ -516,7 +558,7 @@ struct extended_inquiry_info {
 	__u8     data[240];
 } __attribute__ ((packed));
 
-#define HCI_EV_CONN_COMPLETE 	0x03
+#define HCI_EV_CONN_COMPLETE	0x03
 struct hci_ev_conn_complete {
 	__u8     status;
 	__le16   handle;
@@ -572,7 +614,7 @@ struct hci_ev_qos_setup_complete {
 	struct   hci_qos qos;
 } __attribute__ ((packed));
 
-#define HCI_EV_CMD_COMPLETE 	0x0E
+#define HCI_EV_CMD_COMPLETE	0x0E
 struct hci_ev_cmd_complete {
 	__u8     ncmd;
 	__le16   opcode;
@@ -652,6 +694,29 @@ struct hci_ev_pscan_rep_mode {
 	__u8     pscan_rep_mode;
 } __attribute__ ((packed));
 
+#define HCI_EV_SYNC_CONN_COMPLETE	0x2C
+struct hci_ev_sync_conn_complete {
+	__u8     status;
+	__le16   handle;
+	bdaddr_t bdaddr;
+	__u8     link_type;
+	__u8     tx_interval;
+	__u8     retrans_window;
+	__le16   rx_pkt_len;
+	__le16   tx_pkt_len;
+	__u8     air_mode;
+} __attribute__ ((packed));
+
+#define HCI_EV_SYNC_CONN_CHANGED	0x2D
+struct hci_ev_sync_conn_changed {
+	__u8     status;
+	__le16   handle;
+	__u8     tx_interval;
+	__u8     retrans_window;
+	__le16   rx_pkt_len;
+	__le16   tx_pkt_len;
+} __attribute__ ((packed));
+
 #define HCI_EV_SNIFF_SUBRATE	0x2E
 struct hci_ev_sniff_subrate {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0fc396..6e71886 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -78,6 +78,7 @@ struct hci_dev {
 	__u16		voice_setting;
 
 	__u16		pkt_type;
+	__u16		esco_type;
 	__u16		link_policy;
 	__u16		link_mode;
 
@@ -308,6 +309,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
+void hci_setup_sync(struct hci_conn *conn, __u16 handle);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
 int    hci_conn_del(struct hci_conn *conn);
@@ -449,6 +451,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
 #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
 #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
+#define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 
 /* ----- HCI protocols ----- */
 struct hci_proto {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 63980bd..23cb5fb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -123,12 +123,34 @@ void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 
-	cp.pkt_type = cpu_to_le16(hdev->pkt_type & SCO_PTYPE_MASK);
 	cp.handle   = cpu_to_le16(handle);
+	cp.pkt_type = cpu_to_le16(hdev->pkt_type & SCO_PTYPE_MASK);
 
 	hci_send_cmd(hdev, OGF_LINK_CTL, OCF_ADD_SCO, sizeof(cp), &cp);
 }
 
+void hci_setup_sync(struct hci_conn *conn, __u16 handle)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_setup_sync_conn cp;
+
+	BT_DBG("%p", conn);
+
+	conn->state = BT_CONNECT;
+	conn->out = 1;
+
+	cp.handle   = cpu_to_le16(handle);
+	cp.pkt_type = cpu_to_le16(hdev->esco_type);
+
+	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.max_latency    = cpu_to_le16(0xffff);
+	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
+	cp.retrans_effort = 0xff;
+
+	hci_send_cmd(hdev, OGF_LINK_CTL, OCF_SETUP_SYNC_CONN, sizeof(cp), &cp);
+}
+
 static void hci_conn_timeout(unsigned long arg)
 {
 	struct hci_conn *conn = (void *) arg;
@@ -143,7 +165,10 @@ static void hci_conn_timeout(unsigned long arg)
 
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
@@ -220,19 +245,19 @@ int hci_conn_del(struct hci_conn *conn)
 
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
@@ -297,9 +322,10 @@ EXPORT_SYMBOL(hci_get_route);
 
 /* Create SCO or ACL connection.
  * Device _must_ be locked */
-struct hci_conn * hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst)
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *acl;
+	struct hci_conn *sco;
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
@@ -313,28 +339,30 @@ struct hci_conn * hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst)
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
 
-		hci_conn_hold(sco);
+	acl->link = sco;
+	sco->link = acl;
 
-		if (acl->state == BT_CONNECTED &&
-				(sco->state == BT_OPEN || sco->state == BT_CLOSED))
-			hci_add_sco(sco, acl->handle);
+	hci_conn_hold(sco);
 
-		return sco;
-	} else {
-		return acl;
+	if (acl->state == BT_CONNECTED &&
+			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
+		if (lmp_esco_capable(hdev))
+			hci_setup_sync(sco, acl->handle);
+		else
+			hci_add_sco(sco, acl->handle);
 	}
+
+	return sco;
 }
 EXPORT_SYMBOL(hci_connect);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aa4b56a..5d6cd1d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -851,6 +851,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	hdev->flags = 0;
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
+	hdev->esco_type = ESCO_HV1;
 	hdev->link_mode = (HCI_LM_ACCEPT);
 
 	hdev->idle_timeout = 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 447ba71..04acae4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -350,11 +350,24 @@ static void hci_cc_info_param(struct hci_dev *hdev, __u16 ocf, struct sk_buff *s
 		if (hdev->features[0] & LMP_5SLOT)
 			hdev->pkt_type |= (HCI_DM5 | HCI_DH5);
 
-		if (hdev->features[1] & LMP_HV2)
-			hdev->pkt_type |= (HCI_HV2);
+		if (hdev->features[1] & LMP_HV2) {
+			hdev->pkt_type  |= HCI_HV2;
+			hdev->esco_type |= ESCO_HV2;
+		}
+
+		if (hdev->features[1] & LMP_HV3) {
+			hdev->pkt_type  |= HCI_HV3;
+			hdev->esco_type |= ESCO_HV3;
+		}
 
-		if (hdev->features[1] & LMP_HV3)
-			hdev->pkt_type |= (HCI_HV3);
+		if (hdev->features[3] & LMP_ESCO)
+			hdev->esco_type |= ESCO_EV3;
+
+		if (hdev->features[4] & LMP_EV4)
+			hdev->esco_type |= ESCO_EV4;
+
+		if (hdev->features[4] & LMP_EV5)
+			hdev->esco_type |= ESCO_EV5;
 
 		BT_DBG("%s: features 0x%x 0x%x 0x%x", hdev->name,
 				lf->features[0], lf->features[1], lf->features[2]);
@@ -444,40 +457,75 @@ static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
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
+		BT_DBG("%s Setup Sync Conn error: handle %d status 0x%x", hdev->name, handle, status);
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
@@ -810,7 +858,10 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		struct hci_conn *sco = conn->link;
 		if (sco) {
 			if (!ev->status)
-				hci_add_sco(sco, conn->handle);
+				if (lmp_esco_capable(hdev))
+					hci_setup_sync(sco, conn->handle);
+				else
+					hci_add_sco(sco, conn->handle);
 			else {
 				hci_proto_connect_cfm(sco, ev->status);
 				hci_conn_del(sco);
@@ -881,12 +932,12 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
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
@@ -1108,6 +1159,36 @@ static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_unlock(hdev);
 }
 
+/* Synchronous Connection Complete Event */
+static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_sync_conn_complete *ev = (struct hci_ev_sync_conn_complete *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status %d", hdev->name, ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+	if (!conn) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	if (!ev->status) {
+		conn->handle = __le16_to_cpu(ev->handle);
+		conn->type   = ev->link_type;
+		conn->state  = BT_CONNECTED;
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
 /* Sniff Subrate */
 static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -1213,6 +1294,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_pscan_rep_mode_evt(hdev, skb);
 		break;
 
+	case HCI_EV_SYNC_CONN_COMPLETE:
+		hci_sync_conn_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_SNIFF_SUBRATE:
 		hci_sniff_subrate_evt(hdev, skb);
 		break;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3f5163e..2334294 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -189,7 +189,7 @@ static int sco_connect(struct sock *sk)
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
-	int err = 0;
+	int err, type;
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
@@ -200,7 +200,9 @@ static int sco_connect(struct sock *sk)
 
 	err = -ENOMEM;
 
-	hcon = hci_connect(hdev, SCO_LINK, dst);
+	type = lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;
+
+	hcon = hci_connect(hdev, type, dst);
 	if (!hcon)
 		goto done;
 
@@ -846,7 +848,7 @@ static int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 
-	if (hcon->type != SCO_LINK)
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
 		return 0;
 
 	if (!status) {
@@ -865,7 +867,7 @@ static int sco_disconn_ind(struct hci_conn *hcon, __u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
-	if (hcon->type != SCO_LINK)
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
 		return 0;
 
 	sco_conn_del(hcon, bt_err(reason));

--=-USfcwYptFT7LVV21o176
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-USfcwYptFT7LVV21o176
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-USfcwYptFT7LVV21o176--
