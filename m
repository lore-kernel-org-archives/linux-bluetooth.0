Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: andrzej.kaczmarek@tieto.com,
	marcel@holtmann.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] mgmt-api: Add support to get connection characteristics
Date: Wed,  7 May 2014 01:58:10 +0200
Message-Id: <1399420690-21653-1-git-send-email-lukasz.rymanowski@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces Get Connection Characteristics command.
---
 doc/mgmt-api.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cd5cd24..5d31a90 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1679,6 +1679,42 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Get Connection Characteristics Command
+======================================
+
+	Command Code:		0x0031
+	Controller Index:       <controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Requested_Characteristics (4 Octet)
+
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				RSSI (1 Octet)
+				EIR_Data_Length (2 Octets)
+				EIR_Data (0-65535 Octets)
+
+	This command is used to get connection characteristics information.
+
+	Requested_Characteristics parameter is a bitmask with currently the
+	following available bits:
+
+		0	RSSI
+		1	TX Power
+
+	All the requested characteristics other than RSSI are returned in
+	EIR_Data.
+
+	This command generates a Command Complete event on success and
+	on failure.
+
+	Possible errors:	Busy
+				Not Connected
+				Not Powered
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.8.4
