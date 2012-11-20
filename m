Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/4] Bluetooth: Improve error message printing
Date: Tue, 20 Nov 2012 17:16:21 +0200
Message-Id: <1353424582-26042-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1353424582-26042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20121119212812.GB14006@joana>
 <1353424582-26042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Instead of printing:
"[ 7763.082007] Bluetooth: 2"
print something like:
"[ 7763.082007] Bluetooth: Trailing bytes: 2 in sframe"

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7114bdf..f44c542 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6091,7 +6091,7 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		       control->super);
 
 		if (len != 0) {
-			BT_ERR("%d", len);
+			BT_ERR("Trailing bytes: %d in sframe", len);
 			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 			goto drop;
 		}
-- 
1.7.10.4

