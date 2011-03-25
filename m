Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/2] Emit missing signal when data channel is reconnected.
Date: Fri, 25 Mar 2011 18:39:22 +0100
Message-Id: <1301074762-26844-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1301074762-26844-1-git-send-email-sancane@gmail.com>
References: <1301074762-26844-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reconnections of data channels should be indicated to others
applications by using the appropriate signal.
---
 health/hdp.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 7a4b219..7fed483 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -510,14 +510,23 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 	}
 
 	fd = mcap_mdl_get_fd(dc_data->hdp_chann->mdl);
-	if (fd < 0)
+	if (fd < 0) {
 		reply = g_dbus_create_error(dc_data->msg,
 						ERROR_INTERFACE ".HealthError",
 						"Cannot get file descriptor");
-	else
-		reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD,
+		g_dbus_send_message(dc_data->conn, reply);
+		return;
+	}
+
+	reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD,
 							&fd, DBUS_TYPE_INVALID);
 	g_dbus_send_message(dc_data->conn, reply);
+
+	g_dbus_emit_signal(dc_data->conn,
+			device_get_path(dc_data->hdp_chann->dev->dev),
+			HEALTH_DEVICE, "ChannelConnected",
+			DBUS_TYPE_OBJECT_PATH, &dc_data->hdp_chann->path,
+			DBUS_TYPE_INVALID);
 }
 
 static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
-- 
1.7.4.1

