Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Check HealthApplication path before trying to destroy it
Date: Wed, 10 Nov 2010 00:11:48 -0200
Message-Id: <1289355108-4041-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 1eba8e1..b141fe7 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -376,6 +376,12 @@ static DBusMessage *manager_destroy_application(DBusConnection *conn,
 
 	l = g_slist_find_custom(applications, path, cmp_app);
 
+	if (!l)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call, "
+					"no such application");
+
 	app = l->data;
 	applications = g_slist_remove(applications, app);
 
-- 
1.7.0.4

