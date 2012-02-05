Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Feb 2012 06:21:05 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Subject: [PATCH] l2cap_chan_connect() shouldn't be inlined
Message-ID: <20120205062105.GZ23916@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

For one thing, it's big.  For another, the only caller is in a different
file anyway...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 68f5891..124f7cf 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -834,7 +834,7 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
-inline int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
+int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 								bdaddr_t *dst);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index faf0b11..980abdb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1120,7 +1120,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr
 	return c1;
 }
 
-inline int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *dst)
+int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *dst)
 {
 	struct sock *sk = chan->sk;
 	bdaddr_t *src = &bt_sk(sk)->src;
