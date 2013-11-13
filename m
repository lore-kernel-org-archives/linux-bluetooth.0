Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/A2DP: Return -ENOPROTOOPT if record doesn't exist
Date: Wed, 13 Nov 2013 15:26:36 +0200
Message-Id: <1384349196-18190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case record is not registered it means no endpoint is available so
return -ENOPROTOOPT to indicate that it is currently not available.
---
 profiles/audio/a2dp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6b3d6b2..864cb18 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1861,10 +1861,22 @@ static void a2dp_sink_remove(struct btd_service *service)
 static int a2dp_source_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(dev);
+	struct a2dp_server *server;
 	const char *path = device_get_path(dev);
 
 	DBG("path %s", path);
 
+	server = find_server(servers, adapter);
+	if (!server || !server->sink_enabled) {
+		DBG("Unexpected error: cannot find server");
+		return -EPROTONOSUPPORT;
+	}
+
+	/* Return protocol not available if no record/endpoint exists */
+	if (server->sink_record_id == 0)
+		return -ENOPROTOOPT;
+
 	return source_connect(service);
 }
 
@@ -1881,10 +1893,22 @@ static int a2dp_source_disconnect(struct btd_service *service)
 static int a2dp_sink_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(dev);
+	struct a2dp_server *server;
 	const char *path = device_get_path(dev);
 
 	DBG("path %s", path);
 
+	server = find_server(servers, adapter);
+	if (!server || !server->source_enabled) {
+		DBG("Unexpected error: cannot find server");
+		return -EPROTONOSUPPORT;
+	}
+
+	/* Return protocol not available if no record/endpoint exists */
+	if (server->source_record_id == 0)
+		return -ENOPROTOOPT;
+
 	return sink_connect(service);
 }
 
-- 
1.8.3.1

