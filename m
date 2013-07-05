Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v8 2/8] Bluetooth: Remove unused mask parameter in sco_conn_defer_accept
Date: Fri,  5 Jul 2013 17:01:36 +0200
Message-Id: <1373036503-1349-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth specification states that when accepting a bluetooth synchronous
connection request, the role parameter is unused and will be ignored by the
controller. Moreover, the function is called only once with a fixed value.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 net/bluetooth/sco.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 7114984..0c15a0c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -651,7 +651,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	return err;
 }
 
-static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
+static void sco_conn_defer_accept(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -663,11 +663,7 @@ static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
 		struct hci_cp_accept_conn_req cp;
 
 		bacpy(&cp.bdaddr, &conn->dst);
-
-		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
-			cp.role = 0x00; /* Become master */
-		else
-			cp.role = 0x01; /* Remain slave */
+		cp.role = 0x00; /* Ignored */
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
 	} else {
@@ -697,7 +693,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	if (sk->sk_state == BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon, 0);
+		sco_conn_defer_accept(pi->conn->hcon);
 		sk->sk_state = BT_CONFIG;
 		msg->msg_namelen = 0;
 
-- 
1.7.9.5

