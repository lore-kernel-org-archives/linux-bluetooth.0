Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 05/11] attrib-server: Remove global client list
Date: Fri, 16 Dec 2011 17:09:53 +0100
Message-Id: <1324051799-21439-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-5-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
 <1324051799-21439-4-git-send-email-sancane@gmail.com>
 <1324051799-21439-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 751091e..453bdd7 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -72,7 +72,6 @@ struct group_elem {
 };
 
 static GIOChannel *le_io = NULL;
-static GSList *clients = NULL;
 
 struct gatt_adapter {
 	struct btd_adapter	*adapter;
@@ -1082,11 +1081,18 @@ static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
 
 gboolean attrib_channel_detach(guint id)
 {
+	struct gatt_adapter *gatt_adapter;
 	struct gatt_channel *channel;
 	GSList *l;
 
-	l = g_slist_find_custom(clients, GUINT_TO_POINTER(id),
-						channel_id_cmp);
+	DBG("Deprecated function");
+
+	gatt_adapter = get_default_gatt_adapter();
+	if (gatt_adapter == NULL)
+		return FALSE;
+
+	l = g_slist_find_custom(gatt_adapter->clients, GUINT_TO_POINTER(id),
+								channel_id_cmp);
 	if (!l)
 		return FALSE;
 
-- 
1.7.8

