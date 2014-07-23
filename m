Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/pts: Update PICS for GATT
Date: Wed, 23 Jul 2014 11:22:24 +0200
Message-Id: <1406107345-2510-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-gatt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
index 9cdbe85..0179d6d 100644
--- a/android/pics-gatt.txt
+++ b/android/pics-gatt.txt
@@ -29,7 +29,7 @@ C.4: Optional IF TSPC_GATT_1_2 is supported, otherwise Excluded
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GATT_2_1	False (*)	Attribute Protocol Supported over BR/EDR
+TSPC_GATT_2_1	True		Attribute Protocol Supported over BR/EDR
 					(L2CAP fixed channel support) (C.1)
 TSPC_GATT_2_2	True		Attribute Protocol Supported over LE (C.2)
 -------------------------------------------------------------------------------
@@ -221,7 +221,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GATT_6_2	True		Discover GATT Services using Service Discovery
 					Profile (C.1)
-TSPC_GATT_6_3	False (*)	Publish SDP record for GATT services support
+TSPC_GATT_6_3	True		Publish SDP record for GATT services support
 					via BR/EDR (C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory IF TSPC_GATT_1_1 is supported, otherwise Excluded
-- 
1.9.3

