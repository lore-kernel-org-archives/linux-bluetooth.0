Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 6/8] Bluetooth: use l2cap_chan_set_err()
Date: Mon,  8 Oct 2012 07:19:39 +0800
Message-Id: <1349651981-6251-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
References: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

l2cap_conn_unreliable() doesn't take the sk lock, so we need to take it
using l2cap_chan_set_err().

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7914641..94b0e75 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1293,7 +1293,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
-			__l2cap_chan_set_err(chan, err);
+			l2cap_chan_set_err(chan, err);
 	}
 
 	mutex_unlock(&conn->chan_lock);
-- 
1.7.11.4

