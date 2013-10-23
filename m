Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android: Add initial code for services unregister
Date: Wed, 23 Oct 2013 13:04:37 +0200
Message-ID: <1382526281-19711-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
References: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to disable services on respective HAL cleanup calls.
---
 android/main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/android/main.c b/android/main.c
index af7ebf3..73ff3ee 100644
--- a/android/main.c
+++ b/android/main.c
@@ -96,10 +96,15 @@ static void service_unregister(void *buf, uint16_t len)
 {
 	struct hal_msg_cmd_unregister_module *m = buf;
 
-	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id]) {
-		ipc_send_error(hal_cmd_io, HAL_SERVICE_ID_CORE,
-							HAL_ERROR_FAILED);
-		return;
+	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id])
+		goto error;
+
+	switch (m->service_id) {
+	default:
+		/* This would indicate bug in HAL, as unregister should not be
+		 * called in init failed */
+		DBG("service %u not supported", m->service_id);
+		goto error;
 	}
 
 	services[m->service_id] = false;
@@ -108,6 +113,9 @@ static void service_unregister(void *buf, uint16_t len)
 								0, NULL, -1);
 
 	info("Service ID=%u unregistered", m->service_id);
+	return;
+error:
+	ipc_send_error(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_ERROR_FAILED);
 }
 
 static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
-- 
1.8.4

