Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Feb 2012 09:57:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] Bluetooth: change min_t() cast in hci_reassembly()
Message-ID: <20120228065759.GD20506@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

"count" is type int so the cast to __u16 truncates the high bits away
and triggers a Smatch static checker warning.  It looks like a high
value of count could cause a forever loop, but I didn't follow it
through to see if count is capped somewhere.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e6cbb8a..db484a8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1966,7 +1966,7 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 
 	while (count) {
 		scb = (void *) skb->cb;
-		len = min_t(__u16, scb->expect, count);
+		len = min_t(uint, scb->expect, count);
 
 		memcpy(skb_put(skb, len), data, len);
 
