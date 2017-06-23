Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_serdev: make hci_serdev_client_ops static
Date: Fri, 23 Jun 2017 09:37:38 +0100
Message-Id: <20170623083738.8836-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The structure hci_serdev_client_ops does not need to be in global scope
and is not modified, so make it static.

Cleans up sparse warning:
"symbol 'hci_serdev_client_ops' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/hci_serdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 7de0edc0ff8c..aea930101dd2 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -31,7 +31,7 @@
 
 #include "hci_uart.h"
 
-struct serdev_device_ops hci_serdev_client_ops;
+static struct serdev_device_ops hci_serdev_client_ops;
 
 static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_type)
 {
@@ -268,7 +268,7 @@ static int hci_uart_receive_buf(struct serdev_device *serdev, const u8 *data,
 	return count;
 }
 
-struct serdev_device_ops hci_serdev_client_ops = {
+static struct serdev_device_ops hci_serdev_client_ops = {
 	.receive_buf = hci_uart_receive_buf,
 	.write_wakeup = hci_uart_write_wakeup,
 };
-- 
2.11.0
