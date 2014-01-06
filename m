Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	stable@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v2 2/4] rfcomm: move rfcomm_get_device() before rfcomm_dev_activate()
Date: Mon,  6 Jan 2014 19:43:13 +0100
Message-Id: <1389033795-23895-3-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1389033795-23895-1-git-send-email-gianluca@sottospazio.it>
References: <1389033795-23895-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

This is a preparatory patch which moves the rfcomm_get_device()
definition before rfcomm_dev_activate() where it will be used.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a535ef1..32ef9f9 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -103,6 +103,22 @@ static void rfcomm_dev_destruct(struct tty_port *port)
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
 /* device-specific initialization: open the dlc */
 static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
 {
@@ -169,22 +185,6 @@ static struct rfcomm_dev *rfcomm_dev_get(int id)
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
-- 
1.8.5.2
