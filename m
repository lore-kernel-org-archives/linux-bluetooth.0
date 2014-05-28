Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/2] android/pics: Adjust PICS for GATT
Date: Wed, 28 May 2014 14:25:25 +0200
Message-Id: <1401279926-19312-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since there is no support for 'Read Multiple Characteristic
Values' for both server and client, respective PICS should be set
to 'False'.
---
 android/pics-gatt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
index a648846..a77aedb 100644
--- a/android/pics-gatt.txt
+++ b/android/pics-gatt.txt
@@ -58,7 +58,7 @@ TSPC_GATT_3_7	True		Client: Discover All Characteristic Descriptors
 TSPC_GATT_3_8	True		Client: Read Characteristic Value (C.1)
 TSPC_GATT_3_9	True		Client: Read using Characteristic UUID (C.1)
 TSPC_GATT_3_10	True		Client: Read Long Characteristic Values (C.1)
-TSPC_GATT_3_11	True		Client: Read Multiple Characteristic
+TSPC_GATT_3_11	False (*)	Client: Read Multiple Characteristic
 					Values (C.1)
 TSPC_GATT_3_12	True		Client: Write without Response (C.1)
 TSPC_GATT_3_13	True		Client: Signed Write Without Response (C.1)
@@ -140,7 +140,7 @@ TSPC_GATT_4_7	True		Server: Discover All Characteristic
 TSPC_GATT_4_8	True		Server: Read Characteristic Value (M)
 TSPC_GATT_4_9	True		Server: Read using Characteristic UUID (M)
 TSPC_GATT_4_10	True		Server: Read Long Characteristic Values (C.4)
-TSPC_GATT_4_11	True		Server: Read Multiple Characteristic
+TSPC_GATT_4_11	False (*)	Server: Read Multiple Characteristic
 					Values (C.4)
 TSPC_GATT_4_12	True		Server: Write without Response (C.2)
 TSPC_GATT_4_13	False (*)	Server: Signed Write Without Response (C.4)
-- 
1.8.5.3

