Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: linux-bluetooth@vger.kernel.org
Cc: peter@hurleysoftware.com,
	gustavo@padovan.org,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v2 3/7] rfcomm: Move rfcomm_get_device before rfcomm_dev_state_change
Date: Mon, 22 Jul 2013 18:27:11 +0200
Message-Id: <1374510435-12149-3-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
References: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Move rfcomm_get_device before rfcomm_dev_state_change. This function will be
called later to move the device under the remote host when the connection is
established.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index c9913dd..fb5dde1 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -147,22 +147,6 @@ static struct rfcomm_dev *rfcomm_dev_get(int id)
 	return dev;
 }
 
-static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
-{
-	struct hci_dev *hdev;
-	struct hci_conn *conn;
-
-	hdev = hci_get_route(&dev->dst, &dev->src);
-	if (!hdev)
-		return NULL;
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &dev->dst);
-
-	hci_dev_put(hdev);
-
-	return conn ? &conn->dev : NULL;
-}
-
 static ssize_t show_address(struct device *tty_dev, struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
@@ -565,6 +549,22 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
+{
+	struct hci_dev *hdev;
+	struct hci_conn *conn;
+
+	hdev = hci_get_route(&dev->dst, &dev->src);
+	if (!hdev)
+		return NULL;
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &dev->dst);
+
+	hci_dev_put(hdev);
+
+	return conn ? &conn->dev : NULL;
+}
+
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 {
 	struct rfcomm_dev *dev = dlc->owner;
-- 
1.8.3.3
