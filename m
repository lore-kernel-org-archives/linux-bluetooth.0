Return-Path: <cyrus@holtmann.org>
Message-ID: <1392377748.5384.28.camel@tkhai>
Subject: [PATCH] bluetooth: Do not free priv until timer handler hasn't
 actually stopped using it
From: Kirill Tkhai <ktkhai@parallels.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Date: Fri, 14 Feb 2014 15:35:48 +0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Function del_timer() does not guarantee that timer was really deleted.
If the timer handler is beeing executed at the moment, the function
just returns. So, it's possible to use already freed memory in the handler:

[ref: Documentation/DocBook/kernel-locking.tmpl]

This was found using grep and compile-tested only.

Signed-off-by: Kirill Tkhai <ktkhai@parallels.com>
CC: Marcel Holtmann <marcel@holtmann.org>
CC: Gustavo Padovan <gustavo@padovan.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>
---
 drivers/bluetooth/hci_bcsp.c |    2 +-
 drivers/bluetooth/hci_h5.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 0bc87f7..d796a6d 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -722,7 +722,7 @@ static int bcsp_close(struct hci_uart *hu)
 	skb_queue_purge(&bcsp->unack);
 	skb_queue_purge(&bcsp->rel);
 	skb_queue_purge(&bcsp->unrel);
-	del_timer(&bcsp->tbcsp);
+	del_timer_sync(&bcsp->tbcsp);
 
 	kfree(bcsp);
 	return 0;
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index f6f4974..9f007f6 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -210,7 +210,7 @@ static int h5_close(struct hci_uart *hu)
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
-	del_timer(&h5->timer);
+	del_timer_sync(&h5->timer);
 
 	kfree(h5);
 
