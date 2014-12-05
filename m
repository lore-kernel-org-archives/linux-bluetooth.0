Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] doc/mgmt-api: Add support to add/remove advertising data instance
Date: Fri,  5 Dec 2014 14:29:12 +0100
Message-Id: <1417786152-19742-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Multi advertising is design for embedded devices having multiple GATT
application running on it. Since Advertising data are size limited there
is a need to have a way to make sure that each application will be
advertised and in the same time visible for GATT Client application.

It has been noticed that there is many GATT clients doing filtering on
Service UUIDs contained in advertising data.

Since this command is design for embedded devices, we allow to choose
whether given data element shall be in advertising data or scan
response.

This patch also enhance supported settings with multi advertising bit
which indicates to user space that kernel supports that.
---
 doc/mgmt-api.txt | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index fed41a9..8a947f1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -267,6 +267,7 @@ Read Controller Information Command
 		12	Debug Keys
 		13	Privacy
 		14	Controller Configuration
+		15	Multi Advertising
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -2214,6 +2215,77 @@ Start Service Discovery Command
 				Invalid Index
 
 
+Add Advertising Data Instance
+=============================
+
+	Command Code:		0x003b
+	Controller Index:	<controller id>
+	Command Parameters:
+				Flags (4 Octet)
+				Num_Of_Data_Elements (1 Octet)
+				Data_Element_1 {
+					Flags (4 Octet)
+					Type (1 Octet)
+					Value_Length (1 Octet)
+					Value (Variable)
+				}
+				Data_Element_2 { }
+				...
+
+	Return Parameters:	Advertising_Instance_ID (2 Octets)
+
+	This command allows to set User Advertising Data Instance which are advertised
+	in such manner so each element has its own advertising time slice then it
+	expires and next item gets its advertising time slice.
+
+	Note that kernel has own instance which always gets its advertising time
+	slice.
+
+	Note that maximum length of Advertising Data and Scan Response is
+	specified to 31 bytes each.
+
+	Possible values Flags parameter are a bit-wise or of the following bits:
+		0	Include Short Name
+		1	Include TX Power
+
+	Possible values for Data Element Flags are a bit-wise or of the following
+	bits:
+		0	Force include into advertising data
+		1	Force include into scan response
+
+	Possible values for the Type parameter are specified by Bluetooth SIG and can
+	be found in Assigned Number section for Generic Access Profile.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered and advertising is enabled.
+
+	Provided advertising data instances are persistent over power down/up toggles.
+
+	Possible errors:	Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
+Remove Advertising Data Instance
+================================
+
+	Command Code:		0x003c
+	Controller Index:	<controller id>
+	Command Parameters:	Advertising_Instance_ID (1 Octet)
+	Return Parameters:
+
+	This command is use to remove user advertising instance created with
+	Add User Advertising Instance
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+
+	Possible errors:	Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.8.4

