Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] android: Add initial code for services register
Date: Wed, 23 Oct 2013 13:04:36 +0200
Message-ID: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to enable services on respective HAL init calls.
---
 android/main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/android/main.c b/android/main.c
index e13e5b0..af7ebf3 100644
--- a/android/main.c
+++ b/android/main.c
@@ -72,10 +72,13 @@ static void service_register(void *buf, uint16_t len)
 {
 	struct hal_msg_cmd_register_module *m = buf;
 
-	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id]) {
-		ipc_send_error(hal_cmd_io, HAL_SERVICE_ID_CORE,
-							HAL_ERROR_FAILED);
-		return;
+	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
+		goto error;
+
+	switch (m->service_id) {
+	default:
+		DBG("service %u not supported", m->service_id);
+		goto error;
 	}
 
 	services[m->service_id] = true;
@@ -84,6 +87,9 @@ static void service_register(void *buf, uint16_t len)
 								NULL, -1);
 
 	info("Service ID=%u registered", m->service_id);
+	return;
+error:
+	ipc_send_error(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_ERROR_FAILED);
 }
 
 static void service_unregister(void *buf, uint16_t len)
-- 
1.8.4

