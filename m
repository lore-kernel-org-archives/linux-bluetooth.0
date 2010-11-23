Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Fix not deinitializing telephony driver when there is no adapter powered
Date: Tue, 23 Nov 2010 13:33:42 +0200
Message-Id: <1290512024-24547-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This changes hook telephony driver de/initialization to powered state so
telephony drivers can now free their resources when there is no adapter
active in the system.
---
 audio/manager.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 816c807..8a5616d 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -96,6 +96,7 @@ typedef enum {
 
 struct audio_adapter {
 	struct btd_adapter *btd_adapter;
+	gboolean powered;
 	uint32_t hsp_ag_record_id;
 	uint32_t hfp_ag_record_id;
 	uint32_t hfp_hs_record_id;
@@ -858,6 +859,49 @@ static struct audio_adapter *audio_adapter_get(struct btd_adapter *adapter)
 	return adp;
 }
 
+static void state_changed(struct btd_adapter *adapter, gboolean powered)
+{
+	struct audio_adapter *adp;
+	static gboolean telephony = FALSE;
+	GSList *l;
+
+	DBG("%s powered %s", adapter_get_path(adapter),
+						powered ? "on" : "off");
+
+	/* ignore powered change, adapter is powering down */
+	if (powered && adapter_powering_down(adapter))
+		return;
+
+	adp = find_adapter(adapters, adapter);
+	if (!adp)
+		return;
+
+	adp->powered = powered;
+
+	if (powered) {
+		/* telephony driver already initialized*/
+		if (telephony == TRUE)
+			return;
+		telephony_init();
+		telephony = TRUE;
+		return;
+	}
+
+	/* telephony not initialized just ignore power down */
+	if (telephony == FALSE)
+		return;
+
+	for (l = adapters; l; l = l->next) {
+		adp = l->data;
+
+		if (adp->powered == TRUE)
+			return;
+	}
+
+	telephony_exit();
+	telephony = FALSE;
+}
+
 static int headset_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
@@ -871,10 +915,15 @@ static int headset_server_probe(struct btd_adapter *adapter)
 		return -EINVAL;
 
 	err = headset_server_init(adp);
-	if (err < 0)
+	if (err < 0) {
 		audio_adapter_unref(adp);
+		return err;
+	}
 
-	return err;
+	btd_adapter_register_powered_callback(adapter, state_changed);
+	state_changed(adapter, TRUE);
+
+	return 0;
 }
 
 static void headset_server_remove(struct btd_adapter *adapter)
@@ -910,6 +959,8 @@ static void headset_server_remove(struct btd_adapter *adapter)
 		adp->hfp_ag_server = NULL;
 	}
 
+	btd_adapter_unregister_powered_callback(adapter, state_changed);
+
 	audio_adapter_unref(adp);
 }
 
@@ -1177,10 +1228,8 @@ proceed:
 	if (enabled.media)
 		btd_register_adapter_driver(&media_server_driver);
 
-	if (enabled.headset) {
-		telephony_init();
+	if (enabled.headset)
 		btd_register_adapter_driver(&headset_server_driver);
-	}
 
 	if (enabled.gateway)
 		btd_register_adapter_driver(&gateway_server_driver);
-- 
1.7.1

