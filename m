Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pics: change AVRCP to 1.5
Date: Thu,  6 Mar 2014 09:38:40 +0100
Message-Id: <1394095120-17044-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simple PICS switch from AVRCP 1.3 to 1.5
---
 android/pics-avrcp.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
index 2be0746..69328de 100644
--- a/android/pics-avrcp.txt
+++ b/android/pics-avrcp.txt
@@ -448,9 +448,9 @@ C.15: Mandatory if Basic Group Navigation Feature supported. If any item
 Parameter Name    Selected	Description
 -------------------------------------------------------------------------------
 TSPC_AVRCP_7b_1   False		TG: AVRCP v1.0 (C.1)
-TSPC_AVRCP_7b_2   True (*)	TG: AVRCP v1.3 (C.1)
+TSPC_AVRCP_7b_2   False		TG: AVRCP v1.3 (C.1)
 TSPC_AVRCP_7b_3   False		TG: AVRCP v1.4 (C.1)
-TSPC_AVRCP_7b_4   False		TG: AVRCP v1.5 (C.1)
+TSPC_AVRCP_7b_4   True (*)	TG: AVRCP v1.5 (C.1)
 TSPC_AVRCP_7b_5   False		TG: AVRCP v1.6 (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the profile versions.
-- 
1.8.5.3

