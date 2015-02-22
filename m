Return-Path: <cyrus@holtmann.org>
From: "Gregory M. Turner" <gmt@be-evil.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
Date: Sun, 22 Feb 2015 12:36:41 -0800
Message-ID: <1832240.mNuY6LIF5L@moneypit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From b222223a4410587ea21b20841581f22614432b77 Mon Sep 17 00:00:00 2001
From: "Gregory M. Turner" <gmt@be-evil.net>
Date: Sun, 22 Feb 2015 10:54:06 -0800
Subject: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise

For years, my logs have often looked like this:

    # dmesg | wc -lc ; \
      dmesg | grep -v \
          'Bluetooth: Unexpected continuation frame (len 0)' \
          | wc -lc
      32769 2096857
         85    5081

Google suggests I'm not alone in this.  AFAICT, it means:

    "Hey, kernel, here.  I was trying to talk to some gizmo by way
    of your tiny $2.50 USB dongle broadcasting a 2.4Ghz near-field
    RF protocol.  Inexplicably, there was some sort of RFI or
    dropout!  I'm deeply offended, and taking it personally.  I'll
    remind you again a few microseconds if the problem continues."

Surely this is causing more harm than benefit; silence the kmsg
unless the frame is nonempty.

Signed-off-by: Gregory M. Turner <gmt@be-evil.net>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6ba33f9..dcec242 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7493,7 +7493,8 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		BT_DBG("Cont: frag len %d (expecting %d)", skb->len, conn->rx_len);
 
 		if (!conn->rx_len) {
-			BT_ERR("Unexpected continuation frame (len %d)", skb->len);
+			if (skb->len)
+				BT_ERR("Unexpected continuation frame (len %d)", skb->len);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto drop;
 		}
-- 
2.3.0


