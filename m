Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ] gatttool: Update interactive prompt if connection is lost
Date: Fri, 23 Mar 2012 11:22:06 -0400
Message-Id: <1332516126-6665-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In interactive mode, when connection is lost, the prompt used to remain
in "connected" state. This patch fixes that case, by always showing the
actual connection state.
---
 attrib/interactive.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index be81424..47ddcf6 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -56,6 +56,7 @@ struct characteristic_data {
 };
 
 static void cmd_help(int argcp, char **argvp);
+static void cmd_disconnect(int argcp, char **argvp);
 
 enum state {
 	STATE_DISCONNECTED,
@@ -327,6 +328,14 @@ static void cmd_exit(int argcp, char **argvp)
 	g_main_loop_quit(event_loop);
 }
 
+static gboolean channel_watcher(GIOChannel *chan, GIOCondition cond,
+				gpointer user_data)
+{
+	cmd_disconnect(0, NULL);
+
+	return TRUE;
+}
+
 static void cmd_connect(int argcp, char **argvp)
 {
 	if (conn_state != STATE_DISCONNECTED)
@@ -347,6 +356,8 @@ static void cmd_connect(int argcp, char **argvp)
 						opt_mtu, connect_cb);
 	if (iochannel == NULL)
 		set_state(STATE_DISCONNECTED);
+	else
+		g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
 }
 
 static void cmd_disconnect(int argcp, char **argvp)
-- 
1.7.9.4

