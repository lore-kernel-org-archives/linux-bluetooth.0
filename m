Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android/tester: Adapter properties can come in any order
Date: Fri, 11 Apr 2014 09:41:26 +0200
Message-Id: <1397202087-1203-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
References: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no point in forcing specific order of adapter properties (with
exception of address being first).
---
 android/android-tester.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index e7a8280..7989f14 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1432,37 +1432,37 @@ static struct priority_property enable_done_props[] = {
 	.prop.type = BT_PROPERTY_UUIDS,
 	.prop.len = sizeof(enable_done_uuids_val),
 	.prop.val = &enable_done_uuids_val,
-	.prio = 3,
+	.prio = 2,
 	},
 	{
 	.prop.type = BT_PROPERTY_CLASS_OF_DEVICE,
 	.prop.len = sizeof(uint32_t),
 	.prop.val = NULL,
-	.prio = 4,
+	.prio = 2,
 	},
 	{
 	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
 	.prop.len = sizeof(enable_done_tod_val),
 	.prop.val = &enable_done_tod_val,
-	.prio = 5,
+	.prio = 2,
 	},
 	{
 	.prop.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
 	.prop.len = sizeof(enable_done_scanmode_val),
 	.prop.val = &enable_done_scanmode_val,
-	.prio = 6,
+	.prio = 2,
 	},
 	{
 	.prop.type = BT_PROPERTY_ADAPTER_BONDED_DEVICES,
 	.prop.len = 0,
 	.prop.val = NULL,
-	.prio = 7,
+	.prio = 2,
 	},
 	{
 	.prop.type = BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT,
 	.prop.len = sizeof(enable_done_disctimeout_val),
 	.prop.val = &enable_done_disctimeout_val,
-	.prio = 8,
+	.prio = 2,
 	},
 };
 
-- 
1.9.1

