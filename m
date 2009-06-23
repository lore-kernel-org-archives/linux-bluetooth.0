Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/3] Adding resolve name functionality to hciops plugin.
Date: Tue, 23 Jun 2009 20:20:20 +0530
Message-Id: <1245768621-22895-2-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1245768621-22895-1-git-send-email-alok.barsode@azingo.com>
References: <1245768621-22895-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   24 ++++++++++++++++++++++++
 src/adapter.c    |   19 ++-----------------
 src/adapter.h    |    1 +
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index dae79b3..9a873fd 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -628,6 +628,29 @@ static int hciops_stop_discovery(int index)
 	return err;
 }
 
+static int hciops_resolve_name(int index, bdaddr_t *bdaddr)
+{
+	remote_name_req_cp cp;
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.bdaddr, bdaddr);
+	cp.pscan_rep_mode = 0x02;
+
+	err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_REMOTE_NAME_REQ,
+					REMOTE_NAME_REQ_CP_SIZE, &cp);
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
@@ -639,6 +662,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_limited_discoverable = hciops_set_limited_discoverable,
 	.start_discovery = hciops_start_discovery,
 	.stop_discovery = hciops_stop_discovery,
+	.resolve_name = hciops_resolve_name,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 9a913ac..cd5c1d0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -260,9 +260,8 @@ int pending_remote_name_cancel(struct btd_adapter *adapter)
 
 int adapter_resolve_names(struct btd_adapter *adapter)
 {
-	remote_name_req_cp cp;
 	struct remote_dev_info *dev, match;
-	int dd, err;
+	int err;
 
 	memset(&match, 0, sizeof(struct remote_dev_info));
 	bacpy(&match.bdaddr, BDADDR_ANY);
@@ -272,21 +271,12 @@ int adapter_resolve_names(struct btd_adapter *adapter)
 	if (!dev)
 		return -ENODATA;
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return -errno;
-
 	/* send at least one request or return failed if the list is empty */
 	do {
 		/* flag to indicate the current remote name requested */
 		dev->name_status = NAME_REQUESTED;
 
-		memset(&cp, 0, sizeof(cp));
-		bacpy(&cp.bdaddr, &dev->bdaddr);
-		cp.pscan_rep_mode = 0x02;
-
-		err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_REMOTE_NAME_REQ,
-						REMOTE_NAME_REQ_CP_SIZE, &cp);
+		err = adapter_ops->resolve_name(adapter->dev_id, &dev->bdaddr);
 
 		if (!err)
 			break;
@@ -302,11 +292,6 @@ int adapter_resolve_names(struct btd_adapter *adapter)
 		dev = adapter_search_found_devices(adapter, &match);
 	} while (dev);
 
-	hci_close_dev(dd);
-
-	if (err < 0)
-		err = errno;
-
 	return err;
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index fca34eb..e087bb0 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -164,6 +164,7 @@ struct btd_adapter_ops {
 						gboolean limited);
 	int (*start_discovery) (int index, gboolean periodic);
 	int (*stop_discovery) (int index);
+	int (*resolve_name) (int index, bdaddr_t *bdaddr);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3

