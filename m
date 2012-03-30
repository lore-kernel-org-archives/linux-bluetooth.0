Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Clean up l2cap_chan_connect
Date: Fri, 30 Mar 2012 10:57:08 +0300
Message-Id: <1333094228-31591-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Reduce number of arguments by two and in future by another one. All
those parameters are passed inside L2CAP sockaddr_l2 pointer.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    3 +--
 net/bluetooth/l2cap_core.c    |    5 ++++-
 net/bluetooth/l2cap_sock.c    |    3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f6f0500..c0f0b6d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -909,8 +909,7 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
-int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
-								bdaddr_t *dst);
+int l2cap_chan_connect(struct l2cap_chan *chan, struct sockaddr_l2 *la);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3caff27..75bf88a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1131,10 +1131,13 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr
 	return c1;
 }
 
-int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *dst)
+int l2cap_chan_connect(struct l2cap_chan *chan, struct sockaddr_l2 *la)
 {
 	struct sock *sk = chan->sk;
 	bdaddr_t *src = &bt_sk(sk)->src;
+	__le16 psm = la->l2_psm;
+	u16 cid = le16_to_cpu(la->l2_cid);
+	bdaddr_t *dst = &la->l2_bdaddr;
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1d3e9c3..085b4d3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -123,8 +123,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
-	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
-				&la.l2_bdaddr);
+	err = l2cap_chan_connect(chan, &la);
 	if (err)
 		return err;
 
-- 
1.7.9.1

