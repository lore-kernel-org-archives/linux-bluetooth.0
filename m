Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 4/4] Bluetooth: Use proper datatypes in release-callbacks
Date: Fri, 27 Jan 2012 16:47:26 +0100
Message-Id: <1327679246-2667-5-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This enhances code readability a lot and avoids using void* even though
we know the type of the variable.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/hci_sysfs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 17e6cd4..bc15429 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -79,8 +79,8 @@ static const struct attribute_group *bt_link_groups[] = {
 
 static void bt_link_release(struct device *dev)
 {
-	void *data = to_hci_conn(dev);
-	kfree(data);
+	struct hci_conn *conn = to_hci_conn(dev);
+	kfree(conn);
 }
 
 static struct device_type bt_link = {
@@ -368,8 +368,8 @@ static const struct attribute_group *bt_host_groups[] = {
 
 static void bt_host_release(struct device *dev)
 {
-	void *data = to_hci_dev(dev);
-	kfree(data);
+	struct hci_dev *hdev = to_hci_dev(dev);
+	kfree(hdev);
 	module_put(THIS_MODULE);
 }
 
-- 
1.7.8.4
