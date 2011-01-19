Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: [PATCH 4/5] Bluetooth: Fix authentication request for L2CAP raw sockets
Date: Wed, 19 Jan 2011 12:06:51 +0530
Message-Id: <1295419012-25717-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

When there is an existing connection l2cap_check_security needs to be
called to ensure that the security level of the new socket is fulfilled.
Normally l2cap_do_start takes care of this, but that function doesn't
get called for SOCK_RAW type sockets. This patch adds the necessary
l2cap_check_security call to the appropriate branch in l2cap_do_connect.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/l2cap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ae227bf..7550abb 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1106,7 +1106,8 @@ static int l2cap_do_connect(struct sock *sk)
 		if (sk->sk_type != SOCK_SEQPACKET &&
 				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
-			sk->sk_state = BT_CONNECTED;
+			if (l2cap_check_security(sk))
+				sk->sk_state = BT_CONNECTED;
 		} else
 			l2cap_do_start(sk);
 	}
-- 
1.7.2.3

