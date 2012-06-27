Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/17] Bluetooth: Add initial sleep support to Three-wire UART
Date: Wed, 27 Jun 2012 14:26:03 +0300
Message-Id: <1340796367-10321-14-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds very basic support for the sleep related messages. The
only thing the code does right now is send a wakeup message as soon as
receiving a sleep one, essentially preventing the controller from going
to sleep.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 31b8d57..d26f801 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -71,6 +71,8 @@ struct h5 {
 	bool			tx_ack_req;	/* Pending ack to send */
 	u8			tx_seq;		/* Next seq number to send */
 	u8			tx_ack;		/* Next ack number to send */
+
+	bool			sleeping;
 };
 
 static void h5_reset_rx(struct h5 *h5);
@@ -208,6 +210,9 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 	const unsigned char sync_rsp[] = { 0x02, 0x7d };
 	const unsigned char conf_req[] = { 0x03, 0xfc, 0x01 };
 	const unsigned char conf_rsp[] = { 0x04, 0x7b, 0x01 };
+	const unsigned char wakeup_req[] = { 0x05, 0xfa };
+	const unsigned char woken_req[] = { 0x06, 0xf9 };
+	const unsigned char sleep_req[] = { 0x07, 0x78 };
 	const unsigned char *hdr = h5->rx_skb->data;
 	const unsigned char *data = &h5->rx_skb->data[4];
 
@@ -230,6 +235,14 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 		BT_DBG("Three-wire init sequence complete");
 		hci_uart_init_ready(hu);
 		return;
+	} else if (memcmp(data, sleep_req, 2) == 0) {
+		BT_DBG("Peer went to sleep");
+		h5->sleeping = true;
+		h5_link_control(hu, wakeup_req, 2);
+	} else if (memcmp(data, woken_req, 2) == 0) {
+		BT_DBG("Peer woke up");
+		h5->sleeping = false;
+		return;
 	} else {
 		BT_DBG("Link Control: 0x%02hhx 0x%02hhx", data[0], data[1]);
 		return;
-- 
1.7.10.4

