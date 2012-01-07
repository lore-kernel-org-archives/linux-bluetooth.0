Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 15/18] Bluetooth: Correctly acquire module ref
Date: Sat,  7 Jan 2012 15:47:21 +0100
Message-Id: <1325947644-11736-16-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We provide a device-object to other subsystems and we provide our own
release-function. Therefore, the device-object must own a reference to our
module, otherwise the release-function may get deleted before the device-object
does.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/hci_sysfs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 5210956..e3bdee0 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -372,6 +372,7 @@ static void bt_host_release(struct device *dev)
 {
 	void *data = dev_get_drvdata(dev);
 	kfree(data);
+	module_put(THIS_MODULE);
 }
 
 static struct device_type bt_host = {
@@ -523,6 +524,7 @@ void hci_init_sysfs(struct hci_dev *hdev)
 	dev->type = &bt_host;
 	dev->class = bt_class;
 
+	__module_get(THIS_MODULE);
 	dev_set_drvdata(dev, hdev);
 	device_initialize(dev);
 }
-- 
1.7.8.1
