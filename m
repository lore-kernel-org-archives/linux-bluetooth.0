Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Jan 2011 00:18:49 +0100 (CET)
From: Jesper Juhl <jj@chaosbits.net>
To: linux-bluetooth@vger.kernel.org
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    "David S. Miller" <davem@davemloft.net>,
    "Gustavo F. Padovan" <padovan@profusion.mobi>,
    Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] bluetooth: Fix failure to release lock in read_index_list()
 when mem alloc fails.
Message-ID: <alpine.LNX.2.00.1101140000541.11347@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

If alloc_skb() fails in read_index_list() we'll return -ENOMEM without 
releasing 'hci_dev_list_lock'.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 mgmt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f827fd9..ace8726 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -111,8 +111,10 @@ static int read_index_list(struct sock *sk)
 
 	body_len = sizeof(*ev) + sizeof(*rp) + (2 * count);
 	skb = alloc_skb(sizeof(*hdr) + body_len, GFP_ATOMIC);
-	if (!skb)
+	if (!skb) {
+		read_unlock(&hci_dev_list_lock);
 		return -ENOMEM;
+	}
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);


-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
