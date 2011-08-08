Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 10/11] Write Immediate Alert if connected
Date: Mon,  8 Aug 2011 15:46:49 -0300
Message-Id: <1312829210-6781-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When SetProperty for ImmediateAlertLevel is called, write operation to
update the characteristic in the Immediate Alert Service can be sent
if the connection is established.
---
 proximity/monitor.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 2133ad7..b59e7a0 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -432,6 +432,8 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 							attio_connected_cb,
 							attio_disconnected_cb,
 							monitor);
+	else if (monitor->attrib)
+		write_immediate_alert(monitor);
 
 	return dbus_message_new_method_return(msg);
 }
-- 
1.7.6

