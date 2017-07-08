Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org
Subject: [PATCH 2/2] bluetooth: Nokia: remove duplicate call to pm_runtime_disable()
Date: Sat,  8 Jul 2017 14:43:35 +0100
Message-Id: <20170708134335.10896-3-ian@mnementh.co.uk>
In-Reply-To: <20170708134335.10896-1-ian@mnementh.co.uk>
References: <20170708134335.10896-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

pm_runtime_disable() is called in the _close() handler.

Since we call the _close() handler on remove, there is no need to
call pm_runtime_disable() a second time.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/bluetooth/hci_nokia.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index bc1f4496583e..6dbb1f6ff6bd 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -777,8 +777,6 @@ static void nokia_bluetooth_serdev_remove(struct serdev_device *serdev)
 	cancel_work_sync(&hu->write_work);
 
 	hu->proto->close(hu);
-
-	pm_runtime_disable(&btdev->serdev->dev);
 }
 
 static int nokia_bluetooth_runtime_suspend(struct device *dev)
-- 
2.11.0
