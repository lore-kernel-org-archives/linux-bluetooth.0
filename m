Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/5] l2cap: Pass hci_dev to l2cap_chan_connect()
Date: Fri,  4 Mar 2016 13:40:42 +0200
Message-Id: <1457091644-21536-4-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the Bluetooth Management Interface already associates
commands with a hci_dev, pass the hci_dev when calling
l2cap_chan_connect(). This indicates which specific hci_dev to
use for the l2cap connection and will be useful when connecting
or disconnecting Bluetooth IPSP.

Modify the existing code to do a hci_dev lookup before calling
connect.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 include/net/bluetooth/l2cap.h | 4 ++--
 net/bluetooth/6lowpan.c       | 4 +++-
 net/bluetooth/l2cap_core.c    | 6 ++----
 net/bluetooth/l2cap_sock.c    | 5 ++++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5ee3c68..b65ca60 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -926,8 +926,8 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
-int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
-		       bdaddr_t *dst, u8 dst_type);
+int l2cap_chan_connect(struct l2cap_chan *chan, struct hci_dev *hdev,
+			__le16 psm, u16 cid, bdaddr_t *dst, u8 dst_type);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 198e158..a582a736 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1113,6 +1113,7 @@ static inline __u8 bdaddr_type(__u8 type)
 
 static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 {
+	struct hci_dev *hdev;
 	struct l2cap_chan *chan;
 	int err;
 
@@ -1122,7 +1123,8 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 
 	chan->ops = &bt_6lowpan_chan_ops;
 
-	err = l2cap_chan_connect(chan, cpu_to_le16(L2CAP_PSM_IPSP), 0,
+	hdev = hci_get_route(addr, NULL);
+	err = l2cap_chan_connect(chan, hdev, cpu_to_le16(L2CAP_PSM_IPSP), 0,
 				 addr, dst_type);
 
 	BT_DBG("chan %p err %d", chan, err);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eb4f5f2..8a87a0d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7041,18 +7041,16 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
 	return ((psm & 0x0101) == 0x0001);
 }
 
-int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
-		       bdaddr_t *dst, u8 dst_type)
+int l2cap_chan_connect(struct l2cap_chan *chan, struct hci_dev *hdev,
+			__le16 psm, u16 cid, bdaddr_t *dst, u8 dst_type)
 {
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
-	struct hci_dev *hdev;
 	int err;
 
 	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", &chan->src, dst,
 	       dst_type, __le16_to_cpu(psm));
 
-	hdev = hci_get_route(dst, &chan->src);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e4cae72..abcb508 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -176,6 +176,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct sockaddr_l2 la;
+	struct hci_dev *hdev;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -233,7 +234,9 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (chan->psm && bdaddr_type_is_le(chan->src_type))
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
-	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
+	hdev = hci_get_route(&la.l2_bdaddr, &chan->src);
+	err = l2cap_chan_connect(chan, hdev, la.l2_psm,
+				 __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
 		return err;
-- 
2.1.4

