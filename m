Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Access CMTP session addresses through L2CAP channel
Date: Sun, 13 Oct 2013 09:49:55 -0700
Message-Id: <1381682997-26437-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP socket structure does not contain the address information
anymore. They need to be accessed through the L2CAP channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/cmtp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index e0a6ebf..67fe5e8 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -340,20 +340,20 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 
 	down_write(&cmtp_session_sem);
 
-	s = __cmtp_get_session(&bt_sk(sock->sk)->dst);
+	s = __cmtp_get_session(&l2cap_pi(sock->sk)->chan->dst);
 	if (s && s->state == BT_CONNECTED) {
 		err = -EEXIST;
 		goto failed;
 	}
 
-	bacpy(&session->bdaddr, &bt_sk(sock->sk)->dst);
+	bacpy(&session->bdaddr, &l2cap_pi(sock->sk)->chan->dst);
 
 	session->mtu = min_t(uint, l2cap_pi(sock->sk)->chan->omtu,
 					l2cap_pi(sock->sk)->chan->imtu);
 
 	BT_DBG("mtu %d", session->mtu);
 
-	sprintf(session->name, "%pMR", &bt_sk(sock->sk)->dst);
+	sprintf(session->name, "%pMR", &session->bdaddr);
 
 	session->sock  = sock;
 	session->state = BT_CONFIG;
-- 
1.8.3.1

