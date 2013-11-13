Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/3] core/device: Only connect profiles which are enabled
Date: Wed, 13 Nov 2013 10:53:31 +0200
Message-Id: <1384332813-7891-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384332813-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1384332813-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some profile may register their records dynamically e.g. A2DP so the code
has to check if the profile is really available before attempting to
connect.
---
 src/device.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9ca457e..60efd62 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1224,11 +1224,25 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 						DEVICE_INTERFACE, "UUIDs");
 }
 
+static int uuid_cmp(const void *a, const void *b)
+{
+	const sdp_record_t *rec = a;
+	const char *string = b;
+	uuid_t uuid;
+
+	if (bt_string2uuid(&uuid, string) < 0)
+		return -1;
+
+	return sdp_uuid_cmp(&rec->svclass, &uuid);
+}
+
 static struct btd_service *find_connectable_service(struct btd_device *dev,
 							const char *uuid)
 {
 	GSList *l;
+	sdp_list_t *uuids;
 
+	uuids = btd_adapter_get_services(dev->adapter);
 	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
 		struct btd_service *service = l->data;
 		struct btd_profile *p = btd_service_get_profile(service);
@@ -1236,7 +1250,12 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 		if (!p->connect || !p->remote_uuid)
 			continue;
 
-		if (strcasecmp(uuid, p->remote_uuid) == 0)
+		if (strcasecmp(uuid, p->remote_uuid))
+			continue;
+
+		/* Check if adapter has the local_uuid enabled */
+		if (!p->local_uuid || sdp_list_find(uuids,
+					(void *) p->local_uuid, uuid_cmp))
 			return service;
 	}
 
@@ -1256,6 +1275,7 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 	struct btd_service *service;
 	struct btd_profile *p;
 	GSList *l;
+	sdp_list_t *uuids;
 
 	if (uuid) {
 		service = find_connectable_service(dev, uuid);
@@ -1265,6 +1285,7 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 		return dev->pending;
 	}
 
+	uuids = btd_adapter_get_services(dev->adapter);
 	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
 		service = l->data;
 		p = btd_service_get_profile(service);
@@ -1272,14 +1293,18 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 		if (!p->auto_connect)
 			continue;
 
-		if (g_slist_find(dev->pending, service))
-			continue;
-
 		if (btd_service_get_state(service) !=
 						BTD_SERVICE_STATE_DISCONNECTED)
 			continue;
 
-		dev->pending = g_slist_insert_sorted(dev->pending, service,
+		if (g_slist_find(dev->pending, service))
+			continue;
+
+		/* Check if adapter has the local_uuid enabled */
+		if (!p->local_uuid || sdp_list_find(uuids,
+					(void *) p->local_uuid, uuid_cmp))
+			dev->pending = g_slist_insert_sorted(dev->pending,
+							service,
 							service_prio_cmp);
 	}
 
-- 
1.8.3.1

