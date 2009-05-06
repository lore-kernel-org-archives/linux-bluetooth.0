Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/2] Adding stop() functionality to hciops plugin.
Date: Wed,  6 May 2009 14:07:57 +0530
Message-Id: <1241599077-26438-2-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1241599077-26438-1-git-send-email-alok.barsode@azingo.com>
References: <1241599077-26438-1-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   24 ++++++++++++++++++++++++
 src/adapter.c    |   23 ++++++++++-------------
 src/adapter.h    |    1 +
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index ba4b69d..2e91129 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -439,10 +439,34 @@ done:
 	return err;
 }
 
+static int hciops_stop(int index)
+{
+	int dd;
+	int err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if (ioctl(dd, HCIDEVDOWN, index) == 0)
+		goto done; /* on success */
+
+	if (errno != EALREADY) {
+		err = -errno;
+		error("Can't stop device hci%d: %s (%d)",
+				index, strerror(errno), errno);
+	}
+
+done:
+	hci_close_dev(dd);
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
 	.start = hciops_start,
+	.stop = hciops_stop,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 99dd2eb..eecca34 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -424,18 +424,21 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		};
 
 		hci_send_req(dd, &rq, HCI_REQ_TIMEOUT);
+		hci_close_dev(dd);
 
-		if (ioctl(dd, HCIDEVDOWN, adapter->dev_id) < 0) {
-			err = -errno;
-			hci_close_dev(dd);
+		err = adapter_ops->stop(adapter->dev_id);
+		if (err < 0)
 			return err;
-		}
 
 		adapter->off_requested = TRUE;
 
 		goto done;
 	}
 
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0)
+		return -EIO;
+
 	if (current_scan != scan_enable) {
 		err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
 					1, &scan_enable);
@@ -2082,7 +2085,7 @@ proceed:
 	}
 
 	if (dev_down) {
-		ioctl(dd, HCIDEVDOWN, adapter->dev_id);
+		adapter_ops->stop(adapter->dev_id);
 		adapter->off_requested = TRUE;
 		return 1;
 	} else
@@ -2465,14 +2468,8 @@ void adapter_remove(struct btd_adapter *adapter)
 	unload_drivers(adapter);
 
 	/* Return adapter to down state if it was not up on init */
-	if (adapter->up && !adapter->already_up) {
-		int dd = hci_open_dev(adapter->dev_id);
-		if (dd < 0)
-			goto done;
-
-		ioctl(dd, HCIDEVDOWN, adapter->dev_id);
-		hci_close_dev(dd);
-	}
+	if (adapter->up && !adapter->already_up)
+		adapter_ops->stop(adapter->dev_id);
 
 done:
 	g_dbus_unregister_interface(connection, path, ADAPTER_INTERFACE);
diff --git a/src/adapter.h b/src/adapter.h
index 67db648..acf680b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -153,6 +153,7 @@ struct btd_adapter_ops {
 	int (*setup) (void);
 	void (*cleanup) (void);
 	int (*start) (int index);
+	int (*stop) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3
