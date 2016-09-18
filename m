Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH v2 1/5] doc/mgmt-api: Add Set Appearance command specification
Date: Sun, 18 Sep 2016 12:34:37 +0200
Message-Id: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

---
 doc/mgmt-api.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 2b8a81d..0cc747a 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2885,6 +2885,31 @@ Read Extended Controller Information Command
 				Invalid Index
 
 
+Set Appearance Command
+======================
+
+	Command Code:		0x0042
+	Controller Index:	<controller id>
+	Command Parameters:	Appearance (2 Octets)
+	Return Parameters:
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
 
-- 
2.7.4

