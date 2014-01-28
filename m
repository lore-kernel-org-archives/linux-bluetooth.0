Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Refuse peer RFCOMM address reading when not connected
Date: Tue, 28 Jan 2014 15:16:50 -0800
Message-Id: <1390951011-30576-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
References: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're not connected the peer address information is undefined. This
patch fixes the remote address getting to return a proper error in case
the sate is anything else than BT_CONNECTED.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/rfcomm/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index fb8158af1f39..00573fb79030 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -528,6 +528,9 @@ static int rfcomm_sock_getname(struct socket *sock, struct sockaddr *addr, int *
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
+	if (peer && sk->sk_state != BT_CONNECTED)
+		return -ENOTCONN;
+
 	memset(sa, 0, sizeof(*sa));
 	sa->rc_family  = AF_BLUETOOTH;
 	sa->rc_channel = rfcomm_pi(sk)->channel;
-- 
1.8.5.3

