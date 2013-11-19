Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/10] android/hal-bluetooth: Remove not needed check in set_adapter_property
Date: Tue, 19 Nov 2013 16:51:53 +0100
Message-Id: <1384876314-31347-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Properties types are verified on daemon side and proper error is
returned on wrong type. No need to double check that on HAL side.
---
 android/hal-bluetooth.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index b8ffce6..68f1bd5 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -508,15 +508,6 @@ static int set_adapter_property(const bt_property_t *property)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	switch (property->type) {
-	case BT_PROPERTY_BDNAME:
-	case BT_PROPERTY_ADAPTER_SCAN_MODE:
-	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-		break;
-	default:
-		return BT_STATUS_PARM_INVALID;
-	}
-
 	/* type match IPC type */
 	cmd->type = property->type;
 	cmd->len = property->len;
-- 
1.8.4.3

