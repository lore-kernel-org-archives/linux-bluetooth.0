Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 3/7] Adding set_connectable method to hciops plugin.
Date: Tue, 12 May 2009 17:56:52 +0530
Message-Id: <1242131216-4081-3-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   18 ++++++++++++++++++
 src/adapter.c    |   45 ++++++++++++++++++++++-----------------------
 src/adapter.h    |    1 +
 3 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index c0368d0..9fdb20d 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -481,12 +481,30 @@ static int hciops_powered(int index, gboolean powered)
 	return hciops_stop(index);
 }
 
+static int hciops_connectable(int index)
+{
+	int dd;
+	uint8_t mode = SCAN_PAGE;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
+					1, &mode);
+
+	hci_close_dev(dd);
+
+	return 0;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
 	.start = hciops_start,
 	.stop = hciops_stop,
 	.set_powered = hciops_powered,
+	.set_connectable = hciops_connectable,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index caf82b1..121694d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -343,23 +343,10 @@ static void adapter_remove_discov_timeout(struct btd_adapter *adapter)
 static gboolean discov_timeout_handler(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	int dd;
-	uint8_t scan_enable;
-	uint16_t dev_id = adapter->dev_id;
 
 	adapter->discov_timeout_id = 0;
 
-	dd = hci_open_dev(dev_id);
-	if (dd < 0) {
-		error("HCI device open failed: hci%d", dev_id);
-		return FALSE;
-	}
-
-	scan_enable = adapter->scan_mode & ~SCAN_INQUIRY;
-
-	hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
-					1, &scan_enable);
-	hci_close_dev(dd);
+	adapter_ops->set_connectable(adapter->dev_id);
 
 	return FALSE;
 }
@@ -421,16 +408,24 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		goto done;
 	}
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return -EIO;
-
 	if (current_scan != scan_enable) {
-		err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
+		if (scan_enable == SCAN_PAGE) {
+			err = adapter_ops->set_connectable(adapter->dev_id);
+			if (err < 0)
+				return err;
+		} else {
+			dd = hci_open_dev(adapter->dev_id);
+			if (dd < 0)
+				return -EIO;
+
+			err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
 					1, &scan_enable);
-		if (err < 0) {
+			if (err < 0) {
+				hci_close_dev(dd);
+				return err;
+			}
+
 			hci_close_dev(dd);
-			return err;
 		}
 	} else if ((scan_enable & SCAN_INQUIRY) &&
 						(new_mode != adapter->mode)) {
@@ -438,20 +433,24 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		if (adapter->discov_timeout)
 			adapter_set_discov_timeout(adapter,
 						adapter->discov_timeout);
+
+		dd = hci_open_dev(adapter->dev_id);
+		if (dd < 0)
+			return -EIO;
+
 		if (new_mode == MODE_LIMITED)
 			set_limited_discoverable(dd, adapter->dev.class,
 									TRUE);
 		else if (adapter->mode == MODE_LIMITED)
 			set_limited_discoverable(dd, adapter->dev.class,
 									FALSE);
+		hci_close_dev(dd);
 	}
 done:
 	modestr = mode2str(new_mode);
 
 	write_device_mode(&adapter->bdaddr, modestr);
 
-	hci_close_dev(dd);
-
 	adapter->mode = new_mode;
 
 	return 0;
diff --git a/src/adapter.h b/src/adapter.h
index 5c292fb..0bfad8a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -153,6 +153,7 @@ struct btd_adapter_ops {
 	int (*start) (int index);
 	int (*stop) (int index);
 	int (*set_powered) (int index, gboolean powered);
+	int (*set_connectable) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3
