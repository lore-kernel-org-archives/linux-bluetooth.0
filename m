Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Prasanna Karthik <pkarthik@intrinsyc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: hci_qca: Use setup_timer Kernel API instead of
 init_timer
Date: Tue, 18 Oct 2016 23:55:12 +0000
Message-ID: <20161018235323.GA19419@prasanna-ubuntu.itc.intrinsyc.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace init_timer function with setup_timer reported by coccinelle

Signed-off-by: Prasanna Karthik <pkarthik@intrinsyc.com>
---
 drivers/bluetooth/hci_qca.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 6c867fb..05c2307 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -438,14 +438,11 @@ static int qca_open(struct hci_uart *hu)
 
 	hu->priv = qca;
 
-	init_timer(&qca->wake_retrans_timer);
-	qca->wake_retrans_timer.function = hci_ibs_wake_retrans_timeout;
-	qca->wake_retrans_timer.data = (u_long)hu;
+	setup_timer(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout,
+		    (u_long)hu);
 	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
 
-	init_timer(&qca->tx_idle_timer);
-	qca->tx_idle_timer.function = hci_ibs_tx_idle_timeout;
-	qca->tx_idle_timer.data = (u_long)hu;
+	setup_timer(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, (u_long)hu);
 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
 
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
-- 
1.9.1
