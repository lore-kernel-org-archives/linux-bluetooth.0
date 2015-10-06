Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: 6lowpan: Remove unnecessary chan_open() function
Date: Tue,  6 Oct 2015 13:03:22 +0300
Message-Id: <1444125804-15577-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All the chan_open() function now does is to call chan_create() so it
doesn't really add any value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 023fa29db709..77eb698d898e 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -780,17 +780,6 @@ static struct l2cap_chan *chan_create(void)
 	return chan;
 }
 
-static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
-{
-	struct l2cap_chan *chan;
-
-	chan = chan_create();
-	if (!chan)
-		return NULL;
-
-	return chan;
-}
-
 static void set_ip_addr_bits(u8 addr_type, u8 *addr)
 {
 	if (addr_type == BDADDR_LE_PUBLIC)
@@ -913,7 +902,10 @@ static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
 {
 	struct l2cap_chan *chan;
 
-	chan = chan_open(pchan);
+	chan = chan_create();
+	if (!chan)
+		return NULL;
+
 	chan->ops = pchan->ops;
 
 	BT_DBG("chan %p pchan %p", chan, pchan);
-- 
2.4.3

