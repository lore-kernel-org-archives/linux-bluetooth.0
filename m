Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Adding start() functionality to hciops plugin.
Date: Wed, 29 Apr 2009 20:27:00 +0530
Message-Id: <1241017020-4299-1-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   23 +++++++++++++++++++++++
 src/adapter.c    |   21 ++++++---------------
 src/adapter.h    |    1 +
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index e820e72..115c4f0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -416,9 +416,32 @@ static void hciops_cleanup(void)
 {
 }
 
+int hciops_start(int index)
+{
+	int dd;
+	int err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if (ioctl(dd, HCIDEVUP, index) == 0)
+			goto done; /* on success */
+
+	if (errno != EALREADY) {
+		err = -errno;
+		error("Can't init device hci%d: %s (%d)\n",
+				index, strerror(errno), errno);
+		}
+ done:
+	hci_close_dev(dd);
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
+	.start = hciops_start,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 0ad5717..ac7b1ec 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -405,25 +405,16 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 
 	scan_enable = mode2scan(new_mode);
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return -EIO;
-
 	if (!adapter->up && scan_enable != SCAN_DISABLED) {
-		/* Start HCI device */
-		if (ioctl(dd, HCIDEVUP, adapter->dev_id) == 0)
-			goto done; /* on success */
-
-		if (errno != EALREADY) {
-			err = -errno;
-			error("Can't init device hci%d: %s (%d)\n",
-				adapter->dev_id, strerror(errno), errno);
-
-			hci_close_dev(dd);
+		err = adapter_ops->start(adapter->dev_id);
+		if (err < 0)
 			return err;
-		}
 	}
 
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0)
+		return -EIO;
+
 	if (adapter->up && scan_enable == SCAN_DISABLED) {
 		struct hci_request rq = {
 			.ogf = OGF_HOST_CTL,
diff --git a/src/adapter.h b/src/adapter.h
index 3452519..9343d12 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -152,6 +152,7 @@ gboolean adapter_powering_down(struct btd_adapter *adapter);
 struct btd_adapter_ops {
 	int (*setup) (void);
 	void (*cleanup) (void);
+	int (*start) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3
