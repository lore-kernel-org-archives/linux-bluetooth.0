Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/3] Add get Path Loss RSSI signal level
Date: Wed,  3 Aug 2011 10:46:08 -0300
Message-Id: <1312379168-14795-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Extends GetProperties method of the Proximity Monitor adding SignalLevel
Property. Possible values: "unknown", "good", "regular", "weak".
"unknown" will be returned if the link is disconnected.
---
 proximity/monitor.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 7e28b39..3b90df5 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -60,6 +60,7 @@ struct monitor {
 	struct enabled enabled;
 	char *linklosslevel;		/* Link Loss Alert Level */
 	char *immediatelevel;		/* Immediate Alert Level */
+	char *signallevel;		/* Path Loss RSSI level */
 };
 
 static inline int create_filename(char *buf, size_t size,
@@ -262,6 +263,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 		dict_append_entry(&dict, "ImmediateAlertLevel",
 				DBUS_TYPE_STRING, &monitor->linklosslevel);
 
+	if (monitor->enabled.pathloss)
+		dict_append_entry(&dict, "SignalLevel",
+				DBUS_TYPE_STRING, &monitor->signallevel);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
@@ -330,6 +335,7 @@ static void monitor_destroy(gpointer user_data)
 	btd_device_unref(monitor->device);
 	g_free(monitor->linklosslevel);
 	g_free(monitor->immediatelevel);
+	g_free(monitor->signallevel);
 	g_free(monitor);
 }
 
@@ -349,6 +355,7 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
 	monitor->linklosslevel = (level ? : g_strdup("none"));
+	monitor->signallevel = g_strdup("unknown");
 	monitor->enabled.linkloss = linkloss;
 	monitor->enabled.pathloss = pathloss;
 	monitor->enabled.findme = findme;
-- 
1.7.6

