Return-Path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH -next] Bluetooth: hci_bcsp: Use setup_timer instead of init_timer and data fields
Date: Tue, 18 Oct 2016 15:01:18 +0000
Message-Id: <1476802878-5593-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Use setup_timer function instead of initializing timer with the function
and data fields

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/bluetooth/hci_bcsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index a2c921f..910ec96 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -733,9 +733,7 @@ static int bcsp_open(struct hci_uart *hu)
 	skb_queue_head_init(&bcsp->rel);
 	skb_queue_head_init(&bcsp->unrel);
 
-	init_timer(&bcsp->tbcsp);
-	bcsp->tbcsp.function = bcsp_timed_event;
-	bcsp->tbcsp.data     = (u_long)hu;
+	setup_timer(&bcsp->tbcsp, bcsp_timed_event, (u_long)hu);
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 
