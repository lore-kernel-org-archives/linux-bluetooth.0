Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 5/5] Add adapter_update_remote_features to adapter.c
Date: Mon,  9 Nov 2009 15:30:57 +0530
Message-Id: <1257760857-27848-5-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1257760857-27848-4-git-send-email-alok.barsode@azingo.com>
References: <1257760857-27848-1-git-send-email-alok.barsode@azingo.com>
 <1257760857-27848-2-git-send-email-alok.barsode@azingo.com>
 <1257760857-27848-3-git-send-email-alok.barsode@azingo.com>
 <1257760857-27848-4-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |   27 +++++++++++++++++++++++++++
 src/adapter.h  |    1 +
 src/security.c |   16 +---------------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5171e97..4c649de 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3011,6 +3011,33 @@ void adapter_update_remote_version(bdaddr_t *local, void *ptr)
 				evt->lmp_ver, btohs(evt->lmp_subver));
 }
 
+void adapter_update_remote_features(bdaddr_t *local, void *ptr)
+{
+	evt_read_remote_features_complete *evt = ptr;
+	bdaddr_t peer;
+	struct btd_device *device;
+	struct btd_adapter *adapter;
+
+	if (evt->status)
+		return;
+
+	adapter = manager_find_adapter(local);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
+	device = adapter_find_connection(adapter, btohs(evt->handle));
+	if (!device) {
+		error("Unable to find matching device");
+		return;
+	}
+
+	device_get_address(device, &peer);
+
+	write_features_info(&adapter->bdaddr, &peer, evt->features);
+}
+
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
 	GSList *adapters;
diff --git a/src/adapter.h b/src/adapter.h
index 421b19e..63b505b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -122,6 +122,7 @@ void adapter_handle_inquiry_complete(bdaddr_t *local, uint8_t status,
 							gboolean periodic);
 void adapter_update_remote_name(bdaddr_t *local, void *ptr);
 void adapter_update_remote_version(bdaddr_t *local, void *ptr);
+void adapter_update_remote_features(bdaddr_t *local, void *ptr);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
diff --git a/src/security.c b/src/security.c
index 1608b1b..24bf8e6 100644
--- a/src/security.c
+++ b/src/security.c
@@ -677,20 +677,6 @@ static inline void extended_inquiry_result(int dev, bdaddr_t *sba, int plen, voi
 	}
 }
 
-static inline void remote_features_information(int dev, bdaddr_t *sba, void *ptr)
-{
-	evt_read_remote_features_complete *evt = ptr;
-	bdaddr_t dba;
-
-	if (evt->status)
-		return;
-
-	if (get_bdaddr(dev, sba, btohs(evt->handle), &dba) < 0)
-		return;
-
-	write_features_info(sba, &dba, evt->features);
-}
-
 static inline void conn_complete(int dev, int dev_id, bdaddr_t *sba, void *ptr)
 {
 	evt_conn_complete *evt = ptr;
@@ -854,7 +840,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 		break;
 
 	case EVT_READ_REMOTE_FEATURES_COMPLETE:
-		remote_features_information(dev, &di->bdaddr, ptr);
+		adapter_update_remote_features(&di->bdaddr, ptr);
 		break;
 
 	case EVT_REMOTE_HOST_FEATURES_NOTIFY:
-- 
1.5.6.3

