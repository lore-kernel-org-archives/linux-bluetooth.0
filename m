Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/6] Bluetooth: AMP: Add handle to hci_chan structure
Date: Wed, 10 Oct 2012 17:38:28 +0300
Message-Id: <1349879912-23633-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349879912-23633-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349879912-23633-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

hci_chan will be identified by handle used in logical link creation
process. This handle is used in AMP ACL-U packet handle field.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_conn.c         |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dfa108c..b697ef3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -350,7 +350,7 @@ struct hci_conn {
 
 struct hci_chan {
 	struct list_head list;
-
+	__u16 handle;
 	struct hci_conn *conn;
 	struct sk_buff_head data_q;
 	unsigned int	sent;
@@ -567,6 +567,7 @@ void hci_conn_check_pending(struct hci_dev *hdev);
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
 void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
+struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6487579..fe64621 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -989,3 +989,35 @@ void hci_chan_list_flush(struct hci_conn *conn)
 	list_for_each_entry_safe(chan, n, &conn->chan_list, list)
 		hci_chan_del(chan);
 }
+
+static struct hci_chan *__hci_chan_lookup_handle(struct hci_conn *hcon,
+						 __u16 handle)
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
+struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *hcon;
+	struct hci_chan *hchan = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(hcon, &h->list, list) {
+		hchan = __hci_chan_lookup_handle(hcon, handle);
+		if (hchan)
+			break;
+	}
+
+	rcu_read_unlock();
+
+	return hchan;
+}
-- 
1.7.9.5

