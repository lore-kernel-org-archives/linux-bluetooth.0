Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org,
	ohad@bencohen.org
Subject: [PATCH 2/3] bluetooth: Nokia: Use new hci_uart_unregister_device() function.
Date: Sat,  8 Jul 2017 15:29:48 +0100
Message-Id: <20170708142949.13496-3-ian@mnementh.co.uk>
In-Reply-To: <20170708142949.13496-1-ian@mnementh.co.uk>
References: <20170708142949.13496-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Simplify _remove() path for hci_nokia.c

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_nokia.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 6dbb1f6ff6bd..1a465dd2970e 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -770,11 +770,7 @@ static void nokia_bluetooth_serdev_remove(struct serdev_device *serdev)
 	struct hci_uart *hu = &btdev->hu;
 	struct hci_dev *hdev = hu->hdev;
 
-
-	hci_unregister_dev(hdev);
-	hci_free_dev(hdev);
-
-	cancel_work_sync(&hu->write_work);
+	hci_uart_unregister_device(hdev);
 
 	hu->proto->close(hu);
 }
-- 
2.11.0
