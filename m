Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pics: Update PICS to PTS 5.0 for DID
Date: Wed,  8 Jan 2014 12:01:17 +0200
Message-Id: <1389175277-28726-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove PICS settings which are not applicable in PTS
---
 android/pics-did.txt | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/android/pics-did.txt b/android/pics-did.txt
index 8f92bc1..58cee41 100644
--- a/android/pics-did.txt
+++ b/android/pics-did.txt
@@ -1,21 +1,13 @@
 DID PICS for the PTS tool.
 
+PTS version: 5.0
+
 * - different than PTS defaults
 # - not yet implemented/supported
 
 M - mandatory
 O - optional
 
-		Version
--------------------------------------------------------------------------------
-Parameter Name	Selected	Description
--------------------------------------------------------------------------------
-TSPC_DID_0_1	False		Device ID 1.2 (C.1)
-TSPC_DID_0_2	True		Device ID 1.3 (C.1)
--------------------------------------------------------------------------------
-C.1: It is mandatory to support one of the profile versions.
--------------------------------------------------------------------------------
-
 
 		SDP Requirements
 -------------------------------------------------------------------------------
-- 
1.8.3.2

