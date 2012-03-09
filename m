Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Correct CID endian notation
Date: Fri,  9 Mar 2012 15:52:56 +0200
Message-Id: <1331301176-28650-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

L2CAP channel id is used in host format in internal L2CAP code.
Fix sparse warnings about wrong endian conversion.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 50579ee..428e0b0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -871,7 +871,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 /* Find socket with cid and source bdaddr.
  * Returns closest match, locked.
  */
-static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid, bdaddr_t *src)
+static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid, bdaddr_t *src)
 {
 	struct l2cap_chan *c, *c1 = NULL;
 
@@ -4435,7 +4435,7 @@ drop:
 	return 0;
 }
 
-static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct sk_buff *skb)
+static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
 
-- 
1.7.9

