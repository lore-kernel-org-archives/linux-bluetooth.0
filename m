Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android: Shutdown if IPC command for unregistered service is received
Date: Wed, 13 Nov 2013 15:47:12 +0100
Message-ID: <1384354033-21724-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sending commands to not registered services is violation of IPC spec
and should result in daemon shutdown.
---
 android/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/main.c b/android/main.c
index 36cc8aa..12284f7 100644
--- a/android/main.c
+++ b/android/main.c
@@ -252,6 +252,12 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 	DBG("service_id %u opcode %u len %u", msg->service_id, msg->opcode,
 								msg->len);
 
+	if (msg->service_id > HAL_SERVICE_ID_MAX ||
+						!services[msg->service_id]) {
+		error("HAL command of not registered service, terminating");
+		goto fail;
+	}
+
 	switch (msg->service_id) {
 	case HAL_SERVICE_ID_CORE:
 		handle_service_core(msg->opcode, msg->payload, msg->len);
-- 
1.8.4.2

