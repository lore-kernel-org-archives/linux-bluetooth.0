Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Bluetooth: Remove unneeded parameter
Date: Thu, 11 Apr 2013 11:35:44 -0300
Message-Id: <1365690946-28050-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the status parameter of the l2cap_conn_add function.
The parameter 'status' is always 0.

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 net/bluetooth/l2cap_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c7e932..0104c02 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1502,12 +1502,12 @@ static void security_timeout(struct work_struct *work)
 	}
 }
 
-static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
+static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct hci_chan *hchan;
 
-	if (conn || status)
+	if (conn)
 		return conn;
 
 	hchan = hci_chan_create(hcon);
@@ -1695,7 +1695,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
-	conn = l2cap_conn_add(hcon, 0);
+	conn = l2cap_conn_add(hcon);
 	if (!conn) {
 		hci_conn_put(hcon);
 		err = -ENOMEM;
@@ -6313,7 +6313,7 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
 	if (!status) {
-		conn = l2cap_conn_add(hcon, status);
+		conn = l2cap_conn_add(hcon);
 		if (conn)
 			l2cap_conn_ready(conn);
 	} else {
@@ -6482,7 +6482,7 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		goto drop;
 
 	if (!conn)
-		conn = l2cap_conn_add(hcon, 0);
+		conn = l2cap_conn_add(hcon);
 
 	if (!conn)
 		goto drop;
-- 
1.7.11.7

