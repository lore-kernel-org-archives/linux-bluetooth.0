Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 6/7] Bluetooth: Add support for running SMP without a socket
Date: Fri, 19 Aug 2011 21:06:55 -0300
Message-Id: <1313798816-8647-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When doing the pairing procedure we won't have an associated
socket, but we still have to do the SMP negotiation. This
adds support for encrypting the link and exchanging keys.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ed1d2bd..00e93d1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -912,6 +912,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (!conn->hcon->out && conn->hcon->type == LE_LINK)
 		l2cap_le_conn_ready(conn);
 
+	if (conn->hcon->out && conn->hcon->type == LE_LINK)
+		smp_conn_security(conn, conn->hcon->pending_sec_level);
+
 	read_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
@@ -4034,6 +4037,11 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p", conn);
 
+	if (hcon->type == LE_LINK) {
+		smp_distribute_keys(conn, 0);
+		del_timer(&conn->security_timer);
+	}
+
 	read_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
@@ -4046,9 +4054,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		if (chan->scid == L2CAP_CID_LE_DATA) {
 			if (!status && encrypt) {
 				chan->sec_level = hcon->sec_level;
-				del_timer(&conn->security_timer);
 				l2cap_chan_ready(sk);
-				smp_distribute_keys(conn, 0);
 			}
 
 			bh_unlock_sock(sk);
-- 
1.7.6

