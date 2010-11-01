Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] [RFC] Add Application property to HealthChannel
Date: Mon,  1 Nov 2010 16:16:22 -0200
Message-Id: <1288635382-2032-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the Application property to HealthChannel, which
allows to unambiguously relate a channel to an application.

This property is useful when there are several processes interested
in accepting HealthChannels but device address is not sufficient
criteria to engage upon, or ignore, the ChannelConnected signal.
Having the application path allows to determine role and data type,
in the context of the process that has created that application.

Also, channel path skeleton is fixed in documentation, in order to
reflect atual implementation.
---
 doc/health-api.txt |    8 ++++++--
 health/hdp.c       |    3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 89d5ff9..a0a1685 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -119,8 +119,7 @@ Properties:
 
 Service		org.bluez
 Interface	org.bluez.HealthChannel
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
-							hdp_YYYY/channel_ZZ
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/chanZZZ
 
 Only the process that created the data channel or the creator of the
 HealthApplication that received it will be able to call this methods.
@@ -160,3 +159,8 @@ Properties:
 
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

