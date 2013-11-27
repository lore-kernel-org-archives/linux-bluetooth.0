Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 16/17] gatttool: Add unix socket support for interactive mode
Date: Wed, 27 Nov 2013 17:50:56 -0300
Message-Id: <1385585457-26951-17-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows running GATT operations over unix socket on
interactive mode.
---
 attrib/interactive.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 5bd27af..d89b494 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -84,7 +84,7 @@ static char *get_prompt(void)
 	if (opt_dst)
 		g_string_append_printf(prompt, "[%17s]", opt_dst);
 	else
-		g_string_append_printf(prompt, "[%17s]", "");
+		g_string_append_printf(prompt, "[LOCAL]");
 
 	if (conn_state == STATE_CONNECTED)
 		g_string_append(prompt, COLOR_OFF);
@@ -406,15 +406,17 @@ static void cmd_connect(int argcp, char **argvp)
 			opt_dst_type = g_strdup("public");
 	}
 
-	if (opt_dst == NULL) {
-		error("Remote Bluetooth address required\n");
-		return;
+	if (opt_dst) {
+
+		rl_printf("Attempting to connect to %s\n", opt_dst);
+		set_state(STATE_CONNECTING);
+		iochannel = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
+				opt_psm, opt_mtu, connect_cb, &gerr);
+	} else {
+		rl_printf("Local connection\n");
+		iochannel = unix_connect(connect_cb, &gerr);
 	}
 
-	rl_printf("Attempting to connect to %s\n", opt_dst);
-	set_state(STATE_CONNECTING);
-	iochannel = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
-					opt_psm, opt_mtu, connect_cb, &gerr);
 	if (iochannel == NULL) {
 		set_state(STATE_DISCONNECTED);
 		error("%s\n", gerr->message);
-- 
1.8.3.1

