Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 19/19] Bluetooth: Move specific Basic Mode code to the right place
Date: Tue, 23 Mar 2010 16:48:46 -0300
Message-Id: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-19-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-9-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-10-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-11-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-12-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-13-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-14-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-15-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-16-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-17-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-18-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-19-git-send-email-padovan@profusion.mobi>
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
