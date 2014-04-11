Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] android/tester: Device properties can come in any order
Date: Fri, 11 Apr 2014 09:41:27 +0200
Message-Id: <1397202087-1203-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
References: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no point in forcing specific order of device properties.
---
 android/android-tester.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 7989f14..f7f3f31 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1864,37 +1864,31 @@ static struct priority_property remote_getprops_props[] = {
 	.prop.type = BT_PROPERTY_BDNAME,
 	.prop.val = &remote_get_properties_bdname_val,
 	.prop.len = sizeof(remote_get_properties_bdname_val) - 1,
-	.prio = 1,
 	},
 	{
 	.prop.type = BT_PROPERTY_UUIDS,
 	.prop.val = NULL,
 	.prop.len = 0,
-	.prio = 2,
 	},
 	{
 	.prop.type = BT_PROPERTY_CLASS_OF_DEVICE,
 	.prop.val = &remote_get_properties_cod_val,
 	.prop.len = sizeof(remote_get_properties_cod_val),
-	.prio = 3,
 	},
 	{
 	.prop.type = BT_PROPERTY_TYPE_OF_DEVICE,
 	.prop.val = &remote_get_properties_tod_val,
 	.prop.len = sizeof(remote_get_properties_tod_val),
-	.prio = 4,
 	},
 	{
 	.prop.type = BT_PROPERTY_REMOTE_RSSI,
 	.prop.val = &remote_get_properties_rssi_val,
 	.prop.len = sizeof(remote_get_properties_rssi_val),
-	.prio = 5,
 	},
 	{
 	.prop.type = BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP,
 	.prop.val = NULL,
 	.prop.len = 4,
-	.prio = 6,
 	},
 };
 
-- 
1.9.1

