Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/1] Fix fd comparison and comment
Date: Mon, 25 Oct 2010 11:29:12 -0200
Message-Id: <1288013352-23258-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |    6 +++---
 health/mcap_sync.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index fd3b1ca..7332cd5 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -339,7 +339,7 @@ static DBusMessage *manager_create_application(DBusConnection *conn,
 					"Can't get sender name");
 	}
 
-	if (!set_app_path(app)){
+	if (!set_app_path(app)) {
 		free_application(app);
 		return g_dbus_create_error(msg,
 				ERROR_INTERFACE ".HealthError",
@@ -477,7 +477,7 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 	}
 
 	fd = mcap_mdl_get_fd(dc_data->hdp_chann->mdl);
-	if (fd <= 0)
+	if (fd < 0)
 		reply = g_dbus_create_error(dc_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"Cannot get file descriptor");
@@ -568,7 +568,7 @@ static DBusMessage *channel_acquire_continue(struct hdp_tmp_dc_data *data,
 	}
 
 	fd = mcap_mdl_get_fd(data->hdp_chann->mdl);
-	if (fd > 0)
+	if (fd >= 0)
 		return g_dbus_create_reply(data->msg, DBUS_TYPE_UNIX_FD, &fd,
 							DBUS_TYPE_INVALID);
 
diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 49661a7..57ba0fd 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -350,7 +350,7 @@ static gboolean initialize_caps(struct mcap_mcl *mcl)
 	clock_gettime(CLK, &t1);
 	read_btclock_retry(mcl, &btclock, &btaccuracy);
 
-	/* Do clock read a number of times and measure latency */
+	/* Read clock a number of times and measure latency */
 	avg = 0;
 	i = 0;
 	retries = MAX_RETRIES;
-- 
1.7.0.4

