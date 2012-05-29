Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 2/2] Bluetooth: Remove unused err var from l2cap_segment_sdu()
Date: Tue, 29 May 2012 13:29:17 -0300
Message-Id: <1338308957-17282-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338308957-17282-1-git-send-email-gustavo@padovan.org>
References: <1338308957-17282-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Trivial fix, let the code cleaner.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index acd43aa..db54e2d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2067,7 +2067,6 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	struct sk_buff *skb;
 	u16 sdu_len;
 	size_t pdu_len;
-	int err = 0;
 	u8 sar;
 
 	BT_DBG("chan %p, msg %p, len %d", chan, msg, (int)len);
@@ -2126,7 +2125,7 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 		}
 	}
 
-	return err;
+	return 0;
 }
 
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
-- 
1.7.10.2

