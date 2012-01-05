Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] Bluetooth: Add name resolving support for mgmt based discovery
Date: Thu,  5 Jan 2012 17:16:22 +0200
Message-Id: <1325776582-10314-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the necessary logic to perform name lookups after
inquiry completes. This is done by checking for entries in the resolve
list after each inquiry complete and remote name complete HCI event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    8 +++-
 net/bluetooth/hci_core.c         |   34 +++++++++++++++-
 net/bluetooth/hci_event.c        |   81 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             |   37 +++++++++++++++--
 4 files changed, 149 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f19de4..a8680da 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -60,7 +60,8 @@ struct discovery_state {
 	enum {
 		DISCOVERY_STOPPED,
 		DISCOVERY_STARTING,
-		DISCOVERY_ACTIVE,
+		DISCOVERY_INQUIRY,
+		DISCOVERY_RESOLVING,
 		DISCOVERY_STOPPING,
 	} state;
 	struct list_head all;		/* All devices found during inquiry */
@@ -371,6 +372,8 @@ static inline void discovery_init(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->discovery.resolve);
 }
 
+bool hci_discovery_active(struct hci_dev *hdev);
+
 void hci_discovery_set_state(struct hci_dev *hdev, int state);
 
 static inline int inquiry_cache_empty(struct hci_dev *hdev)
@@ -393,6 +396,9 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
 							bdaddr_t *bdaddr);
 struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 							bdaddr_t *bdaddr);
+struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
+							bdaddr_t *bdaddr,
+							int state);
 bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 							bool name_known);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f3aaa3c..803655f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -356,6 +356,17 @@ struct hci_dev *hci_dev_get(int index)
 
 /* ---- Inquiry support ---- */
 
+bool hci_discovery_active(struct hci_dev *hdev)
+{
+	struct discovery_state *discov = &hdev->discovery;
+
+	if (discov->state == DISCOVERY_INQUIRY ||
+					discov->state == DISCOVERY_RESOLVING)
+		return true;
+
+	return false;
+}
+
 void hci_discovery_set_state(struct hci_dev *hdev, int state)
 {
 	BT_DBG("%s state %u -> %u", hdev->name, hdev->discovery.state, state);
@@ -369,9 +380,11 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 		break;
 	case DISCOVERY_STARTING:
 		break;
-	case DISCOVERY_ACTIVE:
+	case DISCOVERY_INQUIRY:
 		mgmt_discovering(hdev, 1);
 		break;
+	case DISCOVERY_RESOLVING:
+		break;
 	case DISCOVERY_STOPPING:
 		break;
 	}
@@ -425,6 +438,25 @@ struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 	return NULL;
 }
 
+struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
+							bdaddr_t *bdaddr,
+							int state)
+{
+	struct discovery_state *cache = &hdev->discovery;
+	struct inquiry_entry *e;
+
+	BT_DBG("cache %p bdaddr %s state %d", cache, batostr(bdaddr), state);
+
+	list_for_each_entry(e, &cache->resolve, list) {
+		if (!bacmp(bdaddr, BDADDR_ANY) && e->name_state == state)
+			return e;
+		if (!bacmp(&e->data.bdaddr, bdaddr))
+			return e;
+	}
+
+	return NULL;
+}
+
 bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 							bool name_known)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6213b5f..43bbf32 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1119,7 +1119,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_dev_lock(hdev);
-	hci_discovery_set_state(hdev, DISCOVERY_ACTIVE);
+	hci_discovery_set_state(hdev, DISCOVERY_INQUIRY);
 	hci_dev_unlock(hdev);
 }
 
@@ -1271,6 +1271,50 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 	return 1;
 }
 
+static inline int hci_resolve_name(struct hci_dev *hdev, struct inquiry_entry *e)
+{
+	struct hci_cp_remote_name_req cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	bacpy(&cp.bdaddr, &e->data.bdaddr);
+	cp.pscan_rep_mode = e->data.pscan_rep_mode;
+	cp.pscan_mode = e->data.pscan_mode;
+	cp.clock_offset = e->data.clock_offset;
+
+	return hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
+}
+
+static void hci_resolve_next_name(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct discovery_state *discov = &hdev->discovery;
+	struct inquiry_entry *e;
+
+	if (discov->state == DISCOVERY_STOPPING)
+		goto discov_complete;
+
+	if (discov->state != DISCOVERY_RESOLVING)
+		return;
+
+	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
+	if (e) {
+		e->name_state = NAME_KNOWN;
+		list_del(&e->list);
+	}
+
+	if (list_empty(&discov->resolve))
+		goto discov_complete;
+
+	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
+	if (hci_resolve_name(hdev, e) == 0) {
+		e->name_state = NAME_PENDING;
+		return;
+	}
+
+discov_complete:
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+}
+
 static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_remote_name_req *cp;
@@ -1289,6 +1333,9 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 
 	hci_dev_lock(hdev);
 
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		hci_resolve_next_name(hdev, &cp->bdaddr);
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 	if (!conn)
 		goto unlock;
@@ -1496,6 +1543,8 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
+	struct discovery_state *discov = &hdev->discovery;
+	struct inquiry_entry *e;
 
 	BT_DBG("%s status %d", hdev->name, status);
 
@@ -1506,8 +1555,28 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
+	if (!test_bit(HCI_MGMT, &hdev->flags))
+		return;
+
 	hci_dev_lock(hdev);
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
+	if (discov->state != DISCOVERY_INQUIRY)
+		goto unlock;
+
+	if (list_empty(&discov->resolve)) {
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		goto unlock;
+	}
+
+	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
+	if (e && hci_resolve_name(hdev, e) == 0) {
+		e->name_state = NAME_PENDING;
+		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
+	} else {
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	}
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -1807,8 +1876,12 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 
 	hci_dev_lock(hdev);
 
-	if (ev->status == 0 && test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_remote_name(hdev, &ev->bdaddr, ev->name);
+	if (test_bit(HCI_MGMT, &hdev->flags)) {
+		if (ev->status == 0)
+			mgmt_remote_name(hdev, &ev->bdaddr, ev->name);
+
+		hci_resolve_next_name(hdev, &ev->bdaddr);
+	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 590966d..295cfc8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1947,6 +1947,8 @@ static int stop_discovery(struct sock *sk, u16 index)
 {
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
+	struct hci_cp_remote_name_req_cancel cp;
+	struct inquiry_entry *e;
 	int err;
 
 	BT_DBG("hci%u", index);
@@ -1958,25 +1960,44 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	hci_dev_lock(hdev);
 
-	if (hdev->discovery.state != DISCOVERY_ACTIVE) {
+	if (!hci_discovery_active(hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
 						MGMT_STATUS_REJECTED);
-		goto failed;
+		goto unlock;
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
-		goto failed;
+		goto unlock;
+	}
+
+	if (hdev->discovery.state == DISCOVERY_INQUIRY) {
+		err = hci_cancel_inquiry(hdev);
+		if (err < 0)
+			mgmt_pending_remove(cmd);
+		else
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
+		goto unlock;
+	}
+
+	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_PENDING);
+	if (!e) {
+		mgmt_pending_remove(cmd);
+		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY, NULL, 0);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		goto unlock;
 	}
 
-	err = hci_cancel_inquiry(hdev);
+	bacpy(&cp.bdaddr, &e->data.bdaddr);
+	err = hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ_CANCEL,
+							sizeof(cp), &cp);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 
-failed:
+unlock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
@@ -2004,6 +2025,12 @@ static int confirm_name(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock(hdev);
 
+	if (!hci_discovery_active(hdev)) {
+		err = cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
+							MGMT_STATUS_FAILED);
+		goto failed;
+	}
+
 	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->bdaddr);
 	if (!e) {
 		err = cmd_status (sk, index, MGMT_OP_CONFIRM_NAME,
-- 
1.7.7.3

