Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/8] unit: Remove not needed functions from test-sdp
Date: Thu, 19 Sep 2013 16:00:45 +0200
Message-ID: <1379599248-7923-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDP code no longer depends on adapter code.
---
 unit/test-sdp.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 5aa6948..6d699e2 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -134,35 +134,6 @@ void btd_debug(const char *format, ...)
 {
 }
 
-struct btd_adapter;
-
-typedef void (*adapter_cb) (struct btd_adapter *adapter, gpointer user_data);
-
-void adapter_foreach(adapter_cb func, gpointer user_data);
-
-void adapter_foreach(adapter_cb func, gpointer user_data)
-{
-}
-
-struct btd_adapter *adapter_find(const bdaddr_t *sba);
-
-struct btd_adapter *adapter_find(const bdaddr_t *sba)
-{
-	return NULL;
-}
-
-void adapter_service_insert(struct btd_adapter *adapter, void *rec);
-
-void adapter_service_insert(struct btd_adapter *adapter, void *rec)
-{
-}
-
-void adapter_service_remove(struct btd_adapter *adapter, void *rec);
-
-void adapter_service_remove(struct btd_adapter *adapter, void *rec)
-{
-}
-
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
-- 
1.8.4

