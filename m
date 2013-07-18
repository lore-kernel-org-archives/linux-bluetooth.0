Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] lib: Remove duplicated HSP_HS_UUID definition
Date: Wed, 17 Jul 2013 22:20:09 -0400
Message-Id: <1374114009-23434-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is an identical definition on the same header file (next to
HSP_AG_UUID).
---
 lib/uuid.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 1e8188a..95e5a9a 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -86,7 +86,6 @@ extern "C" {
 #define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805f9b34fb"
 #define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
 
-#define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
 #define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
 
 #define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
-- 
1.7.9.5

