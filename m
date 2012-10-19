Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 01/15] network: Specify id while registering server
Date: Fri, 19 Oct 2012 17:39:18 +0200
Message-Id: <1350661172-18125-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Only one type of server is being installed (BNEP_SVC_NAP), but the
server API actually supports having several of them. Therefore, it is
more accurate to specify BNEP_SVC_NAP in the manager's side.
---
 profiles/network/manager.c | 4 ++--
 profiles/network/server.c  | 9 ++++-----
 profiles/network/server.h  | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index aa564bd..fe3324b 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -102,7 +102,7 @@ static int network_server_probe(struct btd_profile *p,
 
 	DBG("path %s", path);
 
-	return server_register(adapter);
+	return server_register(adapter, BNEP_SVC_NAP);
 }
 
 static void network_server_remove(struct btd_profile *p,
@@ -112,7 +112,7 @@ static void network_server_remove(struct btd_profile *p,
 
 	DBG("path %s", path);
 
-	server_unregister(adapter);
+	server_unregister(adapter, BNEP_SVC_NAP);
 }
 
 static struct btd_profile network_profile = {
diff --git a/profiles/network/server.c b/profiles/network/server.c
index ccf6e69..7b4460d 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -766,7 +766,7 @@ static struct network_adapter *create_adapter(struct btd_adapter *adapter)
 	return na;
 }
 
-int server_register(struct btd_adapter *adapter)
+int server_register(struct btd_adapter *adapter, uint16_t id)
 {
 	struct network_adapter *na;
 	struct network_server *ns;
@@ -780,7 +780,7 @@ int server_register(struct btd_adapter *adapter)
 		adapters = g_slist_append(adapters, na);
 	}
 
-	ns = find_server(na->servers, BNEP_SVC_NAP);
+	ns = find_server(na->servers, id);
 	if (ns)
 		return 0;
 
@@ -802,7 +802,7 @@ int server_register(struct btd_adapter *adapter)
 	}
 
 	bacpy(&ns->src, adapter_get_address(adapter));
-	ns->id = BNEP_SVC_NAP;
+	ns->id = id;
 	ns->na = na;
 	ns->record_id = 0;
 	na->servers = g_slist_append(na->servers, ns);
@@ -812,11 +812,10 @@ int server_register(struct btd_adapter *adapter)
 	return 0;
 }
 
-int server_unregister(struct btd_adapter *adapter)
+int server_unregister(struct btd_adapter *adapter, uint16_t id)
 {
 	struct network_adapter *na;
 	struct network_server *ns;
-	uint16_t id = BNEP_SVC_NAP;
 
 	na = find_adapter(adapters, adapter);
 	if (!na)
diff --git a/profiles/network/server.h b/profiles/network/server.h
index 4c3ab85..2edd342 100644
--- a/profiles/network/server.h
+++ b/profiles/network/server.h
@@ -23,5 +23,5 @@
 
 int server_init(gboolean secure);
 void server_exit(void);
-int server_register(struct btd_adapter *adapter);
-int server_unregister(struct btd_adapter *adapter);
+int server_register(struct btd_adapter *adapter, uint16_t id);
+int server_unregister(struct btd_adapter *adapter, uint16_t id);
-- 
1.7.11.7

