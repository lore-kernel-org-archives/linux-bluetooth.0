Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove bus attribute in favor of hierarchy
Date: Fri, 18 Oct 2013 12:39:27 -0700
Message-Id: <1382125167-44247-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bus information are exposed in the actual hierarchy and should
not be exposed as attribute.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sysfs.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 95fc5bb..0b61250 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -131,28 +131,6 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 	hci_dev_put(hdev);
 }
 
-static inline char *host_bustostr(int bus)
-{
-	switch (bus) {
-	case HCI_VIRTUAL:
-		return "VIRTUAL";
-	case HCI_USB:
-		return "USB";
-	case HCI_PCCARD:
-		return "PCCARD";
-	case HCI_UART:
-		return "UART";
-	case HCI_RS232:
-		return "RS232";
-	case HCI_PCI:
-		return "PCI";
-	case HCI_SDIO:
-		return "SDIO";
-	default:
-		return "UNKNOWN";
-	}
-}
-
 static inline char *host_typetostr(int type)
 {
 	switch (type) {
@@ -165,13 +143,6 @@ static inline char *host_typetostr(int type)
 	}
 }
 
-static ssize_t show_bus(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%s\n", host_bustostr(hdev->bus));
-}
-
 static ssize_t show_type(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -200,13 +171,11 @@ static ssize_t show_address(struct device *dev,
 	return sprintf(buf, "%pMR\n", &hdev->bdaddr);
 }
 
-static DEVICE_ATTR(bus, S_IRUGO, show_bus, NULL);
 static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
 
 static struct attribute *bt_host_attrs[] = {
-	&dev_attr_bus.attr,
 	&dev_attr_type.attr,
 	&dev_attr_name.attr,
 	&dev_attr_address.attr,
-- 
1.8.3.1

