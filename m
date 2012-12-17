Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/13] adapter: Add btd_adapter_for_each_device()
Date: Mon, 17 Dec 2012 16:09:42 +0100
Message-Id: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    7 +++++++
 src/adapter.h |    4 ++++
 2 files changed, 11 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 96a23e9..1279145 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3635,3 +3635,10 @@ void adapter_read_local_oob_data_complete(struct btd_adapter *adapter,
 	g_free(adapter->oob_handler);
 	adapter->oob_handler = NULL;
 }
+
+void btd_adapter_for_each_device(struct btd_adapter *adapter,
+			void (*cb)(struct btd_device *device, void *data),
+			void *data)
+{
+	g_slist_foreach(adapter->devices, (GFunc) cb, data);
+}
diff --git a/src/adapter.h b/src/adapter.h
index bde76b2..a192a71 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -231,3 +231,7 @@ void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
 gboolean btd_adapter_check_oob_handler(struct btd_adapter *adapter);
 void adapter_store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
 							const char *name);
+
+void btd_adapter_for_each_device(struct btd_adapter *adapter,
+			void (*cb)(struct btd_device *device, void *data),
+			void *data);
-- 
1.7.9.5

