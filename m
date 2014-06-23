Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/pics-hogp: Fix having both types of discover set
Date: Mon, 23 Jun 2014 15:46:16 +0300
Message-Id: <1403527577-16254-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently the code discover by service handle and not by UUID.
---
 android/pics-hogp.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
index 81e182c..6544b54 100644
--- a/android/pics-hogp.txt
+++ b/android/pics-hogp.txt
@@ -330,10 +330,10 @@ TSPC_HOGP_13_1	True		Attribute Protocol supported over LE Transport
 				(M)
 TSPC_HOGP_13_2	True		Generic Attribute Profile Client (M)
 TSPC_HOGP_13_3	True		Discover All Primary Services (C.1)
-TSPC_HOGP_13_4	True		Discover Primary Services by Service UUID (C.1)
+TSPC_HOGP_13_4	False		Discover Primary Services by Service UUID (C.1)
 TSPC_HOGP_13_5	True		Find Included Services (M)
 TSPC_HOGP_13_6	True		Discover All Characteristics of a Service (C.2)
-TSPC_HOGP_13_7	True		Discover Characteristics by UUID (C.2)
+TSPC_HOGP_13_7	False		Discover Characteristics by UUID (C.2)
 TSPC_HOGP_13_8	True		Discover All Characteristic Descriptors (M)
 TSPC_HOGP_13_9	True		Read Characteristic Value (M)
 TSPC_HOGP_13_10	True		Read using Characteristic UUID (O)
-- 
1.9.3

