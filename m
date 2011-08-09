Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Write Link Loss Alert level if connected
Date: Tue,  9 Aug 2011 13:47:43 -0300
Message-Id: <1312908464-20064-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When SetProperty gets called for LinkLossAlertLevel, the alert level
can be written in the remote is the link is up.
---
 proximity/monitor.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 55d3985..c32ddec 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -396,6 +396,9 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
 				DBUS_TYPE_STRING, &monitor->linklosslevel);
 
+	if (monitor->attrib)
+		write_alert_level(monitor);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.6

