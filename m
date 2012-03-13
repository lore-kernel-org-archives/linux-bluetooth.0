Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 1/3] audio: fix missing unref in case of error
Date: Tue, 13 Mar 2012 14:19:54 +0100
Message-Id: <1331644796-14314-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

audio_adapter_get() increases the reference counter of the adapter, so
it's necessary to decrement it in case of error.
---
 audio/manager.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 68a0a56..f15893d 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -964,12 +964,17 @@ static void headset_server_remove(struct btd_adapter *adapter)
 static int gateway_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
+	int err;
 
 	adp = audio_adapter_get(adapter);
 	if (!adp)
 		return -EINVAL;
 
-	return gateway_server_init(adp);
+	err = gateway_server_init(adp);
+	if (err < 0)
+		audio_adapter_unref(adp);
+
+	return err;
 }
 
 static void gateway_server_remove(struct btd_adapter *adapter)
@@ -1040,6 +1045,7 @@ static int avrcp_server_probe(struct btd_adapter *adapter)
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
 	bdaddr_t src;
+	int err;
 
 	DBG("path %s", path);
 
@@ -1049,7 +1055,11 @@ static int avrcp_server_probe(struct btd_adapter *adapter)
 
 	adapter_get_address(adapter, &src);
 
-	return avrcp_register(connection, &src, config);
+	err = avrcp_register(connection, &src, config);
+	if (err < 0)
+		audio_adapter_unref(adp);
+
+	return err;
 }
 
 static void avrcp_server_remove(struct btd_adapter *adapter)
@@ -1074,6 +1084,7 @@ static int media_server_probe(struct btd_adapter *adapter)
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
 	bdaddr_t src;
+	int err;
 
 	DBG("path %s", path);
 
@@ -1083,7 +1094,11 @@ static int media_server_probe(struct btd_adapter *adapter)
 
 	adapter_get_address(adapter, &src);
 
-	return media_register(connection, path, &src);
+	err = media_register(connection, path, &src);
+	if (err < 0)
+		audio_adapter_unref(adp);
+
+	return err;
 }
 
 static void media_server_remove(struct btd_adapter *adapter)
-- 
1.7.7.6

