Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Adjust PICS for GATT
Date: Mon, 19 May 2014 15:21:32 +0200
Message-Id: <1400505692-5855-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we do not support SDP record for GATT we shall disable
respective PICS (6/3). Moreover patch disables support for
Attribute Protocol over BR/EDR.
---
 android/pics-gatt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
index f3e8199..a648846 100644
--- a/android/pics-gatt.txt
+++ b/android/pics-gatt.txt
@@ -29,7 +29,7 @@ C.4: Optional IF TSPC_GATT_1_2 is supported, otherwise Excluded
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_GATT_2_1	True		Attribute Protocol Supported over BR/EDR
+TSPC_GATT_2_1	False (*)	Attribute Protocol Supported over BR/EDR
 					(L2CAP fixed channel support) (C.1)
 TSPC_GATT_2_2	True		Attribute Protocol Supported over LE (C.2)
 -------------------------------------------------------------------------------
@@ -221,7 +221,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_GATT_6_2	True		Discover GATT Services using Service Discovery
 					Profile (C.1)
-TSPC_GATT_6_3	True		Publish SDP record for GATT services support
+TSPC_GATT_6_3	False  (*)	Publish SDP record for GATT services support
 					via BR/EDR (C.2)
 -------------------------------------------------------------------------------
 C.1: Mandatory IF TSPC_GATT_1_1 is supported, otherwise Excluded
-- 
1.8.5.3

