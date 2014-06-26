Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 4/4] Bluetooth: Introduce "New Connection Parameter" Event
Date: Wed, 25 Jun 2014 21:52:55 -0300
Message-Id: <1403743975-31114-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org>
References: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a new Mgmt event called "New Connection Parameter".
This event indicates to userspace the connection parameters values the
remote device requested.

The user may store these values and load them into kernel (an upcoming
patch will introduce a Mgmt command to do that). This way, next time a
connection is established to that device, the kernel will use those
parameters values instead of the default ones.

This event is sent when the remote device requests new connection
parameters through Link Layer or L2CAP connection parameter update
procedures.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  3 +++
 include/net/bluetooth/mgmt.h     | 10 ++++++++++
 net/bluetooth/hci_event.c        |  3 +++
 net/bluetooth/l2cap_core.c       |  6 +++++-
 net/bluetooth/mgmt.c             | 19 +++++++++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 016d262..f318efe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1322,6 +1322,9 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		   bool persistent);
+void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			 u8 bdaddr_type, u16 min_interval, u16 max_interval,
+			 u16 latency, u16 timeout);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bcffc9a..de22982 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -578,3 +578,13 @@ struct mgmt_ev_new_csrk {
 	__u8 store_hint;
 	struct mgmt_csrk_info key;
 } __packed;
+
+#define MGMT_EV_NEW_CONN_PARAM		0x001a
+struct mgmt_ev_new_conn_param {
+	struct mgmt_addr_info addr;
+	__u8 store_hint;
+	__le16 min_interval;
+	__le16 max_interval;
+	__le16 latency;
+	__le16 timeout;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ded97b..0a103ad 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4344,6 +4344,9 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
 
+	mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type, min, max,
+			    latency, timeout);
+
 	cp.handle = ev->handle;
 	cp.interval_min = ev->interval_min;
 	cp.interval_max = ev->interval_max;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e203a5f..058b3b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5249,8 +5249,12 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
 		       sizeof(rsp), &rsp);
 
-	if (!err)
+	if (!err) {
+		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
+				    min, max, latency, to_multiplier);
+
 		hci_le_conn_update(hcon, min, max, latency, to_multiplier);
+	}
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f75a090..ca96c4c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -111,6 +111,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_PASSKEY_NOTIFY,
 	MGMT_EV_NEW_IRK,
 	MGMT_EV_NEW_CSRK,
+	MGMT_EV_NEW_CONN_PARAM,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -5384,6 +5385,24 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 	mgmt_event(MGMT_EV_NEW_CSRK, hdev, &ev, sizeof(ev), NULL);
 }
 
+void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			 u8 bdaddr_type, u16 min_interval, u16 max_interval,
+			 u16 latency, u16 timeout)
+{
+	struct mgmt_ev_new_conn_param ev;
+
+	memset(&ev, 0, sizeof(ev));
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_bdaddr(LE_LINK, bdaddr_type);
+	ev.store_hint = 0x00;
+	ev.min_interval = cpu_to_le16(min_interval);
+	ev.max_interval = cpu_to_le16(max_interval);
+	ev.latency = cpu_to_le16(latency);
+	ev.timeout = cpu_to_le16(timeout);
+
+	mgmt_event(MGMT_EV_NEW_CONN_PARAM, hdev, &ev, sizeof(ev), NULL);
+}
+
 static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 				  u8 data_len)
 {
-- 
1.9.1

