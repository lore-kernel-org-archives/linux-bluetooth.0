Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Remove controller device attributes
Date: Tue,  5 Jul 2016 14:30:13 +0200
Message-Id: <1467721814-117020-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The controller device attributes are not used and expose no valuable
information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sysfs.c | 54 -----------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 6bfdca8541d6..ca7a35ebaefb 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -79,59 +79,6 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 	hci_dev_put(hdev);
 }
 
-static inline char *host_typetostr(int type)
-{
-	switch (type) {
-	case HCI_BREDR:
-		return "BR/EDR";
-	case HCI_AMP:
-		return "AMP";
-	default:
-		return "UNKNOWN";
-	}
-}
-
-static ssize_t show_type(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%s\n", host_typetostr(hdev->dev_type));
-}
-
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	char name[HCI_MAX_NAME_LENGTH + 1];
-	int i;
-
-	for (i = 0; i < HCI_MAX_NAME_LENGTH; i++)
-		name[i] = hdev->dev_name[i];
-
-	name[HCI_MAX_NAME_LENGTH] = '\0';
-	return sprintf(buf, "%s\n", name);
-}
-
-static ssize_t show_address(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%pMR\n", &hdev->bdaddr);
-}
-
-static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-static DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
-
-static struct attribute *bt_host_attrs[] = {
-	&dev_attr_type.attr,
-	&dev_attr_name.attr,
-	&dev_attr_address.attr,
-	NULL
-};
-
-ATTRIBUTE_GROUPS(bt_host);
-
 static void bt_host_release(struct device *dev)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
@@ -141,7 +88,6 @@ static void bt_host_release(struct device *dev)
 
 static struct device_type bt_host = {
 	.name    = "host",
-	.groups  = bt_host_groups,
 	.release = bt_host_release,
 };
 
-- 
2.7.4

