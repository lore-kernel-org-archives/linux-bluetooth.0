Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update L2CAP socket source address from HCI connection
Date: Sun, 13 Oct 2013 05:56:37 -0700
Message-Id: <1381668997-1240-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When having LE connections, the source address is not always the
public address of the controller. So update the socket address
based on the actual used source address of the HCI connection.

This also remove the pointless source address pointer and adds
a proper lock around the socket structure.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3ed9a2b..062e28e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1756,17 +1756,16 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type)
 {
 	struct sock *sk = chan->sk;
-	bdaddr_t *src = &bt_sk(sk)->src;
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 	__u8 auth_type;
 	int err;
 
-	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", src, dst,
+	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", &bt_sk(sk)->src, dst,
 	       dst_type, __le16_to_cpu(psm));
 
-	hdev = hci_get_route(dst, src);
+	hdev = hci_get_route(dst, &bt_sk(sk)->src);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -1858,7 +1857,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	}
 
 	/* Update source addr of the socket */
-	bacpy(src, &hdev->bdaddr);
+	lock_sock(sk);
+	bacpy(&bt_sk(sk)->src, &hcon->src);
+	release_sock(sk);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_add(conn, chan);
-- 
1.8.3.1

