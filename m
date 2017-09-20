Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/2] hostname: Add more debug in soft failure cases
Date: Wed, 20 Sep 2017 14:54:44 +0200
Message-Id: <20170920125445.24792-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So it's easier to debug problems with the hostname plugin.
---
 plugins/hostname.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index 4f9dfe6d8..f876d0afb 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -82,8 +82,10 @@ static void update_name(struct btd_adapter *adapter, gpointer user_data)
 {
 	const char *hostname = get_hostname();
 
-	if (hostname == NULL)
+	if (hostname == NULL) {
+		DBG ("No hostname available yet");
 		return;
+	}
 
 	if (btd_adapter_is_default(adapter)) {
 		DBG("name: %s", hostname);
@@ -281,13 +283,16 @@ static int hostname_init(void)
 
 	hostname_client = g_dbus_client_new(conn, "org.freedesktop.hostname1",
 						"/org/freedesktop/hostname1");
-	if (!hostname_client)
+	if (!hostname_client) {
+		DBG("Failed to get hostname client");
 		return -EIO;
+	}
 
 	hostname_proxy = g_dbus_proxy_new(hostname_client,
 						"/org/freedesktop/hostname1",
 						"org.freedesktop.hostname1");
 	if (!hostname_proxy) {
+		DBG("Failed to get hostname proxy");
 		g_dbus_client_unref(hostname_client);
 		hostname_client = NULL;
 		return -EIO;
@@ -297,6 +302,7 @@ static int hostname_init(void)
 
 	err = btd_register_adapter_driver(&hostname_driver);
 	if (err < 0) {
+		DBG("Failed to register adapter driver");
 		g_dbus_proxy_unref(hostname_proxy);
 		hostname_proxy = NULL;
 		g_dbus_client_unref(hostname_client);
-- 
2.14.1

