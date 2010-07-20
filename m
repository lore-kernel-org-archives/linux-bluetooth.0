Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 3/5] Update EIR whenever record is added or removed
Date: Tue, 20 Jul 2010 14:56:12 -0700
Message-Id: <1279662974-16454-4-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1279662974-16454-1-git-send-email-ingas@codeaurora.org>
References: <1279662974-16454-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/service.c |   18 ++++++++++++++++++
 src/adapter.c     |   23 ++++++++++++++++++++++-
 src/adapter.h     |    1 +
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index 96280bd..ee9176b 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -445,6 +445,8 @@ static DBusMessage *update_record(DBusConnection *conn, DBusMessage *msg,
 				strerror(EIO));
 	}
 
+	adapter_update_eir_data(&src);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -516,6 +518,7 @@ static DBusMessage *add_service_record(DBusConnection *conn,
 	const char *sender, *record;
 	dbus_uint32_t handle;
 	int err;
+	bdaddr_t bdaddr;
 
 	if (dbus_message_get_args(msg, NULL,
 			DBUS_TYPE_STRING, &record, DBUS_TYPE_INVALID) == FALSE)
@@ -526,6 +529,13 @@ static DBusMessage *add_service_record(DBusConnection *conn,
 	if (err < 0)
 		return failed_strerror(msg, err);
 
+	if (serv_adapter->adapter)
+		adapter_get_address(serv_adapter->adapter, &bdaddr);
+	else
+		bacpy(&bdaddr, BDADDR_ANY);
+
+	adapter_update_eir_data(&bdaddr);
+
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -550,6 +560,7 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 	struct service_adapter *serv_adapter = data;
 	dbus_uint32_t handle;
 	const char *sender;
+	bdaddr_t bdaddr;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &handle,
 						DBUS_TYPE_INVALID) == FALSE)
@@ -560,6 +571,13 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 	if (remove_record(conn, sender, serv_adapter, handle) < 0)
 		return not_available(msg);
 
+	if (serv_adapter->adapter)
+		adapter_get_address(serv_adapter->adapter, &bdaddr);
+	else
+		bacpy(&bdaddr, BDADDR_ANY);
+
+	adapter_update_eir_data(&bdaddr);
+
 	return dbus_message_new_method_return(msg);
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 789a196..c1e1768 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -820,7 +820,7 @@ static DBusMessage *set_pairable_timeout(DBusConnection *conn,
 
 static void update_ext_inquiry_response(struct btd_adapter *adapter)
 {
-	uint8_t fec = 0, data[240];
+	uint8_t fec = 0, data[EIR_DATA_LENGTH];
 	struct hci_dev *dev = &adapter->dev;
 	int dd;
 
@@ -846,6 +846,27 @@ static void update_ext_inquiry_response(struct btd_adapter *adapter)
 	hci_close_dev(dd);
 }
 
+void adapter_update_eir_data(const bdaddr_t *src)
+{
+	struct btd_adapter *adapter;
+	GSList *adapters;
+
+	if (bacmp(src, BDADDR_ANY) != 0) {
+		adapter = manager_find_adapter(src);
+		if (adapter)
+			update_ext_inquiry_response(adapter);
+		else
+			error("Updating EIR failed: device not found");
+	} else {
+
+		/* Update extended inquiry reponse for ANY adapter */
+		for (adapters = manager_get_adapters(); adapters; adapters = adapters->next) {
+			adapter = adapters->data;
+			update_ext_inquiry_response(adapter);
+		}
+	}
+}
+
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status)
 {
 	uint8_t class[3];
diff --git a/src/adapter.h b/src/adapter.h
index 8226514..f72eb0b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -126,6 +126,7 @@ void adapter_service_insert(const bdaddr_t *bdaddr, void *rec);
 void adapter_service_remove(const bdaddr_t *bdaddr, void *rec);
 sdp_list_t *adapter_get_services(struct btd_adapter *adapter);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
+void adapter_update_eir_data(const bdaddr_t *src);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
-- 
1.7.1

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
