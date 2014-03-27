Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 2/3] mgmt-api: Add Stop Read Remote RSSI Command
Date: Thu, 27 Mar 2014 22:10:28 +0100
Message-ID: <1395954629-16156-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395954629-16156-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395954629-16156-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 28e7845..6d3b86b 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1700,6 +1700,27 @@ Start Read Remote RSSI Command
 				Invalid Index
 
 
+Stop Read Remote RSSI Command
+=============================
+
+	Command Code:		0x0032
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Adress_Type (1 Octet)
+
+	Return Parametes:
+
+	This command is used to stop read remote RSSI started with
+	Start Read Remote RSSI command.
+
+	This command generates Command Complete event on success
+	and on failure.
+
+	Possible errors:	Rejected
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.8.4

