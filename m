Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Fix updating Identity Address in L2CAP channels
Date: Tue, 18 Feb 2014 21:41:33 +0200
Message-Id: <1392752497-8696-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
References: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we receive a remote identity address during SMP key distribution we
should ensure that any associated L2CAP channel instances get their
address information correspondingly updated (so that e.g. doing
getpeername on associated sockets returns the correct address).

This patch adds a new L2CAP core function l2cap_conn_update_id_addr()
which is used to iterate through all L2CAP channels associated with a
connection and update their address information.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 17 +++++++++++++++++
 net/bluetooth/smp.c           |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 13bec91785f4..4abdcb220e3a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -881,6 +881,7 @@ int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
+void l2cap_conn_update_id_addr(struct hci_conn *hcon);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
 void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6e6b3a9c8e6d..c3bda6445f3d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -609,6 +609,23 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	return;
 }
 
+void l2cap_conn_update_id_addr(struct hci_conn *hcon)
+{
+	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_chan *chan;
+
+	mutex_lock(&conn->chan_lock);
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		l2cap_chan_lock(chan);
+		bacpy(&chan->dst, &hcon->dst);
+		chan->dst_type = bdaddr_type(hcon, hcon->dst_type);
+		l2cap_chan_unlock(chan);
+	}
+
+	mutex_unlock(&conn->chan_lock);
+}
+
 static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index af29afed0cca..b6a2a8942b2d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -991,6 +991,8 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	bacpy(&hcon->dst, &smp->id_addr);
 	hcon->dst_type = smp->id_addr_type;
 
+	l2cap_conn_update_id_addr(hcon);
+
 	smp_distribute_keys(conn, 1);
 
 	return 0;
-- 
1.8.5.3

