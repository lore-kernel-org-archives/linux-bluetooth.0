Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 7/9] Fix primary services registration from storage for basic rate
Date: Thu,  7 Apr 2011 14:30:12 -0300
Message-Id: <1302197414-833-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    5 ++++-
 src/device.c  |    4 ++--
 src/device.h  |    2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9a0f688..7049ba6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2004,7 +2004,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 						void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	GSList *uuids = bt_string2list(value);
+	GSList *list, *uuids = bt_string2list(value);
 	struct btd_device *device;
 
 	if (g_slist_find_custom(adapter->devices,
@@ -2019,6 +2019,9 @@ static void create_stored_device_from_profiles(char *key, char *value,
 	adapter->devices = g_slist_append(adapter->devices, device);
 
 	device_probe_drivers(device, uuids);
+	list = device_services_from_record(device, uuids);
+	if (list)
+		device_register_services(connection, device, list, 31);
 
 	g_slist_foreach(uuids, (GFunc) g_free, NULL);
 	g_slist_free(uuids);
diff --git a/src/device.c b/src/device.c
index eecaee0..4da6579 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1441,7 +1441,7 @@ static gboolean parse_primary_record(const sdp_record_t *rec,
 	return ret;
 }
 
-static GSList *primary_from_record(struct btd_device *device, GSList *profiles)
+GSList *device_services_from_record(struct btd_device *device, GSList *profiles)
 {
 	GSList *l, *prim_list = NULL;
 	char *att_uuid;
@@ -1514,7 +1514,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 		device_probe_drivers(device, req->profiles_added);
 
-		list = primary_from_record(device, req->profiles_added);
+		list = device_services_from_record(device, req->profiles_added);
 		if (list)
 			device_register_services(req->conn, device, list, 31);
 	}
diff --git a/src/device.h b/src/device.h
index 2432884..370382d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -58,6 +58,8 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
 GSList *btd_device_get_primaries(struct btd_device *device);
 void device_register_services(DBusConnection *conn, struct btd_device *device,
 						GSList *prim_list, int psm);
+GSList *device_services_from_record(struct btd_device *device,
+							GSList *profiles);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr);
-- 
1.7.4.1

