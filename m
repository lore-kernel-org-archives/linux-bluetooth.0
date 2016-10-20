Return-Path: <jacob@teenage.engineering>
From: Jacob Siverskog <jacob@teenage.engineering>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Jacob Siverskog <jacob@teenage.engineering>
Subject: [PATCH] Bluetooth: btwilink: Fix probe return value
Date: Thu, 20 Oct 2016 09:05:09 +0200
Message-Id: <20161020070509.24042-1-jacob@teenage.engineering>
List-ID: <linux-bluetooth.vger.kernel.org>

Probe functions should return 0 on success. This driver's probe
returns the value returned by hci_register_dev(), which is the hci
index. This works for systems with only one hci device (id = 0) but
for systems where the btwilink device ends up with an id larger than
0, things will start to fall apart.

Make the probe function return 0 on success.

Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
---
 drivers/bluetooth/btwilink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index ef51c9c..b6bb58c 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -310,7 +310,7 @@ static int bt_ti_probe(struct platform_device *pdev)
 	BT_DBG("HCI device registered (hdev %p)", hdev);
 
 	dev_set_drvdata(&pdev->dev, hst);
-	return err;
+	return 0;
 }
 
 static int bt_ti_remove(struct platform_device *pdev)
-- 
2.10.1
