Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/3] Add get Immediate Alert for Proximity Monitor
Date: Wed,  3 Aug 2011 10:46:07 -0300
Message-Id: <1312379168-14795-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Extends GetProperties method of the Proximity Monitor adding
ImmediateAlertLevel property when Path Loss and/or Find Me is enabled
---
 proximity/monitor.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 537e389..7e28b39 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -258,6 +258,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 		dict_append_entry(&dict, "LinkLossAlertLevel",
 				DBUS_TYPE_STRING, &monitor->linklosslevel);
 
+	if (monitor->enabled.findme || monitor->enabled.pathloss)
+		dict_append_entry(&dict, "ImmediateAlertLevel",
+				DBUS_TYPE_STRING, &monitor->linklosslevel);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
-- 
1.7.6

