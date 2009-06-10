Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/2] Adding start_discovery to hciops plugin.
Date: Wed, 10 Jun 2009 17:50:41 +0530
Message-Id: <1244636441-22878-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   42 +++++++++++++++++
 src/adapter.c    |  133 +++++++++---------------------------------------------
 src/adapter.h    |    3 +-
 src/dbus-hci.c   |    5 ++-
 4 files changed, 69 insertions(+), 114 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 8f9ee06..d337b75 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -561,6 +561,47 @@ done:
 	return err;
 }
 
+static int hciops_start_discovery(int index, gboolean periodic)
+{
+	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if (periodic) {
+		periodic_inquiry_cp cp;
+
+		memset(&cp, 0, sizeof(cp));
+		memcpy(&cp.lap, lap, 3);
+		cp.max_period = htobs(24);
+		cp.min_period = htobs(16);
+		cp.length  = 0x08;
+		cp.num_rsp = 0x00;
+
+		err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,
+					PERIODIC_INQUIRY_CP_SIZE, &cp);
+	} else {
+		inquiry_cp inq_cp;
+
+		memset(&inq_cp, 0, sizeof(inq_cp));
+		memcpy(&inq_cp.lap, lap, 3);
+		inq_cp.length = 0x08;
+		inq_cp.num_rsp = 0x00;
+
+		err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_INQUIRY,
+					INQUIRY_CP_SIZE, &inq_cp);
+	}
+
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
@@ -570,6 +611,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_connectable = hciops_connectable,
 	.set_discoverable = hciops_discoverable,
 	.set_limited_discoverable = hciops_set_limited_discoverable,
+	.start_discovery = hciops_start_discovery,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index a45765d..98c80da 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -214,6 +214,16 @@ static void dev_info_free(struct remote_dev_info *dev)
 	g_free(dev);
 }
 
+void clear_found_devices_list(struct btd_adapter *adapter)
+{
+	if (!adapter->found_devices)
+		return;
+
+	g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free, NULL);
+	g_slist_free(adapter->found_devices);
+	adapter->found_devices = NULL;
+}
+
 int pending_remote_name_cancel(struct btd_adapter *adapter)
 {
 	struct remote_dev_info *dev, match;
@@ -243,11 +253,6 @@ int pending_remote_name_cancel(struct btd_adapter *adapter)
 						strerror(errno), errno);
 	}
 
-	/* free discovered devices list */
-	g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free, NULL);
-	g_slist_free(adapter->found_devices);
-	adapter->found_devices = NULL;
-
 	hci_close_dev(dd);
 
 	return err;
@@ -946,106 +951,16 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 	return adapter_create_device(conn, adapter, address);
 }
 
-static int start_inquiry(struct btd_adapter *adapter)
+static int adapter_start_inquiry(struct btd_adapter *adapter)
 {
-	inquiry_cp cp;
-	evt_cmd_status rp;
-	struct hci_request rq;
-	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
-	int dd, err;
-
-	pending_remote_name_cancel(adapter);
-
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return dd;
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.length = 0x08;
-	cp.num_rsp = 0x00;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf = OGF_LINK_CTL;
-	rq.ocf = OCF_INQUIRY;
-	rq.cparam = &cp;
-	rq.clen = INQUIRY_CP_SIZE;
-	rq.rparam = &rp;
-	rq.rlen = EVT_CMD_STATUS_SIZE;
-	rq.event = EVT_CMD_STATUS;
-
-	if (hci_send_req(dd, &rq, HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
-		error("Unable to start inquiry: %s (%d)",
-						strerror(errno), errno);
-		hci_close_dev(dd);
-		return err;
-	}
-
-	if (rp.status) {
-		error("HCI_Inquiry command failed with status 0x%02x",
-			rp.status);
-		hci_close_dev(dd);
-		return -bt_error(rp.status);
-	}
-
-	hci_close_dev(dd);
-
-	if (main_opts.name_resolv)
-		adapter->state |= RESOLVE_NAME;
+	gboolean periodic = TRUE;
 
-	return 0;
-}
-
-static int start_periodic_inquiry(struct btd_adapter *adapter)
-{
-	periodic_inquiry_cp cp;
-	struct hci_request rq;
-	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
-	uint8_t status;
-	int dd, err;
-
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return dd;
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.max_period = htobs(24);
-	cp.min_period = htobs(16);
-	cp.length  = 0x08;
-	cp.num_rsp = 0x00;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_PERIODIC_INQUIRY;
-	rq.cparam = &cp;
-	rq.clen   = PERIODIC_INQUIRY_CP_SIZE;
-	rq.rparam = &status;
-	rq.rlen   = sizeof(status);
-	rq.event  = EVT_CMD_COMPLETE;
-
-	if (hci_send_req(dd, &rq, HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
-		error("Unable to start periodic inquiry: %s (%d)",
-						strerror(errno), errno);
-		hci_close_dev(dd);
-		return err;
-	}
-
-	if (status) {
-		error("HCI_Periodic_Inquiry_Mode failed with status 0x%02x",
-				status);
-		hci_close_dev(dd);
-		return -bt_error(status);
-	}
-
-	hci_close_dev(dd);
+	if (main_opts.discov_interval)
+		periodic = FALSE;
 
-	if (main_opts.name_resolv)
-		adapter->state |= RESOLVE_NAME;
+	pending_remote_name_cancel(adapter);
 
-	return 0;
+	return adapter_ops->start_discovery(adapter->dev_id, periodic);
 }
 
 static DBusMessage *adapter_start_discovery(DBusConnection *conn,
@@ -1068,11 +983,10 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	if (adapter->disc_sessions)
 		goto done;
 
-	if (main_opts.discov_interval)
-		err = start_inquiry(adapter);
-	else
-		err = start_periodic_inquiry(adapter);
+	if (main_opts.name_resolv)
+		adapter->state |= RESOLVE_NAME;
 
+	err = adapter_start_inquiry(adapter);
 	if (err < 0)
 		return failed_strerror(msg, -err);
 
@@ -2215,12 +2129,7 @@ int adapter_stop(struct btd_adapter *adapter)
 		adapter->disc_sessions = NULL;
 	}
 
-	if (adapter->found_devices) {
-		g_slist_foreach(adapter->found_devices,
-				(GFunc) dev_info_free, NULL);
-		g_slist_free(adapter->found_devices);
-		adapter->found_devices = NULL;
-	}
+	clear_found_devices_list(adapter);
 
 	if (adapter->oor_devices) {
 		g_slist_foreach(adapter->oor_devices, (GFunc) free, NULL);
@@ -2468,7 +2377,7 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 	else if (adapter->disc_sessions && main_opts.discov_interval)
 		adapter->scheduler_id = g_timeout_add_seconds(
 						main_opts.discov_interval,
-						(GSourceFunc) start_inquiry,
+						(GSourceFunc) adapter_start_inquiry,
 						adapter);
 
 	/* Send out of range */
diff --git a/src/adapter.h b/src/adapter.h
index 31eaea6..5fb4741 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -95,7 +95,7 @@ struct btd_device *adapter_create_device(DBusConnection *conn,
 
 int pending_remote_name_cancel(struct btd_adapter *adapter);
 
-void remove_pending_device(struct btd_adapter *adapter);
+void clear_found_devices_list(struct btd_adapter *adapter);
 
 struct btd_adapter *adapter_create(DBusConnection *conn, int id,
 				gboolean devup);
@@ -160,6 +160,7 @@ struct btd_adapter_ops {
 	int (*set_discoverable) (int index);
 	int (*set_limited_discoverable) (int index, const uint8_t *cls,
 						gboolean limited);
+	int (*start_discovery) (int index, gboolean periodic);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 37143cf..089fd2e 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -452,9 +452,12 @@ void hcid_dbus_inquiry_start(bdaddr_t *local)
 	 * Cancel pending remote name request and clean the device list
 	 * when inquiry is supported in periodic inquiry idle state.
 	 */
-	if (adapter_get_state(adapter) & PERIODIC_INQUIRY)
+	if (adapter_get_state(adapter) & PERIODIC_INQUIRY) {
 		pending_remote_name_cancel(adapter);
 
+		clear_found_devices_list(adapter);
+	}
+
 	/* Disable name resolution for non D-Bus clients */
 	if (!adapter_has_discov_sessions(adapter)) {
 		state = adapter_get_state(adapter);
-- 
1.5.6.3

