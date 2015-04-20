Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add command for limited discoverable procedure
Date: Mon, 20 Apr 2015 20:02:18 +0200
Message-Id: <1429552938-71139-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 7a5d33f0f5c0..4b97aad3c6cb 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2655,6 +2655,51 @@ Remove Advertising Command
 				Invalid Index
 
 
+Start Limited Discovery Command
+===============================
+
+	Command Code:		0x0040
+	Controller Index:	<controller id>
+	Command Parameters:	Address_Type (1 Octet)
+	Return Parameters:	Address_Type (1 Octet)
+
+	This command is used to start the process of discovering remote
+	devices using the limited discovery procedure. A Device Found event
+	will be sent for each discovered device.
+
+	Possible values for the Address_Type parameter are a bit-wise or
+	of the following bits:
+
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	By combining these e.g. the following values are possible:
+
+		1	BR/EDR
+		6	LE (public & random)
+		7	BR/EDR/LE (interleaved discovery)
+
+	The limited discovery uses active scanning for Low Energy scanning
+	and will search for devices with the limited discoverabilty flag
+	configured. On BR/EDR it uses LIAC and filters on the limited
+	discoverabilty flag of the class of device.
+
+	When the discovery procedure starts the Discovery event will
+	notify this similar to Start Discovery.
+
+	This command can only be used when the controller is powered.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Busy
+				Not Supported
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
2.1.0

