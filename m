Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add management command to get clock information
Date: Fri, 27 Jun 2014 11:52:24 +0200
Message-Id: <1403862744-38756-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 85bb7a44265f..283df8bc0aa1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1829,6 +1829,47 @@ Load Connection Parameters Command
 				Not Supported
 
 
+Get Clock Information Command
+=============================
+
+	Command Code:		0x0033
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Local_Clock (4 Octets)
+				Piconet_Clock (4 Octets)
+				Accuracy (2 Octets)
+				Clock_Offset (2 Octets)
+
+	This command is used to get local and piconet clock information.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	Reserved (not in use)
+		2	Reserved (not in use)
+
+	The Accuracy can be set to 0xffff which means the value is unknown.
+
+	The Clock_Offset can be set to 0x0000 when the local controller
+	is a slave.
+
+	If the Address is set to 00:00:00:00:00:00, then only the
+	Local_Clock field has a valid value. The Piconet_Clock, Accuracy
+	and Clock_Offset fields are invalid and shall be ignored.
+
+	This command generates a Command Complete event on success and
+	on failure. In case of failure only Address and Address_Type fields
+	are valid and values of remaining parameters are considered invalid
+	and shall be ignored.
+
+	Possible errors:	Not Connected
+				Not Powered
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.9.3

