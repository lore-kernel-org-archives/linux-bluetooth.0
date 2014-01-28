Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Refuse peer L2CAP address reading when not connected
Date: Tue, 28 Jan 2014 15:16:49 -0800
Message-Id: <1390951011-30576-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
References: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're not connected the peer address information is undefined. This
patch fixes the remote address getting to return a proper error in case
the state is anything else than BT_CONNECTED.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 304fc8589af4..a0b8c7aa448e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -366,6 +366,9 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
+	if (peer && sk->sk_state != BT_CONNECTED)
+		return -ENOTCONN;
+
 	memset(la, 0, sizeof(struct sockaddr_l2));
 	addr->sa_family = AF_BLUETOOTH;
 	*len = sizeof(struct sockaddr_l2);
-- 
1.8.5.3

