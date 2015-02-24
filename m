Return-Path: <cyrus@holtmann.org>
From: "Gregory M. Turner" <gmt@be-evil.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gregory M. Turner" <gmt@be-evil.net>
Subject: [PATCH v2(sorta) 2/2] bluetooth: l2cap_core: ratelimit continuation frame printk
Date: Mon, 23 Feb 2015 22:25:41 -0800
Message-Id: <1424759141-17889-3-git-send-email-gmt@be-evil.net>
In-Reply-To: <1424759141-17889-1-git-send-email-gmt@be-evil.net>
References: <1424759141-17889-1-git-send-email-gmt@be-evil.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some(1) users with semi-broken dongles (?) get storms of "Unexpected
continuation frame (len 0)" messages flooding their logs.  So ratelimit
this printk.

(1)
https://bugs.launchpad.net/ubuntu/+source/bluetooth-alsa/+bug/192502
https://bugzilla.kernel.org/show_bug.cgi?id=11705
https://bugzilla.redhat.com/show_bug.cgi?id=450490

Signed-off-by: Gregory M. Turner <gmt@be-evil.net>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6ba33f9..7090aa0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7493,7 +7493,7 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		BT_DBG("Cont: frag len %d (expecting %d)", skb->len, conn->rx_len);
 
 		if (!conn->rx_len) {
-			BT_ERR("Unexpected continuation frame (len %d)", skb->len);
+			BT_ERR_RATELIMITED("Unexpected continuation frame (len %d)", skb->len);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto drop;
 		}
-- 
2.3.0

