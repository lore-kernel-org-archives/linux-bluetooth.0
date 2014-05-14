Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v6] doc: Add description for Get Connection Information command
Date: Wed, 14 May 2014 15:28:26 +0200
Message-ID: <1400074106-8545-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

This patch introduces Get Connection Information command.
---
 doc/mgmt-api.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cd5cd24..b691ae0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1679,6 +1679,35 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Get Connection Information Command
+==================================
+
+	Command Code:		0x0031
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				RSSI (1 Octet)
+				TX_Power (1 Octet)
+				Max_TX_Power (1 Octet)
+
+	This command is used to get connection information.
+
+	TX_Power and Max_TX_Power can be set to 127 if values are invalid or
+	unknown.
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

