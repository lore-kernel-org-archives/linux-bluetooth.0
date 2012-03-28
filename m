Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH V4 2/7] Set DeviceID when registering adapter not when sdp server is starting
Date: Wed, 28 Mar 2012 12:03:14 +0200
Message-ID: <1332928999-14224-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1332928999-14224-1-git-send-email-szymon.janc@tieto.com>
References: <1332928999-14224-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter ops are registered after sdp server is started. Thus no
adapters were registered yet when setting DID on sdp startup and DID
was never set.
---
 src/manager.c      |   15 ++++-----------
 src/manager.h      |    1 -
 src/sdpd-service.c |    3 ---
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 8c49457..3afc581 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -413,6 +413,10 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 	if (default_adapter_id < 0)
 		manager_set_default_adapter(id);
 
+	if (main_opts.did_source)
+		btd_adapter_set_did(adapter, main_opts.did_vendor,
+				main_opts.did_product, main_opts.did_version);
+
 	DBG("Adapter %s registered", path);
 
 	return btd_adapter_ref(adapter);
@@ -435,14 +439,3 @@ int btd_manager_unregister_adapter(int id)
 
 	return 0;
 }
-
-void btd_manager_set_did(uint16_t vendor, uint16_t product, uint16_t version)
-{
-	GSList *l;
-
-	for (l = adapters; l != NULL; l = g_slist_next(l)) {
-		struct btd_adapter *adapter = l->data;
-
-		btd_adapter_set_did(adapter, vendor, product, version);
-	}
-}
diff --git a/src/manager.h b/src/manager.h
index 0056909..264cd25 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -41,4 +41,3 @@ GSList *manager_get_adapters(void);
 struct btd_adapter *btd_manager_register_adapter(int id, gboolean up);
 int btd_manager_unregister_adapter(int id);
 void manager_add_adapter(const char *path);
-void btd_manager_set_did(uint16_t vendor, uint16_t product, uint16_t version);
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index eb4b74c..ef00760 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -187,9 +187,6 @@ void register_device_id(void)
 	info("Adding device id record for %04x:%04x:%04x", main_opts.did_vendor,
 				main_opts.did_product, main_opts.did_version);
 
-	btd_manager_set_did(main_opts.did_vendor, main_opts.did_product,
-							main_opts.did_version);
-
 	record->handle = sdp_next_handle();
 
 	sdp_record_add(BDADDR_ANY, record);
-- 
on behalf of ST-Ericsson

