Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/7] proximity: Change adapter driver function names
Date: Fri, 31 Aug 2012 14:48:27 +0200
Message-ID: <1346417314-25109-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

probe and remove suffixes better describe what these functions actually do.
---
 profiles/proximity/manager.c  | 4 ++--
 profiles/proximity/reporter.c | 4 ++--
 profiles/proximity/reporter.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index f2e49a6..e382be1 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -90,8 +90,8 @@ static struct btd_device_driver monitor_driver = {
 
 static struct btd_adapter_driver reporter_server_driver = {
 	.name = "Proximity GATT Reporter Driver",
-	.probe = reporter_init,
-	.remove = reporter_exit,
+	.probe = reporter_adapter_probe,
+	.remove = reporter_adapter_remove,
 };
 
 static void load_config_file(GKeyFile *config)
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 607de2b..a3a8c8a 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -256,7 +256,7 @@ static struct btd_device_driver reporter_device_driver = {
 	.remove = reporter_device_remove,
 };
 
-int reporter_init(struct btd_adapter *adapter)
+int reporter_adapter_probe(struct btd_adapter *adapter)
 {
 	struct reporter_adapter *radapter;
 	DBusConnection *conn;
@@ -286,7 +286,7 @@ int reporter_init(struct btd_adapter *adapter)
 	return 0;
 }
 
-void reporter_exit(struct btd_adapter *adapter)
+void reporter_adapter_remove(struct btd_adapter *adapter)
 {
 	struct reporter_adapter *radapter = find_reporter_adapter(adapter);
 	if (!radapter)
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index 5ae0eb2..ae5ddf6 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -36,7 +36,7 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
-int reporter_init(struct btd_adapter *adapter);
-void reporter_exit(struct btd_adapter *adapter);
+int reporter_adapter_probe(struct btd_adapter *adapter);
+void reporter_adapter_remove(struct btd_adapter *adapter);
 
 const char *get_alert_level_string(uint8_t level);
-- 
1.7.11.3

