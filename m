Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH 04/13] gatttool: Use GError to propage error messages to caller
Date: Thu, 21 Mar 2013 18:31:40 -0400
Message-Id: <1363905109-30839-5-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Handle runtime errors outside gatt_connect(), using GError to propagate
error messages to caller.
---
 attrib/gatttool.c    |    6 +++++-
 attrib/gatttool.h    |    3 ++-
 attrib/interactive.c |   10 +++++++---
 attrib/utils.c       |   14 +++++++-------
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 1dd0c35..8dbebbb 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -576,6 +576,7 @@ int main(int argc, char *argv[])
 	if (g_option_context_parse(context, &argc, &argv, &gerr) == FALSE) {
 		g_printerr("%s\n", gerr->message);
 		g_error_free(gerr);
+		gerr = NULL;
 	}
 
 	if (opt_interactive) {
@@ -610,8 +611,11 @@ int main(int argc, char *argv[])
 	}
 
 	chan = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
-					opt_psm, opt_mtu, connect_cb);
+					opt_psm, opt_mtu, connect_cb, &gerr);
 	if (chan == NULL) {
+		g_printerr("%s\n", gerr->message);
+		g_error_free(gerr);
+		gerr = NULL;
 		got_error = TRUE;
 		goto done;
 	}
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index a38339b..0e13739 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -25,5 +25,6 @@ int interactive(const gchar *src, const gchar *dst, const gchar *dst_type,
 		gboolean le);
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 			const gchar *dst_type, const gchar *sec_level,
-			int psm, int mtu, BtIOConnect connect_cb);
+			int psm, int mtu, BtIOConnect connect_cb,
+			GError **gerr);
 size_t gatt_attr_data_from_string(const char *str, uint8_t **data);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 9f72453..ce35218 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -395,6 +395,8 @@ static gboolean channel_watcher(GIOChannel *chan, GIOCondition cond,
 
 static void cmd_connect(int argcp, char **argvp)
 {
+	GError *gerr = NULL;
+
 	if (conn_state != STATE_DISCONNECTED)
 		return;
 
@@ -416,10 +418,12 @@ static void cmd_connect(int argcp, char **argvp)
 
 	set_state(STATE_CONNECTING);
 	iochannel = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
-						opt_psm, opt_mtu, connect_cb);
-	if (iochannel == NULL)
+					opt_psm, opt_mtu, connect_cb, &gerr);
+	if (iochannel == NULL) {
+		printf("%s\n", gerr->message);
 		set_state(STATE_DISCONNECTED);
-	else
+		g_error_free(gerr);
+	} else
 		g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
 }
 
diff --git a/attrib/utils.c b/attrib/utils.c
index c8c8651..e263bcb 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -42,12 +42,13 @@
 
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 				const gchar *dst_type, const gchar *sec_level,
-				int psm, int mtu, BtIOConnect connect_cb)
+				int psm, int mtu, BtIOConnect connect_cb,
+				GError **gerr)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
 	uint8_t dest_type;
-	GError *err = NULL;
+	GError *tmp_err = NULL;
 	BtIOSecLevel sec;
 
 	str2ba(dst, &dba);
@@ -75,7 +76,7 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 		sec = BT_IO_SEC_LOW;
 
 	if (psm == 0)
-		chan = bt_io_connect(connect_cb, NULL, NULL, &err,
+		chan = bt_io_connect(connect_cb, NULL, NULL, &tmp_err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_DEST_TYPE, dest_type,
@@ -83,7 +84,7 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 				BT_IO_OPT_SEC_LEVEL, sec,
 				BT_IO_OPT_INVALID);
 	else
-		chan = bt_io_connect(connect_cb, NULL, NULL, &err,
+		chan = bt_io_connect(connect_cb, NULL, NULL, &tmp_err,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_PSM, psm,
@@ -91,9 +92,8 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 				BT_IO_OPT_SEC_LEVEL, sec,
 				BT_IO_OPT_INVALID);
 
-	if (err) {
-		g_printerr("%s\n", err->message);
-		g_error_free(err);
+	if (tmp_err) {
+		g_propagate_error(gerr, tmp_err);
 		return NULL;
 	}
 
-- 
1.7.9.5

