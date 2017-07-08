Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org
Subject: [PATCH 1/2] bluetooth: Nokia: prevent crash on module removal.
Date: Sat,  8 Jul 2017 14:43:34 +0100
Message-Id: <20170708134335.10896-2-ian@mnementh.co.uk>
In-Reply-To: <20170708134335.10896-1-ian@mnementh.co.uk>
References: <20170708134335.10896-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Only cancel any ongoing work after making sure, that no new work
can be scheduled. This fixes a race condition in the remove handler.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/bluetooth/hci_nokia.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 181a15b549e5..bc1f4496583e 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -770,10 +770,12 @@ static void nokia_bluetooth_serdev_remove(struct serdev_device *serdev)
 	struct hci_uart *hu = &btdev->hu;
 	struct hci_dev *hdev = hu->hdev;
 
-	cancel_work_sync(&hu->write_work);
 
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
+
+	cancel_work_sync(&hu->write_work);
+
 	hu->proto->close(hu);
 
 	pm_runtime_disable(&btdev->serdev->dev);
-- 
2.11.0
