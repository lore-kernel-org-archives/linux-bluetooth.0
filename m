Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] Bluetooth: Create callbacks for hcon connect and disconnect
Date: Fri, 23 May 2014 12:27:23 +0300
Message-Id: <1400837248-12179-4-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/hci_core.h | 26 ++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 16a07a1..691a6d0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1053,6 +1053,8 @@ struct hci_cb {
 
 	void (*create_cfm)	(struct hci_dev *hdev);
 	void (*destroy_cfm)	(struct hci_dev *hdev);
+	void (*connect_cfm)	(struct hci_conn *conn);
+	void (*disconnect_cfm)	(struct hci_conn *conn);
 };
 
 static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
@@ -1145,6 +1147,30 @@ static inline void hci_destroyed_cfm(struct hci_dev *hdev)
 	read_unlock(&hci_cb_list_lock);
 }
 
+static inline void hci_connect_cfm(struct hci_conn *hcon)
+{
+	struct hci_cb *cb;
+
+	read_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->connect_cfm)
+			cb->connect_cfm(hcon);
+	}
+	read_unlock(&hci_cb_list_lock);
+}
+
+static inline void hci_disconnect_cfm(struct hci_conn *hcon)
+{
+	struct hci_cb *cb;
+
+	read_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->disconnect_cfm)
+			cb->disconnect_cfm(hcon);
+	}
+	read_unlock(&hci_cb_list_lock);
+}
+
 static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 {
 	size_t parsed = 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3454807..b1bfa3f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2176,6 +2176,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	type = conn->type;
 
 	hci_proto_disconn_cfm(conn, ev->reason);
+	hci_disconnect_cfm(conn);
 	hci_conn_del(conn);
 
 	/* Re-enable advertising if necessary, since it might
@@ -4051,6 +4052,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_pend_le_conn_del(hdev, &conn->dst, conn->dst_type);
 
+	hci_connect_cfm(conn);
+
 unlock:
 	hci_dev_unlock(hdev);
 }
-- 
1.8.3.1

