Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH BlueZ 4/5] Emit a signal when Link Loss Alert Level changes
Date: Tue, 26 Jul 2011 13:53:15 -0300
Message-Id: <1311699196-16472-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

There is only one instance of the Alert level in the Link Loss service.
Signal is emitted to notify other local clients that the alert level
has changed. Necessary if the proximity monitor wants to notify the user
and the application responsible for alerting is another application.
---
 proximity/monitor.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 3b2a96e..8bcd4a3 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -110,6 +110,10 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	bacpy(&dba, BDADDR_ALL);
 	write_proximity_config(&sba, &dba, "LinkLossAlertLevel", level);
 
+	emit_property_changed(conn, PROXIMITY_PATH,
+				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
+				DBUS_TYPE_STRING, &monitor->linklosslevel);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.6

