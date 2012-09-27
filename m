Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 01/27] doc: Introduce Alert API
Date: Thu, 27 Sep 2012 14:36:10 -0400
Message-Id: <1348770996-12236-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This API will be implemented and initially used by Phone Alert Status
and Alert Notification GATT profiles (server role).
---
 Makefile.am       |    2 +-
 doc/alert-api.txt |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 doc/alert-api.txt

diff --git a/Makefile.am b/Makefile.am
index 315077f..a42544d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -385,7 +385,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
 		doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
-		doc/supported-features.txt
+		doc/supported-features.txt doc/alert-api.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/alert-api.txt b/doc/alert-api.txt
new file mode 100644
index 0000000..e58430c
--- /dev/null
+++ b/doc/alert-api.txt
@@ -0,0 +1,109 @@
+BlueZ D-Bus Alert API description
+*********************************
+
+Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
+
+Introduction
+------------
+
+Currently, there are two different GATT server profiles that depend on
+receiving alerts or notifications from the platform: Phone Alert Status (PASP)
+and Alert Notification (ANP). PASP is very specific to mobile phones, and also
+allows limited control to alerts (i.e. mute once or switch to a silent mode).
+
+This document presents a unified API that allows to register and notify alerts,
+and to control some alerts (using the provided agent object).
+
+
+Alert hierarchy
+===============
+
+Service		org.bluez
+Interface	org.bluez.Alert
+Object path	/org/bluez
+
+Methods		void RegisterAlert(string category, object agent)
+
+			Register a new alert category and an agent for it. This
+			means the application will be responsible for notifying
+			BlueZ of any alerts of that category, using the
+			NewAlert() method.
+
+			Supported ANP categories: simple, email, news, call,
+				missed_call, sms_mms, voice_mail, schedule,
+				high_priority, instant_message
+			Supported PASP categories: ringer, vibrate, display
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		void NewAlert(string category, uint16 count, string description)
+
+			Notify BlueZ of new alert(s) for the given category. The
+			description is relative to the last received alert and
+			can be sender name, caller ID, title, or other
+			information specific to the category.
+
+			For ringer, vibrate and display categories, valid
+			descriptions are "active" and "not active". Alerts from
+			ringer category also accept "enabled" and "disabled",
+			depending on whether ringer is in silent mode or not.
+
+			Description must not exceed 18 bytes when encoded in
+			UTF-8 format, otherwise an error is returned. If there
+			is no description, an empty string should be used.
+
+			The count argument contains the number of alerts not
+			yet acknowledged by the user on the UI. To save D-Bus
+			traffic, events that may generate multiple alerts at
+			the same time (like email, sms, news) should trigger a
+			single NewAlert().
+
+			If there are more than 254 new alerts, count must be
+			set to 255. PASP alerts should always set count to 1.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		void UnreadAlert(string category, uint16 count)
+
+			Some services (like SMS and e-mail) keep track of
+			number of unread items. This method allows to update
+			this counter, so peer devices can be notified using
+			Alert Notification Profile.
+
+			If there are more than 254 unread alerts, count must be
+			set to 255.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+Alert Agent hierarchy
+=====================
+
+Service		org.bluez
+Interface	org.bluez.AlertAgent
+Object path	freely definable
+
+Methods		void MuteOnce()
+
+			This method is only called if "ringer" alert category
+			is specified when registering the agent.
+
+			Mute the ringer once (e.g. during a incoming call). If
+			ringer is not active, does nothing.
+
+		void SetRinger(string mode)
+
+			This method is only called if "ringer" alert category
+			is specified when registering the agent.
+
+			Set ringer to the specified mode. If mode is "enabled",
+			ringer is set to the default mode, as defined by the
+			current active profile. If mode is "disabled", ringer
+			will not activate on incoming calls, until it is set
+			back to "enabled" mode.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		void Release()
+
+			Release this agent. At this point, it will not be used
+			by BlueZ anymore and can be destroyed by the owner.
-- 
1.7.9.5

