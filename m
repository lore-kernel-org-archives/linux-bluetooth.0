Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V3 2/3] Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
Date: Thu, 20 Apr 2017 18:06:40 +0100
Message-ID: <1492708001-30228-3-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1492708001-30228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1492708001-30228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

When hci_register_dev() fails, hu->hdev should be set to NULL before
freeing hdev. This avoids potential use of hu->hdev after it has been
freed.

This commit sets hu->hdev to NULL before calling hci_free_dev() in error
handling scenarios in hci_uart_init_work() and hci_uart_register_dev().

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 1166e3f..b1096d1 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -177,6 +177,7 @@ static void hci_uart_init_work(struct work_struct *work)
 {
 	struct hci_uart *hu = container_of(work, struct hci_uart, init_ready);
 	int err;
+	struct hci_dev *hdev;
 
 	if (!test_and_clear_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return;
@@ -184,8 +185,9 @@ static void hci_uart_init_work(struct work_struct *work)
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
-		hci_free_dev(hu->hdev);
+		hdev = hu->hdev;
 		hu->hdev = NULL;
+		hci_free_dev(hdev);
 		hu->proto->close(hu);
 		return;
 	}
@@ -603,6 +605,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		hu->hdev = NULL;
 		hci_free_dev(hdev);
 		return -ENODEV;
 	}
-- 
2.7.4
