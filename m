Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 1 Mar 2011 23:41:38 +0800
Message-ID: <AANLkTi=_gAQiAqKsYa2=Haq0ceJwK3n7OafDk6Lb7MZE@mail.gmail.com>
Subject: [2.6.38-rc6, patch] fix hci_dev_list locking...
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: stable@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Release acquired lock on error path, fixing potential hang up.

Signed-off-by: Daniel J Blueman <daniel.blueman@gmail.com>

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
Daniel J Blueman
