Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 3/3] mgmt-api: Add Remote RSSI Event
Date: Thu, 27 Mar 2014 22:10:29 +0100
Message-ID: <1395954629-16156-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395954629-16156-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395954629-16156-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 6d3b86b..2ba2a5b 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2310,3 +2310,33 @@ New Signature Resolving Key Event
 
 	The provided Address and Address_Type are the identity of
 	a device. So either its public address or static random address.
+
+
+Remote RSSI Event
+=================
+
+	Event Code:		0x0020
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Active (1 Octet)
+				RSSI (1 Octet)
+
+	This event indicates that a remote RSSI has exceed threshold
+	given on Start Read Remote RSSI command.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	The valid values for the Active parameter are 0x01
+	(RSSI read active) and 0x00 (RSSI read stopped).
+
+	Possible RSSI values:
+		BR/EDR
+			Range: -128 <= N <= 127 (signed integer)
+			Units: dB
+		LE:
+			Range: -127 to 20, 127 (signed integer)
+			Units: dBm
-- 
1.8.4

