Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/15] profiles/network: Make get_service_id connections private method
Date: Wed,  4 Mar 2015 09:49:00 +0100
Message-Id: <1425458940-24646-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1425458940-24646-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425458940-24646-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

get_service_id method is used only within connection code to get id (16
bit value) of received string format 128bit uuid or service named e.g.
panu, gn or nap. There is no need to make it public as bnep.c only
related code.
---
 profiles/network/bnep.c       | 25 -------------------------
 profiles/network/bnep.h       |  1 -
 profiles/network/connection.c | 20 ++++++++++++++------
 3 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index d6bd630..3fe63f0 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -85,31 +85,6 @@ struct bnep {
 	void	*disconn_data;
 };
 
-uint16_t bnep_service_id(const char *svc)
-{
-	int i;
-	uint16_t id;
-
-	/* Friendly service name */
-	for (i = 0; __svc[i].name; i++) {
-		if (!strcasecmp(svc, __svc[i].name))
-			return __svc[i].id;
-	}
-
-	/* UUID 128 string */
-	for (i = 0; __svc[i].uuid128; i++) {
-		if (!strcasecmp(svc, __svc[i].uuid128))
-			return __svc[i].id;
-	}
-
-	/* Try convert to HEX */
-	id = strtol(svc, NULL, 16);
-	if ((id < BNEP_SVC_PANU) || (id > BNEP_SVC_GN))
-		return 0;
-
-	return id;
-}
-
 const char *bnep_uuid(uint16_t id)
 {
 	int i;
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index df6464d..31579f9 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -26,7 +26,6 @@ struct bnep;
 int bnep_init(void);
 int bnep_cleanup(void);
 
-uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index ecb8441..4311cc9 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -47,6 +47,7 @@
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/error.h"
+#include "lib/uuid.h"
 
 #include "bnep.h"
 #include "connection.h"
@@ -79,9 +80,16 @@ struct network_conn {
 
 static GSList *peers = NULL;
 
-static uint16_t get_service_id(struct btd_service *svc)
+static uint16_t get_pan_srv_id(const char *svc)
 {
-	return bnep_service_id(btd_service_get_profile(svc)->remote_uuid);
+	if (!strcasecmp(svc, "panu") || !strcasecmp(svc, PANU_UUID))
+		return BNEP_SVC_PANU;
+	if (!strcasecmp(svc, "nap") || !strcasecmp(svc, NAP_UUID))
+		return BNEP_SVC_NAP;
+	if (!strcasecmp(svc, "gn") || !strcasecmp(svc, GN_UUID))
+		return BNEP_SVC_GN;
+
+	return 0;
 }
 
 static struct network_peer *find_peer(GSList *list, struct btd_device *device)
@@ -284,7 +292,7 @@ static DBusMessage *local_connect(DBusConnection *conn,
 						DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
-	id = bnep_service_id(svc);
+	id = get_pan_srv_id(svc);
 	uuid = bnep_uuid(id);
 
 	if (uuid == NULL)
@@ -313,7 +321,7 @@ int connection_connect(struct btd_service *svc)
 {
 	struct network_conn *nc = btd_service_get_user_data(svc);
 	struct network_peer *peer = nc->peer;
-	uint16_t id = get_service_id(svc);
+	uint16_t id = get_pan_srv_id(btd_service_get_profile(svc)->remote_uuid);
 	GError *err = NULL;
 	const bdaddr_t *src;
 	const bdaddr_t *dst;
@@ -502,7 +510,7 @@ void connection_unregister(struct btd_service *svc)
 	struct btd_device *device = btd_service_get_device(svc);
 	struct network_conn *conn = btd_service_get_user_data(svc);
 	struct network_peer *peer = conn->peer;
-	uint16_t id = get_service_id(svc);
+	uint16_t id = get_pan_srv_id(btd_service_get_profile(svc)->remote_uuid);
 
 	DBG("%s id %u", device_get_path(device), id);
 
@@ -549,7 +557,7 @@ int connection_register(struct btd_service *svc)
 	struct btd_device *device = btd_service_get_device(svc);
 	struct network_peer *peer;
 	struct network_conn *nc;
-	uint16_t id = get_service_id(svc);
+	uint16_t id = get_pan_srv_id(btd_service_get_profile(svc)->remote_uuid);
 
 	DBG("%s id %u", device_get_path(device), id);
 
-- 
2.1.0

