Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org,
	ohad@bencohen.org
Subject: [PATCH 3/3] bluetooth: hci_ll: Use new hci_uart_unregister_device() function.
Date: Sat,  8 Jul 2017 15:29:49 +0100
Message-Id: <20170708142949.13496-4-ian@mnementh.co.uk>
In-Reply-To: <20170708142949.13496-1-ian@mnementh.co.uk>
References: <20170708142949.13496-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Convert hci_ll to use hci_uart_unregister_device().

This simplifies the _remove() handler as well as fixes a
potential race condition on unload.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_ll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index c982943f0747..20e90fc1f7be 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -745,10 +745,8 @@ static void hci_ti_remove(struct serdev_device *serdev)
 	struct hci_uart *hu = &lldev->hu;
 	struct hci_dev *hdev = hu->hdev;
 
-	cancel_work_sync(&hu->write_work);
+	hci_uart_unregister_device(hdev);
 
-	hci_unregister_dev(hdev);
-	hci_free_dev(hdev);
 	hu->proto->close(hu);
 }
 
-- 
2.11.0
