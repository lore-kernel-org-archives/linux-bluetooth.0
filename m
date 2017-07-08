Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org,
	ohad@bencohen.org
Subject: [PATCH 2/4] bluetooth: Nokia: Use new hci_uart_unregister_device() function.
Date: Sat,  8 Jul 2017 17:26:30 +0100
Message-Id: <20170708162631.24045-2-ian@mnementh.co.uk>
In-Reply-To: <20170708162631.24045-1-ian@mnementh.co.uk>
References: <20170708162631.24045-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Simplify _remove() path for hci_nokia.c

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_nokia.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 6dbb1f6ff6bd..3539fd03f47e 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -767,16 +767,8 @@ static int nokia_bluetooth_serdev_probe(struct serdev_device *serdev)
 static void nokia_bluetooth_serdev_remove(struct serdev_device *serdev)
 {
 	struct nokia_bt_dev *btdev = serdev_device_get_drvdata(serdev);
-	struct hci_uart *hu = &btdev->hu;
-	struct hci_dev *hdev = hu->hdev;
 
-
-	hci_unregister_dev(hdev);
-	hci_free_dev(hdev);
-
-	cancel_work_sync(&hu->write_work);
-
-	hu->proto->close(hu);
+	hci_uart_unregister_device(&btdev->hu);
 }
 
 static int nokia_bluetooth_runtime_suspend(struct device *dev)
-- 
2.11.0
