Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Aug 2011 10:05:05 -0400
Subject: [RFC 3/4] Bluetooth: Track per-connection stats
Message-ID: <1314194705.2219.16.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add per-hci connection rx/tx stats and expose through debugfs
"connections" file.
---
 include/net/bluetooth/hci_core.h |   12 ++++++++++++
 net/bluetooth/hci_sysfs.c        |   17 +++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6c994c0..1f2ed18 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -208,6 +208,16 @@ struct hci_dev {
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
 };
 
+struct hci_conn_stats {
+	__u32	null_rx;
+	__u32	err_rx;
+	__u32	err_tx;
+	__u32	pkt_rx;
+	__u32	pkt_tx;
+	__u32	byte_rx;
+	__u32	byte_tx;
+};
+
 struct hci_conn {
 	struct list_head list;
 
@@ -253,6 +263,8 @@ struct hci_conn {
 	struct work_struct work_add;
 	struct work_struct work_del;
 
+	struct hci_conn_stats stats;
+
 	struct device	dev;
 	atomic_t	devref;
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 3d00769..0775398 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -568,6 +568,23 @@ static int connections_show(struct seq_file *f, void *p)
 				atomic_read(&c->devref));
 	}
 
+	seq_printf(f, "\n\n                  Rx                           "
+					"Tx\n");
+	seq_printf(f,     "Dest              bytes       pkt    err null  "
+					"bytes       pkt    err unack\n");
+
+	list_for_each(l, &h->list) {
+		struct hci_conn *c;
+		c = list_entry(l, struct hci_conn, list);
+
+		seq_printf(f,"%s %-11u %-6u %-3u %-5u %-11u %-6u %-3u %u\n",
+				batostr(&c->dst),
+				c->stats.byte_rx, c->stats.pkt_rx,
+				c->stats.err_rx, c->stats.null_rx,
+				c->stats.byte_tx, c->stats.pkt_tx,
+				c->stats.err_tx, c->sent);
+	};
+
 	hci_dev_unlock_bh(hdev);
 
 	return 0;
-- 
1.7.4.1

