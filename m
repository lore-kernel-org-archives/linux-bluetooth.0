Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Socket address parameter for CID is in little endian
Date: Wed, 16 Oct 2013 09:31:17 -0700
Message-Id: <1381941077-6941-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP socket parameter for CID are actually provided in little
endian. So convert our constants into little endian before comparing
them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 95498d5..34e5a58 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -77,7 +77,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		if (la.l2_psm)
 			return -EINVAL;
 		/* We only allow ATT user space socket */
-		if (la.l2_cid != L2CAP_CID_ATT)
+		if (la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
 			return -EINVAL;
 	}
 
@@ -170,7 +170,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 		if (la.l2_psm)
 			return -EINVAL;
 		/* We only allow ATT user space socket */
-		if (la.l2_cid != L2CAP_CID_ATT)
+		if (la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
 			return -EINVAL;
 	}
 
-- 
1.8.3.1

