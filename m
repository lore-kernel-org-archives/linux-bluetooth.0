Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 1/3] mgmt-api: Add Start Remote RSSI Command
Date: Thu, 27 Mar 2014 22:10:27 +0100
Message-ID: <1395954629-16156-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 78f0bd2..28e7845 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1668,6 +1668,38 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Start Read Remote RSSI Command
+==============================
+
+	Command Code:		0x0031
+	Controller Index:       <controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Threshold (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Current_RSSI (1 Octet)
+
+	This command is used to start read remote rssi with given
+	threshold. On this command current remote RSSI is read and
+	is used as starting point for messurements. If threshold is
+	exceeded then Remote RSSI event is sent.
+
+	If threshold is 0 then no Remote RSSI event is generated but
+	only Command Complete with current RSSI.
+
+	This command can be used only when controller is powered on.
+
+	This command generates a Command Complete event on success
+	and on failure.
+
+	Possible errors:	Not Connected
+				Busy
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.8.4

