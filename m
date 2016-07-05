Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Remove connection link attributes
Date: Tue,  5 Jul 2016 14:30:12 +0200
Message-Id: <1467721814-117020-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The connection link attributes are not used and expose no valuable
information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sysfs.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 555982a78a58..6bfdca8541d6 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -7,50 +7,6 @@
 
 static struct class *bt_class;
 
-static inline char *link_typetostr(int type)
-{
-	switch (type) {
-	case ACL_LINK:
-		return "ACL";
-	case SCO_LINK:
-		return "SCO";
-	case ESCO_LINK:
-		return "eSCO";
-	case LE_LINK:
-		return "LE";
-	default:
-		return "UNKNOWN";
-	}
-}
-
-static ssize_t show_link_type(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct hci_conn *conn = to_hci_conn(dev);
-	return sprintf(buf, "%s\n", link_typetostr(conn->type));
-}
-
-static ssize_t show_link_address(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct hci_conn *conn = to_hci_conn(dev);
-	return sprintf(buf, "%pMR\n", &conn->dst);
-}
-
-#define LINK_ATTR(_name, _mode, _show, _store) \
-struct device_attribute link_attr_##_name = __ATTR(_name, _mode, _show, _store)
-
-static LINK_ATTR(type, S_IRUGO, show_link_type, NULL);
-static LINK_ATTR(address, S_IRUGO, show_link_address, NULL);
-
-static struct attribute *bt_link_attrs[] = {
-	&link_attr_type.attr,
-	&link_attr_address.attr,
-	NULL
-};
-
-ATTRIBUTE_GROUPS(bt_link);
-
 static void bt_link_release(struct device *dev)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
@@ -59,7 +15,6 @@ static void bt_link_release(struct device *dev)
 
 static struct device_type bt_link = {
 	.name    = "link",
-	.groups  = bt_link_groups,
 	.release = bt_link_release,
 };
 
-- 
2.7.4

