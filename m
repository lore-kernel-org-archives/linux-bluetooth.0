Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 3/3] Adding cancel_resolve_name functionality to hciops plugin.
Date: Tue, 23 Jun 2009 20:20:21 +0530
Message-Id: <1245768621-22895-3-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1245768621-22895-2-git-send-email-alok.barsode@azingo.com>
References: <1245768621-22895-1-git-send-email-alok.barsode@azingo.com>
 <1245768621-22895-2-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   23 +++++++++++++++++++++++
 src/adapter.c    |   25 ++++++-------------------
 src/adapter.h    |    1 +
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9a873fd..7e34b12 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -651,6 +651,28 @@ static int hciops_resolve_name(int index, bdaddr_t *bdaddr)
 	return err;
 }
 
+static int hciops_cancel_resolve_name(int index, bdaddr_t *bdaddr)
+{
+	remote_name_req_cancel_cp cp;
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.bdaddr, bdaddr);
+
+	err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_REMOTE_NAME_REQ_CANCEL,
+					REMOTE_NAME_REQ_CANCEL_CP_SIZE, &cp);
+	if (err < 0)
+		err = -errno;
+
+	hci_close_dev(dd);
+
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -663,6 +685,7 @@ static struct btd_adapter_ops hci_ops = {
 	.start_discovery = hciops_start_discovery,
 	.stop_discovery = hciops_stop_discovery,
 	.resolve_name = hciops_resolve_name,
+	.cancel_resolve_name = hciops_cancel_resolve_name,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index cd5c1d0..e9bd1d8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -227,34 +227,21 @@ void clear_found_devices_list(struct btd_adapter *adapter)
 int pending_remote_name_cancel(struct btd_adapter *adapter)
 {
 	struct remote_dev_info *dev, match;
-	GSList *l;
-	int dd, err = 0;
+	int err = 0;
 
 	/* find the pending remote name request */
 	memset(&match, 0, sizeof(struct remote_dev_info));
 	bacpy(&match.bdaddr, BDADDR_ANY);
 	match.name_status = NAME_REQUESTED;
 
-	l = g_slist_find_custom(adapter->found_devices, &match,
-			(GCompareFunc) found_device_cmp);
-	if (!l) /* no pending request */
-		return 0;
-
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return -ENODEV;
-
-	dev = l->data;
+	dev = adapter_search_found_devices(adapter, &match);
+	if (!dev) /* no pending request */
+		return -ENODATA;
 
-	if (hci_read_remote_name_cancel(dd, &dev->bdaddr,
-					HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
+	err = adapter_ops->cancel_resolve_name(adapter->dev_id, &dev->bdaddr);
+	if (err < 0)
 		error("Remote name cancel failed: %s(%d)",
 						strerror(errno), errno);
-	}
-
-	hci_close_dev(dd);
-
 	return err;
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index e087bb0..f631576 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -165,6 +165,7 @@ struct btd_adapter_ops {
 	int (*start_discovery) (int index, gboolean periodic);
 	int (*stop_discovery) (int index);
 	int (*resolve_name) (int index, bdaddr_t *bdaddr);
+	int (*cancel_resolve_name) (int index, bdaddr_t *bdaddr);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3

