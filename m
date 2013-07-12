Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org,
	peter@hurleysoftware.com,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH 2/8] Move functions before the definition of rfcomm_port_ops
Date: Fri, 12 Jul 2013 22:40:42 +0200
Message-Id: <1373661649-1385-2-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Move rfcomm_tty_copy_pending and rfcomm_get_device before the definition of
rfcomm_port_ops.

These functions will be called later from the .activate and .shutdown methods of
the tty_port.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 74 +++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 6c3efb5..ff60171 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -112,6 +112,43 @@ static void rfcomm_dev_destruct(struct tty_port *port)
 	module_put(THIS_MODULE);
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
+static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
+{
+	struct sk_buff *skb;
+	int inserted = 0;
+
+	BT_DBG("dev %p", dev);
+
+	rfcomm_dlc_lock(dev->dlc);
+
+	while ((skb = skb_dequeue(&dev->pending))) {
+		inserted += tty_insert_flip_string(&dev->port, skb->data,
+				skb->len);
+		kfree_skb(skb);
+	}
+
+	rfcomm_dlc_unlock(dev->dlc);
+
+	if (inserted > 0)
+		tty_flip_buffer_push(&dev->port);
+}
+
 static const struct tty_port_operations rfcomm_port_ops = {
 	.destruct = rfcomm_dev_destruct,
 };
@@ -147,22 +184,6 @@ static struct rfcomm_dev *rfcomm_dev_get(int id)
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
@@ -624,27 +645,6 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 }
 
 /* ---- TTY functions ---- */
-static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
-{
-	struct sk_buff *skb;
-	int inserted = 0;
-
-	BT_DBG("dev %p", dev);
-
-	rfcomm_dlc_lock(dev->dlc);
-
-	while ((skb = skb_dequeue(&dev->pending))) {
-		inserted += tty_insert_flip_string(&dev->port, skb->data,
-				skb->len);
-		kfree_skb(skb);
-	}
-
-	rfcomm_dlc_unlock(dev->dlc);
-
-	if (inserted > 0)
-		tty_flip_buffer_push(&dev->port);
-}
-
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	DECLARE_WAITQUEUE(wait, current);
-- 
1.8.3.2
