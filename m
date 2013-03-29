Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH] core: Double free on adapter_stop
Date: Fri, 29 Mar 2013 14:18:23 -0700
Message-Id: <1364591903-29947-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The discovery_list list has the list of current discovery clients and is
removed on adapter_stop (for example due a "power off" command). The
g_slist_free_full will call discovery_free on every element of the list
and remove the nodes of the list, but discovery_destroy (called by
discovery_free) will not only free the element, but also remove it from
the list. This causes the list node to be freed twice, once by
g_slist_free_full and once by g_slist_remove.

This fix calls successively discovery_free and lets it remove the list one
by one.
---
 src/adapter.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e553626..ac322de 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4272,8 +4272,11 @@ static void adapter_stop(struct btd_adapter *adapter)
 	cancel_passive_scanning(adapter);
 
 	if (adapter->discovery_list) {
-		g_slist_free_full(adapter->discovery_list, discovery_free);
-		adapter->discovery_list = NULL;
+		while (adapter->discovery_list) {
+			struct discovery_client *client =
+						adapter->discovery_list->data;
+			discovery_free(client);
+		}
 
 		adapter->discovering = false;
 	}
-- 
1.8.1.3

