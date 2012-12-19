Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] audio: Remove adapter list
Date: Wed, 19 Dec 2012 16:29:08 +0200
Message-Id: <1355927348-19430-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355927348-19430-1-git-send-email-luiz.dentz@gmail.com>
References: <1355927348-19430-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_adapter is directly referenced by the drivers so there is no point
on keeping a list just for the audio adapters.
---
 profiles/audio/manager.c | 180 ++++++-----------------------------------------
 1 file changed, 21 insertions(+), 159 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index bb5688f..9ad3bf6 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -75,7 +75,6 @@ struct audio_adapter {
 };
 
 static GKeyFile *config = NULL;
-static GSList *adapters = NULL;
 static GSList *devices = NULL;
 
 static struct enabled_interfaces enabled = {
@@ -84,19 +83,6 @@ static struct enabled_interfaces enabled = {
 	.control	= TRUE,
 };
 
-static struct audio_adapter *find_adapter(GSList *list,
-					struct btd_adapter *btd_adapter)
-{
-	for (; list; list = list->next) {
-		struct audio_adapter *adapter = list->data;
-
-		if (adapter->btd_adapter == btd_adapter)
-			return adapter;
-	}
-
-	return NULL;
-}
-
 static struct audio_device *get_audio_dev(struct btd_device *device)
 {
 	return manager_get_audio_device(device, TRUE);
@@ -284,191 +270,66 @@ static int avrcp_control_disconnect(struct btd_device *dev,
 	return control_disconnect(audio_dev);
 }
 
-static struct audio_adapter *audio_adapter_ref(struct audio_adapter *adp)
-{
-	adp->ref++;
-
-	DBG("%p: ref=%d", adp, adp->ref);
-
-	return adp;
-}
-
-static void audio_adapter_unref(struct audio_adapter *adp)
-{
-	adp->ref--;
-
-	DBG("%p: ref=%d", adp, adp->ref);
-
-	if (adp->ref > 0)
-		return;
-
-	adapters = g_slist_remove(adapters, adp);
-	btd_adapter_unref(adp->btd_adapter);
-	g_free(adp);
-}
-
-static struct audio_adapter *audio_adapter_create(struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-
-	adp = g_new0(struct audio_adapter, 1);
-	adp->btd_adapter = btd_adapter_ref(adapter);
-
-	return audio_adapter_ref(adp);
-}
-
-static struct audio_adapter *audio_adapter_get(struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp) {
-		adp = audio_adapter_create(adapter);
-		adapters = g_slist_append(adapters, adp);
-	} else
-		audio_adapter_ref(adp);
-
-	return adp;
-}
-
 static int a2dp_source_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-	int err;
-
-	DBG("path %s", path);
-
-	adp = audio_adapter_get(adapter);
-	if (!adp)
-		return -EINVAL;
-
-	err = a2dp_source_register(adapter, config);
-	if (err < 0)
-		audio_adapter_unref(adp);
+	DBG("path %s", adapter_get_path(adapter));
 
-	return err;
+	return a2dp_source_register(adapter, config);
 }
 
 static void a2dp_source_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
+	DBG("path %s", adapter_get_path(adapter));
 
 	a2dp_source_unregister(adapter);
-	audio_adapter_unref(adp);
 }
 
 static int a2dp_sink_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-	int err;
-
-	DBG("path %s", path);
-
-	adp = audio_adapter_get(adapter);
-	if (!adp)
-		return -EINVAL;
-
-	err = a2dp_sink_register(adapter, config);
-	if (err < 0)
-		audio_adapter_unref(adp);
+	DBG("path %s", adapter_get_path(adapter));
 
-	return err;
+	return a2dp_sink_register(adapter, config);
 }
 
 static void a2dp_sink_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
+	DBG("path %s", adapter_get_path(adapter));
 
 	a2dp_sink_unregister(adapter);
-	audio_adapter_unref(adp);
 }
 
 static int avrcp_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-	int err;
-
-	DBG("path %s", path);
-
-	adp = audio_adapter_get(adapter);
-	if (!adp)
-		return -EINVAL;
-
-	err = avrcp_register(adapter, config);
-	if (err < 0)
-		audio_adapter_unref(adp);
+	DBG("path %s", adapter_get_path(adapter));
 
-	return err;
+	return avrcp_register(adapter, config);
 }
 
 static void avrcp_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
+	DBG("path %s", adapter_get_path(adapter));
 
-	avrcp_unregister(adapter);
-	audio_adapter_unref(adp);
+	return avrcp_unregister(adapter);
 }
 
 static int media_server_probe(struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-	int err;
-
 	DBG("path %s", adapter_get_path(adapter));
 
-	adp = audio_adapter_get(adapter);
-	if (!adp)
-		return -EINVAL;
-
-	err = media_register(adapter);
-	if (err < 0)
-		audio_adapter_unref(adp);
-
-	return err;
+	return media_register(adapter);
 }
 
 static void media_server_remove(struct btd_adapter *adapter)
 {
-	struct audio_adapter *adp;
-
 	DBG("path %s", adapter_get_path(adapter));
 
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
-
 	media_unregister(adapter);
-	audio_adapter_unref(adp);
 }
 
 static struct btd_profile a2dp_source_profile = {
@@ -643,16 +504,17 @@ struct audio_device *manager_get_audio_device(struct btd_device *device,
 	return dev;
 }
 
-void manager_set_fast_connectable(gboolean enable)
+static void set_fast_connectable(struct btd_adapter *adapter, gpointer user_data)
 {
-	GSList *l;
+	gboolean enable = GPOINTER_TO_UINT(user_data);
 
-	for (l = adapters; l != NULL; l = l->next) {
-		struct audio_adapter *adapter = l->data;
+	if (btd_adapter_set_fast_connectable(adapter, enable))
+		error("Changing fast connectable for hci%d failed",
+						adapter_get_dev_id(adapter));
+}
 
-		if (btd_adapter_set_fast_connectable(adapter->btd_adapter,
-								enable))
-			error("Changing fast connectable for hci%d failed",
-				adapter_get_dev_id(adapter->btd_adapter));
-	}
+void manager_set_fast_connectable(gboolean enable)
+{
+	manager_foreach_adapter(set_fast_connectable,
+						GUINT_TO_POINTER(enable));
 }
-- 
1.7.11.7

