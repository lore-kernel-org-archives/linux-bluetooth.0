Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 07/16] Add 'timeout' param to start_scanning callback
Date: Fri, 29 Apr 2011 21:27:23 -0300
Message-Id: <1304123252-14464-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a timeout parameter to start_scanning callback in
btd_adatper. The parameter should be used to stop scanning  after
'timeout' milliseconds.
---
 plugins/hciops.c  |   38 ++++++++++++++++++++++++++++++++++++--
 plugins/mgmtops.c |    2 +-
 src/adapter.c     |    2 +-
 src/adapter.h     |    2 +-
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 81a0f29..61ae404 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -139,6 +139,8 @@ static struct dev_info {
 	GSList *uuids;
 
 	GSList *connections;
+
+	guint stop_scan_id;
 } *devs = NULL;
 
 static inline int get_state(int index)
@@ -2303,6 +2305,9 @@ static void stop_hci_dev(int index)
 	if (dev->watch_id > 0)
 		g_source_remove(dev->watch_id);
 
+	if (dev->stop_scan_id > 0)
+		g_source_remove(dev->stop_scan_id);
+
 	if (dev->io != NULL)
 		g_io_channel_unref(dev->io);
 
@@ -3031,10 +3036,25 @@ static int le_set_scan_enable(int index, uint8_t enable)
 	return 0;
 }
 
-static int hciops_start_scanning(int index)
+static gboolean stop_le_scan_cb(gpointer user_data)
+{
+	struct dev_info *dev = user_data;
+	int err;
+
+	err = le_set_scan_enable(dev->id, 0);
+	if (err < 0)
+		return TRUE;
+
+	dev->stop_scan_id = 0;
+
+	return FALSE;
+}
+
+static int hciops_start_scanning(int index, int timeout)
 {
 	struct dev_info *dev = &devs[index];
 	le_set_scan_parameters_cp cp;
+	int err;
 
 	DBG("hci%d", index);
 
@@ -3051,13 +3071,27 @@ static int hciops_start_scanning(int index)
 				LE_SET_SCAN_PARAMETERS_CP_SIZE, &cp) < 0)
 		return -errno;
 
-	return le_set_scan_enable(index, 1);
+	err = le_set_scan_enable(index, 1);
+	if (err < 0)
+		return err;
+
+	/* Schedule a le scan disable in 'timeout' milliseconds */
+	dev->stop_scan_id = g_timeout_add(timeout, stop_le_scan_cb, dev);
+
+	return 0;
 }
 
 static int hciops_stop_scanning(int index)
 {
+	struct dev_info *dev = &devs[index];
+
 	DBG("hci%d", index);
 
+	if (dev->stop_scan_id > 0) {
+		g_source_remove(dev->stop_scan_id);
+		dev->stop_scan_id = 0;
+	}
+
 	return le_set_scan_enable(index, 0);
 }
 
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index ac180f9..9fa195d 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1632,7 +1632,7 @@ static int mgmt_stop_inquiry(int index)
 	return 0;
 }
 
-static int mgmt_start_scanning(int index)
+static int mgmt_start_scanning(int index, int timeout)
 {
 	DBG("index %d", index);
 	return -ENOSYS;
diff --git a/src/adapter.c b/src/adapter.c
index 1dfa9a6..6c29992 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2807,7 +2807,7 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 		 */
 		if (adapter->disc_sessions && (type & DISC_INTERLEAVE) &&
 						(previous & STATE_STDINQ)) {
-			adapter_ops->start_scanning(adapter->dev_id);
+			adapter_ops->start_scanning(adapter->dev_id, 0);
 			return;
 		}
 		/* BR/EDR only: inquiry finished */
diff --git a/src/adapter.h b/src/adapter.h
index 1a5c687..bb1abe8 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -191,7 +191,7 @@ struct btd_adapter_ops {
 	int (*stop_discovery) (int index);
 	int (*start_inquiry) (int index, uint8_t length, gboolean periodic);
 	int (*stop_inquiry) (int index);
-	int (*start_scanning) (int index);
+	int (*start_scanning) (int index, int timeout);
 	int (*stop_scanning) (int index);
 
 	int (*resolve_name) (int index, bdaddr_t *bdaddr);
-- 
1.7.1

