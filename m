Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Describe the new debug keys command and setting
Date: Fri, 31 Jan 2014 12:19:28 -0800
Message-Id: <1391199568-55855-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 44ff12676180..a32237ae26b3 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -212,6 +212,7 @@ Read Controller Information Command
 		10	Low Energy
 		11	Advertising
 		12	Secure Connections
+		13	Debug Keys
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -1423,6 +1424,28 @@ Set Secure Connections Command
 				Invalid Index
 
 
+Set Debug Keys Command
+======================
+
+	Command Code:		0x002E
+	Controller Index:	<controller id>
+	Command Parameters:	Debug_Keys (1 Octet)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command is  used to tell the kernel whether to accept the
+	usage of debug keys or not. The allowed values for this parameter
+	are 0x00 and 0x01. All other values will return an Invalid Parameters
+	response.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.8.5.3

