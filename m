Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org,
	ohad@bencohen.org
Subject: [PATCH 3/4] bluetooth: hci_ll: Use new hci_uart_unregister_device() function.
Date: Sat,  8 Jul 2017 17:12:27 +0100
Message-Id: <20170708161228.24324-3-ian@mnementh.co.uk>
In-Reply-To: <20170708161228.24324-1-ian@mnementh.co.uk>
References: <20170708161228.24324-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Convert hci_ll to use hci_uart_unregister_device().

This simplifies the _remove() handler as well as fixes a
potential race condition on unload.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_ll.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index c982943f0747..1b898445a0b8 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -742,14 +742,8 @@ static int hci_ti_probe(struct serdev_device *serdev)
 static void hci_ti_remove(struct serdev_device *serdev)
 {
 	struct ll_device *lldev = serdev_device_get_drvdata(serdev);
-	struct hci_uart *hu = &lldev->hu;
-	struct hci_dev *hdev = hu->hdev;
 
-	cancel_work_sync(&hu->write_work);
-
-	hci_unregister_dev(hdev);
-	hci_free_dev(hdev);
-	hu->proto->close(hu);
+	hci_uart_unregister_device(&lldev->hu);
 }
 
 static const struct of_device_id hci_ti_of_match[] = {
-- 
2.11.0
