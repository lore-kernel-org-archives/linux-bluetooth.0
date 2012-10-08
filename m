Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 3/6] Bluetooth: AMP: Add handle to hci_chan structure
Date: Mon,  8 Oct 2012 17:52:09 +0300
Message-Id: <1349707932-10006-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

hci_chan will be identified by handle used in logical link creation
process. This handle is used in AMP ACL-U packet handle field.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    6 ++++--
 net/bluetooth/hci_conn.c         |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90ae4f0..951f604 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -348,7 +348,7 @@ struct hci_conn {
 
 struct hci_chan {
 	struct list_head list;
-
+	__u16 handle;
 	struct hci_conn *conn;
 	struct sk_buff_head data_q;
 	unsigned int	sent;
@@ -565,7 +565,9 @@ void hci_conn_check_pending(struct hci_dev *hdev);
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
 void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
-
+struct hci_chan *hci_chan_lookup_handle(struct hci_conn *hcon, __u16 handle);
+struct hci_chan *hci_chan_lookup_handle_all(struct hci_dev *hdev,
+					    __u16 handle);
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3584f58..7387516 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -992,3 +992,37 @@ void hci_chan_list_flush(struct hci_conn *conn)
 	list_for_each_entry_safe(chan, n, &conn->chan_list, list)
 		hci_chan_del(chan);
 }
+
+struct hci_chan *hci_chan_lookup_handle(struct hci_conn *hcon, __u16 handle)
+{
+	struct hci_chan *hchan;
+
+	list_for_each_entry(hchan, &hcon->chan_list, list) {
+		if (hchan->handle == handle)
+			return hchan;
+	}
+
+	return NULL;
+}
+
+struct hci_chan *hci_chan_lookup_handle_all(struct hci_dev *hdev, __u16 handle)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *hcon;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(hcon, &h->list, list) {
+		struct hci_chan *hchan;
+
+		hchan = hci_chan_lookup_handle(hcon, handle);
+		if (hchan) {
+			rcu_read_unlock();
+			return hchan;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
-- 
1.7.9.5

