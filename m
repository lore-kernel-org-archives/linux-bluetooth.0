Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Remove debug entry for connection features
Date: Fri, 18 Oct 2013 12:04:48 -0700
Message-Id: <1382123092-35256-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The debug entry for connection features is incomplete and also does
not work with AMP controllers and physical links. So just remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sysfs.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 90142ae..c5aa42f 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -37,29 +37,15 @@ static ssize_t show_link_address(struct device *dev,
 	return sprintf(buf, "%pMR\n", &conn->dst);
 }
 
-static ssize_t show_link_features(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	struct hci_conn *conn = to_hci_conn(dev);
-
-	return sprintf(buf, "0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
-		       conn->features[0][0], conn->features[0][1],
-		       conn->features[0][2], conn->features[0][3],
-		       conn->features[0][4], conn->features[0][5],
-		       conn->features[0][6], conn->features[0][7]);
-}
-
 #define LINK_ATTR(_name, _mode, _show, _store) \
 struct device_attribute link_attr_##_name = __ATTR(_name, _mode, _show, _store)
 
 static LINK_ATTR(type, S_IRUGO, show_link_type, NULL);
 static LINK_ATTR(address, S_IRUGO, show_link_address, NULL);
-static LINK_ATTR(features, S_IRUGO, show_link_features, NULL);
 
 static struct attribute *bt_link_attrs[] = {
 	&link_attr_type.attr,
 	&link_attr_address.attr,
-	&link_attr_features.attr,
 	NULL
 };
 
-- 
1.8.3.1

