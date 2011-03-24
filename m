Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 3/3] Bluetooth: delete hanging L2CAP channel
Date: Thu, 24 Mar 2011 17:16:08 +0200
Message-Id: <1300979768-31963-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Sometimes L2CAP connection remains hanging. Make sure that
L2CAP channel is deleted.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap_sock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index fc85e7a..f77308e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -923,8 +923,9 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
 					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
-		} else
-			l2cap_chan_del(sk, reason);
+		}
+
+		l2cap_chan_del(sk, reason);
 		break;
 
 	case BT_CONNECT:
-- 
1.7.1

