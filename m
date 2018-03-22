Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] shared/shell: Add bt_shell_cleanup
Date: Thu, 22 Mar 2018 13:04:50 -0700
Message-Id: <20180322200450.27180-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This releases resources used for shell initialization.
This is needed as a separate function to enable clean shutdown
when an application needs to exit prior to calling bt_shell_run(),
e.g., when failing program initialization based on processed command
line input options.
---
 src/shared/shell.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 10f26264f..33bc0d980 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1001,11 +1001,16 @@ void bt_shell_run(void)
 
 	mainloop_run();
 
+	io_destroy(signal);
+
+	bt_shell_cleanup();
+}
+
+void bt_shell_cleanup(void)
+{
 	bt_shell_release_prompt("");
 	bt_shell_detach();
 
-	io_destroy(signal);
-
 	if (data.envs) {
 		queue_destroy(data.envs, env_destroy);
 		data.envs = NULL;
-- 
2.13.6

