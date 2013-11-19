Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/10] android/hal-bluetooth: Remove not needed check in get_adapter_property
Date: Tue, 19 Nov 2013 16:51:54 +0100
Message-Id: <1384876314-31347-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Properties types are verified on daemon side and proper error is
returned on wrong type. No need to double check that on HAL side.
---
 android/hal-bluetooth.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 68f1bd5..b04939e 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -476,21 +476,6 @@ static int get_adapter_property(bt_property_type_t type)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	switch (type) {
-	case BT_PROPERTY_BDNAME:
-	case BT_PROPERTY_BDADDR:
-	case BT_PROPERTY_UUIDS:
-	case BT_PROPERTY_CLASS_OF_DEVICE:
-	case BT_PROPERTY_TYPE_OF_DEVICE:
-	case BT_PROPERTY_SERVICE_RECORD:
-	case BT_PROPERTY_ADAPTER_SCAN_MODE:
-	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
-	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-		break;
-	default:
-		return BT_STATUS_PARM_INVALID;
-	}
-
 	/* type match IPC type */
 	cmd.type = type;
 
-- 
1.8.4.3

