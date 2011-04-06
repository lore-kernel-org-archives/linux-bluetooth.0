Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 15/15] Bluetooth: Add support for returning the encryption key size
Date: Tue,  5 Apr 2011 23:11:28 -0300
Message-Id: <1302055888-28177-16-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be useful when userspace wants to restrict some kinds of
operations based on the length of the key size used to encrypt the
link.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/bluetooth.h |    1 +
 net/bluetooth/l2cap_sock.c        |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index acf186d..28ae91a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -56,6 +56,7 @@
 #define BT_SECURITY	4
 struct bt_security {
 	__u8 level;
+	__u8 key_size;
 };
 #define BT_SECURITY_SDP		0
 #define BT_SECURITY_LOW		1
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 12dbbf2..dd79b6b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -492,8 +492,12 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 			break;
 		}
 
+		memset(&sec, 0, sizeof(sec));
 		sec.level = l2cap_pi(sk)->sec_level;
 
+		if (sk->sk_state == BT_CONNECTED)
+			sec.key_size = l2cap_pi(sk)->conn->hcon->pin_length;
+
 		len = min_t(unsigned int, len, sizeof(sec));
 		if (copy_to_user(optval, (char *) &sec, len))
 			err = -EFAULT;
-- 
1.7.4.1

