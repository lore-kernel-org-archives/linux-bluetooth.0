Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/daemon: Fix error setting property
Date: Thu, 31 Oct 2013 13:52:38 +0200
Message-Id: <1383220358-5436-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Do not return error setting property which is already set. This fixes
bug with set_scan_mode which might return HAL_STATUS_DONE.
---
 android/adapter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index 98b2764..9d4da4e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -917,7 +917,7 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		break;
 	case HAL_OP_SET_ADAPTER_PROP:
 		status = set_property(buf, len);
-		if (status != HAL_STATUS_SUCCESS)
+		if (status != HAL_STATUS_SUCCESS && status != HAL_STATUS_DONE)
 			goto error;
 
 		break;
-- 
1.7.10.4

