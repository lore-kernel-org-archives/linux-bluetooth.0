Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Add option to specify controller index to use
Date: Tue, 5 Nov 2013 17:07:38 +0100
Message-ID: <1383667658-31480-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be usefull while testing on Linux where more controllers
can be present.
---

This is on top of patchset starting with patch
"adapter: Move MGMT_VERSION macro to mgmt.h"

 android/main.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/android/main.c b/android/main.c
index 72e47f2..994d796 100644
--- a/android/main.c
+++ b/android/main.c
@@ -455,10 +455,13 @@ static guint setup_signalfd(void)
 }
 
 static gboolean option_version = FALSE;
+static gint option_index = MGMT_INDEX_NONE;
 
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit", NULL },
+	{ "index", 'i', 0, G_OPTION_ARG_INT, &option_index,
+				"Use specified controller", "INDEX"},
 	{ NULL }
 };
 
@@ -481,6 +484,8 @@ static void adapter_ready(int err)
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
+	uint16_t opt_index = option_index;
+
 	DBG("index %u", index);
 
 	if (adapter_index != MGMT_INDEX_NONE) {
@@ -488,6 +493,11 @@ static void mgmt_index_added_event(uint16_t index, uint16_t length,
 		return;
 	}
 
+	if (opt_index != MGMT_INDEX_NONE && opt_index != index) {
+		DBG("skip event for index %u (option %u)", index, opt_index);
+		return;
+	}
+
 	if (adapter_timeout > 0) {
 		g_source_remove(adapter_timeout);
 		adapter_timeout = 0;
@@ -521,7 +531,9 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_read_index_list *rp = param;
+	uint16_t opt_index = option_index;
 	uint16_t num;
+	int i;
 
 	DBG("");
 
@@ -548,19 +560,26 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 	if (adapter_index != MGMT_INDEX_NONE)
 		return;
 
-	if (num < 1) {
-		adapter_timeout = g_timeout_add_seconds(STARTUP_GRACE_SECONDS,
-						adapter_timeout_handler, NULL);
-		if (adapter_timeout == 0) {
-			error("%s: Failed init timeout", __func__);
-			goto error;
-		}
+	for (i = 0; i < num; i++) {
+		uint16_t index = btohs(rp->index[i]);
+
+		if (opt_index != MGMT_INDEX_NONE && opt_index != index)
+			continue;
+
+		adapter_index = index;
+		bt_adapter_init(adapter_index, mgmt_if, adapter_ready);
 		return;
 	}
 
-	adapter_index = btohs(rp->index[0]);
-	bt_adapter_init(adapter_index, mgmt_if, adapter_ready);
-	return;
+	if (adapter_index != MGMT_INDEX_NONE)
+		return;
+
+	adapter_timeout = g_timeout_add_seconds(STARTUP_GRACE_SECONDS,
+					adapter_timeout_handler, NULL);
+	if (adapter_timeout > 0)
+		return;
+
+	error("%s: Failed init timeout", __func__);
 
 error:
 	g_main_loop_quit(event_loop);
-- 
1.8.4.2

