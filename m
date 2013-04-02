Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ v2 07/13] gatttool: Use bluetoothctl behavior when pressing Enter on empty prompt
Date: Tue,  2 Apr 2013 19:31:24 -0400
Message-Id: <1364945490-17059-8-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 attrib/interactive.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 4fd2280..ecb8b7d 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -930,6 +930,7 @@ int interactive(const gchar *src, const gchar *dst,
 	g_io_add_watch(pchan, events, prompt_read, NULL);
 
 	rl_attempted_completion_function = commands_completion;
+	rl_erase_empty_line = 1;
 	rl_callback_handler_install(get_prompt(), parse_line);
 
 	g_main_loop_run(event_loop);
-- 
1.7.9.5

