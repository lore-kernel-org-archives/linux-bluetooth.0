Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [RFC PATCH] doc/mgmt-api: Add appearance command and event specification
Date: Tue, 23 Aug 2016 13:55:34 +0200
Message-Id: <1471953334-469-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 3f593f9..f7e760d 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2811,6 +2811,31 @@ Start Limited Discovery Command
 				Invalid Index
 
 
+Set Appearance Command
+======================
+
+	Command Code:		0x0042
+	Controller Index:	<controller id>
+	Command Parameters:	Appearance (2 Octets)
+	Return Parameters:	Appearance (2 Octets)
+
+	This command is used to set the appearance value of a controller.
+
+	This command can be used when the controller is not 
+	powered and all settings will be programmed once powered.
+
+	The value of appearance will be remembered when switching
+	the controller off and back on again. So the appearance only
+	have to be set once when a new controller is found and will
+	stay until removed.
+
+	This command generates a Command Complete event on success
+	or a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -3656,3 +3681,17 @@ Advertising Removed Event
 
 	The event will only be sent to management sockets other than the
 	one through which the command was sent.
+
+
+Appearance Changed Event
+========================
+
+	Event Code:		0x0025
+	Controller Index:	<controller id>
+	Event Parameters:	Appearance (2 Octets)
+
+	This event indicates that the appearance of the controller has
+	changed.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
-- 
2.7.4

