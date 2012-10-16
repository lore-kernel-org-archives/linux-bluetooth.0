Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/8] input: Remove not needed adapters list in manager
Date: Tue, 16 Oct 2012 12:12:56 +0200
Message-ID: <1350382379-30489-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

adapters list is not used for anything usefull.

---
 profiles/input/manager.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 3f68620..a2690b5 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -44,8 +44,6 @@
 
 static int idle_timeout = 0;
 
-static GSList *adapters = NULL;
-
 static void input_remove(struct btd_device *device, const char *uuid)
 {
 	const gchar *path = device_get_path(device);
@@ -77,24 +75,13 @@ static void hid_device_remove(struct btd_profile *p, struct btd_device *device)
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	int ret;
-
-	ret = server_start(adapter_get_address(adapter));
-	if (ret < 0)
-		return ret;
-
-	adapters = g_slist_append(adapters, btd_adapter_ref(adapter));
-
-	return 0;
+	return server_start(adapter_get_address(adapter));
 }
 
 static void hid_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	server_stop(adapter_get_address(adapter));
-
-	adapters = g_slist_remove(adapters, adapter);
-	btd_adapter_unref(adapter);
 }
 
 static struct btd_profile input_profile = {
-- 
1.7.9.5

