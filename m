Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 19/34] Bluetooth: Move specific Basic Mode code to the right place
Date: Thu,  1 Apr 2010 17:23:37 -0300
Message-Id: <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Inside "case L2CAP_MODE_BASIC:" we don't need to check for sk_type and
L2CAP mode. So only the length check is fine.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0dc7b95..8c8b5d9 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1660,11 +1660,6 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	/* Check outgoing MTU */
-	if (sk->sk_type == SOCK_SEQPACKET && pi->mode == L2CAP_MODE_BASIC &&
-	    len > pi->omtu)
-		return -EINVAL;
-
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_CONNECTED) {
@@ -1681,6 +1676,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	switch (pi->mode) {
 	case L2CAP_MODE_BASIC:
+		/* Check outgoing MTU */
+		if (len > pi->omtu) {
+			err = -EINVAL;
+			goto done;
+		}
+
 		/* Create a basic PDU */
 		skb = l2cap_create_basic_pdu(sk, msg, len);
 		if (IS_ERR(skb)) {
-- 
1.6.4.4
