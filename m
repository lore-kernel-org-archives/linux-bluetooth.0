Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [RFC 02/20] Bluetooth: Add LE connect support
Date: Tue, 23 Nov 2010 12:06:18 -0300
Message-Id: <1290524796-32246-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Bluetooth V4.0 adds support for Low Energy (LE)
connections. Specification introduses new set
of hci commands to control LE connection.
This patch adds logic to create, cancel and
disconnect LE connections

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/hci.h      |    2 +
 include/net/bluetooth/hci_core.h |   25 +++++++++--
 net/bluetooth/hci_conn.c         |   51 +++++++++++++++++++-
 net/bluetooth/hci_event.c        |   93 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ee5beec..02055b9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -159,6 +159,8 @@ enum {
 #define SCO_LINK	0x00
 #define ACL_LINK	0x01
 #define ESCO_LINK	0x02
+/* Low Energy links do not have defined link type. Use invented one */
+#define LE_LINK		0x80
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ebec8c9..2b7f94a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -60,6 +60,7 @@ struct hci_conn_hash {
 	spinlock_t       lock;
 	unsigned int     acl_num;
 	unsigned int     sco_num;
+	unsigned int     le_num;
 };
 
 struct bdaddr_list {
@@ -272,20 +273,36 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	list_add(&c->list, &h->list);
-	if (c->type == ACL_LINK)
+	switch (c->type) {
+	case ACL_LINK:
 		h->acl_num++;
-	else
+		break;
+	case LE_LINK:
+		h->le_num++;
+		break;
+	case SCO_LINK:
+	case ESCO_LINK:
 		h->sco_num++;
+		break;
+	}
 }
 
 static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	list_del(&c->list);
-	if (c->type == ACL_LINK)
+	switch (c->type) {
+	case ACL_LINK:
 		h->acl_num--;
-	else
+		break;
+	case LE_LINK:
+		h->le_num--;
+		break;
+	case SCO_LINK:
+	case ESCO_LINK:
 		h->sco_num--;
+		break;
+	}
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b1e460..30329ed 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -45,6 +45,32 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+static void hci_le_connect(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_create_conn cp;
+
+	conn->state = BT_CONNECT;
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
+	cp.max_ce_len = cpu_to_le16(0x0001);
+
+	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
+}
+
+static void hci_le_connect_cancel(struct hci_conn *conn)
+{
+	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
+}
+
 void hci_acl_connect(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -192,8 +218,12 @@ static void hci_conn_timeout(unsigned long arg)
 	switch (conn->state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
-		if (conn->type == ACL_LINK && conn->out)
-			hci_acl_connect_cancel(conn);
+		if (conn->out) {
+			if (conn->type == ACL_LINK)
+				hci_acl_connect_cancel(conn);
+			else if (conn->type == LE_LINK)
+				hci_le_connect_cancel(conn);
+		}
 		break;
 	case BT_CONFIG:
 	case BT_CONNECTED:
@@ -359,15 +389,30 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
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
+		if (!le)
+			le = hci_conn_add(hdev, LE_LINK, dst);
+		if (!le)
+			return NULL;
+		if (le->state == BT_OPEN)
+			hci_le_connect(le);
+
+		hci_conn_hold(le);
+
+		return le;
+	}
+
 	if (!(acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst))) {
 		if (!(acl = hci_conn_add(hdev, ACL_LINK, dst)))
 			return NULL;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3c1957c..31cea58 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -863,6 +863,43 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
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
+		if (conn && conn->state == BT_CONNECT) {
+			conn->state = BT_CLOSED;
+			hci_proto_connect_cfm(conn, status);
+			hci_conn_del(conn);
+		}
+	} else {
+		if (!conn) {
+			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr);
+			if (conn)
+				conn->out = 1;
+			else
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
@@ -1445,6 +1482,10 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_exit_sniff_mode(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_CREATE_CONN:
+		hci_cs_le_create_conn(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
@@ -1898,6 +1939,54 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_
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
+	if (!conn)
+		goto unlock;
+
+	if (ev->status) {
+		hci_proto_connect_cfm(conn, ev->status);
+		conn->state = BT_CLOSED;
+		hci_conn_del(conn);
+		goto unlock;
+	}
+
+	conn->handle = __le16_to_cpu(ev->handle);
+	conn->state = BT_CONNECTED;
+
+	hci_conn_hold_device(conn);
+	hci_conn_add_sysfs(conn);
+
+	hci_proto_connect_cfm(conn, ev->status);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_le_meta *le_ev = (void *) skb->data;
+
+	skb_pull(skb, sizeof(*le_ev));
+
+	switch (le_ev->subevent) {
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
@@ -2034,6 +2123,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
1.7.3.2

