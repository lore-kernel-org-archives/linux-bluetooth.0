Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <m.knudsen@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [PATCH] Bluetooth:  Stop BCSP/H5 timer before cleaning up
Date: Tue, 18 Feb 2014 09:48:08 +0100
Message-id: <1392713288-12227-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When stopping BCSP/H5, stop the retransmission timer before proceeding
to clean up packet queues.  The previous code had a race condition where
the timer could trigger after the packet lists and protocol structure
had been removed which lead to dereferencing NULL or use-after-free bugs.

Signed-off-by: Michael Knudsen <m.knudsen@samsung.com>
Reported-by: Kirill Tkhai <ktkhai@parallels.com>
---
 drivers/bluetooth/hci_bcsp.c |    4 +++-
 drivers/bluetooth/hci_h5.c   |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 0bc87f7..eee2fb2 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -715,6 +715,9 @@ static int bcsp_open(struct hci_uart *hu)
 static int bcsp_close(struct hci_uart *hu)
 {
 	struct bcsp_struct *bcsp = hu->priv;
+
+	del_timer_sync(&bcsp->tbcsp);
+
 	hu->priv = NULL;
 
 	BT_DBG("hu %p", hu);
@@ -722,7 +725,6 @@ static int bcsp_close(struct hci_uart *hu)
 	skb_queue_purge(&bcsp->unack);
 	skb_queue_purge(&bcsp->rel);
 	skb_queue_purge(&bcsp->unrel);
-	del_timer(&bcsp->tbcsp);
 
 	kfree(bcsp);
 	return 0;
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index f6f4974..afd759e 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -206,12 +206,12 @@ static int h5_close(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
 
+	del_timer_sync(&h5->timer);
+
 	skb_queue_purge(&h5->unack);
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
-	del_timer(&h5->timer);
-
 	kfree(h5);
 
 	return 0;
-- 
1.7.9.5

