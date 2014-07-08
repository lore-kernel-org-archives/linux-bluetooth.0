Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] client: Allow to terminate if bluetoothd was not started
Date: Tue,  8 Jul 2014 19:52:26 +0200
Message-Id: <1404841946-14501-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to terminate bluetoothctl with CTRL-C if daemon didn't
start. Otherwise input is not functional and user must kill
bluetoothctl by sending signal from another terminal.
---
 client/main.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 774c0cd..ae8aa92 100644
--- a/client/main.c
+++ b/client/main.c
@@ -60,6 +60,8 @@ static GDBusProxy *default_ctrl;
 static GList *ctrl_list;
 static GList *dev_list;
 
+static guint input = 0;
+
 static const char * const agent_arguments[] = {
 	"on",
 	"off",
@@ -1386,11 +1388,20 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
 
 	switch (si.ssi_signo) {
 	case SIGINT:
-		rl_replace_line("", 0);
-		rl_crlf();
-		rl_on_new_line();
-		rl_redisplay();
-		break;
+		if (input) {
+			rl_replace_line("", 0);
+			rl_crlf();
+			rl_on_new_line();
+			rl_redisplay();
+			break;
+		}
+
+		/*
+		 * If input was not yet setup up that means signal was received
+		 * while daemon was not yet running. Since user is not able
+		 * to terminate client by CTRL-D or typing exit treat this as
+		 * exit and fall through.
+		 */
 	case SIGTERM:
 		if (__terminated == 0) {
 			rl_replace_line("", 0);
@@ -1476,7 +1487,7 @@ int main(int argc, char *argv[])
 	GOptionContext *context;
 	GError *error = NULL;
 	GDBusClient *client;
-	guint signal, input;
+	guint signal;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
-- 
2.0.1

