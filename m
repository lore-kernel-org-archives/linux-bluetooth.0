Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/2] Add Application property to HealthChannel
Date: Wed,  3 Nov 2010 12:06:27 -0200
Message-Id: <1288793188-11514-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the Application property to HealthChannel, which
allows to unambiguously relate a channel to an application.

This property is useful when there are several processes interested
in accepting HealthChannels but device address is not sufficient
criteria to engage upon, or ignore, the ChannelConnected signal.
Having the application path allows to determine role and data type,
in the context of the process that has created that application.
---
 doc/health-api.txt |    5 +++++
 health/hdp.c       |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 89d5ff9..3034666 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -160,3 +160,8 @@ Properties:
 
 		Identifies the Remote Device that is connected with. Maps with
 		a HealthDevice object.
+
+	object Application [readonly]
+
+		Identifies the HealthApplication to which this channel is
+		related to (which indirectly defines its role and data type).
diff --git a/health/hdp.c b/health/hdp.c
index be30204..1eba8e1 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -423,6 +423,9 @@ static DBusMessage *channel_get_properties(DBusConnection *conn,
 	path = device_get_path(chan->dev->dev);
 	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH, &path);
 
+	path = chan->app->path;
+	dict_append_entry(&dict, "Application", DBUS_TYPE_OBJECT_PATH, &path);
+
 	if (chan->config == HDP_RELIABLE_DC)
 		type = g_strdup("Reliable");
 	else
-- 
1.7.0.4

