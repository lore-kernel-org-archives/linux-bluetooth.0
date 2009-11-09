Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 4/5] Add adapter_update_remote_version to adapter.c
Date: Mon,  9 Nov 2009 15:30:56 +0530
Message-Id: <1257760857-27848-4-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1257760857-27848-3-git-send-email-alok.barsode@azingo.com>
References: <1257760857-27848-1-git-send-email-alok.barsode@azingo.com>
 <1257760857-27848-2-git-send-email-alok.barsode@azingo.com>
 <1257760857-27848-3-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |   28 ++++++++++++++++++++++++++++
 src/adapter.h  |    1 +
 src/security.c |   17 +----------------
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5f8eadb..5171e97 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2983,6 +2983,34 @@ proceed:
 	adapter_set_state(adapter, state);
 }
 
+void adapter_update_remote_version(bdaddr_t *local, void *ptr)
+{
+	evt_read_remote_version_complete *evt = ptr;
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
+	write_version_info(&adapter->bdaddr, &peer, btohs(evt->manufacturer),
+				evt->lmp_ver, btohs(evt->lmp_subver));
+}
+
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
 	GSList *adapters;
diff --git a/src/adapter.h b/src/adapter.h
index 853bb37..421b19e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -121,6 +121,7 @@ void adapter_handle_start_inquiry(bdaddr_t *local, uint8_t status, gboolean peri
 void adapter_handle_inquiry_complete(bdaddr_t *local, uint8_t status,
 							gboolean periodic);
 void adapter_update_remote_name(bdaddr_t *local, void *ptr);
+void adapter_update_remote_version(bdaddr_t *local, void *ptr);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
diff --git a/src/security.c b/src/security.c
index e92c8f2..1608b1b 100644
--- a/src/security.c
+++ b/src/security.c
@@ -599,21 +599,6 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 	};
 }
 
-static inline void remote_version_information(int dev, bdaddr_t *sba, void *ptr)
-{
-	evt_read_remote_version_complete *evt = ptr;
-	bdaddr_t dba;
-
-	if (evt->status)
-		return;
-
-	if (get_bdaddr(dev, sba, btohs(evt->handle), &dba) < 0)
-		return;
-
-	write_version_info(sba, &dba, btohs(evt->manufacturer),
-				evt->lmp_ver, btohs(evt->lmp_subver));
-}
-
 static inline void inquiry_result(int dev, bdaddr_t *sba, int plen, void *ptr)
 {
 	uint8_t num = *(uint8_t *) ptr++;
@@ -865,7 +850,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 		break;
 
 	case EVT_READ_REMOTE_VERSION_COMPLETE:
-		remote_version_information(dev, &di->bdaddr, ptr);
+		adapter_update_remote_version(&di->bdaddr, ptr);
 		break;
 
 	case EVT_READ_REMOTE_FEATURES_COMPLETE:
-- 
1.5.6.3

