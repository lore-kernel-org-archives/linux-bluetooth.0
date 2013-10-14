Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Check that bind() bdaddr type matches connect()
Date: Mon, 14 Oct 2013 21:17:53 +0300
Message-Id: <1381774673-14150-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381774673-14150-1-git-send-email-johan.hedberg@gmail.com>
References: <1381774673-14150-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If a socket was bound to an address type other than BR/EDR (such as LE)
we should reject trying to connect it to a BR/EDR address. The same
applies for binding to BR/EDR and trying to connect to non-BR/EDR.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 982915d..87e17b7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -150,6 +150,12 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
 		return -EINVAL;
 
+	if (chan->src_type == BDADDR_BREDR && la.l2_bdaddr_type != BDADDR_BREDR)
+		return -EINVAL;
+
+	if (chan->src_type != BDADDR_BREDR && la.l2_bdaddr_type == BDADDR_BREDR)
+		return -EINVAL;
+
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
-- 
1.8.3.1

