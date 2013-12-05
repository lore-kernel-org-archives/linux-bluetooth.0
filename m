Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 30/32] Bluetooth: Fix validating LE PSM values
Date: Thu,  5 Dec 2013 15:11:28 +0200
Message-Id: <1386249090-10236-31-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

LE PSM values have different ranges than those for BR/EDR. The valid
ranges for fixed, SIG assigned values is 0x0001-0x007f and for dynamic
PSM values 0x0080-0x00ff. We need to ensure that bind() and connect()
calls conform to these ranges when operating on LE CoC sockets.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 15 +++++++++++++--
 net/bluetooth/l2cap_sock.c | 40 +++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e447bbedcabf..c638c280db40 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1861,6 +1861,18 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 	return c1;
 }
 
+static bool is_valid_psm(u16 psm, u8 dst_type)
+{
+	if (!psm)
+		return false;
+
+	if (bdaddr_type_is_le(dst_type))
+		return (psm < 0x00ff);
+
+	/* PSM must be odd and lsb of upper byte must be 0 */
+	return ((psm & 0x0101) == 0x0001);
+}
+
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type)
 {
@@ -1881,8 +1893,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	l2cap_chan_lock(chan);
 
-	/* PSM must be odd and lsb of upper byte must be 0 */
-	if ((__le16_to_cpu(psm) & 0x0101) != 0x0001 && !cid &&
+	if (!is_valid_psm(__le16_to_cpu(psm), dst_type) && !cid &&
 	    chan->chan_type != L2CAP_CHAN_RAW) {
 		err = -EINVAL;
 		goto done;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c2424782c245..f4471fd6e99e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -53,6 +53,32 @@ bool l2cap_is_socket(struct socket *sock)
 }
 EXPORT_SYMBOL(l2cap_is_socket);
 
+static int l2cap_validate_bredr_psm(u16 psm)
+{
+	/* PSM must be odd and lsb of upper byte must be 0 */
+	if ((psm & 0x0101) != 0x0001)
+		return -EINVAL;
+
+	/* Restrict usage of well-known PSMs */
+	if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
+static int l2cap_validate_le_psm(u16 psm)
+{
+	/* Valid LE_PSM ranges are defined only until 0x00ff */
+	if (psm > 0x00ff)
+		return -EINVAL;
+
+	/* Restrict fixed, SIG assigned PSM values to CAP_NET_BIND_SERVICE */
+	if (psm <= 0x007f && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
@@ -94,17 +120,13 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (la.l2_psm) {
 		__u16 psm = __le16_to_cpu(la.l2_psm);
 
-		/* PSM must be odd and lsb of upper byte must be 0 */
-		if ((psm & 0x0101) != 0x0001) {
-			err = -EINVAL;
-			goto done;
-		}
+		if (la.l2_bdaddr_type == BDADDR_BREDR)
+			err = l2cap_validate_bredr_psm(psm);
+		else
+			err = l2cap_validate_le_psm(psm);
 
-		/* Restrict usage of well-known PSMs */
-		if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE)) {
-			err = -EACCES;
+		if (err)
 			goto done;
-		}
 	}
 
 	if (la.l2_cid)
-- 
1.8.4.2

