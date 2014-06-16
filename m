Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/pts: Disable OOB from Secure Manager PICS
Date: Tue, 17 Jun 2014 00:39:56 +0200
Message-Id: <1402958397-1415-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-sm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-sm.txt b/android/pics-sm.txt
index 3060d40..239f568 100644
--- a/android/pics-sm.txt
+++ b/android/pics-sm.txt
@@ -25,7 +25,7 @@ Parameter Name	Selected	Description
 TSPC_SM_2_1	True		Authenticated MITM protection (O)
 TSPC_SM_2_2	True		Unauthenticated no MITM protection (C.1)
 TSPC_SM_2_3	True		No security requirements (M)
-TSPC_SM_2_4	True		OOB supported (O)
+TSPC_SM_2_4	False		OOB supported (O)
 -------------------------------------------------------------------------------
 C.1: If TSPC_SM_2_1 is supported then Mandatory, else Optional
 -------------------------------------------------------------------------------
@@ -45,7 +45,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_SM_4_1	True		Just Works (O)
 TSPC_SM_4_2	True		Passkey Entry (C.1)
-TSPC_SM_4_3	True		Out of Band (C.1)
+TSPC_SM_4_3	False		Out of Band (C.1)
 -------------------------------------------------------------------------------
 C.1: If TSPC_SM_2_1 is supported, at least one of these features shall be
 	supported.
-- 
1.8.4

