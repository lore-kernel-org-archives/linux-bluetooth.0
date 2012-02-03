Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 03/10] Bluetooth: Remove unneeded sk variable
Date: Fri,  3 Feb 2012 16:36:22 +0200
Message-Id: <1328279789-10870-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In debug use chan %p instead of sk.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 48fc01e..f1a6b3c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1561,13 +1561,12 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 						struct msghdr *msg, size_t len,
 						u32 priority)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
+	BT_DBG("chan %p len %d priority %u", chan, (int)len, priority);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
@@ -1597,13 +1596,12 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 						struct msghdr *msg, size_t len,
 						u32 priority)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("sk %p len %d", sk, (int)len);
+	BT_DBG("chan %p len %d", chan, (int)len);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
@@ -1632,13 +1630,12 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 						struct msghdr *msg, size_t len,
 						u32 control, u16 sdulen)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("sk %p len %d", sk, (int)len);
+	BT_DBG("chan %p len %d", chan, (int)len);
 
 	if (!conn)
 		return ERR_PTR(-ENOTCONN);
-- 
1.7.8.3

