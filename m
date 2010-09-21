Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH 1/2] Bluetooth: hci open callback for hci UART transport driver
Date: Tue, 21 Sep 2010 19:03:00 +0530
Message-ID: <1285075981-8941-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides option for hci transport driver protocol implementation
to have a callback for hci open.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 drivers/bluetooth/hci_ldisc.c |    5 ++++-
 drivers/bluetooth/hci_uart.h  |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 998833d..5e02501 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -162,9 +162,12 @@ restart:
 /* Initialize device */
 static int hci_uart_open(struct hci_dev *hdev)
 {
+	struct hci_uart *hu  = (struct hci_uart *) hdev->driver_data;
+
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	/* Nothing to do for UART driver */
+	if (hu->proto->hci_open)
+		hu->proto->hci_open(hu);
 
 	set_bit(HCI_RUNNING, &hdev->flags);
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 99fb352..d0198ec 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -51,6 +51,7 @@ struct hci_uart;
 struct hci_uart_proto {
 	unsigned int id;
 	int (*open)(struct hci_uart *hu);
+	int (*hci_open)(struct hci_uart *hu);
 	int (*close)(struct hci_uart *hu);
 	int (*flush)(struct hci_uart *hu);
 	int (*recv)(struct hci_uart *hu, void *data, int len);
-- 
1.7.0.4

