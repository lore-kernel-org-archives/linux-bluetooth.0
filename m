Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 05/15] android/hal: Add support for sending adapter get properties command
Date: Fri, 25 Oct 2013 12:50:01 +0200
Message-ID: <1382698211-9123-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to get all adapter properties.
---
 android/hal-bluetooth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a71de83..b81f8dd 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -138,7 +138,8 @@ static int get_adapter_properties(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROPS,
+						0, NULL, 0, NULL, NULL);
 }
 
 static int get_adapter_property(bt_property_type_t type)
-- 
1.8.4.1

