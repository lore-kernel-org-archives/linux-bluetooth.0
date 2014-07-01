Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 4/4] Bluetooth: Introduce "New Connection Parameter" Event
Date: Tue,  1 Jul 2014 18:10:11 -0300
Message-Id: <1404249011-23645-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
References: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a new Mgmt event called "New Connection Parameter".
This event indicates to userspace the connection parameters values the
remote device requested.

The user may store these values and load them into kernel. This way, next
time a connection is established to that device, the kernel will use those
parameters values instead of the default ones.

This event is sent when the remote device requests new connection
parameters through connection parameter update procedure. This event is
not sent for slave connections.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  3 +++
 include/net/bluetooth/mgmt.h     | 10 ++++++++++
 net/bluetooth/hci_event.c        |  4 ++++
 net/bluetooth/l2cap_core.c       |  6 +++++-
 net/bluetooth/mgmt.c             | 19 +++++++++++++++++++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3404f9b..01fbbe2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1329,6 +1329,9 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		   bool persistent);
+void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			 u8 bdaddr_type, u16 min_interval, u16 max_interval,
+			 u16 latency, u16 timeout);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 2d88f36..3c0f296 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -615,3 +615,13 @@ struct mgmt_ev_device_added {
 struct mgmt_ev_device_removed {
 	struct mgmt_addr_info addr;
 } __packed;
+
+#define MGMT_EV_NEW_CONN_PARAM		0x001c
+struct mgmt_ev_new_conn_param {
+	struct mgmt_addr_info addr;
+	__u8 store_hint;
+	__le16 min_interval;
+	__le16 max_interval;
+	__le16 latency;
+	__le16 timeout;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 544e2ef..b9d16e0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4417,6 +4417,10 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
 
+	if (test_bit(HCI_CONN_MASTER, &hcon->flags))
+		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type, min, max,
+				    latency, timeout);
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
index ba5e215..93cfefa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -116,6 +116,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_NEW_CSRK,
 	MGMT_EV_DEVICE_ADDED,
 	MGMT_EV_DEVICE_REMOVED,
+	MGMT_EV_NEW_CONN_PARAM,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -5690,6 +5691,24 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
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

