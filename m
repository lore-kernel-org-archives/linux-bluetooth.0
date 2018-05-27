Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 09/13] Bluetooth: hci_serdev: Fix HCI_UART_INIT_PENDING not working
Date: Sun, 27 May 2018 21:04:53 +0200
Message-Id: <20180527190457.2632-10-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Init hci_uart->init_ready so that hci_uart_init_ready() works properly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_ldisc.c  | 2 +-
 drivers/bluetooth/hci_serdev.c | 1 +
 drivers/bluetooth/hci_uart.h   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 8da0f53b5912..1b240022dc19 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -195,7 +195,7 @@ static void hci_uart_write_work(struct work_struct *work)
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 }
 
-static void hci_uart_init_work(struct work_struct *work)
+void hci_uart_init_work(struct work_struct *work)
 {
 	struct hci_uart *hu = container_of(work, struct hci_uart, init_ready);
 	int err;
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index ce024142f5d3..cf1ade833fcd 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -309,6 +309,7 @@ int hci_uart_register_device(struct hci_uart *hu,
 	hdev->bus = HCI_UART;
 	hci_set_drvdata(hdev, hu);
 
+	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 	percpu_init_rwsem(&hu->proto_lock);
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 66e8c68e4607..00cab2fd7a1b 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -116,6 +116,7 @@ void hci_uart_unregister_device(struct hci_uart *hu);
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
+void hci_uart_init_work(struct work_struct *work);
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
-- 
2.17.0
