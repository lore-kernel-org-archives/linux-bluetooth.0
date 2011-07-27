Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 5/6] Return an error if LinkLoss is disabled
Date: Wed, 27 Jul 2011 18:53:05 -0300
Message-Id: <1311803586-5405-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes SetProperty method of the Proximity Monitor to verify if the
LinkLoss service is enabled before allowing to change the alert level.
Not available error is returned if LinkLoss service is disabled in the
Proximity configuration file.
---
 proximity/monitor.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 6cea5df..5aa954d 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -240,6 +240,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 static DBusMessage *set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
+	struct monitor *monitor = data;
 	const char *property;
 	DBusMessageIter iter;
 	DBusMessageIter sub;
@@ -259,6 +260,9 @@ static DBusMessage *set_property(DBusConnection *conn,
 	dbus_message_iter_recurse(&iter, &sub);
 
 	if (g_str_equal("LinkLossAlertLevel", property)) {
+		if (monitor->enabled.linkloss == FALSE)
+			return btd_error_not_available(msg);
+
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
 			return btd_error_invalid_args(msg);
 
-- 
1.7.6

