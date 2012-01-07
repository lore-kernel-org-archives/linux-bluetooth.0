Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 12/18] Bluetooth: btsdio: Free driver data on SDIO shutdown
Date: Sat,  7 Jan 2012 15:47:18 +0100
Message-Id: <1325947644-11736-13-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of waiting for the hdev object to get freed we now free the private
driver-internal data on SDIO shutdown. This allows us to remove the obsolete
hci-destruct callback and free our data object right away after calling
hci_unregister_dev(). The HCI-core does not call any callbacks after this so we
are never called again and can safely exit the module.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/btsdio.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 792e32d..d38945c 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -289,15 +289,6 @@ static int btsdio_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void btsdio_destruct(struct hci_dev *hdev)
-{
-	struct btsdio_data *data = hdev->driver_data;
-
-	BT_DBG("%s", hdev->name);
-
-	kfree(data);
-}
-
 static int btsdio_probe(struct sdio_func *func,
 				const struct sdio_device_id *id)
 {
@@ -345,7 +336,6 @@ static int btsdio_probe(struct sdio_func *func,
 	hdev->close    = btsdio_close;
 	hdev->flush    = btsdio_flush;
 	hdev->send     = btsdio_send_frame;
-	hdev->destruct = btsdio_destruct;
 
 	hdev->owner = THIS_MODULE;
 
@@ -378,6 +368,7 @@ static void btsdio_remove(struct sdio_func *func)
 	hci_unregister_dev(hdev);
 
 	hci_free_dev(hdev);
+	kfree(data);
 }
 
 static struct sdio_driver btsdio_driver = {
-- 
1.7.8.1
