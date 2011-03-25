Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/2] Fix memory leak if an error occurs when a data channel is reconnected.
Date: Fri, 25 Mar 2011 18:39:21 +0100
Message-Id: <1301074762-26844-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 3c2dce1..7a4b219 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -514,9 +514,9 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 		reply = g_dbus_create_error(dc_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"Cannot get file descriptor");
-
-	reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD, &fd,
-							DBUS_TYPE_INVALID);
+	else
+		reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD,
+							&fd, DBUS_TYPE_INVALID);
 	g_dbus_send_message(dc_data->conn, reply);
 }
 
-- 
1.7.4.1

