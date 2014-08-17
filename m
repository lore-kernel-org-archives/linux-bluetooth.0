Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Ignore incoming data after initiating disconnection
Date: Mon, 18 Aug 2014 00:41:44 +0300
Message-Id: <1408311704-31747-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
References: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When hci_chan_del is called the disconnection routines get scheduled
through a workqueue. If there's any incoming ACL data before the
routines get executed there's a chance that a new hci_chan is created
and the disconnection never happens. This patch adds a new hci_conn flag
to indicate that we're in the process of driving the connection down. We
set the flag in hci_chan_del and check for it in hci_chan_create so that
no new channels are created for the same connection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_conn.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 18c24f6fce6c..dbe73642c54c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -553,6 +553,7 @@ enum {
 	HCI_CONN_FIPS,
 	HCI_CONN_STK_ENCRYPT,
 	HCI_CONN_AUTH_INITIATOR,
+	HCI_CONN_DROP,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cb04a4e3c829..aaa7e388d026 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1291,6 +1291,11 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 
 	BT_DBG("%s hcon %p", hdev->name, conn);
 
+	if (test_bit(HCI_CONN_DROP, &conn->flags)) {
+		BT_DBG("Refusing to create new hci_chan");
+		return NULL;
+	}
+
 	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
 	if (!chan)
 		return NULL;
@@ -1318,6 +1323,7 @@ void hci_chan_del(struct hci_chan *chan)
 
 	/* Force the connection to be immediately dropped */
 	conn->disc_timeout = 0;
+	set_bit(HCI_CONN_DROP, &conn->flags);
 
 	hci_conn_drop(conn);
 	hci_conn_put(conn);
-- 
1.9.3

