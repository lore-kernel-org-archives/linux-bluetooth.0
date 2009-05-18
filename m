Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 6/7] Adding set_limited_discoverable method to hciops plugin.
Date: Mon, 18 May 2009 17:07:36 +0530
Message-Id: <1242646656-2809-1-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   46 ++++++++++++++++++++++++++++++++++++
 src/adapter.c    |   69 +++++++----------------------------------------------
 src/adapter.h    |    2 +
 3 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 184ed9c..8f9ee06 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -516,6 +516,51 @@ static int hciops_discoverable(int index)
 	return 0;
 }
 
+static int hciops_set_limited_discoverable(int index, const uint8_t *cls,
+							gboolean limited)
+{
+	int dd, err = 0;
+	uint32_t dev_class;
+	int num = (limited ? 2 : 1);
+	uint8_t lap[] = { 0x33, 0x8b, 0x9e, 0x00, 0x8b, 0x9e };
+	/*
+	 * 1: giac
+	 * 2: giac + liac
+	 */
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if (hci_write_current_iac_lap(dd, num, lap, HCI_REQ_TIMEOUT) < 0) {
+		err = -errno;
+		error("Can't write current IAC LAP: %s(%d)",
+						strerror(errno), errno);
+		goto done;
+	}
+
+	if (limited) {
+		if (cls[1] & 0x20)
+			goto done; /* Already limited */
+
+		dev_class = (cls[2] << 16) | ((cls[1] | 0x20) << 8) | cls[0];
+	} else {
+		if (!(cls[1] & 0x20))
+			goto done; /* Already clear */
+
+		dev_class = (cls[2] << 16) | ((cls[1] & 0xdf) << 8) | cls[0];
+	}
+
+	if (hci_write_class_of_dev(dd, dev_class, HCI_REQ_TIMEOUT) < 0) {
+		err = -errno;
+		error("Can't write class of device: %s (%d)",
+						strerror(errno), errno);
+		goto done;
+	}
+done:
+	hci_close_dev(dd);
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -524,6 +569,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_powered = hciops_powered,
 	.set_connectable = hciops_connectable,
 	.set_discoverable = hciops_discoverable,
+	.set_limited_discoverable = hciops_set_limited_discoverable,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 2d7d6cf..ebbd02e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -252,45 +252,6 @@ int pending_remote_name_cancel(struct btd_adapter *adapter)
 	return err;
 }
 
-static int set_limited_discoverable(int dd, const uint8_t *cls,
-							gboolean limited)
-{
-	uint32_t dev_class;
-	int num = (limited ? 2 : 1);
-	uint8_t lap[] = { 0x33, 0x8b, 0x9e, 0x00, 0x8b, 0x9e };
-	/*
-	 * 1: giac
-	 * 2: giac + liac
-	 */
-	if (hci_write_current_iac_lap(dd, num, lap, HCI_REQ_TIMEOUT) < 0) {
-		int err = -errno;
-		error("Can't write current IAC LAP: %s(%d)",
-						strerror(errno), errno);
-		return err;
-	}
-
-	if (limited) {
-		if (cls[1] & 0x20)
-			return 0; /* Already limited */
-
-		dev_class = (cls[2] << 16) | ((cls[1] | 0x20) << 8) | cls[0];
-	} else {
-		if (!(cls[1] & 0x20))
-			return 0; /* Already clear */
-
-		dev_class = (cls[2] << 16) | ((cls[1] & 0xdf) << 8) | cls[0];
-	}
-
-	if (hci_write_class_of_dev(dd, dev_class, HCI_REQ_TIMEOUT) < 0) {
-		int err = -errno;
-		error("Can't write class of device: %s (%d)",
-						strerror(errno), errno);
-		return err;
-	}
-
-	return 0;
-}
-
 static const char *mode2str(uint8_t mode)
 {
 	switch(mode) {
@@ -387,7 +348,7 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 {
 	uint8_t scan_enable;
 	uint8_t current_scan = adapter->scan_mode;
-	int err, dd;
+	int err;
 	const char *modestr;
 
 	scan_enable = mode2scan(new_mode);
@@ -423,17 +384,12 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 			adapter_set_discov_timeout(adapter,
 						adapter->discov_timeout);
 
-		dd = hci_open_dev(adapter->dev_id);
-		if (dd < 0)
-			return -EIO;
-
 		if (new_mode == MODE_LIMITED)
-			set_limited_discoverable(dd, adapter->dev.class,
-									TRUE);
+			adapter_ops->set_limited_discoverable(adapter->dev_id,
+						adapter->dev.class, TRUE);
 		else if (adapter->mode == MODE_LIMITED)
-			set_limited_discoverable(dd, adapter->dev.class,
-									FALSE);
-		hci_close_dev(dd);
+			adapter_ops->set_limited_discoverable(adapter->dev_id,
+						adapter->dev.class,FALSE);
 	}
 
 done:
@@ -2725,7 +2681,6 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 	const gchar *path = adapter_get_path(adapter);
 	gboolean discoverable, pairable;
 	uint8_t real_class[3];
-	int dd;
 
 	if (adapter->scan_mode == scan_mode)
 		return;
@@ -2770,23 +2725,17 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 					ADAPTER_INTERFACE, "Pairable",
 					DBUS_TYPE_BOOLEAN, &pairable);
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0) {
-		error("HCI device open failed: hci%d", adapter->dev_id);
-		goto done;
-	}
-
 	memcpy(real_class, adapter->dev.class, 3);
 	if (adapter->svc_cache)
 		real_class[2] = adapter->svc_cache;
 
 	if (discoverable && adapter->pairable)
-		set_limited_discoverable(dd, real_class, TRUE);
+		adapter_ops->set_limited_discoverable(adapter->dev_id,
+							real_class, TRUE);
 	else if (!discoverable)
-		set_limited_discoverable(dd, real_class, FALSE);
+		adapter_ops->set_limited_discoverable(adapter->dev_id,
+							real_class, FALSE);
 
-	hci_close_dev(dd);
-done:
 	emit_property_changed(connection, path,
 				ADAPTER_INTERFACE, "Discoverable",
 				DBUS_TYPE_BOOLEAN, &discoverable);
diff --git a/src/adapter.h b/src/adapter.h
index bfd2826..a94edc6 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -155,6 +155,8 @@ struct btd_adapter_ops {
 	int (*set_powered) (int index, gboolean powered);
 	int (*set_connectable) (int index);
 	int (*set_discoverable) (int index);
+	int (*set_limited_discoverable) (int index, const uint8_t *cls,
+						gboolean limited);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3
