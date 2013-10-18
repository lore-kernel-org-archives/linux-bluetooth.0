Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix ATT socket backwards compatibility with user space
Date: Fri, 18 Oct 2013 11:49:25 +0300
Message-Id: <1382086165-24818-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Old user space versions bind the Attribute Protocol socket to
BDADDR_BREDR when they should be using BDADDR_LE_PUBLIC or
BDADDR_LE_RANDOM. The kernel recently introduced stricter checks on the
socket parameters but we need to punch this hole for old user space
versions to keep them working.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 34e5a58..1f326d9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -159,8 +159,31 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
 		return -EINVAL;
 
-	if (chan->src_type == BDADDR_BREDR && la.l2_bdaddr_type != BDADDR_BREDR)
-		return -EINVAL;
+	/* Check that the socket wasn't bound to something that
+	 * conflicts with the address given to connect(). If chan->src
+	 * is BDADDR_ANY it means bind() was never used, in which case
+	 * chan->src_type and la.l2_bdaddr_type do not need to match.
+	 */
+	if (chan->src_type == BDADDR_BREDR && bacmp(&chan->src, BDADDR_ANY) &&
+	    bdaddr_type_is_le(la.l2_bdaddr_type)) {
+		/* Old user space versions will try to incorrectly bind
+		 * the ATT socket using BDADDR_BREDR. We need to accept
+		 * this and fix up the source address type only when
+		 * both the source CID and destination CID indicate
+		 * ATT. Anything else is an invalid combination.
+		 */
+		if (chan->scid != L2CAP_CID_ATT ||
+		    la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
+			return -EINVAL;
+
+		/* We don't have the hdev available here to make a
+		 * better decision on random vs public, but since all
+		 * user space versions that exhibit this issue anyway do
+		 * not support random local addresses assuming public
+		 * here is good enough.
+		 */
+		chan->src_type = BDADDR_LE_PUBLIC;
+	}
 
 	if (chan->src_type != BDADDR_BREDR && la.l2_bdaddr_type == BDADDR_BREDR)
 		return -EINVAL;
-- 
1.8.3.1

