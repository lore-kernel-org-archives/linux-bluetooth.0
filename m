Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 4/7] Adding set_discoverable method to hciops.
Date: Mon, 18 May 2009 15:19:10 +0530
Message-Id: <1242640153-23420-4-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1242640153-23420-3-git-send-email-alok.barsode@azingo.com>
References: <1242640153-23420-1-git-send-email-alok.barsode@azingo.com>
 <1242640153-23420-2-git-send-email-alok.barsode@azingo.com>
 <1242640153-23420-3-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   18 ++++++++++++++++++
 src/adapter.c    |   46 +++++++++++++++++++---------------------------
 src/adapter.h    |    1 +
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 15084e4..184ed9c 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -499,6 +499,23 @@ static int hciops_connectable(int index)
 	return 0;
 }
 
+static int hciops_discoverable(int index)
+{
+	int dd;
+	uint8_t mode = (SCAN_PAGE | SCAN_INQUIRY);
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
@@ -506,6 +523,7 @@ static struct btd_adapter_ops hci_ops = {
 	.stop = hciops_stop,
 	.set_powered = hciops_powered,
 	.set_connectable = hciops_connectable,
+	.set_discoverable = hciops_discoverable,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 121694d..cd18412 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -409,24 +409,13 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 	}
 
 	if (current_scan != scan_enable) {
-		if (scan_enable == SCAN_PAGE) {
+		if (scan_enable == SCAN_PAGE)
 			err = adapter_ops->set_connectable(adapter->dev_id);
-			if (err < 0)
-				return err;
-		} else {
-			dd = hci_open_dev(adapter->dev_id);
-			if (dd < 0)
-				return -EIO;
-
-			err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
-					1, &scan_enable);
-			if (err < 0) {
-				hci_close_dev(dd);
-				return err;
-			}
-
-			hci_close_dev(dd);
-		}
+		else
+			err = adapter_ops->set_discoverable(adapter->dev_id);
+
+		if (err < 0)
+			return err;
 	} else if ((scan_enable & SCAN_INQUIRY) &&
 						(new_mode != adapter->mode)) {
 		adapter_remove_discov_timeout(adapter);
@@ -2001,7 +1990,7 @@ static int adapter_up(struct btd_adapter *adapter)
 	char mode[14], srcaddr[18];
 	uint8_t scan_mode;
 	gboolean powered, dev_down = FALSE;
-	int dd;
+	int dd, err;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -2054,19 +2043,22 @@ static int adapter_up(struct btd_adapter *adapter)
 	}
 
 proceed:
-	dd = hci_open_dev(adapter->dev_id);
-
-	if (dd < 0)
-		return -EIO;
+	if (scan_mode == SCAN_PAGE)
+		err = adapter_ops->set_connectable(adapter->dev_id);
+	else
+		err = adapter_ops->set_discoverable(adapter->dev_id);
 
-	if (dev_down == FALSE)
-		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
-				1, &scan_mode);
+	if (err < 0)
+		return err;
 
 	if (adapter->initialized == FALSE) {
 		load_drivers(adapter);
 		load_devices(adapter);
 
+		dd = hci_open_dev(adapter->dev_id);
+		if (dd < 0)
+			return -EIO;
+
 		/* retrieve the active connections: address the scenario where
 		 * the are active connections before the daemon've started */
 		load_connections(adapter, dd);
@@ -2074,6 +2066,8 @@ proceed:
 		adapter->initialized = TRUE;
 
 		manager_add_adapter(adapter->path);
+
+		hci_close_dev(dd);
 	}
 
 	if (adapter->svc_cache)
@@ -2088,8 +2082,6 @@ proceed:
 					ADAPTER_INTERFACE, "Powered",
 					DBUS_TYPE_BOOLEAN, &powered);
 
-	hci_close_dev(dd);
-
 	return 0;
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 0bfad8a..bfd2826 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -154,6 +154,7 @@ struct btd_adapter_ops {
 	int (*stop) (int index);
 	int (*set_powered) (int index, gboolean powered);
 	int (*set_connectable) (int index);
+	int (*set_discoverable) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3
