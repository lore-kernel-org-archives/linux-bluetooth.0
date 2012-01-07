Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 08/18] Bluetooth: vhci: Free driver_data on file release
Date: Sat,  7 Jan 2012 15:47:14 +0100
Message-Id: <1325947644-11736-9-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This removes the hci-destruct callback and instead frees the private driver data
in the vhci_release file release function. There is no reason to keep private
driver data available if the driver has already shut down.

After vhci_release is called our module can be unloaded. The only reason it is
kept alive is the hci-core having a module-ref on us because of our destruct
callback. However, this callback only frees hdev->driver_data. That is, we wait
for the hdev-device to get destroyed to free our internal driver-data. In fact,
the hci-core does never touch hdev->driver_data so it doesn't care if it is
NULL. Therefore, we simply free it when unloading the driver.

Another important fact is that the hdev core does not call any callbacks other
than the destruct-cb after hci_unregister_dev() has been called. So there is no
function of our module that will be called nor does the hci-core touch
hdev->driver_data. Hence, no other code can touch hdev->driver_data after our
cleanup so the destruct callback is definitely unnecessary here.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/hci_vhci.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 2ed6ab1..44a8012 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -103,11 +103,6 @@ static int vhci_send_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static void vhci_destruct(struct hci_dev *hdev)
-{
-	kfree(hdev->driver_data);
-}
-
 static inline ssize_t vhci_get_user(struct vhci_data *data,
 					const char __user *buf, size_t count)
 {
@@ -248,7 +243,6 @@ static int vhci_open(struct inode *inode, struct file *file)
 	hdev->close    = vhci_close_dev;
 	hdev->flush    = vhci_flush;
 	hdev->send     = vhci_send_frame;
-	hdev->destruct = vhci_destruct;
 
 	hdev->owner = THIS_MODULE;
 
@@ -273,6 +267,7 @@ static int vhci_release(struct inode *inode, struct file *file)
 	hci_free_dev(hdev);
 
 	file->private_data = NULL;
+	kfree(data);
 
 	return 0;
 }
-- 
1.7.8.1
