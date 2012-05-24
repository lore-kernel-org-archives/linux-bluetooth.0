Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 04/12] Bluetooth: Use l2cap_chan_ready() in LE path
Date: Thu, 24 May 2012 19:59:44 -0300
Message-Id: <1337900389-30915-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
References: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This replace code in l2cap_le_conn_ready() by a similar code in
l2cap_chan_ready().

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b808955..aa77a93 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1177,10 +1177,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	l2cap_chan_add(conn, chan);
 
-	__set_chan_timer(chan, sk->sk_sndtimeo);
-
-	__l2cap_state_change(chan, BT_CONNECTED);
-	parent->sk_data_ready(parent, 0);
+	l2cap_chan_ready(chan);
 
 clean:
 	release_sock(parent);
-- 
1.7.10.1

