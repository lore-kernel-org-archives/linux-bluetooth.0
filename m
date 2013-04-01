Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH v2] core: Fix a double free on adapter_stop
Date: Mon,  1 Apr 2013 11:14:04 -0700
Message-Id: <1364840044-3577-1-git-send-email-deymo@chromium.org>
In-Reply-To: <20130330155523.GA27129@x220.P-661HNU-F1>
References: <20130330155523.GA27129@x220.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The discovery_list list has the list of current discovery clients and is
removed on adapter_stop (for example due a "power off" command). The
g_slist_free_full will call discovery_free on every element of the list
and remove the nodes of the list, but discovery_destroy (called by
discovery_free) will not only free the element, but also remove it from
the list. This causes the list node to be freed twice, once by
g_slist_free_full and once by g_slist_remove.

This fix calls successively discovery_destroy and lets it remove the list's
elements one by one.
---
 src/adapter.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e553626..9a3bc54 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1540,15 +1540,6 @@ static gboolean remove_temp_devices(gpointer user_data)
 	return FALSE;
 }
 
-static void discovery_free(void *data)
-{
-	struct discovery_client *client = data;
-
-	DBG("owner %s", client->owner);
-
-	g_dbus_remove_watch(dbus_conn, client->watch);
-}
-
 static void discovery_destroy(void *user_data)
 {
 	struct discovery_client *client = user_data;
@@ -4271,12 +4262,13 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 	cancel_passive_scanning(adapter);
 
-	if (adapter->discovery_list) {
-		g_slist_free_full(adapter->discovery_list, discovery_free);
-		adapter->discovery_list = NULL;
-
-		adapter->discovering = false;
+	while (adapter->discovery_list) {
+		struct discovery_client *client = adapter->discovery_list->data;
+		/* g_dbus_remove_watch will remove the client from the adapter's
+		 * list and free it using the discovery_destroy function. */
+		g_dbus_remove_watch(dbus_conn, client->watch);
 	}
+	adapter->discovering = false;
 
 	while (adapter->connections) {
 		struct btd_device *device = adapter->connections->data;
-- 
1.8.1.3

