Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RESEND PATCH 3/4] Bluetooth: Introduce to_hci_conn
Date: Thu,  9 Feb 2012 21:58:33 +0100
Message-Id: <1328821115-12514-4-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
References: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This avoids using the dev_set/get_drvdata() functions to retrieve a
pointer to our own structure. We can use simple pointer arithmetic here.
The drvdata field is actually not needed by any other code-path but this
makes the code more consistent with hci_dev.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
Acked in: Message-ID: <1327960796.1955.181.camel@aeonflux>

 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_sysfs.c        |   10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4559189..b20d990 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -623,6 +623,7 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
 #define to_hci_dev(d) container_of(d, struct hci_dev, dev)
+#define to_hci_conn(c) container_of(c, struct hci_conn, dev)
 
 static inline void *hci_get_drvdata(struct hci_dev *hdev)
 {
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 2a0243a..17e6cd4 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -33,19 +33,19 @@ static inline char *link_typetostr(int type)
 
 static ssize_t show_link_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_conn *conn = dev_get_drvdata(dev);
+	struct hci_conn *conn = to_hci_conn(dev);
 	return sprintf(buf, "%s\n", link_typetostr(conn->type));
 }
 
 static ssize_t show_link_address(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_conn *conn = dev_get_drvdata(dev);
+	struct hci_conn *conn = to_hci_conn(dev);
 	return sprintf(buf, "%s\n", batostr(&conn->dst));
 }
 
 static ssize_t show_link_features(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct hci_conn *conn = dev_get_drvdata(dev);
+	struct hci_conn *conn = to_hci_conn(dev);
 
 	return sprintf(buf, "0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
 				conn->features[0], conn->features[1],
@@ -79,7 +79,7 @@ static const struct attribute_group *bt_link_groups[] = {
 
 static void bt_link_release(struct device *dev)
 {
-	void *data = dev_get_drvdata(dev);
+	void *data = to_hci_conn(dev);
 	kfree(data);
 }
 
@@ -120,8 +120,6 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
 
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
 
-	dev_set_drvdata(&conn->dev, conn);
-
 	if (device_add(&conn->dev) < 0) {
 		BT_ERR("Failed to register connection device");
 		return;
-- 
1.7.9
