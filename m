Return-Path: <cyrus@holtmann.org>
From: gmt@be-evil.net
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gregory M. Turner" <gmt@be-evil.net>
Subject: [PATCH v3 1/1] bluetooth: l2cap_core: ratelimit continuation frame printk
Date: Thu, 19 Mar 2015 11:54:28 -0700
Message-Id: <1426791268-18938-1-git-send-email-gmt@be-evil.net>
In-Reply-To: <1424759141-17889-2-git-send-email-gmt@be-evil.net>
References: <1424759141-17889-2-git-send-email-gmt@be-evil.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gregory M. Turner" <gmt@be-evil.net>

For ages, some(1) users, presumably with broken hardware or buggy
drivers, get storms of "Unexpected continuation frame (len 0)"
messages flooding their logs (but are otherwise able to scrape
by without resolving the underlying problem).  So, ratelimit this
printk.

(1)
me
https://bugs.launchpad.net/ubuntu/+source/bluetooth-alsa/+bug/192502
https://bugzilla.kernel.org/show_bug.cgi?id=11705
https://bugzilla.redhat.com/show_bug.cgi?id=450490
.
.
(just Google, I'm not making it up)

Signed-off-by: Gregory M. Turner <gmt@be-evil.net>
---
 include/net/bluetooth/bluetooth.h | 2 ++
 net/bluetooth/l2cap_core.c        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e00455a..4d47ef6 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -128,6 +128,8 @@ void bt_err(const char *fmt, ...);
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
+#define BT_ERR_RATELIMITED(fmt, ...)	pr_err_ratelimited(fmt "\n", ##__VA_ARGS__)
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
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
2.3.3

