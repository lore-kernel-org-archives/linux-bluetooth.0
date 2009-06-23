Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/3] Renaming found_device_req_name to adapter_resolve_names
Date: Tue, 23 Jun 2009 20:20:19 +0530
Message-Id: <1245768621-22895-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |   52 ++++++++++++++++++++++++++++++++++++++++
 src/adapter.h  |    2 +
 src/dbus-hci.c |   72 +------------------------------------------------------
 3 files changed, 56 insertions(+), 70 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8d277ba..9a913ac 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -258,6 +258,58 @@ int pending_remote_name_cancel(struct btd_adapter *adapter)
 	return err;
 }
 
+int adapter_resolve_names(struct btd_adapter *adapter)
+{
+	remote_name_req_cp cp;
+	struct remote_dev_info *dev, match;
+	int dd, err;
+
+	memset(&match, 0, sizeof(struct remote_dev_info));
+	bacpy(&match.bdaddr, BDADDR_ANY);
+	match.name_status = NAME_REQUIRED;
+
+	dev = adapter_search_found_devices(adapter, &match);
+	if (!dev)
+		return -ENODATA;
+
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0)
+		return -errno;
+
+	/* send at least one request or return failed if the list is empty */
+	do {
+		/* flag to indicate the current remote name requested */
+		dev->name_status = NAME_REQUESTED;
+
+		memset(&cp, 0, sizeof(cp));
+		bacpy(&cp.bdaddr, &dev->bdaddr);
+		cp.pscan_rep_mode = 0x02;
+
+		err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_REMOTE_NAME_REQ,
+						REMOTE_NAME_REQ_CP_SIZE, &cp);
+
+		if (!err)
+			break;
+
+		error("Unable to send HCI remote name req: %s (%d)",
+						strerror(errno), errno);
+
+		/* if failed, request the next element */
+		/* remove the element from the list */
+		adapter_remove_found_device(adapter, &dev->bdaddr);
+
+		/* get the next element */
+		dev = adapter_search_found_devices(adapter, &match);
+	} while (dev);
+
+	hci_close_dev(dd);
+
+	if (err < 0)
+		err = errno;
+
+	return err;
+}
+
 static const char *mode2str(uint8_t mode)
 {
 	switch(mode) {
diff --git a/src/adapter.h b/src/adapter.h
index 2356743..fca34eb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -95,6 +95,8 @@ struct btd_device *adapter_create_device(DBusConnection *conn,
 
 int pending_remote_name_cancel(struct btd_adapter *adapter);
 
+int adapter_resolve_names(struct btd_adapter *adapter);
+
 void clear_found_devices_list(struct btd_adapter *adapter);
 
 struct btd_adapter *adapter_create(DBusConnection *conn, int id,
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 8718465..ca391c5 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -466,74 +466,6 @@ void hcid_dbus_inquiry_start(bdaddr_t *local)
 	}
 }
 
-static int found_device_req_name(struct btd_adapter *adapter)
-{
-	struct hci_request rq;
-	evt_cmd_status rp;
-	remote_name_req_cp cp;
-	struct remote_dev_info *dev, match;
-	int dd, req_sent = 0;
-	uint16_t dev_id = adapter_get_dev_id(adapter);
-
-	memset(&match, 0, sizeof(struct remote_dev_info));
-	bacpy(&match.bdaddr, BDADDR_ANY);
-	match.name_status = NAME_REQUIRED;
-
-	dev = adapter_search_found_devices(adapter, &match);
-	if (!dev)
-		return -ENODATA;
-
-	dd = hci_open_dev(dev_id);
-	if (dd < 0)
-		return -errno;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_REMOTE_NAME_REQ;
-	rq.cparam = &cp;
-	rq.clen   = REMOTE_NAME_REQ_CP_SIZE;
-	rq.rparam = &rp;
-	rq.rlen   = EVT_CMD_STATUS_SIZE;
-	rq.event  = EVT_CMD_STATUS;
-
-	/* send at least one request or return failed if the list is empty */
-	do {
-		/* flag to indicate the current remote name requested */
-		dev->name_status = NAME_REQUESTED;
-
-		memset(&rp, 0, sizeof(rp));
-		memset(&cp, 0, sizeof(cp));
-		bacpy(&cp.bdaddr, &dev->bdaddr);
-		cp.pscan_rep_mode = 0x02;
-
-		if (hci_send_req(dd, &rq, HCI_REQ_TIMEOUT) < 0)
-			error("Unable to send HCI remote name req: %s (%d)",
-						strerror(errno), errno);
-
-		if (!rp.status) {
-			req_sent = 1;
-			break;
-		}
-
-		error("Remote name request failed with status 0x%02x",
-								rp.status);
-
-		/* if failed, request the next element */
-		/* remove the element from the list */
-		adapter_remove_found_device(adapter, &dev->bdaddr);
-
-		/* get the next element */
-		dev = adapter_search_found_devices(adapter, &match);
-	} while (dev);
-
-	hci_close_dev(dd);
-
-	if (!req_sent)
-		return -ENODATA;
-
-	return 0;
-}
-
 void hcid_dbus_inquiry_complete(bdaddr_t *local)
 {
 	struct btd_adapter *adapter;
@@ -556,7 +488,7 @@ void hcid_dbus_inquiry_complete(bdaddr_t *local)
 	 *
 	 * Keep in mind that non D-Bus requests can arrive.
 	 */
-	if (found_device_req_name(adapter) == 0)
+	if (adapter_resolve_names(adapter) == 0)
 		return;
 
 	state = adapter_get_state(adapter);
@@ -791,7 +723,7 @@ proceed:
 	adapter_remove_found_device(adapter, peer);
 
 	/* check if there is more devices to request names */
-	if (found_device_req_name(adapter) == 0)
+	if (adapter_resolve_names(adapter) == 0)
 		return;
 
 	state = adapter_get_state(adapter);
-- 
1.5.6.3

