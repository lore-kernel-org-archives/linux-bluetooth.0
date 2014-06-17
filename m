Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: Adjust PICS for HDP
Date: Tue, 17 Jun 2014 18:13:54 +0300
Message-Id: <1403018034-19319-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-hdp.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pics-hdp.txt b/android/pics-hdp.txt
index 3d8020d..3b4cce8 100644
--- a/android/pics-hdp.txt
+++ b/android/pics-hdp.txt
@@ -47,7 +47,7 @@ TSPC_HDP_2_7	True (*)	Supports General Inquiry (C.5) (C.4)
 TSPC_HDP_2_8	True		Supports Acceptance of Bonding requests (M)
 TSPC_HDP_2_9	True (*)	Supports Initiation of Bonding (O)
 TSPC_HDP_2_10	True (*)	Supports Extended Inquiry Response (C.7)
-TSPC_HDP_2_11	True (*)	Supports use of Health Class of Device (O)
+TSPC_HDP_2_11	False		Supports use of Health Class of Device (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_HDP_2_9 is supported, otherwise Optional.
 C.2: Mandatory if Security Mode 2, 3, or 4 is supported, otherwise Optional.
@@ -189,9 +189,9 @@ TSPC_HDP_8_5	True		Supports Acceptance of Encryption request (M)
 TSPC_HDP_8_6	True		Supports Initiation of Encryption (M) (C.3)
 TSPC_HDP_8_7	True		Supports General Inquiry (M) C.4)
 TSPC_HDP_8_8	True		Supports Acceptance of Bonding requests (M)
-TSPC_HDP_8_9	Ture (*)	Supports Initiation of Bonding (O)
+TSPC_HDP_8_9	True (*)	Supports Initiation of Bonding (O)
 TSPC_HDP_8_10	True (*)	Supports Extended Inquiry Response (C.5) (C.6)
-TSPC_HDP_8_11	True (*)	Supports use of Health Class of Device (O)
+TSPC_HDP_8_11	Fale		Supports use of Health Class of Device (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_HDP_8_9 is supported, otherwise Optional.
 C.2: Mandatory if Security Mode 2, 3, or 4 is supported, otherwise Optional.
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

