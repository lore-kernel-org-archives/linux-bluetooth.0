Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 6/6] Return LinkLossAlertLevel if enabled
Date: Thu, 28 Jul 2011 11:43:43 -0300
Message-Id: <1311864223-16337-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311803586-5405-7-git-send-email-claudio.takahasi@openbossa.org>
References: <1311803586-5405-7-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GetProperties method of Proximity Monitor should not append the
LinkLossAlertLevel property if the LinkLoss service is not enabled
in the configuration file.
---
 proximity/monitor.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index dc480ab..d068142 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -230,8 +230,9 @@ static DBusMessage *get_properties(DBusConnection *conn,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	dict_append_entry(&dict, "LinkLossAlertLevel",
-			DBUS_TYPE_STRING, &monitor->linklosslevel);
+	if (monitor->enabled.linkloss)
+		dict_append_entry(&dict, "LinkLossAlertLevel",
+				DBUS_TYPE_STRING, &monitor->linklosslevel);
 
 	dbus_message_iter_close_container(&iter, &dict);
 
-- 
1.7.6

