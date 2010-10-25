Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/2] Fix fd comparison
Date: Mon, 25 Oct 2010 14:28:43 -0200
Message-Id: <1288024124-24492-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index fd3b1ca..eb27613 100644
--- a/health/hdp.c
+++ b/health/hdp.c
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
 
-- 
1.7.0.4

