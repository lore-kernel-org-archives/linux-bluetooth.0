Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/1] Adding start_discovery functionality to hciops plugin.
Date: Fri, 29 May 2009 18:14:40 +0530
Message-Id: <1243601080-27314-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   40 +++++++++++++++++++
 src/adapter.c    |  115 ++++++------------------------------------------------
 src/adapter.h    |    2 +
 3 files changed, 54 insertions(+), 103 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 8f9ee06..898b77b 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -561,6 +561,45 @@ done:
 	return err;
 }
 
+static int hciops_start_discovery(int index, gboolean periodic)
+{
+	inquiry_cp inq_cp;
+	periodic_inquiry_cp cp;
+	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if (periodic) {
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
@@ -570,6 +609,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_connectable = hciops_connectable,
 	.set_discoverable = hciops_discoverable,
 	.set_limited_discoverable = hciops_set_limited_discoverable,
+	.start_discovery = hciops_start_discovery,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 25ec33a..3db5ba6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -945,106 +945,16 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
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
-
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
+	gboolean periodic = TRUE;
 
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
@@ -1067,12 +977,11 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	if (adapter->disc_sessions)
 		goto done;
 
-	if (main_opts.discov_interval)
-		err = start_inquiry(adapter);
-	else
-		err = start_periodic_inquiry(adapter);
+	if (main_opts.name_resolv)
+		adapter->state |= RESOLVE_NAME;
 
-	if (err < 0)
+	err = adapter_start_inquiry(adapter);
+ 	if (err < 0)
 		return failed_strerror(msg, -err);
 
 done:
@@ -2441,8 +2350,8 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 	else if (adapter->disc_sessions && main_opts.discov_interval)
 		adapter->scheduler_id = g_timeout_add_seconds(
 						main_opts.discov_interval,
-						(GSourceFunc) start_inquiry,
-						adapter);
+						(GSourceFunc) adapter_start_inquiry,
+						(gpointer) adapter);
 
 	/* Send out of range */
 	if (!discov_active)
diff --git a/src/adapter.h b/src/adapter.h
index a94edc6..42ee0e1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -157,6 +157,8 @@ struct btd_adapter_ops {
 	int (*set_discoverable) (int index);
 	int (*set_limited_discoverable) (int index, const uint8_t *cls,
 						gboolean limited);
+	int (*start_discovery) (int index, gboolean periodic);
+	int (*stop_discovery) (int index, gboolean periodic);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3

