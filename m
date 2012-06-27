Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/17] Bluetooth: Use delayed init for Three-wire UART
Date: Wed, 27 Jun 2012 14:26:01 +0300
Message-Id: <1340796367-10321-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch takes into use the delayed initialization feature that the
Bluetooth UART framework provides.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index d602cc4..4f41d24 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -135,6 +135,8 @@ static int h5_open(struct hci_uart *hu)
 	h5->timer.function = h5_timed_event;
 	h5->timer.data = (unsigned long) hu;
 
+	set_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags);
+
 	/* Send initial sync request */
 	h5_link_control(hu, sync, sizeof(sync));
 	mod_timer(&h5->timer, jiffies + HZ / 10);
@@ -226,6 +228,7 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 		h5_link_control(hu, conf_req, 3);
 	} else if (memcmp(data, conf_rsp, 2) == 0) {
 		BT_DBG("Three-wire init sequence complete");
+		hci_uart_init_ready(hu);
 		return;
 	} else {
 		BT_DBG("Link Control: 0x%02hhx 0x%02hhx", data[0], data[1]);
-- 
1.7.10.4

