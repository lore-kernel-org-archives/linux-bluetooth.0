Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Adding stop_discovery functionality to hciops plugin.
Date: Tue,  2 Jun 2009 16:46:19 +0530
Message-Id: <1243941379-32490-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   27 +++++++++
 src/adapter.c    |   51 +++++++----------
 src/adapter.h    |    1 +
 src/dbus-hci.c   |  157 ------------------------------------------------------
 src/dbus-hci.h   |    5 --
 5 files changed, 49 insertions(+), 192 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index d337b75..dae79b3 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -602,6 +602,32 @@ static int hciops_start_discovery(int index, gboolean periodic)
 	return err;
 }
 
+static int hciops_stop_discovery(int index)
+{
+	struct hci_dev_info di;
+	int dd, err = 0;
+
+	if (hci_devinfo(index, &di) < 0)
+		return -errno;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if (hci_test_bit(HCI_INQUIRY, &di.flags))
+		err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_INQUIRY_CANCEL,
+				0, 0);
+	else
+		err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY,
+				0, 0);
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
@@ -612,6 +638,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_discoverable = hciops_discoverable,
 	.set_limited_discoverable = hciops_set_limited_discoverable,
 	.start_discovery = hciops_start_discovery,
+	.stop_discovery = hciops_stop_discovery,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 8af3eb7..fbf642c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -250,7 +250,10 @@ int pending_remote_name_cancel(struct btd_adapter *adapter)
 
 	hci_close_dev(dd);
 
-	return err;
+	if (err < 0)
+		return err;
+
+	return 1;
 }
 
 static const char *mode2str(uint8_t mode)
@@ -546,20 +549,20 @@ static void session_remove(struct session_req *req)
 
 		debug("Stopping discovery");
 
-		g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free,
-				NULL);
-		g_slist_free(adapter->found_devices);
-		adapter->found_devices = NULL;
+		if (pending_remote_name_cancel(adapter) <= 0) {
+			g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free,
+					NULL);
+			g_slist_free(adapter->found_devices);
+			adapter->found_devices = NULL;
+		}
 
 		g_slist_free(adapter->oor_devices);
 		adapter->oor_devices = NULL;
 
-		if (adapter->state & STD_INQUIRY)
-			cancel_discovery(adapter);
-		else if (adapter->scheduler_id)
+		if (adapter->scheduler_id)
 			g_source_remove(adapter->scheduler_id);
-		else
-			cancel_periodic_discovery(adapter);
+
+		adapter_ops->stop_discovery(adapter->dev_id);
 	}
 }
 
@@ -2043,19 +2046,12 @@ setup:
 	hci_send_cmd(dd, OGF_LINK_POLICY, OCF_READ_DEFAULT_LINK_POLICY,
 								0, NULL);
 
-	if (hci_test_bit(HCI_INQUIRY, &di.flags)) {
-		debug("inquiry_cancel at adapter startup");
-		inquiry_cancel(dd, HCI_REQ_TIMEOUT);
-	} else if (!adapter->initialized && adapter->already_up) {
-		debug("periodic_inquiry_exit at adapter startup");
-		periodic_inquiry_exit(dd, HCI_REQ_TIMEOUT);
-	}
-
-	adapter->state &= ~STD_INQUIRY;
-
 	adapter_setup(adapter, dd);
 	hci_close_dev(dd);
 
+	if (!adapter->initialized && adapter->already_up)
+		adapter_ops->stop_discovery(adapter->dev_id);
+
 	err = adapter_up(adapter);
 
 	info("Adapter %s has been enabled", adapter->path);
@@ -2079,16 +2075,11 @@ static void reply_pending_requests(struct btd_adapter *adapter)
 						HCI_OE_USER_ENDED_CONNECTION);
 	}
 
-	if (adapter->state & STD_INQUIRY) {
-		/* Cancel inquiry initiated by D-Bus client */
-		if (adapter->disc_sessions)
-			cancel_discovery(adapter);
-	}
-
-	if (adapter->state & PERIODIC_INQUIRY) {
-		/* Stop periodic inquiry initiated by D-Bus client */
-		if (adapter->disc_sessions)
-			cancel_periodic_discovery(adapter);
+	if (adapter->state & STD_INQUIRY || adapter->state & PERIODIC_INQUIRY) {
+		if (adapter->disc_sessions){
+			pending_remote_name_cancel(adapter);
+			adapter_ops->stop_discovery(adapter->dev_id);
+		}
 	}
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 5c0df05..7300ce6 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -161,6 +161,7 @@ struct btd_adapter_ops {
 	int (*set_limited_discoverable) (int index, const uint8_t *cls,
 						gboolean limited);
 	int (*start_discovery) (int index, gboolean periodic);
+	int (*stop_discovery) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 37143cf..06155ad 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -1216,163 +1216,6 @@ int hcid_dbus_set_io_cap(bdaddr_t *local, bdaddr_t *remote,
 	return 0;
 }
 
-int inquiry_cancel(int dd, int to)
-{
-	struct hci_request rq;
-	uint8_t status;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_INQUIRY_CANCEL;
-	rq.rparam = &status;
-	rq.rlen   = sizeof(status);
-	rq.event = EVT_CMD_COMPLETE;
-
-	if (hci_send_req(dd, &rq, to) < 0)
-		return -1;
-
-	if (status) {
-		errno = bt_error(status);
-		return -1;
-	}
-
-	return 0;
-}
-
-static int remote_name_cancel(int dd, bdaddr_t *dba, int to)
-{
-	remote_name_req_cancel_cp cp;
-	struct hci_request rq;
-	uint8_t status;
-
-	memset(&rq, 0, sizeof(rq));
-	memset(&cp, 0, sizeof(cp));
-
-	bacpy(&cp.bdaddr, dba);
-
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_REMOTE_NAME_REQ_CANCEL;
-	rq.cparam = &cp;
-	rq.clen   = REMOTE_NAME_REQ_CANCEL_CP_SIZE;
-	rq.rparam = &status;
-	rq.rlen = sizeof(status);
-	rq.event = EVT_CMD_COMPLETE;
-
-	if (hci_send_req(dd, &rq, to) < 0)
-		return -1;
-
-	if (status) {
-		errno = bt_error(status);
-		return -1;
-	}
-
-	return 0;
-}
-
-int cancel_discovery(struct btd_adapter *adapter)
-{
-	struct remote_dev_info *dev, match;
-	int dd, err = 0;
-	uint16_t dev_id = adapter_get_dev_id(adapter);
-
-	dd = hci_open_dev(dev_id);
-	if (dd < 0)
-		return -ENODEV;
-
-	/*
-	 * If there is a pending read remote name request means
-	 * that the inquiry complete event was already received
-	 */
-	memset(&match, 0, sizeof(struct remote_dev_info));
-	bacpy(&match.bdaddr, BDADDR_ANY);
-	match.name_status = NAME_REQUESTED;
-
-	dev = adapter_search_found_devices(adapter, &match);
-	if (dev) {
-		if (remote_name_cancel(dd, &dev->bdaddr,
-							HCI_REQ_TIMEOUT) < 0) {
-			err = -errno;
-			error("Read remote name cancel failed: %s, (%d)",
-						strerror(errno), errno);
-		}
-	} else {
-		if (inquiry_cancel(dd, HCI_REQ_TIMEOUT) < 0) {
-			err = -errno;
-			error("Inquiry cancel failed:%s (%d)",
-						strerror(errno), errno);
-		}
-	}
-
-	hci_close_dev(dd);
-
-	return err;
-}
-
-int periodic_inquiry_exit(int dd, int to)
-{
-	struct hci_request rq;
-	uint8_t status;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_EXIT_PERIODIC_INQUIRY;
-	rq.rparam = &status;
-	rq.rlen   = sizeof(status);
-	rq.event = EVT_CMD_COMPLETE;
-
-	if (hci_send_req(dd, &rq, to) < 0)
-		return -1;
-
-	if (status) {
-		errno = status;
-		return -1;
-	}
-
-	return 0;
-}
-
-int cancel_periodic_discovery(struct btd_adapter *adapter)
-{
-	struct remote_dev_info *dev, match;
-	int dd, err = 0;
-	uint16_t dev_id = adapter_get_dev_id(adapter);
-
-	dd = hci_open_dev(dev_id);
-	if (dd < 0)
-		return -ENODEV;
-
-	/* find the pending remote name request */
-	memset(&match, 0, sizeof(struct remote_dev_info));
-	bacpy(&match.bdaddr, BDADDR_ANY);
-	match.name_status = NAME_REQUESTED;
-
-	dev = adapter_search_found_devices(adapter, &match);
-	if (dev) {
-		if (remote_name_cancel(dd, &dev->bdaddr,
-						HCI_REQ_TIMEOUT) < 0) {
-			err = -errno;
-			error("Read remote name cancel failed: %s, (%d)",
-						strerror(errno), errno);
-		}
-	}
-
-	/* ovewrite err if necessary: stop periodic inquiry has higher
-	 * priority */
-	if (periodic_inquiry_exit(dd, HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
-		error("Periodic Inquiry exit failed:%s (%d)",
-						strerror(errno), errno);
-	}
-
-	hci_close_dev(dd);
-
-	return err;
-}
-
-/* Most of the functions in this module require easy access to a connection so
- * we keep it global here and provide these access functions the other (few)
- * modules that require access to it */
-
 void set_dbus_connection(DBusConnection *conn)
 {
 	connection = conn;
diff --git a/src/dbus-hci.h b/src/dbus-hci.h
index 1cb10f3..d46ccf8 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -52,14 +52,9 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 
 DBusMessage *new_authentication_return(DBusMessage *msg, uint8_t status);
 
-int cancel_discovery(struct btd_adapter *adapter);
-int cancel_periodic_discovery(struct btd_adapter *adapter);
-
 int set_service_classes(int dd, const uint8_t *cls, uint8_t value);
 int set_major_and_minor_class(int dd, const uint8_t *cls,
 						uint8_t major, uint8_t minor);
-int inquiry_cancel(int dd, int to);
-int periodic_inquiry_exit(int dd, int to);
 
 const char *class_to_icon(uint32_t class);
 
-- 
1.5.6.3

