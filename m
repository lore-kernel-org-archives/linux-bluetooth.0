Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: make batostr() print the in the right order
Date: Fri,  3 Sep 2010 18:43:57 -0300
Message-Id: <1283550237-6066-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1283550237-6066-1-git-send-email-padovan@profusion.mobi>
References: <1283550237-6066-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth core uses the the BD_ADDR in the opposite order from the
human readable order. So we are changing batostr() to print in the
correct order and then removing some baswap(), as they are not needed
anymore.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/cmtp/core.c  |    5 +----
 net/bluetooth/hci_sysfs.c  |   17 ++++-------------
 net/bluetooth/hidp/core.c  |    8 ++------
 net/bluetooth/lib.c        |    4 ++--
 net/bluetooth/rfcomm/tty.c |    4 +---
 5 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index d461606..ec0a134 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -321,13 +321,10 @@ static int cmtp_session(void *arg)
 int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 {
 	struct cmtp_session *session, *s;
-	bdaddr_t dst;
 	int i, err;
 
 	BT_DBG("");
 
-	baswap(&dst, &bt_sk(sock->sk)->dst);
-
 	session = kzalloc(sizeof(struct cmtp_session), GFP_KERNEL);
 	if (!session)
 		return -ENOMEM;
@@ -346,7 +343,7 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 
 	BT_DBG("mtu %d", session->mtu);
 
-	sprintf(session->name, "%s", batostr(&dst));
+	sprintf(session->name, "%s", batostr(&bt_sk(sock->sk)->dst));
 
 	session->sock  = sock;
 	session->state = BT_CONFIG;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 8fb967b..118be43 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -37,9 +37,7 @@ static ssize_t show_link_type(struct device *dev, struct device_attribute *attr,
 static ssize_t show_link_address(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hci_conn *conn = dev_get_drvdata(dev);
-	bdaddr_t bdaddr;
-	baswap(&bdaddr, &conn->dst);
-	return sprintf(buf, "%s\n", batostr(&bdaddr));
+	return sprintf(buf, "%s\n", batostr(&conn->dst));
 }
 
 static ssize_t show_link_features(struct device *dev, struct device_attribute *attr, char *buf)
@@ -238,9 +236,7 @@ static ssize_t show_class(struct device *dev, struct device_attribute *attr, cha
 static ssize_t show_address(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	bdaddr_t bdaddr;
-	baswap(&bdaddr, &hdev->bdaddr);
-	return sprintf(buf, "%s\n", batostr(&bdaddr));
+	return sprintf(buf, "%s\n", batostr(&hdev->bdaddr));
 }
 
 static ssize_t show_features(struct device *dev, struct device_attribute *attr, char *buf)
@@ -408,10 +404,8 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 
 	for (e = cache->list; e; e = e->next) {
 		struct inquiry_data *data = &e->data;
-		bdaddr_t bdaddr;
-		baswap(&bdaddr, &data->bdaddr);
 		seq_printf(f, "%s %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
-			   batostr(&bdaddr),
+			   batostr(&data->bdaddr),
 			   data->pscan_rep_mode, data->pscan_period_mode,
 			   data->pscan_mode, data->dev_class[2],
 			   data->dev_class[1], data->dev_class[0],
@@ -445,13 +439,10 @@ static int blacklist_show(struct seq_file *f, void *p)
 
 	list_for_each(l, &hdev->blacklist) {
 		struct bdaddr_list *b;
-		bdaddr_t bdaddr;
 
 		b = list_entry(l, struct bdaddr_list, list);
 
-		baswap(&bdaddr, &b->bdaddr);
-
-		seq_printf(f, "%s\n", batostr(&bdaddr));
+		seq_printf(f, "%s\n", batostr(&b->bdaddr));
 	}
 
 	hci_dev_unlock_bh(hdev);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index bfe641b..c0ee8b3 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -758,7 +758,6 @@ static int hidp_setup_hid(struct hidp_session *session,
 				struct hidp_connadd_req *req)
 {
 	struct hid_device *hid;
-	bdaddr_t src, dst;
 	int err;
 
 	session->rd_data = kzalloc(req->rd_size, GFP_KERNEL);
@@ -781,9 +780,6 @@ static int hidp_setup_hid(struct hidp_session *session,
 
 	hid->driver_data = session;
 
-	baswap(&src, &bt_sk(session->ctrl_sock->sk)->src);
-	baswap(&dst, &bt_sk(session->ctrl_sock->sk)->dst);
-
 	hid->bus     = BUS_BLUETOOTH;
 	hid->vendor  = req->vendor;
 	hid->product = req->product;
@@ -791,8 +787,8 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->country = req->country;
 
 	strncpy(hid->name, req->name, 128);
-	strncpy(hid->phys, batostr(&src), 64);
-	strncpy(hid->uniq, batostr(&dst), 64);
+	strncpy(hid->phys, batostr(&bt_sk(session->ctrl_sock->sk)->src), 64);
+	strncpy(hid->uniq, batostr(&bt_sk(session->ctrl_sock->sk)->dst), 64);
 
 	hid->dev.parent = hidp_get_device(session);
 	hid->ll_driver = &hidp_hid_driver;
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index ad2af58..b826d1b 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -51,8 +51,8 @@ char *batostr(bdaddr_t *ba)
 
 	i ^= 1;
 	sprintf(str[i], "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[0], ba->b[1], ba->b[2],
-		ba->b[3], ba->b[4], ba->b[5]);
+		ba->b[5], ba->b[4], ba->b[3],
+		ba->b[2], ba->b[1], ba->b[0]);
 
 	return str[i];
 }
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index befc3a5..2646163 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -183,9 +183,7 @@ static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
 static ssize_t show_address(struct device *tty_dev, struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
-	bdaddr_t bdaddr;
-	baswap(&bdaddr, &dev->dst);
-	return sprintf(buf, "%s\n", batostr(&bdaddr));
+	return sprintf(buf, "%s\n", batostr(&dev->dst));
 }
 
 static ssize_t show_channel(struct device *tty_dev, struct device_attribute *attr, char *buf)
-- 
1.7.2.2

