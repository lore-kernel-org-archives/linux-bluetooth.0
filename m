Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 09/16] heartrate: Remove boilerplate code
Date: Tue, 25 Jun 2013 18:24:42 +0200
Message-Id: <1372177489-6858-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The helper fuctions to adapt btd_profile signatures with internal APIs
add boilerplate code of little use, so remove them.
---
 profiles/heartrate/heartrate.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 1d902a8..81ca2a8 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -724,8 +724,9 @@ static const GDBusPropertyTable heartrate_device_properties[] = {
 	{ }
 };
 
-static int heartrate_adapter_register(struct btd_adapter *adapter)
+static int heartrate_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct heartrate_adapter *hradapter;
 
 	hradapter = g_new0(struct heartrate_adapter, 1);
@@ -748,8 +749,9 @@ static int heartrate_adapter_register(struct btd_adapter *adapter)
 	return 0;
 }
 
-static void heartrate_adapter_unregister(struct btd_adapter *adapter)
+static void heartrate_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct heartrate_adapter *hradapter;
 
 	hradapter = find_heartrate_adapter(adapter);
@@ -831,20 +833,6 @@ static void heartrate_device_unregister(struct btd_device *device)
 				device_get_path(device), HEART_RATE_INTERFACE);
 }
 
-static int heartrate_adapter_probe(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-
-	return heartrate_adapter_register(adapter);
-}
-
-static void heartrate_adapter_remove(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-
-	heartrate_adapter_unregister(adapter);
-}
-
 static int heartrate_device_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-- 
1.8.1.4

