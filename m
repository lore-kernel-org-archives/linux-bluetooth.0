Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 17/32] Bluetooth: Limit L2CAP_OPTIONS socket option usage with LE
Date: Thu,  5 Dec 2013 15:11:15 +0200
Message-Id: <1386249090-10236-18-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Most of the values in L2CAP_OPTIONS are not applicable for LE and those
that are have different semantics. It makes therefore sense to
completely block this socket option for LE and add (in a separate patch)
a new socket option for tweaking the values that do make sense (mainly
the send and receive MTU). Legacy user space ATT code still depends on
getsockopt for L2CAP_OPTIONS though so we need to plug a hole for that
for backwards compatibility.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 61e25bafdf43..a20fcc3ddcd9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -370,6 +370,16 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case L2CAP_OPTIONS:
+		/* LE sockets should use BT_SNDMTU/BT_RCVMTU, but since
+		 * legacy ATT code depends on getsockopt for
+		 * L2CAP_OPTIONS we need to let this pass.
+		 */
+		if (bdaddr_type_is_le(chan->src_type) &&
+		    chan->scid != L2CAP_CID_ATT) {
+			err = -EINVAL;
+			break;
+		}
+
 		memset(&opts, 0, sizeof(opts));
 		opts.imtu     = chan->imtu;
 		opts.omtu     = chan->omtu;
@@ -564,6 +574,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case L2CAP_OPTIONS:
+		if (bdaddr_type_is_le(chan->src_type)) {
+			err = -EINVAL;
+			break;
+		}
+
 		if (sk->sk_state == BT_CONNECTED) {
 			err = -EINVAL;
 			break;
-- 
1.8.4.2

