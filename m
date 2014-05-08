Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	andrzej.kaczmarek@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3] mgmt-api: Add support to get connection information
Date: Thu,  8 May 2014 14:59:59 +0200
Message-Id: <1399553999-14566-1-git-send-email-lukasz.rymanowski@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces Get Connection Information command.
---

v2: Changed Command name and add Flags into the response
v3: Added TXPowerMax into the response based on the comments we got.

 doc/mgmt-api.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cd5cd24..8345048 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1679,6 +1679,45 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Get Connection Information Command
+==================================
+
+	Command Code:		0x0031
+	Controller Index:       <controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Data_Type (4 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				RSSI (1 Octet)
+				TXPowerMax (1 Octet)
+				Flags (4 Octets)
+				EIR_Data_Length (2 Octets)
+				EIR_Data (0-65535 Octets)
+
+	This command is used to get connection information.
+
+	Data_Type parameter is a bitmask with currently the following available
+	bits:
+
+		0	TX Power
+
+	All the other bits are reserved and shall be set to 0. Unknown bits are
+	ignored.
+
+	All the requested Data_Type information are returned in EIR_Data.
+
+	Flags are reserved for the future use.
+
+	This command generates a Command Complete event on success and
+	on failure.
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
1.8.4
