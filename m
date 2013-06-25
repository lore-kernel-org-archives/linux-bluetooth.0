Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 13/16] network: Simplify search-by-UUID
Date: Tue, 25 Jun 2013 18:24:46 +0200
Message-Id: <1372177489-6858-14-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The helper function bnep_service_id() provides enough functionality to
avoid a specific helper function to search by UUID.
---
 profiles/network/server.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index a0b7754..02a74ab 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -114,24 +114,6 @@ static struct network_server *find_server(struct network_adapter *na,
 	return NULL;
 }
 
-static struct network_server *find_server_by_uuid(struct network_adapter *na,
-							const char *uuid)
-{
-	GSList *list;
-
-	for (list = na->servers; list; list = list->next) {
-		struct network_server *ns = list->data;
-
-		if (strcasecmp(uuid, bnep_uuid(ns->id)) == 0)
-			return ns;
-
-		if (strcasecmp(uuid, bnep_name(ns->id)) == 0)
-			return ns;
-	}
-
-	return NULL;
-}
-
 static sdp_record_t *server_record_new(const char *name, uint16_t id)
 {
 	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
@@ -655,7 +637,7 @@ static DBusMessage *register_server(DBusConnection *conn,
 				DBUS_TYPE_STRING, &bridge, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	ns = find_server_by_uuid(na, uuid);
+	ns = find_server(na, bnep_service_id(uuid));
 	if (ns == NULL)
 		return btd_error_failed(msg, "Invalid UUID");
 
@@ -692,7 +674,7 @@ static DBusMessage *unregister_server(DBusConnection *conn,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	ns = find_server_by_uuid(na, uuid);
+	ns = find_server(na, bnep_service_id(uuid));
 	if (!ns)
 		return btd_error_failed(msg, "Invalid UUID");
 
-- 
1.8.1.4

