Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 2/7] Bluetooth: Add LE connect support
Date: Wed,  6 Oct 2010 20:42:10 +0200
Message-Id: <1286390535-27462-3-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add logic to create LE connections.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    6 ++-
 net/bluetooth/hci_conn.c         |   38 ++++++++++++++-
 net/bluetooth/hci_event.c        |  100 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b86aed5..b326240 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -162,6 +162,7 @@ enum {
 #define SCO_LINK	0x00
 #define ACL_LINK	0x01
 #define ESCO_LINK	0x02
+#define LE_LINK		0x03
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ebec8c9..89f4b10 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -170,6 +170,7 @@ struct hci_conn {
 	bdaddr_t	 dst;
 	__u16		 handle;
 	__u16		 state;
+	__u16		 le_state;
 	__u8             mode;
 	__u8		 type;
 	__u8		 out;
@@ -203,6 +204,7 @@ struct hci_conn {
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
 	void		*sco_data;
+	void		*le_data;
 	void		*priv;
 
 	struct hci_conn	*link;
@@ -272,7 +274,7 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	list_add(&c->list, &h->list);
-	if (c->type == ACL_LINK)
+	if (c->type == ACL_LINK || c->type == LE_LINK)
 		h->acl_num++;
 	else
 		h->sco_num++;
@@ -282,7 +284,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	list_del(&c->list);
-	if (c->type == ACL_LINK)
+	if (c->type == ACL_LINK || c->type == LE_LINK)
 		h->acl_num--;
 	else
 		h->sco_num--;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 145993f..cb41d64 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -45,6 +45,27 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+void hci_le_connect(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_create_conn cp;
+
+	conn->le_state = BT_CONNECT;
+	conn->out = 1;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.scan_interval = cpu_to_le16(0x0004);
+	cp.scan_window = cpu_to_le16(0x0004);
+	bacpy(&cp.peer_addr, &conn->dst);
+	cp.conn_interval_min = cpu_to_le16(0x0008);
+	cp.conn_interval_max = cpu_to_le16(0x0100);
+	cp.supervision_timeout = cpu_to_le16(0x0064);
+	cp.min_ce_len = cpu_to_le16(0x0001);
+	cp.max_ce_len = cpu_to_le16(0xffff);
+
+	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
+}
+
 void hci_acl_connect(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -365,15 +386,30 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 }
 EXPORT_SYMBOL(hci_get_route);
 
-/* Create SCO or ACL connection.
+/* Create SCO, ACL or LE connection.
  * Device _must_ be locked */
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
+	struct hci_conn *le;
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
+	if (type == LE_LINK) {
+		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+
+		if (!le)
+			le = hci_conn_add(hdev, LE_LINK, dst);
+
+		if (!le)
+			return NULL;
+
+		hci_le_connect(le);
+
+		return le;
+	}
+
 	if (!(acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst))) {
 		if (!(acl = hci_conn_add(hdev, ACL_LINK, dst)))
 			return NULL;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d3c68de..0b979ae 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -868,6 +868,44 @@ static void hci_cc_le_set_scan(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, status);
 }
 
+static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
+{
+	struct hci_cp_le_create_conn *cp;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_CREATE_CONN);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
+
+	BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->peer_addr),
+		conn);
+
+	if (status) {
+		if (conn && conn->le_state == BT_CONNECT) {
+			conn->le_state = BT_CLOSED;
+			hci_proto_connect_cfm(conn, status);
+			hci_conn_del(conn);
+		}
+	} else {
+		if (!conn) {
+			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr);
+			if (conn) {
+				conn->out = 1;
+				conn->link_mode |= HCI_LM_MASTER;
+			} else
+				BT_ERR("No memory for new connection");
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -1069,7 +1107,10 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
-		conn->state = BT_CLOSED;
+		if (conn->type == LE_LINK)
+			conn->le_state = BT_CLOSED;
+		else
+			conn->state = BT_CLOSED;
 
 		hci_proto_disconn_cfm(conn, ev->reason);
 		hci_conn_del(conn);
@@ -1430,6 +1471,10 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_exit_sniff_mode(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_CREATE_CONN:
+		hci_cs_le_create_conn(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
@@ -1875,6 +1920,55 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status %d", hdev->name, ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
+
+	if (!conn)
+		goto unlock;
+
+	if (ev->status) {
+		hci_proto_connect_cfm(conn, ev->status);
+		conn->le_state = BT_CLOSED;
+		hci_conn_del(conn);
+		goto unlock;
+	}
+
+	conn->handle = __le16_to_cpu(ev->handle);
+	conn->le_state = BT_CONNECTED;
+
+	hci_conn_hold_device(conn);
+	hci_conn_add_sysfs(conn);
+
+	hci_proto_connect_cfm(conn, ev->status);
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_le_meta *le_ev = (void *) skb->data;
+	__u8 event = le_ev->subevent;
+
+	skb_pull(skb, sizeof(*le_ev));
+
+	switch (event) {
+	case HCI_EV_LE_CONN_COMPLETE:
+		hci_le_conn_complete_evt(hdev, skb);
+		break;
+
+	default:
+		break;
+	}
+}
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
@@ -2011,6 +2105,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_host_features_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_META:
+		hci_le_meta_evt(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s event 0x%x", hdev->name, event);
 		break;
-- 
1.7.0.1

