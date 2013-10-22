Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] adapter: Print debug message with IPC message header parameters
Date: Tue, 22 Oct 2013 18:47:53 +0200
Message-Id: <1382460476-6604-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
References: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is usefull while debugging HAL IPC.
---
 android/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/main.c b/android/main.c
index f3e2baa..988d08b 100644
--- a/android/main.c
+++ b/android/main.c
@@ -151,6 +151,9 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
+	DBG("service_id %u opcode %u len %u", msg->service_id, msg->opcode,
+								msg->len);
+
 	switch (msg->service_id) {
 	case HAL_SERVICE_ID_CORE:
 		handle_service_core(msg->opcode, buf + sizeof(*msg), msg->len);
-- 
1.8.4

