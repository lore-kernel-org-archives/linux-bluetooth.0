Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 2/2] Fix coding style and comment
Date: Mon, 25 Oct 2010 14:28:44 -0200
Message-Id: <1288024124-24492-2-git-send-email-epx@signove.com>
In-Reply-To: <1288024124-24492-1-git-send-email-epx@signove.com>
References: <1288024124-24492-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |    2 +-
 health/mcap_sync.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index eb27613..7332cd5 100644
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

