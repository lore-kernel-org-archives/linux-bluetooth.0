Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Remove bogus inline declaration from l2cap_chan_connect
Date: Mon,  9 Jan 2012 13:46:02 +0200
Message-Id: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

As reported by Dan Carpenter this function causes a Sparse warning and
shouldn't be declared inline:

include/net/bluetooth/l2cap.h:837:30 error: marked inline, but without a
definition"

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b564142..370214f 100644
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
index 97f8549..90f5b5d 100644
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
-- 
1.7.8.2

