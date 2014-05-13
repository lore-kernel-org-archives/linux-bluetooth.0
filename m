Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5] mgmt-api: Add support to get connection information
Date: Tue, 13 May 2014 15:09:11 +0200
Message-Id: <1399986551-6419-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces Get Connection Information command.
---
v2: Changed Command name and add Flags into the response
v3: Added TXPowerMax into the response based on the comments we got.
v4: Fixed name to TX_Power_Max
v5: Removed EIR and Data Type. Only fixed values in the response.

 doc/mgmt-api.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cd5cd24..e51ba6c 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1679,6 +1679,32 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Get Connection Information Command
+==================================
+
+	Command Code:		0x0031
+	Controller Index:       <controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				RSSI (1 Octet)
+				TX_Power (1 Octet)
+				TX_Power_Max (1 Octet)
+
+	This command is used to get connection information.
+
+	TX_Power and TX_Power_Max are set to 127 if incorrect.
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

