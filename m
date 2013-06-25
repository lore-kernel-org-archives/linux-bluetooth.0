Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 11/16] network: Replace list with network_adapter
Date: Tue, 25 Jun 2013 18:24:44 +0200
Message-Id: <1372177489-6858-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially refactor the code such that find_server() receives a pointer
to struct network_adapter instead of a GSList, given that the codebase
always searches within the network_adapter->servers list.
---
 profiles/network/server.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index de48bec..ace31c5 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -97,9 +97,12 @@ static struct network_adapter *find_adapter(GSList *list,
 	return NULL;
 }
 
-static struct network_server *find_server(GSList *list, uint16_t id)
+static struct network_server *find_server(struct network_adapter *na,
+								uint16_t id)
 {
-	for (; list; list = list->next) {
+	GSList *list;
+
+	for (list = na->servers; list; list = list->next) {
 		struct network_server *ns = list->data;
 
 		if (ns->id == id)
@@ -109,10 +112,12 @@ static struct network_server *find_server(GSList *list, uint16_t id)
 	return NULL;
 }
 
-static struct network_server *find_server_by_uuid(GSList *list,
+static struct network_server *find_server_by_uuid(struct network_adapter *na,
 							const char *uuid)
 {
-	for (; list; list = list->next) {
+	GSList *list;
+
+	for (list = na->servers; list; list = list->next) {
 		struct network_server *ns = list->data;
 
 		if (strcasecmp(uuid, bnep_uuid(ns->id)) == 0)
@@ -441,7 +446,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 
 	rsp = BNEP_CONN_NOT_ALLOWED;
 
-	ns = find_server(na->servers, dst_role);
+	ns = find_server(na, dst_role);
 	if (!ns) {
 		error("Server unavailable: (0x%x)", dst_role);
 		goto reply;
@@ -538,7 +543,7 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	ns = find_server(na->servers, BNEP_SVC_NAP);
+	ns = find_server(na, BNEP_SVC_NAP);
 	if (!ns)
 		goto drop;
 
@@ -648,7 +653,7 @@ static DBusMessage *register_server(DBusConnection *conn,
 				DBUS_TYPE_STRING, &bridge, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	ns = find_server_by_uuid(na->servers, uuid);
+	ns = find_server_by_uuid(na, uuid);
 	if (ns == NULL)
 		return btd_error_failed(msg, "Invalid UUID");
 
@@ -685,7 +690,7 @@ static DBusMessage *unregister_server(DBusConnection *conn,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	ns = find_server_by_uuid(na->servers, uuid);
+	ns = find_server_by_uuid(na, uuid);
 	if (!ns)
 		return btd_error_failed(msg, "Invalid UUID");
 
@@ -795,7 +800,7 @@ int server_register(struct btd_adapter *adapter, uint16_t id)
 		adapters = g_slist_append(adapters, na);
 	}
 
-	ns = find_server(na->servers, id);
+	ns = find_server(na, id);
 	if (ns)
 		return 0;
 
@@ -840,7 +845,7 @@ int server_unregister(struct btd_adapter *adapter, uint16_t id)
 	if (!na)
 		return -EINVAL;
 
-	ns = find_server(na->servers, id);
+	ns = find_server(na, id);
 	if (!ns)
 		return -EINVAL;
 
-- 
1.8.1.4

