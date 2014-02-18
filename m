Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] Bluetooth: Print error when dropping L2CAP data
Date: Tue, 18 Feb 2014 20:48:34 +0100
Message-Id: <1392752914-15392-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Silently dropping L2CAP data (i.e. due to remote device not obeying
negotiated MTU) is confusing and makes debugging harder.

Signed-off-by: Szymon Janc <szymon.janc@gmail.com>
---

I also wonder if kernel shouldn't just disconnect if data would be
dropped. This is reliable connection after all...

 net/bluetooth/l2cap_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6e6b3a9..7e0c51a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6759,8 +6759,10 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 		 * But we don't have any other choice. L2CAP doesn't
 		 * provide flow control mechanism. */
 
-		if (chan->imtu < skb->len)
+		if (chan->imtu < skb->len) {
+			BT_ERR("Dropping L2CAP data: receive buffer overflow");
 			goto drop;
+		}
 
 		if (!chan->ops->recv(chan, skb))
 			goto done;
-- 
1.9.0.rc3

