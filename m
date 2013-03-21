Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH 09/13] gatttool: Remove connecting message from prompt
Date: Thu, 21 Mar 2013 18:31:45 -0400
Message-Id: <1363905109-30839-10-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When trying to connect, the "connecting" message is not set as prompt
anymore. Instead, it is printed just like other status messages and the
prompt is kept, allowing the user to send commands while connection is
being established.
---
 attrib/interactive.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 5ffe2fb..7520324 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -73,20 +73,18 @@ static enum state {
 
 static char *get_prompt(void)
 {
-	if (conn_state == STATE_CONNECTING) {
-		g_string_assign(prompt, "Connecting... ");
-		return prompt->str;
-	}
-
 	if (conn_state == STATE_CONNECTED)
-		g_string_append(prompt, COLOR_BLUE);
+		g_string_assign(prompt, COLOR_BLUE);
+	else
+		g_string_assign(prompt, "");
 
 	if (opt_dst)
 		g_string_append_printf(prompt, "[%17s]", opt_dst);
 	else
 		g_string_append_printf(prompt, "[%17s]", "");
 
-	g_string_append(prompt, COLOR_OFF);
+	if (conn_state == STATE_CONNECTED)
+		g_string_append(prompt, COLOR_OFF);
 
 	if (opt_psm)
 		g_string_append(prompt, "[BR]");
@@ -160,7 +158,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
 						events_handler, attrib, NULL);
 	set_state(STATE_CONNECTED);
-	rl_redisplay();
+	rl_printf("Connection successful\n");
 }
 
 static void disconnect_io()
@@ -408,6 +406,7 @@ static void cmd_connect(int argcp, char **argvp)
 		return;
 	}
 
+	rl_printf("Attempting to connect to %s\n", opt_dst);
 	set_state(STATE_CONNECTING);
 	iochannel = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
 					opt_psm, opt_mtu, connect_cb, &gerr);
-- 
1.7.9.5

