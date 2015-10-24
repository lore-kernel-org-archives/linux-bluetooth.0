Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Subject: [RFC bluetooth-next 1/2] bluetooth: 6lowpan: avoid endless loop
Date: Sat, 24 Oct 2015 16:50:55 +0200
Message-Id: <1445698256-10407-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
References: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When -EAGAIN as return value for receive handling will do a retry of
parsing I can trigger a endless loop when iphc decompression e.g.
returns an errno because some missing function "-ENOTSUPP" or something
else. Somebody from outside can trigger an endless loop when sending a
an IPHC header which triggers this behaviour.

NOTE: This really depends only if -EAGAIN means "try again to call the
receive handler with the skb". Sometimes we also drop (and kfree) the
skb, I think something is broken there... depends on the error branch.
When receiving failed simple free skb and return errno (which is not
-EAGAIN).

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d85af23..d936e7d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -383,10 +383,8 @@ static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOENT;
 
 	err = recv_pkt(skb, dev->netdev, chan);
-	if (err) {
+	if (err)
 		BT_DBG("recv pkt %d", err);
-		err = -EAGAIN;
-	}
 
 	return err;
 }
-- 
2.6.1

