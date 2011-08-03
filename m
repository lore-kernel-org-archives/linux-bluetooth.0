Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 6/7] Add function to check invalid alert level value
Date: Wed,  3 Aug 2011 15:41:46 -0300
Message-Id: <1312396907-14524-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/monitor.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index ca19a8f..a6bdf34 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -181,6 +181,13 @@ static void attio_disconnected_cb(gpointer user_data)
 	monitor->attrib = NULL;
 }
 
+static gboolean level_is_valid(const char *level)
+{
+	return (g_str_equal("none", level) ||
+			g_str_equal("mild", level) ||
+			g_str_equal("high", level));
+}
+
 static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 						const char *level, void *data)
 {
@@ -189,8 +196,7 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	const char *path = device_get_path(device);
 	bdaddr_t sba, dba;
 
-	if (!g_str_equal("none", level) && !g_str_equal("mild", level) &&
-			!g_str_equal("high", level))
+	if (!level_is_valid(level))
 		return btd_error_invalid_args(msg);
 
 	if (g_strcmp0(monitor->linklosslevel, level) == 0)
@@ -217,8 +223,7 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 	struct monitor *monitor = data;
 	const gchar *path = device_get_path(monitor->device);
 
-	if (!g_str_equal("none", level) && !g_str_equal("mild", level) &&
-			!g_str_equal("high", level))
+	if (!level_is_valid(level))
 		return btd_error_invalid_args(msg);
 
 	if (g_strcmp0(monitor->immediatelevel, level) == 0)
-- 
1.7.6

