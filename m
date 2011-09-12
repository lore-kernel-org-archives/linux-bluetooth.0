Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/5 v3] Bluetooth: mark l2cap_create_iframe_pdu as static
Date: Mon, 12 Sep 2011 20:00:50 +0300
Message-Id: <1315846853-27442-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_create_iframe_pdu is only used in l2cap_core.c

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0b6e1ae..afd5455 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1531,7 +1531,9 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 	return skb;
 }
 
-struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
+static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
+						struct msghdr *msg, size_t len,
+						u16 control, u16 sdulen)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
-- 
1.7.6.1

