Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCHv2 BlueZ] gatttool: Update interactive prompt if connection is lost
Date: Tue, 27 Mar 2012 09:21:55 -0400
Message-Id: <1332854515-22080-1-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1332516126-6665-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1332516126-6665-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In interactive mode, when connection is lost, the prompt used to remain
in "connected" state. This patch fixes that case, by always showing the
actual connection state.
---
 attrib/interactive.c |   39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 5941811..0064ba2 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -149,6 +149,22 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	set_state(STATE_CONNECTED);
 }
 
+static void disconnect_io()
+{
+	if (conn_state == STATE_DISCONNECTED)
+		return;
+
+	g_attrib_unref(attrib);
+	attrib = NULL;
+	opt_mtu = 0;
+
+	g_io_channel_shutdown(iochannel, FALSE, NULL);
+	g_io_channel_unref(iochannel);
+	iochannel = NULL;
+
+	set_state(STATE_DISCONNECTED);
+}
+
 static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	GSList *l;
@@ -327,6 +343,14 @@ static void cmd_exit(int argcp, char **argvp)
 	g_main_loop_quit(event_loop);
 }
 
+static gboolean channel_watcher(GIOChannel *chan, GIOCondition cond,
+				gpointer user_data)
+{
+	disconnect_io();
+
+	return FALSE;
+}
+
 static void cmd_connect(int argcp, char **argvp)
 {
 	if (conn_state != STATE_DISCONNECTED)
@@ -347,22 +371,13 @@ static void cmd_connect(int argcp, char **argvp)
 						opt_mtu, connect_cb);
 	if (iochannel == NULL)
 		set_state(STATE_DISCONNECTED);
+	else
+		g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
 }
 
 static void cmd_disconnect(int argcp, char **argvp)
 {
-	if (conn_state == STATE_DISCONNECTED)
-		return;
-
-	g_attrib_unref(attrib);
-	attrib = NULL;
-	opt_mtu = 0;
-
-	g_io_channel_shutdown(iochannel, FALSE, NULL);
-	g_io_channel_unref(iochannel);
-	iochannel = NULL;
-
-	set_state(STATE_DISCONNECTED);
+	disconnect_io();
 }
 
 static void cmd_primary(int argcp, char **argvp)
-- 
1.7.9.4

