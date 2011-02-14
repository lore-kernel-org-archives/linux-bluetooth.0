Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix parsing of "Flags" AD type
Date: Mon, 14 Feb 2011 14:36:49 -0300
Message-Id: <1297705009-12848-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If an advertising report did not contain a "Flags" AD Type (e.g. a Scan
response), the previous flags value was mistakenly set to 0x00. This fix
makes sure dev->flags is only updated for valid values.
---
 src/adapter.c |    5 +++--
 src/adapter.h |    2 +-
 src/event.c   |    4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3e609c1..5366285 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3028,7 +3028,7 @@ static void dev_prepend_uuid(gpointer data, gpointer user_data)
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 					bdaddr_t bdaddr, int8_t rssi,
 					uint8_t evt_type, const char *name,
-					GSList *services, uint8_t flags)
+					GSList *services, int flags)
 {
 	struct remote_dev_info *dev;
 	gboolean new_dev;
@@ -3049,7 +3049,8 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 	g_slist_foreach(services, remove_same_uuid, dev);
 	g_slist_foreach(services, dev_prepend_uuid, dev);
 
-	dev->flags = flags;
+	if (flags >= 0)
+		dev->flags = flags;
 
 	if (name) {
 		g_free(dev->name);
diff --git a/src/adapter.h b/src/adapter.h
index 1edc441..39dd905 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -135,7 +135,7 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 					bdaddr_t bdaddr, int8_t rssi,
 					uint8_t evt_type, const char *name,
-					GSList *services, uint8_t flags);
+					GSList *services, int flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index 0659fd1..6f345d4 100644
--- a/src/event.c
+++ b/src/event.c
@@ -60,7 +60,7 @@
 
 struct eir_data {
 	GSList *services;
-	uint8_t flags;
+	int flags;
 	char *name;
 	gboolean name_complete;
 };
@@ -289,6 +289,8 @@ static int parse_eir_data(struct eir_data *eir, uint8_t *eir_data,
 	char *uuid_str;
 	unsigned int i;
 
+	eir->flags = -1;
+
 	/* No EIR data to parse */
 	if (eir_data == NULL || eir_length == 0)
 		return 0;
-- 
1.7.0.4

